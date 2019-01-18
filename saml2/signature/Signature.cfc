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
 * @author Joel Tobey
 */
component
  extends="cfboom.lang.Object"
  displayname="Class Signature"
  output="false"
{
  property name="canonicalizationAlgorithm";
  property name="signatureAlgorithm";
  property name="digestAlgorithm";
  property name="digestValue" type="string";
  property name="signatureValue" type="string";
  property name="validated" type="boolean" default="false";
  property name="validatingKey";

  public cfboom.security.saml.saml2.signature.Signature function init() {
    variables['validated'] = false;
    return this;
  }

  public any function getCanonicalizationAlgorithm() {
    if (structKeyExists(variables, "canonicalizationAlgorithm"))
      return variables.canonicalizationAlgorithm;
  }

  public cfboom.security.saml.saml2.signature.Signature function setCanonicalizationAlgorithm(canonicalizationAlgorithm) {
    variables['canonicalizationAlgorithm'] = arguments.canonicalizationAlgorithm;
    return this;
  }

  public any function getSignatureAlgorithm() {
    if (structKeyExists(variables, "signatureAlgorithm"))
      return variables.signatureAlgorithm;
  }

  public cfboom.security.saml.saml2.signature.Signature function setSignatureAlgorithm(signatureAlgorithm) {
    variables['signatureAlgorithm'] = arguments.signatureAlgorithm;
    return this;
  }

  public any function getDigestAlgorithm() {
    if (structKeyExists(variables, "digestAlgorithm"))
      return variables.digestAlgorithm;
  }

  public cfboom.security.saml.saml2.signature.Signature function setDigestAlgorithm(digestAlgorithm) {
    variables['digestAlgorithm'] = arguments.digestAlgorithm;
    return this;
  }

  public string function getDigestValue() {
    if (structKeyExists(variables, "digestValue"))
      return variables.digestValue;
  }

  public cfboom.security.saml.saml2.signature.Signature function setDigestValue(string digestValue) {
    variables['digestValue'] = arguments.digestValue;
    return this;
  }

  public string function getSignatureValue() {
    if (structKeyExists(variables, "signatureValue"))
      return variables.signatureValue;
  }

  public cfboom.security.saml.saml2.signature.Signature function setSignatureValue(string signatureValue) {
    variables['signatureValue'] = arguments.signatureValue;
    return this;
  }

  public boolean function isValidated() {
    return variables.validated;
  }

  public cfboom.security.saml.saml2.signature.Signature function setValidated(boolean b) {
    variables['validated'] = arguments.b;
    return this;
  }

  public any function getValidatingKey() {
    if (structKeyExists(variables, "validatingKey"))
      return variables.validatingKey;
  }

  public cfboom.security.saml.saml2.signature.Signature function setValidatingKey(validatingKey) {
    variables['validatingKey'] = arguments.validatingKey;
    return this;
  }
}
