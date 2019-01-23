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
 * Implementation saml:SubjectType as defined by
 * https://www.oasis-open.org/committees/download.php/35711/sstc-saml-core-errata-2.0-wd-06-diff.pdf
 * Page 18, Line 708
 */
component
  extends="cfboom.lang.Object"
  displayname="Class Subject"
  output="false"
{
  variables['Collections'] = createObject("java","java.util.Collections");

  /**
   * BaseID, NameID or EncryptedID
   */
  //private NameIdPrincipal principal;
  variables['_confirmations'] = createObject("java","java.util.LinkedList").init();

  public cfboom.security.saml.saml2.authentication.Subject function init() {
    return this;
  }

  public cfboom.security.saml.saml2.authentication.NameIdPrincipal function getPrincipal() {
    return variables._principal;
  }

  public cfboom.security.saml.saml2.authentication.Subject function setPrincipal(cfboom.security.saml.saml2.authentication.NameIdPrincipal principal) {
    variables['_principal'] = arguments.principal;
    return this;
  }

  public any function getConfirmations() {
    return Collections.unmodifiableList(variables._confirmations);
  }

  public cfboom.security.saml.saml2.authentication.Subject function setConfirmations(any confirmations) {
    variables._confirmations.clear();
    if (structKeyExists(arguments, "confirmations") && !isNull(arguments.confirmations)) {
      variables._confirmations.addAll(arguments.confirmations);
    }
    return this;
  }

  public cfboom.security.saml.saml2.authentication.Subject function addConfirmation(cfboom.security.saml.saml2.authentication.SubjectConfirmation subjectConfirmation) {
    if (structKeyExists(arguments, "subjectConfirmation") && !isNull(arguments.subjectConfirmation)) {
      variables._confirmations.add(arguments.subjectConfirmation);
    }
    return this;
  }
}
