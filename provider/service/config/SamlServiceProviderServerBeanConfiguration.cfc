/*
 * Copyright 2002-2019 the original author or authors and Joel Tobey <joeltobey@gmail.com>
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
 * @singleton
 */
component
  extends="cfboom.security.saml.provider.config.AbstractSamlServerBeanConfiguration"
  displayname="Abstract Class SamlServiceProviderServerBeanConfiguration"
  output="false"
{
  property name="settings" inject="coldbox:moduleSettings:cfboom-security-saml";
  property name="AlgorithmMethod" inject="AlgorithmMethod@cfboom-security-saml";
  property name="DigestMethod" inject="DigestMethod@cfboom-security-saml";
  property name="wirebox" inject="wirebox";

  variables['Arrays'] = createObject("java", "java.util.Arrays");

  public cfboom.security.saml.provider.service.config.SamlServiceProviderServerBeanConfiguration function init() {
    return this;
  }

  /**
   * @Override
   * @Bean(name = "spSamlServerConfiguration")
   */
  public cfboom.security.saml.provider.SamlServerConfiguration function getDefaultHostSamlServerConfiguration() {
    var configuration = variables.wirebox.getInstance("SamlServerConfiguration@cfboom-security-saml")
      .setNetwork(
        variables.wirebox.getInstance("NetworkConfiguration@cfboom-security-saml")
          .setConnectTimeout(variables.settings.network['connect-timeout'])
          .setReadTimeout(variables.settings.network['read-timeout'])
      )
      .setServiceProvider(
        variables.wirebox.getInstance("LocalServiceProviderConfiguration@cfboom-security-saml")
        .setPrefix(variables.settings['service-provider']['prefix'])
        .setAlias(variables.settings['service-provider']['alias'])
        .setEntityId(variables.settings['service-provider']['entity-id'])
        .setSignMetadata(variables.settings['service-provider']['sign-metadata'])
        .setSignRequests(variables.settings['service-provider']['sign-requests'])
        .setDefaultSigningAlgorithm(AlgorithmMethod.RSA_SHA256)
        .setDefaultDigest(DigestMethod.SHA256)
        .setNameIds(Arrays.asList(variables.settings['service-provider']['name-ids']))
        .setKeys(variables.wirebox.getInstance("RotatingKeys@cfboom-security-saml")
        .setActive(variables.wirebox.getInstance("SimpleKey@cfboom-security-saml")
          .setName(variables.settings['service-provider']['keys']['active']['name'])
          .setPrivateKey(variables.settings['service-provider']['keys']['active']['private-key'])
          .setPassphrase(variables.settings['service-provider']['keys']['active']['passphrase'])
          .setCertificate(variables.settings['service-provider']['keys']['active']['certificate'])
        ))
        .setProviders(createObject("java","java.util.LinkedList").init())
      );
    if (structKeyExists(variables.settings['service-provider']['keys'], "stand-by")) {
      var keys = configuration.getServiceProvider().getKeys();
      var standBy = createObject("java","java.util.LinkedList").init();
      for (var key in variables.settings['service-provider']['keys']['stand-by']) {
        standBy.add(variables.wirebox.getInstance("SimpleKey@cfboom-security-saml")
          .setName(key['name'])
          .setPrivateKey(key['private-key'])
          .setPassphrase(key['passphrase'])
          .setCertificate(key['certificate']));
      }
      keys.setStandBy(standBy);
    }
    if (structKeyExists(variables.settings, "providers")) {
      var defaultProvider = "";
      if (structKeyExists(variables.settings, "defaultProvider"))
        defaultProvider = variables.settings.defaultProvider;
      var sp = configuration.getServiceProvider();
      var spList = createObject("java","java.util.LinkedList").init();
      for (var key in variables.settings.providers) {
        var provider = variables.settings.providers[key];
        var eipc = variables.wirebox.getInstance("ExternalIdentityProviderConfiguration@cfboom-security-saml");
        eipc.setAlias(provider.alias);
        if (structKeyExists(provider, "recipient-routed-url"))
          eipc.setRecipientRoutedUrl(provider['recipient-routed-url']);
        if (structKeyExists(provider, "metadata"))
          eipc.setMetadata(provider['metadata']);
        if (structKeyExists(provider, "link-text"))
          eipc.setLinktext(provider['link-text']);
        if (structKeyExists(provider, "skip-ssl-validation"))
          eipc.setSkipSslValidation(javaCast("boolean",provider['skip-ssl-validation']));
        if (structKeyExists(provider, "metadata-trust-check"))
          eipc.setMetadataTrustCheck(javaCast("boolean",provider['metadata-trust-check']));
        if (structKeyExists(provider, "verification-keys"))
          eipc.setMetadata(Arrays.asList(provider['verification-keys']));
        if (structKeyExists(provider, "name-id"))
          eipc.setNameId(provider['name-id']);
        if (structKeyExists(provider, "assertion-consumer-service-index"))
          eipc.setAssertionConsumerServiceIndex(provider['assertion-consumer-service-index']);
        spList.add(eipc);
        if (key == defaultProvider)
          sp.setDefaultProvider(eipc);
      }
      sp.setProviders(spList);
      if (isNull(sp.getDefaultProvider()) && spList.size() > 0) {
        sp.setDefaultProvider(spList.get(0));
      }
    }
    return configuration;
  }
}
