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
  extends="cfboom.security.saml.provider.config.LocalProviderConfiguration"
  displayname="Class LocalServiceProviderConfiguration"
  output="false"
{
  variables['_signRequests'] = false;
  variables['_wantAssertionsSigned'] = false;

  public cfboom.security.saml.provider.service.config.LocalServiceProviderConfiguration function init() {
    super.init("saml/sp");
    return this;
  }

  public boolean function isSignRequests() {
    return variables._signRequests;
  }

  public cfboom.security.saml.provider.service.config.LocalServiceProviderConfiguration function setSignRequests(boolean signRequests) {
    variables['_signRequests'] = arguments.signRequests;
    return this;
  }

  public boolean function isWantAssertionsSigned() {
    return variables._wantAssertionsSigned;
  }

  public cfboom.security.saml.provider.service.config.LocalServiceProviderConfiguration function setWantAssertionsSigned(boolean wantAssertionsSigned) {
    variables['_wantAssertionsSigned'] = arguments.wantAssertionsSigned;
    return this;
  }

  public any function getDefaultProvider() {
    if (structKeyExists(variables, "_defaultProvider"))
      return variables._defaultProvider;
  }

  public cfboom.security.saml.provider.service.config.LocalServiceProviderConfiguration function setDefaultProvider(cfboom.security.saml.provider.service.config.ExternalIdentityProviderConfiguration defaultProvider) {
    variables['_defaultProvider'] = arguments.defaultProvider;
    return this;
  }
}
