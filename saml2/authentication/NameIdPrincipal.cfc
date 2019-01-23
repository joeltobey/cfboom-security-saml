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
 * Value inside a Subject holding the asserted entity, such as username
 * See saml:SubjectType
 * https://www.oasis-open.org/committees/download.php/35711/sstc-saml-core-errata-2.0-wd-06-diff.pdf
 * Page 18, Line 707
 */
component
  extends="cfboom.security.saml.saml2.authentication.SubjectPrincipal"
  displayname="Class NameIdPrincipal"
  output="false"
{
  public cfboom.security.saml.saml2.authentication.NameIdPrincipal function init() {
    return this;
  }

  public string function getNameQualifier() {
    return variables._nameQualifier;
  }

  public cfboom.security.saml.saml2.authentication.NameIdPrincipal function setNameQualifier(string nameQualifier) {
    variables['_nameQualifier'] = arguments.nameQualifier;
    return this;
  }

  public string function getSpNameQualifier() {
    return variables._spNameQualifier;
  }

  public cfboom.security.saml.saml2.authentication.NameIdPrincipal function setSpNameQualifier(string spNameQualifier) {
    variables['_spNameQualifier'] = arguments.spNameQualifier;
    return this;
  }

  public cfboom.security.saml.saml2.metadata.NameId function getFormat() {
    return variables._format;
  }

  public cfboom.security.saml.saml2.authentication.NameIdPrincipal function setFormat(cfboom.security.saml.saml2.metadata.NameId format) {
    variables['_format'] = arguments.format;
    return this;
  }

  public string function getSpProvidedId() {
    return variables._spProvidedId;
  }

  public cfboom.security.saml.saml2.authentication.NameIdPrincipal function setSpProvidedId(string spProvidedId) {
    variables['_spProvidedId'] = arguments.spProvidedId;
    return this;
  }
}
