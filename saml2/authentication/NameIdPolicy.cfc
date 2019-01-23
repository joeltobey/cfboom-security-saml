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
 * Implementation samlp:LogoutRequestType as defined by
 * https://www.oasis-open.org/committees/download.php/35711/sstc-saml-core-errata-2.0-wd-06-diff.pdf
 * Page 52, Line 2248
 */
component
  extends="cfboom.lang.Object"
  displayname="Class NameIdPolicy"
  output="false"
{
  public cfboom.security.saml.saml2.authentication.NameIdPolicy function init(cfboom.security.saml.saml2.metadata.NameId format,
                                                                              string spNameQualifier,
                                                                              boolean allowCreate) {

    if (structKeyExists(arguments, "format"))
      variables['_format'] = arguments.format;
    if (structKeyExists(arguments, "spNameQualifier"))
      variables['_spNameQualifier'] = arguments.spNameQualifier;
    if (structKeyExists(arguments, "allowCreate"))
      variables['_allowCreate'] = arguments.allowCreate;
    return this;
  }

  public string function getSpNameQualifier() {
    return variables._spNameQualifier;
  }

  public cfboom.security.saml.saml2.authentication.NameIdPolicy function setSpNameQualifier(string spNameQualifier) {
    variables['_spNameQualifier'] = arguments.spNameQualifier;
    return this;
  }

  public boolean function getAllowCreate() {
    return variables._allowCreate;
  }

  public cfboom.security.saml.saml2.authentication.NameIdPolicy function setAllowCreate(boolean allowCreate) {
    variables['_allowCreate'] = arguments.allowCreate;
    return this;
  }

  public cfboom.security.saml.saml2.metadata.NameId function getFormat() {
    return variables._format;
  }

  public cfboom.security.saml.saml2.authentication.NameIdPolicy function setFormat(cfboom.security.saml.saml2.metadata.NameId format) {
    variables['_format'] = arguments.format;
    return this;
  }
}
