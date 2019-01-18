/*
 * Copyright 2019 Joel Tobey <joeltobey@gmail.com>
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
 * @singleton
 */
component
  extends="cfboom.lang.Object"
  displayname="Abstract Class AbstractSamlServerBeanConfiguration"
  output="false"
{
  property name="clockTime" inject="time@cfboom-security-saml";
  property name="wirebox" inject="wirebox";

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

  /**
   * @Bean
   */
  public cfboom.security.saml.SamlTransformer function samlTransformer() {
    if (!structKeyExists(variables, "_transformer")) {
      var args = {};
      args['name'] = "cfboom.security.saml.spi.DefaultSamlTransformer";
      args['initArguments'] = {
        "implementation" = samlImplementation()
      };
      variables['_transformer'] = wirebox.getInstance( argumentCollection = args );
    }
    return variables._transformer;
  }

  /**
   * @Bean
   */
  public cfboom.security.saml.spi.SecuritySaml function samlImplementation() {
    if (!structKeyExists(variables, "_implementation")) {
      var args = {};
      args['name'] = "cfboom.security.saml.spi.opensaml.OpenSamlImplementation";
      args['initArguments'] = {
        "time" = samlTime()
      };
      variables['_implementation'] = wirebox.getInstance( argumentCollection = args )._init();
    }
    return variables._implementation;
  }

  /**
   * @Bean
   */
  public any function samlTime() {
    return variables.clockTime;
  }

  /**
   * @Bean
   */
  public cfboom.security.saml.SamlValidator function samlValidator() {
    if (!structKeyExists(variables, "_validator")) {
      var args = {};
      args['name'] = "cfboom.security.saml.spi.DefaultValidator";
      args['initArguments'] = {
        "implementation" = samlImplementation()
      };
      variables['_validator'] = wirebox.getInstance( argumentCollection = args );
    }
    return variables._validator;
  }

  /**
   * @Bean
   */
  public cfboom.security.saml.SamlMetadataCache function samlMetadataCache() {
    if (!structKeyExists(variables, "_metadataCache")) {
      variables['_metadataCache'] = wirebox.getInstance( "cfboom.security.saml.spi.DefaultMetadataCache" );
    }
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
