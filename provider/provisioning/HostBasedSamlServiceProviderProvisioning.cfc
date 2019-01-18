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
 */
component
  extends="cfboom.security.saml.provider.provisioning.AbstractHostbasedSamlProviderProvisioning"
  implements="cfboom.security.saml.provider.provisioning.SamlProviderProvisioning"
  displayname="Class HostBasedSamlServiceProviderProvisioning"
  output="false"
{
  public cfboom.security.saml.provider.provisioning.HostBasedSamlServiceProviderProvisioning function init(cfboom.security.saml.provider.config.SamlConfigurationRepository configuration,
                                                                                                           cfboom.security.saml.SamlTransformer transformer,
                                                                                                           cfboom.security.saml.SamlValidator validator,
                                                                                                           cfboom.security.saml.SamlMetadataCache cache) {
    super.init(arguments.configuration, arguments.transformer, arguments.validator, arguments.cache);
    return this;
  }

  /**
   * @Override
   */
  public cfboom.security.saml.provider.service.ServiceProviderService function getHostedProvider() {
    var config = getConfigurationRepository().getServerConfiguration().getServiceProvider();
    return getHostedServiceProvider(config);
  }
}
