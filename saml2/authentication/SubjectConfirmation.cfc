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
 * Implementation saml:SubjectConfirmationType as defined by
 * https://www.oasis-open.org/committees/download.php/35711/sstc-saml-core-errata-2.0-wd-06-diff.pdf
 * Page 19, Line 748
 */
component
  extends="cfboom.lang.Object"
  displayname="Class SubjectConfirmation"
  output="false"
{
  public cfboom.security.saml.saml2.authentication.SubjectConfirmation function init() {
    return this;
  }

  public cfboom.security.saml.saml2.authentication.SubjectConfirmationData function getConfirmationData() {
    return variables._data;
  }

  public cfboom.security.saml.saml2.authentication.SubjectConfirmation function setConfirmationData(cfboom.security.saml.saml2.authentication.SubjectConfirmationData confirmationData) {
    variables['_data'] = arguments.confirmationData;
    return this;
  }

  public cfboom.security.saml.saml2.authentication.SubjectConfirmationMethod function getMethod() {
    return variables._method;
  }

  public cfboom.security.saml.saml2.authentication.SubjectConfirmation function setMethod(cfboom.security.saml.saml2.authentication.SubjectConfirmationMethod method) {
    variables['_method'] = arguments.method;
    return this;
  }

  public string function getNameId() {
    return variables._nameId;
  }

  public cfboom.security.saml.saml2.authentication.SubjectConfirmation function setNameId(string nameId) {
    variables['_nameId'] = arguments.nameId;
    return this;
  }

  public cfboom.security.saml.saml2.metadata.NameId function getFormat() {
    return variables._format;
  }

  /**
   * @format.class cfboom.security.saml.saml2.metadata.NameId
   */
  public cfboom.security.saml.saml2.authentication.SubjectConfirmation function setFormat(any format) {
    variables['_format'] = arguments.format;
    return this;
  }
}
