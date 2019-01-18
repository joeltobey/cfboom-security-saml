/*
 * Copyright 2017-2019 Joel Tobey <joeltobey@gmail.com>
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/**
 * @author Joel Tobey
 */
component
  output="false"
{
  variables['Arrays'] = createObject("java", "java.util.Arrays");

  // Module Properties
  this.title              = "cfboom-security-saml";
  this.author             = "Joel Tobey";
  this.webURL             = "https://github.com/joeltobey/cfboom-security-saml";
  this.description        = "Provides SAML integration with cfboom-security";
  this.version            = "2.0.0";
  // If true, looks for views in the parent first, if not found, then in the module. Else vice-versa
  this.viewParentLookup   = true;
  // If true, looks for layouts in the parent first, if not found, then in module. Else vice-versa
  this.layoutParentLookup = true;
  // Module Entry Point
  this.entryPoint         = "saml";
  // Inherit entry point from parent, so this will be /cfboom/security/saml
  this.inheritEntryPoint  = true;
  // Model Namespace
  this.modelNamespace     = "cfboom-security-saml";
  // CF Mapping
  this.cfmapping          = "cfboom/security/saml";
  // Auto-map models
  this.autoMapModels      = false;
  // Module Dependencies
  this.dependencies       = [ "cfboom-security", "cfboom-http" ];

  function configure() {
    // module settings - stored in modules.name.settings
    settings = {
      "network" = {
        "read-timeout" = 10000,
        "connect-timeout" = 5000
      },
      "service-provider" = {
        "entity-id" = "cfboom.security.saml.sp.id",
        "alias" = "cfboom-sample-sp",
        "sign-metadata" = true,
        "sign-requests" = true,
        "want-assertions-signed" = true,
        "single-logout-enabled" = true,
        "name-ids" = [
          "urn:oasis:names:tc:SAML:2.0:nameid-format:persistent",
          "urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress",
          "urn:oasis:names:tc:SAML:1.1:nameid-format:unspecified"
        ],
        "keys" = {
          "active" = {
            "name" = "",
            "private-key" = "",
            "passphrase" = "",
            "certificate" = ""
          },
          "stand-by" = [
            {
              "name" = "key2",
              "private-key" = "",
              "passphrase" = "",
              "certificate" = ""
            },
            {
              "name" = "key3",
              "private-key" = "",
              "passphrase" = "",
              "certificate" = ""
            }
          ]
        }
      },
      "defaultProvider" = "", // the prodiver key (i.e. 'default' in the example below)
      "providers" = {
        "default" = {
          "alias" = "default",
          "recipientRoutedUrl" = "saml/sso/default",
          "metadata" = "https://idp-url/metadata", // optional if 'configurationLoader' is specified.
          "configurationLoader" = "", // optional wirebox model that implements cfboom.security.saml.ConfigurationLoader.
                                      // It defaults to MetadataConfigurationLoader and uses the 'metadata' property.
          "name-id" = "", // optional
          "link-text" = "" // optional user-friendly text used to select an IdP during login
        }
      },
      "useJavaLoader" = false
    };

    // SES Routes
    routes = [
      // Module Entry Point
      { pattern="/", handler="home", action="index" },
      // Convention Route
      { pattern="/:handler/:action?" }
    ];

    // Binder Mappings
    binder.map("InitializationService@cfboom-security-saml").to("cfboom.security.saml.config.InitializationService");
    //binder.map("SamlServiceProviderServerBeanConfiguration@cfboom-security-saml").to("cfboom.security.saml.provider.service.config.SamlServiceProviderServerBeanConfiguration");
    binder.map("time@cfboom-security-saml").toValue(createObject("java","java.time.Clock").systemUTC()).asSingleton();
  }

  /**
   * Fired when the module is registered and activated.
   */
  function onLoad() {
    if ( settings.useJavaLoader ) {
        wirebox.getInstance( "loader@cbjavaloader" ).appendPaths( modulePath & "/lib" );
    } else {
      // Double check if we need to use `cbjavaloader`
      try {
        createObject("java", "org.opensaml.core.config.InitializationService");
      } catch ( any ex ) {
        settings.useJavaLoader = true;
        wirebox.getInstance( "loader@cbjavaloader" ).appendPaths( modulePath & "/lib" );
      }
    }

    // Map the cfboom-security javaloader
    binder.map( "JavaLoader@cfboom-security-saml" )
      .to( "cfboom.util.JavaLoader" )
      .initWith( useJavaLoader = settings.useJavaLoader )
      .asSingleton();

    // Un-register the Security Interceptor
    controller.getInterceptorService().unregister("cfboomSecurityInterceptor");

    // Register the Security SAML Interceptor
    controller.getInterceptorService()
      .registerInterceptor(
        interceptorClass      = "cfboom.security.saml.interceptors.SecuritySamlInterceptor",
        interceptorProperties = settings,
        interceptorName       = "cfboomSecuritySamlInterceptor"
      );

    // Re-Register the Security Interceptor
    controller.getInterceptorService()
      .registerInterceptor(
        interceptorClass      = "cfboom.security.interceptors.SecuritySamlInterceptor",
        interceptorProperties = settings,
        interceptorName       = "cfboomSecurityInterceptor"
      );

    var NameId = new cfboom.security.saml.saml2.metadata.NameId();
    var AlgorithmMethod = new cfboom.security.saml.saml2.signature.AlgorithmMethod();
    var DigestMethod = new cfboom.security.saml.saml2.signature.DigestMethod();
    var prefix = "saml/sp/";
    var settingsNameIds = settings['service-provider']['name-ids'];
    var nameIds = [];
    for (var key in settingsNameIds) {
      arrayAppend(nameIds, NameId[key]);
    }

    var configuration = new cfboom.security.saml.provider.SamlServerConfiguration()
      .setNetwork(
        new cfboom.security.saml.provider.config.NetworkConfiguration()
          .setConnectTimeout(settings.network['connect-timeout'])
          .setReadTimeout(settings.network['read-timeout'])
      )
      .setServiceProvider(
        new cfboom.security.saml.provider.service.config.LocalServiceProviderConfiguration()
          .setPrefix(prefix)
          .setSignMetadata(settings['service-provider']['sign-metadata'])
          .setSignRequests(settings['service-provider']['sign-requests'])
          .setDefaultSigningAlgorithm(AlgorithmMethod.RSA_SHA256)
          .setDefaultDigest(DigestMethod.SHA256)
          .setNameIds(
            Arrays.asList(nameIds)
          )
          .setProviders(createObject("java","java.util.LinkedList").init())
      );
writeDump(configuration);
writeDump(configuration.getServiceProvider());
writeDump(configuration.getServiceProvider().getMetadata());
writeDump(configuration.getNetwork());
writeDump(configuration.getMeta());
abort;
  }

  /**
   * Fired when the module is unregistered and unloaded
   */
  function onUnload() {}

}
