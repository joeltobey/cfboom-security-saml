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
 */
component
  displayname="Enum NameId"
  output="false"
{
  variables['_format'] = new cfboom.security.saml.saml2.metadata.NameIdFormat();

  this['urn:oasis:names:tc:SAML:1.1:nameid-format:unspecified'] = _format.UNSPECIFIED;
  this['urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress'] = _format.EMAIL;
  this['urn:oasis:names:tc:SAML:2.0:nameid-format:transient'] = _format.TRANSIENT;
  this['urn:oasis:names:tc:SAML:2.0:nameid-format:persistent'] = _format.PERSISTENT;
  this['urn:oasis:names:tc:SAML:1.1:nameid-format:X509SubjectName'] = _format.X509_SUBJECT;
  this['urn:oasis:names:tc:SAML:1.1:nameid-format:WindowsDomainQualifiedName'] = _format.WIN_DOMAIN_QUALIFIED;
  this['urn:oasis:names:tc:SAML:2.0:nameid-format:kerberos'] = _format.KERBEROS;
  this['urn:oasis:names:tc:SAML:2.0:nameid-format:entity'] = _format.ENTITY;
  this['urn:oasis:names:tc:SAML:2.0:nameid-format:encrypted'] = _format.ENCRYPTED;

  public cfboom.security.saml.saml2.metadata.NameId function init() {
    return this;
  }
}
