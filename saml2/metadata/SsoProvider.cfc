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
 * Base class for SAML providers
 */
component
  extends="cfboom.security.saml.saml2.metadata.Provider"
  displayname="Class SsoProvider"
  output="false"
{
  variables['_artifactResolutionService'] = createObject("java","java.util.LinkedList").init();
  variables['_singleLogoutService'] = createObject("java","java.util.LinkedList").init();
  variables['_manageNameIDService'] = createObject("java","java.util.LinkedList").init();
  variables['_nameIds'] = createObject("java","java.util.LinkedList").init();
  //private Endpoint discovery;
  //private Endpoint requestInitiation;

  public cfboom.security.saml.saml2.metadata.SsoProvider function init() {
    return this;
  }

  public any function getArtifactResolutionService() {
    return variables._artifactResolutionService;
  }

  public cfboom.security.saml.saml2.metadata.SsoProvider function setArtifactResolutionService(any artifactResolutionService) {
    variables['_artifactResolutionService'] = arguments.artifactResolutionService;
    return this;
  }

  public any function getSingleLogoutService() {
    return variables._singleLogoutService;
  }

  public cfboom.security.saml.saml2.metadata.SsoProvider function setSingleLogoutService(any singleLogoutService) {
    variables['_singleLogoutService'] = arguments.singleLogoutService;
    return this;
  }

  public any function getManageNameIDService() {
    return variables._manageNameIDService;
  }

  public cfboom.security.saml.saml2.metadata.SsoProvider function setManageNameIDService(any manageNameIDService) {
    variables['_manageNameIDService'] = arguments.manageNameIDService;
    return this;
  }

  public any function getNameIds() {
    return variables._nameIds;
  }

  public cfboom.security.saml.saml2.metadata.SsoProvider function setNameIds(any nameIds) {
    variables['_nameIds'] = arguments.nameIds;
    return this;
  }

  public cfboom.security.saml.saml2.metadata.Endpoint function getDiscovery() {
    return variables._discovery;
  }

  public cfboom.security.saml.saml2.metadata.SsoProvider function setDiscovery(cfboom.security.saml.saml2.metadata.Endpoint discovery) {
    variables['_discovery'] = arguments.discovery;
    return this;
  }

  public cfboom.security.saml.saml2.metadata.Endpoint function getRequestInitiation() {
    return variables._requestInitiation;
  }

  public cfboom.security.saml.saml2.metadata.SsoProvider function setRequestInitiation(cfboom.security.saml.saml2.metadata.Endpoint requestInitiation) {
    variables['_requestInitiation'] = arguments.requestInitiation;
    return this;
  }
}
