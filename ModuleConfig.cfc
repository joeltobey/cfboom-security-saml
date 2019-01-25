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

  variables['Arrays'] = createObject("java", "java.util.Arrays");

  function configure() {
    // module settings - stored in modules.name.settings
    settings = {
      // Must implement cfboom.security.saml.provider.config.SamlServerBeanConfiguration
      "samlServerBeanConfiguration" = "cfboom.security.saml.provider.service.config.SamlServiceProviderServerBeanConfiguration",

      "samlImplementation" = "cfboom.security.saml.spi.opensaml.OpenSamlImplementation",
      "samlTransformer" = "cfboom.security.saml.spi.DefaultSamlTransformer",
      "samlValidator" = "cfboom.security.saml.spi.DefaultValidator",
      "samlMetadataCache" = "cfboom.security.saml.spi.DefaultMetadataCache",
      "samlConfigurationRepository" = "cfboom.security.saml.provider.config.StaticSamlConfigurationRepository",
      "samlServiceProviderProvisioning" = "cfboom.security.saml.provider.provisioning.HostBasedSamlServiceProviderProvisioning",
      "localServiceProviderConfiguration" = "cfboom.security.saml.provider.service.config.LocalServiceProviderConfiguration",
      "network" = {
        "read-timeout" = 10000,
        "connect-timeout" = 5000
      },
      "service-provider" = {
        "base-url" = "http://localhost",
        // "assertion-consumer-service-path" = "custom/saml/SSO/path", // This overrides default created from 'prefix' and 'alias'
        // "single-logout-service-path" = "custom/saml/logout/path", // This overrides default created from 'prefix' and 'alias'
        "prefix" = "saml/sp/",
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
            "name" = "key1",
            "private-key" = "",
            "passphrase" = "key1-password",
            "certificate" = ""
          },
          "stand-by" = [
            {
              "name" = "key2",
              "private-key" = "",
              "passphrase" = "key2-password",
              "certificate" = ""
            },
            {
              "name" = "key3",
              "private-key" = "",
              "passphrase" = "key3-password",
              "certificate" = ""
            }
          ]
        }
      },
      "defaultProvider" = "", // the prodiver key (i.e. 'default' in the example below)
      "providers" = {
        "default" = {
          "alias" = "default",
          "metadata" = "https://idp-url/metadata", // optional if 'configurationLoader' is specified.
          "name-id" = "", // optional
          "link-text" = "" // optional user-friendly text used to select an IdP during login
        }
      },
      "useJavaLoader" = false
    };

    // Binder Mappings
    binder.map("cfboom.security.saml.key.KeyType").to("cfboom.security.saml.key.KeyType").noInit();
    binder.map("KeyType@cfboom-security-saml").toFactoryMethod("cfboom.security.saml.key.KeyType", "enum").asSingleton().noInit();

    binder.map("cfboom.security.saml.saml2.Namespace").to("cfboom.security.saml.saml2.Namespace").noInit();
    binder.map("Namespace@cfboom-security-saml").to("cfboom.security.saml.saml2.Namespace").asSingleton();

    binder.map("cfboom.security.saml.saml2.attribute.AttributeNameFormat").to("cfboom.security.saml.saml2.attribute.AttributeNameFormat").noInit();
    binder.map("AttributeNameFormat@cfboom-security-saml").toFactoryMethod("cfboom.security.saml.saml2.attribute.AttributeNameFormat", "enum").asSingleton().noInit();

    binder.map("cfboom.security.saml.saml2.authentication.LogoutReason").to("cfboom.security.saml.saml2.authentication.LogoutReason").noInit();
    binder.map("LogoutReason@cfboom-security-saml").toFactoryMethod("cfboom.security.saml.saml2.authentication.LogoutReason", "enum").asSingleton().noInit();

    binder.map("cfboom.security.saml.saml2.authentication.StatusCode").to("cfboom.security.saml.saml2.authentication.StatusCode").noInit();
    binder.map("StatusCode@cfboom-security-saml").toFactoryMethod("cfboom.security.saml.saml2.authentication.StatusCode", "enum").asSingleton().noInit();

    binder.map("cfboom.security.saml.saml2.authentication.AuthenticationContextClassReference").to("cfboom.security.saml.saml2.authentication.AuthenticationContextClassReference").noInit();
    binder.map("AuthenticationContextClassReference@cfboom-security-saml").toFactoryMethod("cfboom.security.saml.saml2.authentication.AuthenticationContextClassReference", "enum").asSingleton().noInit();

    binder.map("cfboom.security.saml.saml2.authentication.SubjectConfirmationMethod").to("cfboom.security.saml.saml2.authentication.SubjectConfirmationMethod").noInit();
    binder.map("SubjectConfirmationMethod@cfboom-security-saml").toFactoryMethod("cfboom.security.saml.saml2.authentication.SubjectConfirmationMethod", "enum").asSingleton().noInit();

    binder.map("cfboom.security.saml.saml2.metadata.Binding").to("cfboom.security.saml.saml2.metadata.Binding").noInit();
    binder.map("Binding@cfboom-security-saml").toFactoryMethod("cfboom.security.saml.saml2.metadata.Binding", "enum").asSingleton().noInit();

    binder.map("cfboom.security.saml.saml2.metadata.NameId").to("cfboom.security.saml.saml2.metadata.NameId").noInit();
    binder.map("NameId@cfboom-security-saml").toFactoryMethod("cfboom.security.saml.saml2.metadata.NameId", "enum").asSingleton().noInit();

    binder.map("cfboom.security.saml.saml2.signature.AlgorithmMethod").to("cfboom.security.saml.saml2.signature.AlgorithmMethod").noInit();
    binder.map("AlgorithmMethod@cfboom-security-saml").toFactoryMethod("cfboom.security.saml.saml2.signature.AlgorithmMethod", "enum").asSingleton().noInit();

    binder.map("cfboom.security.saml.saml2.signature.CanonicalizationMethod").to("cfboom.security.saml.saml2.signature.CanonicalizationMethod").noInit();
    binder.map("CanonicalizationMethod@cfboom-security-saml").toFactoryMethod("cfboom.security.saml.saml2.signature.CanonicalizationMethod", "enum").asSingleton().noInit();

    binder.map("cfboom.security.saml.saml2.signature.DigestMethod").to("cfboom.security.saml.saml2.signature.DigestMethod").noInit();
    binder.map("DigestMethod@cfboom-security-saml").toFactoryMethod("cfboom.security.saml.saml2.signature.DigestMethod", "enum").asSingleton().noInit();

    binder.map("InitializationService@cfboom-security-saml").to("cfboom.security.saml.config.InitializationService");
    binder.map("SamlServerConfiguration@cfboom-security-saml").to("cfboom.security.saml.provider.SamlServerConfiguration");
    binder.map("NetworkConfiguration@cfboom-security-saml").to("cfboom.security.saml.provider.config.NetworkConfiguration");
    binder.map("ServiceProviderMetadata@cfboom-security-saml").to("cfboom.security.saml.saml2.metadata.ServiceProviderMetadata").into("NoScope");
    binder.map("ServiceProvider@cfboom-security-saml").to("cfboom.security.saml.saml2.metadata.ServiceProvider").into("NoScope");
    binder.map("SimpleKey@cfboom-security-saml").to("cfboom.security.saml.key.SimpleKey").into("NoScope");
    binder.map("RotatingKeys@cfboom-security-saml").to("cfboom.security.saml.provider.config.RotatingKeys").into("NoScope");
    binder.map("Endpoint@cfboom-security-saml").to("cfboom.security.saml.saml2.metadata.Endpoint").into("NoScope");
    binder.map("ExternalIdentityProviderConfiguration@cfboom-security-saml").to("cfboom.security.saml.provider.service.config.ExternalIdentityProviderConfiguration").into("NoScope");

    binder.map("EncodingUtils@cfboom-security-saml").to("cfboom.security.saml.spi.EncodingUtils").asSingleton();
    binder.map("HostedServiceProviderService@cfboom-security-saml").to("cfboom.security.saml.provider.service.HostedServiceProviderService").into("NoScope");
    binder.map("DateUtils@cfboom-security-saml").to("cfboom.security.saml.util.DateUtils").asSingleton();

    binder.map("time@cfboom-security-saml").toValue(createObject("java","java.time.Clock").systemUTC()).asSingleton();
  }

  /**
   * Fired when the module is registered and activated.
   */
  function onLoad() {
    binder.map("SamlServerBeanConfiguration@cfboom-security-saml").to( settings.samlServerBeanConfiguration ).asSingleton();
    binder.map("SamlTransformer@cfboom-security-saml").to( settings.samlTransformer ).asSingleton();
    binder.map("SamlImplementation@cfboom-security-saml").to( settings.samlImplementation ).asSingleton();
    binder.map("SamlValidator@cfboom-security-saml").to( settings.samlValidator ).asSingleton();
    binder.map("SamlMetadataCache@cfboom-security-saml").to( settings.samlMetadataCache ).asSingleton();
    binder.map("SamlConfigurationRepository@cfboom-security-saml").to( settings.samlConfigurationRepository ).asSingleton();
    binder.map("SamlServiceProviderProvisioning@cfboom-security-saml").to( settings.samlServiceProviderProvisioning ).asSingleton();
    binder.map("LocalServiceProviderConfiguration@cfboom-security-saml").to( settings.localServiceProviderConfiguration ).asSingleton();

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

    var samlServerBeanConfiguration = wirebox.getInstance("SamlServerBeanConfiguration@cfboom-security-saml");
    binder.map("spSamlServerConfiguration@cfboom-security-saml").toValue(samlServerBeanConfiguration.getDefaultHostSamlServerConfiguration()).asSingleton();

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
  }

  /**
   * Fired when the module is unregistered and unloaded
   */
  function onUnload() {}
}
