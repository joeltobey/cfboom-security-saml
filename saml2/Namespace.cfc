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
 *
 */
component
  displayname="Class Namespace"
  output="false"
{
  this.NS_ASSERTION_PREFIX = "saml:";
  this.NS_ASSERTION = "urn:oasis:names:tc:SAML:2.0:assertion";

  this.NS_PROTOCOL_PREFIX = "samlp:";
  this.NS_PROTOCOL = "urn:oasis:names:tc:SAML:2.0:protocol";

  this.NS_METADATA_PREFIX = "md:";
  this.NS_METADATA = "urn:oasis:names:tc:SAML:2.0:metadata";

  this.NS_SIGNATURE_PREFIX = "ds:";
  this.NS_SIGNATURE = "http://www.w3.org/2000/09/xmldsig##";

  this.NS_ENCRYPTION_PREFIX = "xenc:";
  this.NS_ENCRYPTION = "http://www.w3.org/2001/04/xmlenc##";

  this.NS_SCHEMA_PREFIX = "xs:";
  this.NS_SCHEMA = "http://www.w3.org/2001/XMLSchema";

  this.NS_IDP_DISCOVERY = "urn:oasis:names:tc:SAML:profiles:SSO:idp-discovery-protocol";
  this.NS_REQUEST_INIT = "urn:oasis:names:tc:SAML:profiles:SSO:request-init";

  public cfboom.security.saml.saml2.Namespace function init() {
    return this;
  }
}
