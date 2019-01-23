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
 * An authentication containing SAML information
 */
interface
  extends="org.springframework.security.core.Authentication"
  displayname="Interface SamlAuthentication"
{
  /**
   * Returns the entity id of the identity provider that issued the assertion
   *
   * @return entity id of IDP
   */
  public string function getAssertingEntityId();

  /**
   * Returns the entity id of the service provider that received the assertion
   *
   * @return entity id of SP
   */
  public string function getHoldingEntityId();

  /**
   * Returns the principal object as it was received from the assertion
   *
   * @return principal with user information
   */
  public cfboom.security.saml.saml2.authentication.SubjectPrincipal function getSamlPrincipal();

/**
 * returns the assertion object that was used to create this authentication object
 *
 * @return assertion representing authentication
 */
    Assertion getAssertion();

/**
 * If the POST or REDIRECT contained a RelayState parameter this will be the value of it
 *
 * @return the RelayState parameter value, or null
 */
    public string function getRelayState();
}
