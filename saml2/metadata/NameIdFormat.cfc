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
 * Attribute Name Format Identifiers
 * https://www.oasis-open.org/committees/download.php/35711/sstc-saml-core-errata-2.0-wd-06-diff.pdf
 * Page 82, Line 3528
 */
component
  displayname="Enum NameIdFormat"
  output="false"
{
  import cfboom.security.saml.saml2.metadata.NameIdFormat;

  variables['_map'] = {
    "urn:oasis:names:tc:SAML:1.1:nameid-format:unspecified" = "UNSPECIFIED",
    "urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress" = "EMAIL",
    "urn:oasis:names:tc:SAML:2.0:nameid-format:transient" = "TRANSIENT",
    "urn:oasis:names:tc:SAML:2.0:nameid-format:persistent" = "PERSISTENT",
    "urn:oasis:names:tc:SAML:1.1:nameid-format:X509SubjectName" = "X509_SUBJECT",
    "urn:oasis:names:tc:SAML:1.1:nameid-format:WindowsDomainQualifiedName" = "WIN_DOMAIN_QUALIFIED",
    "urn:oasis:names:tc:SAML:2.0:nameid-format:kerberos" = "KERBEROS",
    "urn:oasis:names:tc:SAML:2.0:nameid-format:entity" = "ENTITY",
    "urn:oasis:names:tc:SAML:2.0:nameid-format:encrypted" = "ENCRYPTED"
  };

  public cfboom.security.saml.saml2.metadata.NameIdFormat function enum() {
    variables['_values'] = [];

    this.UNSPECIFIED = new NameIdFormat("urn:oasis:names:tc:SAML:1.1:nameid-format:unspecified");
    arrayAppend(variables._values, this.UNSPECIFIED);

    this.EMAIL = new NameIdFormat("urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress");
    arrayAppend(variables._values, this.EMAIL);

    this.TRANSIENT = new NameIdFormat("urn:oasis:names:tc:SAML:2.0:nameid-format:transient");
    arrayAppend(variables._values, this.TRANSIENT);

    this.PERSISTENT = new NameIdFormat("urn:oasis:names:tc:SAML:2.0:nameid-format:persistent");
    arrayAppend(variables._values, this.PERSISTENT);

    this.X509_SUBJECT = new NameIdFormat("urn:oasis:names:tc:SAML:1.1:nameid-format:X509SubjectName");
    arrayAppend(variables._values, this.X509_SUBJECT);

    this.WIN_DOMAIN_QUALIFIED = new NameIdFormat("urn:oasis:names:tc:SAML:1.1:nameid-format:WindowsDomainQualifiedName");
    arrayAppend(variables._values, this.WIN_DOMAIN_QUALIFIED);

    this.KERBEROS = new NameIdFormat("urn:oasis:names:tc:SAML:2.0:nameid-format:kerberos");
    arrayAppend(variables._values, this.KERBEROS);

    this.ENTITY = new NameIdFormat("urn:oasis:names:tc:SAML:2.0:nameid-format:entity");
    arrayAppend(variables._values, this.ENTITY);

    this.ENCRYPTED = new NameIdFormat("urn:oasis:names:tc:SAML:2.0:nameid-format:encrypted");
    arrayAppend(variables._values, this.ENCRYPTED);

    return this;
  }

  public cfboom.security.saml.saml2.metadata.NameIdFormat function init(string urn) {
    variables['_urn'] = arguments.urn;
    variables['_name'] = variables._map[arguments.urn];
    return this;
  }

  public cfboom.security.saml.saml2.metadata.NameIdFormat function fromUrn(string other) {
    for (var name in variables._values) {
      if (arguments.other.equalsIgnoreCase(name.toString())) {
        return name;
      }
    }
    return this.UNSPECIFIED;
  }

  public string function name() {
    return variables._name;
  }

  /**
   * @Override
   */
  public string function toString() {
    return variables._urn;
  }

  public any function toUri() {
    return createObject("java","java.net.URI").init(variables._urn);
  }
}
