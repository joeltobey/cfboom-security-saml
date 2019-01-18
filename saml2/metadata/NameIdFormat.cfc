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
  this.UNSPECIFIED = "urn:oasis:names:tc:SAML:1.1:nameid-format:unspecified";
  this.EMAIL = "urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress";
  this.TRANSIENT = "urn:oasis:names:tc:SAML:2.0:nameid-format:transient";
  this.PERSISTENT = "urn:oasis:names:tc:SAML:2.0:nameid-format:persistent";
  this.X509_SUBJECT = "urn:oasis:names:tc:SAML:1.1:nameid-format:X509SubjectName";
  this.WIN_DOMAIN_QUALIFIED = "urn:oasis:names:tc:SAML:1.1:nameid-format:WindowsDomainQualifiedName";
  this.KERBEROS = "urn:oasis:names:tc:SAML:2.0:nameid-format:kerberos";
  this.ENTITY = "urn:oasis:names:tc:SAML:2.0:nameid-format:entity";
  this.ENCRYPTED = "urn:oasis:names:tc:SAML:2.0:nameid-format:encrypted";

  public cfboom.security.saml.saml2.metadata.NameIdFormat function init() {
    return this;
  }
}
