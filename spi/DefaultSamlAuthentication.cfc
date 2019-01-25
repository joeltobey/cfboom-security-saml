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
 *
 */
component
  extends="cfboom.lang.Object"
  implements="cfboom.security.saml.SamlAuthentication"
  displayname="Class DefaultSamlAuthentication"
  output="false"
{
  //private boolean authenticated;
  //private Assertion assertion;
  //private String assertingEntityId;
  //private String holdingEntityId;
  //private String relayState;

  variables['Collections'] = createObject("java","java.util.Collections");

  public cfboom.security.saml.spi.DefaultSamlAuthentication function init(boolean authenticated,
                                                                          cfboom.security.saml.saml2.authentication.Assertion assertion,
                                                                          string assertingEntityId,
                                                                          string holdingEntityId,
                                                                          string relayState) {
    variables['_authenticated'] = arguments.authenticated;
    variables['_assertion'] = arguments.assertion;
    variables['_assertingEntityId'] = arguments.assertingEntityId;
    variables['_holdingEntityId'] = arguments.holdingEntityId;
    variables['_relayState'] = arguments.relayState;
    return this;
  }

  /**
   * @Override
   */
  public string function getAssertingEntityId() {
    return variables._assertingEntityId;
  }

  /**
   * @Override
   */
  public string function getHoldingEntityId() {
    return variables._holdingEntityId;
  }

  /**
   * @Override
   */
  public cfboom.security.saml.saml2.authentication.SubjectPrincipal function getSamlPrincipal() {
    return variables._assertion.getSubject().getPrincipal();
  }

  public cfboom.security.saml.saml2.authentication.Assertion function getAssertion() {
    return variables._assertion;
  }

  public void function setAssertion(Assertion assertion) {
    variables['_assertion'] = arguments.assertion;
  }

  /**
   * @Override
   */
  public string function getRelayState() {
    return variables._relayState;
  }

  public void function setRelayState(string relayState) {
    variables['_relayState'] = arguments.relayState;
  }

  public void function setHoldingEntityId(string holdingEntityId) {
    variables['_holdingEntityId'] = arguments.holdingEntityId;
  }

  public void function setAssertingEntityId(string assertingEntityId) {
    variables['_assertingEntityId'] = arguments.assertingEntityId;
  }

  /**
   * @Override
   */
  public array function getAuthorities() {
    return Collections.emptyList();
  }

  /**
   * @Override
   */
  public any function getCredentials() {
    return;
  }

  /**
   * @Override
   */
  public any function getDetails() {
    return getAssertion();
  }

  /**
   * @Override
   */
  public any function getPrincipal() {
    return getSamlPrincipal();
  }

  /**
   * @Override
   */
  public boolean function isAuthenticated() {
    return variables._authenticated;
  }

  /**
   * @Override
   */
  public void function setAuthenticated(boolean isAuthenticated) {
    if (!variables._authenticated && arguments.isAuthenticated) {
      throw(object=createObject("java","java.lang.IllegalArgumentException").init("Unable to change state of an existing authentication object."));
    }
  }

  /**
   * @Override
   */
  public string function getName() {
    return getSamlPrincipal().getValue();
  }
}
