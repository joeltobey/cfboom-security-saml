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
 * Defines md:SPSSODescriptorType as defined by
 * https://www.oasis-open.org/committees/download.php/35391/sstc-saml-metadata-errata-2.0-wd-04-diff.pdf
 * Page 20, Line 846
 */
component
  extends="cfboom.security.saml.saml2.metadata.SsoProvider"
  displayname="Class ServiceProvider"
  output="false"
{
  //private boolean authnRequestsSigned;
  //private boolean wantAssertionsSigned;
  variables['_assertionConsumerService'] = createObject("java","java.util.LinkedList").init();
  //private Endpoint configuredAssertionConsumerService;
  variables['_requestedAttributes'] = createObject("java","java.util.LinkedList").init();

  public cfboom.security.saml.saml2.metadata.ServiceProvider function init() {
    return this;
  }

  public boolean function getAuthnRequestsSigned() {
    return variables._authnRequestsSigned;
  }

  public boolean function getWantAssertionsSigned() {
    return variables._wantAssertionsSigned;
  }

  public any function getAssertionConsumerService() {
    return variables._assertionConsumerService;
  }

  public cfboom.security.saml.saml2.metadata.ServiceProvider function setAssertionConsumerService(any assertionConsumerService) {
    variables['_assertionConsumerService'] = arguments.assertionConsumerService;
    return this;
  }

  public boolean function isAuthnRequestsSigned() {
    return variables._authnRequestsSigned;
  }

  public cfboom.security.saml.saml2.metadata.ServiceProvider function setAuthnRequestsSigned(boolean authnRequestsSigned) {
    variables['_authnRequestsSigned'] = arguments.authnRequestsSigned;
    return this;
  }

  public boolean function isWantAssertionsSigned() {
    return variables._wantAssertionsSigned;
  }

  public cfboom.security.saml.saml2.metadata.ServiceProvider function setWantAssertionsSigned(boolean wantAssertionsSigned) {
    variables['_wantAssertionsSigned'] = arguments.wantAssertionsSigned;
    return this;
  }

  public cfboom.security.saml.saml2.metadata.Endpoint function getConfiguredAssertionConsumerService() {
    return variables.configuredAssertionConsumerService;
  }

  public cfboom.security.saml.saml2.metadata.ServiceProvider function setConfiguredAssertionConsumerService(cfboom.security.saml.saml2.metadata.Endpoint configuredAssertionConsumerService) {
    variables['_configuredAssertionConsumerService'] = arguments.configuredAssertionConsumerService;
    return this;
  }

  public any function getRequestedAttributes() {
    return variables.requestedAttributes;
  }

  public cfboom.security.saml.saml2.metadata.ServiceProvider function setRequestedAttributes(any requestedAttributes) {
    variables['_requestedAttributes'] = arguments.requestedAttributes;
    return this;
  }
}
