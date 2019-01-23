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
 * Implementation saml:AuthnStatementType as defined by
 * https://www.oasis-open.org/committees/download.php/35711/sstc-saml-core-errata-2.0-wd-06-diff.pdf
 * Page 27, Line 1137
 */
component
  extends="cfboom.lang.Object"
  displayname="Class AuthenticationStatement"
  output="false"
{
  //private DateTime authInstant;
  //private String sessionIndex;
  //private DateTime sessionNotOnOrAfter;
  variables['_authenticationContext'] = new cfboom.security.saml.saml2.authentication.AuthenticationContext();

  public cfboom.security.saml.saml2.authentication.AuthenticationStatement function init() {
    return this;
  }

  public any function getAuthInstant() {
    return variables._authInstant;
  }

  public cfboom.security.saml.saml2.authentication.AuthenticationStatement function setAuthInstant(any authInstant) {
    variables['_authInstant'] = arguments.authInstant;
    return this;
  }

  public string function getSessionIndex() {
    return variables._sessionIndex;
  }

  public cfboom.security.saml.saml2.authentication.AuthenticationStatement function setSessionIndex(string sessionIndex) {
    variables['_sessionIndex'] = arguments.sessionIndex;
    return this;
  }

  public any function getSessionNotOnOrAfter() {
    return variables._sessionNotOnOrAfter;
  }

  public cfboom.security.saml.saml2.authentication.AuthenticationStatement function setSessionNotOnOrAfter(any sessionNotOnOrAfter) {
    variables['_sessionNotOnOrAfter'] = arguments.sessionNotOnOrAfter;
    return this;
  }

  public cfboom.security.saml.saml2.authentication.AuthenticationContext function getAuthenticationContext() {
    return variables._authenticationContext;
  }

  public cfboom.security.saml.saml2.authentication.AuthenticationStatement function setAuthenticationContext(cfboom.security.saml.saml2.authentication.AuthenticationContext authenticationContext) {
    variables['_authenticationContext'] = arguments.authenticationContext;
    return this;
  }
}
