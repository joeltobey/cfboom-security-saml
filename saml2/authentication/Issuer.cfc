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
 * Implementation saml:Issuer as defined by
 * https://www.oasis-open.org/committees/download.php/35711/sstc-saml-core-errata-2.0-wd-06-diff.pdf
 * Page 15, Line 564
 */
component
  extends="cfboom.security.saml.saml2.authentication.NameIdPolicy"
  displayname="Class Issuer"
  output="false"
{
  public cfboom.security.saml.saml2.authentication.Issuer function init() {
    return this;
  }

  public string function getValue() {
    return variables._value;
  }

  public cfboom.security.saml.saml2.authentication.Issuer function setValue(string value) {
    variables['_value'] = arguments.value;
    return this;
  }

  public string function getNameQualifier() {
    return variables._nameQualifier;
  }

  public cfboom.security.saml.saml2.authentication.Issuer function setNameQualifier(string nameQualifier) {
    variables['_nameQualifier'] = arguments.nameQualifier;
    return this;
  }
}
