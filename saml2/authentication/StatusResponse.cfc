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
 * Base class for responses samlp:StatusResponseType as defined by
 */
component
  extends="cfboom.security.saml.saml2.ImplementationHolder"
  displayname="Class StatusResponse"
  output="false"
{
  public cfboom.security.saml.saml2.authentication.StatusResponse function init() {
    return this;
  }

  public string function getId() {
    return variables._id;
  }

  public cfboom.security.saml.saml2.authentication.StatusResponse function setId(string id) {
    variables['_id'] = arguments.id;
    return this;
  }

  public string function getInResponseTo() {
    return variables._inResponseTo;
  }

  public cfboom.security.saml.saml2.authentication.StatusResponse function setInResponseTo(string inResponseTo) {
    variables['_inResponseTo'] = arguments.inResponseTo;
    return this;
  }

  public string function getVersion() {
    return variables._version;
  }

  public cfboom.security.saml.saml2.authentication.StatusResponse function setVersion(string version) {
    variables['_version'] = arguments.version;
    return this;
  }

  public any function getIssueInstant() {
    return variables._issueInstant;
  }

  public cfboom.security.saml.saml2.authentication.StatusResponse function setIssueInstant(any issueInstant) {
    variables['_issueInstant'] = arguments.issueInstant;
    return this;
  }

  public string function getDestination() {
    return variables._destination;
  }

  public cfboom.security.saml.saml2.authentication.StatusResponse function setDestination(string destination) {
    variables['_destination'] = arguments.destination;
    return this;
  }

  public string function getConsent() {
    return variables._consent;
  }

  public cfboom.security.saml.saml2.authentication.StatusResponse function setConsent(string consent) {
    variables['_consent'] = arguments.consent;
    return this;
  }

  public cfboom.security.saml.saml2.authentication.Issuer function getIssuer() {
    return variables._issuer;
  }

  public cfboom.security.saml.saml2.authentication.StatusResponse function setIssuer(cfboom.security.saml.saml2.authentication.Issuer issuer) {
    variables['_issuer'] = arguments.issuer;
    return this;
  }

  public cfboom.security.saml.saml2.signature.Signature function getSignature() {
    return variables._signature;
  }

  public cfboom.security.saml.saml2.authentication.StatusResponse function setSignature(cfboom.security.saml.saml2.signature.Signature signature) {
    variables['_signature'] = arguments.signature;
    return this;
  }

  public cfboom.security.saml.saml2.authentication.Status function getStatus() {
    return variables._status;
  }

  public cfboom.security.saml.saml2.authentication.StatusResponse function setStatus(cfboom.security.saml.saml2.authentication.Status status) {
    variables['_status'] = arguments.status;
    return this;
  }

  public cfboom.security.saml.key.SimpleKey function getSigningKey() {
    return variables._signingKey;
  }

  public cfboom.security.saml.saml2.signature.AlgorithmMethod function getAlgorithm() {
    return variables._algorithm;
  }

  public cfboom.security.saml.saml2.signature.DigestMethod function getDigest() {
    return variables._digest;
  }

  public cfboom.security.saml.saml2.authentication.StatusResponse function setSigningKey(cfboom.security.saml.key.SimpleKey signingKey,
                                                                                         cfboom.security.saml.saml2.signature.AlgorithmMethod algorithm,
                                                                                         cfboom.security.saml.saml2.signature.DigestMethod digest) {
    variables['_signingKey'] = arguments.signingKey;
    variables['_algorithm'] = arguments.algorithm;
    variables['_digest'] = arguments.digest;
    return this;
  }
}
