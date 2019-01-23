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
 * Implementation saml:SubjectConfirmationDataType as defined by
 * https://www.oasis-open.org/committees/download.php/35711/sstc-saml-core-errata-2.0-wd-06-diff.pdf
 * Page 20, Line 810
 */
component
  extends="cfboom.lang.Object"
  displayname="Class SubjectConfirmationData"
  output="false"
{
  public cfboom.security.saml.saml2.authentication.SubjectConfirmationData function init() {
    return this;
  }

  public any function getNotBefore() {
    return variables._notBefore;
  }

  public cfboom.security.saml.saml2.authentication.SubjectConfirmationData function setNotBefore(any notBefore) {
    variables['_notBefore'] = arguments.notBefore;
  return this;
}

  public any function getNotOnOrAfter() {
    return variables._notOnOrAfter;
  }

  public cfboom.security.saml.saml2.authentication.SubjectConfirmationData function setNotOnOrAfter(DateTime notOnOrAfter) {
    variables['_notOnOrAfter'] = arguments.notOnOrAfter;
    return this;
  }

  public string function getRecipient() {
    return variables._recipient;
  }

  public cfboom.security.saml.saml2.authentication.SubjectConfirmationData function setRecipient(string recipient) {
    variables['_recipient'] = arguments.recipient;
    return this;
  }

  public string function getInResponseTo() {
    return variables._inResponseTo;
  }

  public cfboom.security.saml.saml2.authentication.SubjectConfirmationData function setInResponseTo(string inResponseTo) {
    variables['_inResponseTo'] = arguments.inResponseTo;
    return this;
  }
}
