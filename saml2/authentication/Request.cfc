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
 * Base class for requests
 */
component
  extends="cfboom.security.saml.saml2.ImplementationHolder"
  displayname="Class Request"
  output="false"
{
  //private Issuer issuer;
  //private Signature signature;
  //private List<Object> extensions;
  //private String id;
  //private DateTime issueInstant;
  //private Endpoint destination;
  //private String consent;
  variables['_version'] = "2.0";

  public cfboom.security.saml.saml2.authentication.Request function init() {
    return this;
  }

  public cfboom.security.saml.saml2.authentication.Issuer function getIssuer() {
    return variables._issuer;
  }

  public cfboom.security.saml.saml2.authentication.Request function setIssuer(cfboom.security.saml.saml2.authentication.Issuer issuer) {
    variables['_issuer'] = arguments.issuer;
    return this;
  }

  public cfboom.security.saml.saml2.signature.Signature function getSignature() {
    return variables._signature;
  }

  public cfboom.security.saml.saml2.authentication.Request function setSignature(cfboom.security.saml.saml2.signature.Signature signature) {
    variables['_signature'] = arguments.signature;
    return this;
  }

  public any function getExtensions() {
    return variables._extensions;
  }

  public cfboom.security.saml.saml2.authentication.Request function setExtensions(any extensions) {
    variables['_extensions'] = arguments.extensions;
    return this;
  }

  public string function getId() {
    return variables._id;
  }

  public cfboom.security.saml.saml2.authentication.Request function setId(string id) {
    variables['_id'] = arguments.id;
    return this;
  }

  public any function getIssueInstant() {
    return variables._issueInstant;
  }

  public cfboom.security.saml.saml2.authentication.Request function setIssueInstant(any issueInstant) {
    variables['_issueInstant'] = arguments.issueInstant;
    return this;
  }

  public cfboom.security.saml.saml2.metadata.Endpoint function getDestination() {
    return variables._destination;
  }

  public cfboom.security.saml.saml2.authentication.Request function setDestination(cfboom.security.saml.saml2.metadata.Endpoint destination) {
    variables['_destination'] = arguments.destination;
    return this;
  }

  public string function getConsent() {
    return variables._consent;
  }

  public cfboom.security.saml.saml2.authentication.Request function setConsent(string consent) {
    variables['_consent'] = arguments.consent;
    return this;
  }

  public string function getVersion() {
    return variables._version;
  }

  public cfboom.security.saml.saml2.authentication.Request function setVersion(string version) {
    variables['_version'] = arguments.version;
    return this;
  }
}
