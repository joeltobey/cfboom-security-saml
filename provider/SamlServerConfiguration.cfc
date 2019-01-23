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
 * Represents a configuration for a hosted or domain.
 * A hosted domain can have one local service provider, or one local identity provider, or both.
 */
component
  extends="cfboom.lang.Object"
  displayname="Class SamlServerConfiguration"
  output="false"
{
  public cfboom.security.saml.provider.SamlServerConfiguration function init() {
    return this;
  }

  public cfboom.security.saml.provider.service.config.LocalServiceProviderConfiguration function getServiceProvider() {
    return variables._serviceProvider;
  }

  public cfboom.security.saml.provider.SamlServerConfiguration function setServiceProvider(cfboom.security.saml.provider.service.config.LocalServiceProviderConfiguration serviceProvider) {
    variables['_serviceProvider'] = arguments.serviceProvider;
    return this;
  }

  public LocalIdentityProviderConfiguration function getIdentityProvider() {
    return variables._identityProvider;
  }

  public cfboom.security.saml.provider.SamlServerConfiguration function setIdentityProvider(LocalIdentityProviderConfiguration identityProvider) {
    variables['_identityProvider'] = arguments.identityProvider;
    return this;
  }

  public cfboom.security.saml.provider.config.NetworkConfiguration function getNetwork() {
    return variables._network;
  }

  public cfboom.security.saml.provider.SamlServerConfiguration function setNetwork(cfboom.security.saml.provider.config.NetworkConfiguration network) {
    variables['_network'] = arguments.network;
    return this;
  }

  public cfboom.security.saml.provider.SamlServerConfiguration function clone() {
    var result = super.clone();
    result.network = structKeyExists(variables, "_network") ? variables._network.clone() : null;
    result.identityProvider = structKeyExists(variables, "_identityProvider") ? variables._identityProvider.clone() : null;
    result.serviceProvider = structKeyExists(variables, "_serviceProvider") ? variables._serviceProvider.clone() : null;
    return result;
  }

  public cfboom.security.saml.provider.SamlServerConfiguration function transfer(cfboom.security.saml.provider.SamlServerConfiguration external) {
    return this
      .setNetwork(arguments.external.getNetwork())
      .setIdentityProvider(arguments.external.getIdentityProvider())
      .setServiceProvider(arguments.external.getServiceProvider());
  }
}
