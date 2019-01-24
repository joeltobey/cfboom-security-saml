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
  extends="cfboom.lang.Object"
  implements="cfboom.security.saml.provider.config.SamlConfigurationRepository"
  displayname="Class StaticSamlConfigurationRepository"
  output="false"
{
  /**
   * @configuration.inject spSamlServerConfiguration@cfboom-security-saml
   */
  public cfboom.security.saml.provider.config.StaticSamlConfigurationRepository function init(cfboom.security.saml.provider.SamlServerConfiguration configuration) {
    variables['_configuration'] = arguments.configuration;
    return this;
  }

  public cfboom.security.saml.provider.SamlServerConfiguration function getServerConfiguration() {
    return variables._configuration;
  }
}
