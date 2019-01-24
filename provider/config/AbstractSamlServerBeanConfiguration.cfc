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
 * @deprecated
 */
component
  extends="cfboom.lang.Object"
  displayname="Abstract Class AbstractSamlServerBeanConfiguration"
  output="false"
{
  property name="_samlTransformer" inject="SamlTransformer@cfboom-security-saml";
  property name="_implementation" inject="SamlImplementation@cfboom-security-saml";
  property name="_validator" inject="SamlValidator@cfboom-security-saml";
  property name="_metadataCache" inject="SamlMetadataCache@cfboom-security-saml";
  property name="_samlTime" inject="time@cfboom-security-saml";

  public cfboom.security.saml.provider.config.AbstractSamlServerBeanConfiguration function init() {
    return this;
  }

  public cfboom.security.saml.provider.provisioning.SamlProviderProvisioning function getSamlProvisioning() {
    throw(object=createObject("java", "java.lang.AbstractMethodError").init("Subcass must implement 'getSamlProvisioning()'"));
  }
/*
  @Bean
  public DefaultSessionAssertionStore samlAssertionStore() {
    return new DefaultSessionAssertionStore();
  }
*/
/*
  @Bean
  public SamlTemplateEngine samlTemplateEngine() {
    return new OpenSamlVelocityEngine();
  }
*/

  public cfboom.security.saml.SamlTransformer function samlTransformer() {
    return variables._samlTransformer;
  }

  public cfboom.security.saml.spi.SecuritySaml function samlImplementation() {
    return variables._implementation;
  }

  public any function samlTime() {
    return variables._samlTime;
  }

  public cfboom.security.saml.SamlValidator function samlValidator() {
    return variables._validator;
  }

  public cfboom.security.saml.SamlMetadataCache function samlMetadataCache() {
    return variables._metadataCache;
  }
/*
  public Filter samlConfigurationFilter() {
  return new ThreadLocalSamlConfigurationFilter(
    (ThreadLocalSamlConfigurationRepository) samlConfigurationRepository()
  );
  }
*/

  public cfboom.security.saml.provider.config.SamlConfigurationRepository function samlConfigurationRepository() {
    return new cfboom.security.saml.provider.config.StaticSamlConfigurationRepository(getDefaultHostSamlServerConfiguration());
  }

  public cfboom.security.saml.provider.SamlServerConfiguration function getDefaultHostSamlServerConfiguration() {
    throw(object=createObject("java", "java.lang.AbstractMethodError").init("Subcass must implement 'getDefaultHostSamlServerConfiguration()'"));
  }

/*
  private int getNetworkHandlerConnectTimeout() {
  if (getDefaultHostSamlServerConfiguration() != null && getDefaultHostSamlServerConfiguration().getNetwork() != null) {
    NetworkConfiguration networkConfiguration = getDefaultHostSamlServerConfiguration().getNetwork();
    return networkConfiguration.getConnectTimeout();
  }
  return 5000;
  }
*/
/*
  private int getNetworkHandlerReadTimeout() {
  if (getDefaultHostSamlServerConfiguration() != null && getDefaultHostSamlServerConfiguration().getNetwork() != null) {
    NetworkConfiguration networkConfiguration = getDefaultHostSamlServerConfiguration().getNetwork();
    return networkConfiguration.getReadTimeout();
  }
  return 10000;
  }
*/
/*
  @Bean
  public RestOperations samlValidatingNetworkHandler() {
  return new Network(getNetworkHandlerConnectTimeout(), getNetworkHandlerReadTimeout()).get(false);
  }
*/
/*
  @Bean
  public RestOperations samlNonValidatingNetworkHandler() {
  return new Network(getNetworkHandlerConnectTimeout(), getNetworkHandlerReadTimeout()).get(true);
  }
*/
}
