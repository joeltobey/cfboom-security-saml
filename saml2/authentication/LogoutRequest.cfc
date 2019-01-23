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
 * Page 62, Line 2686
 */
component
  extends="cfboom.security.saml.saml2.authentication.Request"
  displayname="Class LogoutRequest"
  output="false"
{
  public cfboom.security.saml.saml2.authentication.LogoutRequest function init() {
    return this;
  }

  public cfboom.security.saml.saml2.signature.AlgorithmMethod function getAlgorithm() {
    return variables._algorithm;
  }

  public cfboom.security.saml.saml2.authentication.LogoutRequest function setAlgorithm(cfboom.security.saml.saml2.signature.AlgorithmMethod algorithm) {
    variables['_algorithm'] = arguments.algorithm;
    return this;
  }

  public cfboom.security.saml.saml2.signature.DigestMethod function getDigest() {
    return variables._digest;
  }

  public cfboom.security.saml.saml2.authentication.LogoutRequest function setDigest(cfboom.security.saml.saml2.signature.DigestMethod digest) {
    variables['_digest'] = arguments.digest;
    return this;
  }

  public cfboom.security.saml.saml2.authentication.NameIdPrincipal function getNameId() {
    return variables._nameId;
  }

  public cfboom.security.saml.saml2.authentication.LogoutRequest function setNameId(cfboom.security.saml.saml2.authentication.NameIdPrincipal nameId) {
    variables['_nameId'] = arguments.nameId;
    return this;
  }

  public cfboom.security.saml.saml2.authentication.LogoutReason function getReason() {
    return variables._reason;
  }

  public cfboom.security.saml.saml2.authentication.LogoutRequest function setReason(cfboom.security.saml.saml2.authentication.LogoutReason reason) {
    variables['_reason'] = arguments.reason;
    return this;
  }

  public any function getNotOnOrAfter() {
    return variables._notOnOrAfter;
  }

  public cfboom.security.saml.saml2.authentication.LogoutRequest function setNotOnOrAfter(any notOnOrAfter) {
    variables['_notOnOrAfter'] = arguments.notOnOrAfter;
    return this;
  }

  public cfboom.security.saml.key.SimpleKey function getSigningKey() {
    return variables._signingKey;
  }

  public cfboom.security.saml.saml2.authentication.LogoutRequest function setSigningKey(cfboom.security.saml.key.SimpleKey signingKey, cfboom.security.saml.saml2.signature.AlgorithmMethod algorithm, cfboom.security.saml.saml2.signature.DigestMethod digest) {
    variables['_signingKey'] = arguments.signingKey;
    variables['_algorithm'] = arguments.algorithm;
    variables['_digest'] = arguments.digest;
    return this;
  }
}
