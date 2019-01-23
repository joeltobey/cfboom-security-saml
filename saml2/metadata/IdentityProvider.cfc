/*
 * Copyright 2019 the original author or authors and Joel Tobey <joeltobey@gmail.com>
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
 * Defines md:IDPSSODescriptorType as defined by
 * https://www.oasis-open.org/committees/download.php/35391/sstc-saml-metadata-errata-2.0-wd-04-diff.pdf
 * Page 19, Line 792
 */
component
  extends="cfboom.security.saml.saml2.metadata.SsoProvider"
  displayname="Class IdentityProvider"
  output="false"
{
  variables['_wantAuthnRequestsSigned'] = true;
  //private List<Endpoint> singleSignOnService;
  //private List<Endpoint> nameIDMappingService;
  //private List<Endpoint> assertionIDRequestService;
  //private List<String> attributeProfile;
  //private List<Attribute> attribute;

  public cfboom.security.saml.saml2.metadata.IdentityProvider function init() {
    return this;
  }

  public boolean function getWantAuthnRequestsSigned() {
      return variables._wantAuthnRequestsSigned;
  }

  public cfboom.security.saml.saml2.metadata.IdentityProvider function setWantAuthnRequestsSigned(boolean wantAuthnRequestsSigned) {
      variables['_wantAuthnRequestsSigned'] = arguments.wantAuthnRequestsSigned;
      return this;
  }

  public any function getSingleSignOnService() {
      return variables._singleSignOnService;
  }

  public cfboom.security.saml.saml2.metadata.IdentityProvider function setSingleSignOnService(any singleSignOnService) {
      variables['_singleSignOnService'] = arguments.singleSignOnService;
      return this;
  }

  public any function getNameIDMappingService() {
      return variables._nameIDMappingService;
  }

  public cfboom.security.saml.saml2.metadata.IdentityProvider function setNameIDMappingService(any nameIDMappingService) {
      variables['_nameIDMappingService'] = arguments.nameIDMappingService;
      return this;
  }

  public any function getAssertionIDRequestService() {
      return variables._assertionIDRequestService;
  }

  public cfboom.security.saml.saml2.metadata.IdentityProvider function setAssertionIDRequestService(any assertionIDRequestService) {
      variables['_assertionIDRequestService'] = arguments.assertionIDRequestService;
      return this;
  }

  public any function getAttributeProfile() {
      return variables._attributeProfile;
  }

  public cfboom.security.saml.saml2.metadata.IdentityProvider function setAttributeProfile(any attributeProfile) {
      variables['_attributeProfile'] = arguments.attributeProfile;
      return this;
  }

  public any function getAttribute() {
      return variables._attribute;
  }

  public cfboom.security.saml.saml2.metadata.IdentityProvider function setAttribute(any attribute) {
      variables['_attribute'] = arguments.attribute;
      return this;
  }
}
