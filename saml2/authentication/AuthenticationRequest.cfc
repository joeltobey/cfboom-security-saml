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
 * Implementation samlp:AuthnRequestType as defined by
 * https://www.oasis-open.org/committees/download.php/35711/sstc-saml-core-errata-2.0-wd-06-diff.pdf
 * Page 50, Line 2147
 */
component
  extends="cfboom.security.saml.saml2.authentication.Request"
  displayname="Class AuthenticationRequest"
  output="false"
{
  //private String providerName;
  //private Binding binding;
  //private Boolean forceAuth;
  //private Boolean isPassive;
  //private Endpoint assertionConsumerService;
  //private RequestedAuthenticationContext requestedAuthenticationContext;
  //private AuthenticationContextClassReference authenticationContextClassReference;
  //private SimpleKey signingKey;
  //private AlgorithmMethod algorithm;
  //private DigestMethod digest;

  //private NameIdPolicy nameIdPolicy;

  public cfboom.security.saml.saml2.authentication.AuthenticationRequest function init() {
    return this;
  }

  public string function getProviderName() {
    return variables._providerName;
  }

  public cfboom.security.saml.saml2.authentication.AuthenticationRequest function setProviderName(string providerName) {
    variables['_providerName'] = arguments.providerName;
    return this;
  }

  public cfboom.security.saml.saml2.metadata.Binding function getBinding() {
    return variables._binding;
  }

  public cfboom.security.saml.saml2.authentication.AuthenticationRequest function setBinding(cfboom.security.saml.saml2.metadata.Binding binding) {
    variables['_binding'] = arguments.binding;
    return this;
  }

  public cfboom.security.saml.saml2.metadata.Endpoint function getAssertionConsumerService() {
    return variables._assertionConsumerService;
  }

  public cfboom.security.saml.saml2.authentication.AuthenticationRequest function setAssertionConsumerService(cfboom.security.saml.saml2.metadata.Endpoint assertionConsumerService) {
    variables['_assertionConsumerService'] = arguments.assertionConsumerService;
    return this;
  }

  public cfboom.security.saml.saml2.authentication.RequestedAuthenticationContext function getRequestedAuthenticationContext() {
    return variables._requestedAuthenticationContext;
  }

  public cfboom.security.saml.saml2.authentication.AuthenticationRequest function setRequestedAuthenticationContext(cfboom.security.saml.saml2.authentication.RequestedAuthenticationContext requestedAuthenticationContext) {
    variables['_requestedAuthenticationContext'] = arguments.requestedAuthenticationContext;
    return this;
  }

  public cfboom.security.saml.saml2.authentication.AuthenticationContextClassReference function getAuthenticationContextClassReference() {
    return variables._authenticationContextClassReference;
  }

  public cfboom.security.saml.saml2.authentication.AuthenticationRequest function setAuthenticationContextClassReference(cfboom.security.saml.saml2.authentication.AuthenticationContextClassReference authenticationContextClassReference) {
    variables['_authenticationContextClassReference'] = arguments.authenticationContextClassReference;
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

  public cfboom.security.saml.saml2.authentication.NameIdPolicy function getNameIdPolicy() {
    return variables._nameIdPolicy;
  }

  public cfboom.security.saml.saml2.authentication.AuthenticationRequest function setNameIdPolicy(cfboom.security.saml.saml2.authentication.NameIdPolicy nameIdPolicy) {
    variables['_nameIdPolicy'] = arguments.nameIdPolicy;
    return this;
  }

  public cfboom.security.saml.saml2.authentication.AuthenticationRequest function setForceAuth(boolean forceAuth) {
    variables['_forceAuth'] = arguments.forceAuth;
    return this;
  }

  public cfboom.security.saml.saml2.authentication.AuthenticationRequest function setPassive(boolean passive) {
    variables['_isPassive'] = arguments.passive;
    return this;
  }

  public boolean function isForceAuth() {
    return variables._forceAuth;
  }

  public boolean function isPassive() {
    return variables._isPassive;
  }

  public cfboom.security.saml.saml2.authentication.AuthenticationRequest function setSigningKey(cfboom.security.saml.key.SimpleKey signingKey, cfboom.security.saml.saml2.signature.AlgorithmMethod algorithm, cfboom.security.saml.saml2.signature.DigestMethod digest) {
    variables['_signingKey'] = arguments.signingKey;
    variables['_algorithm'] = arguments.algorithm;
    variables['_digest'] = arguments.digest;
    return this;
  }
}
