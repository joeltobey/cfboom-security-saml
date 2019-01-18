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
  extends="cfboom.security.saml.provider.config.AbstractSamlServerBeanConfiguration"
  displayname="Abstract Class SamlServiceProviderServerBeanConfiguration"
  output="false"
{
  property name="wirebox" inject="wirebox";

  public cfboom.security.saml.provider.service.config.SamlServiceProviderServerBeanConfiguration function init() {
    return this;
  }

  /**
   * @Override
   * @Bean(name = "samlServiceProviderProvisioning")
   */
  public cfboom.security.saml.provider.provisioning.SamlProviderProvisioning function getSamlProvisioning() {
    if (!structKeyExists(variables, "_samlServiceProviderProvisioning")) {
      variables['_samlServiceProviderProvisioning'] = new cfboom.security.saml.provider.provisioning.HostBasedSamlServiceProviderProvisioning(
        samlConfigurationRepository(),
        samlTransformer(),
        samlValidator(),
        samlMetadataCache()
      );
    }
    return variables._samlServiceProviderProvisioning;
  }
/*
  public Filter spAuthenticationRequestFilter() {
    return new SamlAuthenticationRequestFilter(getSamlProvisioning());
  }
*/
/*
  public Filter spAuthenticationResponseFilter() {
    SamlAuthenticationResponseFilter authenticationFilter =
      new SamlAuthenticationResponseFilter(getSamlProvisioning());
    authenticationFilter.setAuthenticationManager(new SimpleAuthenticationManager());
    authenticationFilter.setAuthenticationSuccessHandler(new SavedRequestAwareAuthenticationSuccessHandler());
    authenticationFilter.setAuthenticationFailureHandler(new GenericErrorAuthenticationFailureHandler());
    return authenticationFilter;
  }
*/
/*
  public Filter spSamlLogoutFilter() {
    return new SamlProviderLogoutFilter<>(
      getSamlProvisioning(),
      new ServiceProviderLogoutHandler(getSamlProvisioning()),
      new SimpleUrlLogoutSuccessHandler(),
      new SecurityContextLogoutHandler()
    );
  }
*/
/*
  public Filter spSelectIdentityProviderFilter() {
    return new SelectIdentityProviderFilter(getSamlProvisioning());
  }
*/

  /**
   * @Override
   * @Bean(name = "spSamlServerConfiguration")
   */
  public cfboom.security.saml.provider.SamlServerConfiguration function getDefaultHostSamlServerConfiguration() {
    if (!structKeyExists(variables, "_spSamlServerConfiguration")) {

    }
    return variables._spSamlServerConfiguration;
  }

}
