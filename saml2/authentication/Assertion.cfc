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
 * Implementation saml:AssertionType as defined by
 * https://www.oasis-open.org/committees/download.php/35711/sstc-saml-core-errata-2.0-wd-06-diff.pdf
 * Page 17, Line 649
 */
component
  extends="cfboom.security.saml.saml2.ImplementationHolder"
  displayname="Class Assertion"
  output="false"
{
  variables['Collections'] = createObject("java","java.util.Collections");

  //private String version;
  //private String id;
  //private DateTime issueInstant;
  //private Issuer issuer;
  //private Signature signature;
  //private Subject subject;
  //private Conditions conditions;
  //private Advice advice;
  variables['_authenticationStatements'] = createObject("java","java.util.LinkedList").init();
  variables['_attributes'] = createObject("java","java.util.LinkedList").init();
  //private SimpleKey signingKey;
  //private AlgorithmMethod algorithm;
  //private DigestMethod digest;
  //private SimpleKey encryptionKey;
  //private KeyEncryptionMethod keyAlgorithm;
  //private DataEncryptionMethod dataAlgorithm;

  public cfboom.security.saml.saml2.authentication.Assertion function init() {
    return this;
  }

  public string function getVersion() {
    return variables._version;
  }

  public cfboom.security.saml.saml2.authentication.Assertion function setVersion(string version) {
    variables['_version'] = arguments.version;
    return this;
  }

  public string function getId() {
    return variables._id;
  }

  public cfboom.security.saml.saml2.authentication.Assertion function setId(string id) {
    variables['_id'] = arguments.id;
    return this;
  }

  public any function getIssueInstant() {
    return variables._issueInstant;
  }

  public cfboom.security.saml.saml2.authentication.Assertion function setIssueInstant(any issueInstant) {
    variables['_issueInstant'] = arguments.issueInstant;
    return this;
  }

  public cfboom.security.saml.saml2.authentication.Issuer function getIssuer() {
    return variables._issuer;
  }

  public cfboom.security.saml.saml2.authentication.Assertion function setIssuer(cfboom.security.saml.saml2.authentication.Issuer issuer) {
    if (isInstanceOf(arguments.issuer, "cfboom.security.saml.saml2.authentication.Issuer")) {
      variables['_issuer'] = arguments.issuer;
    } else {
      variables['_issuer'] = new cfboom.security.saml.saml2.authentication.Issuer();
      variables._issuer.setValue(arguments.issuer);
    }
    return this;
  }

  public cfboom.security.saml.saml2.signature.Signature function getSignature() {
    return variables._signature;
  }

  /**
   * @signature.class cfboom.security.saml.saml2.signature.Signature
   */
  public cfboom.security.saml.saml2.authentication.Assertion function setSignature(any signature) {
    variables['_signature'] = arguments.signature;
    return this;
  }

  public cfboom.security.saml.saml2.authentication.Subject function getSubject() {
    return variables._subject;
  }

  public cfboom.security.saml.saml2.authentication.Assertion function setSubject(cfboom.security.saml.saml2.authentication.Subject subject) {
    variables['_subject'] = arguments.subject;
    return this;
  }

  public cfboom.security.saml.saml2.authentication.Conditions function getConditions() {
    return variables._conditions;
  }

  public cfboom.security.saml.saml2.authentication.Assertion function setConditions(cfboom.security.saml.saml2.authentication.Conditions conditions) {
    variables['_conditions'] = arguments.conditions;
    return this;
  }

  public cfboom.security.saml.saml2.authentication.Advice function getAdvice() {
    return variables._advice;
  }

  public cfboom.security.saml.saml2.authentication.Assertion function setAdvice(cfboom.security.saml.saml2.authentication.Advice advice) {
    variables['_advice'] = arguments.advice;
    return this;
  }

  public any function getAuthenticationStatements() {
    return Collections.unmodifiableList(variables._authenticationStatements);
  }

  public cfboom.security.saml.saml2.authentication.Assertion function setAuthenticationStatements(any authenticationStatements) {
    variables._authenticationStatements.clear();
    variables._authenticationStatements.addAll(arguments.authenticationStatements);
    return this;
  }

  public any function getAttributes() {
    return Collections.unmodifiableList(variables._attributes);
  }

  public cfboom.security.saml.saml2.authentication.Assertion function setAttributes(any attributes) {
    variables._attributes.clear();
    variables._attributes.addAll(arguments.attributes);
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

  public any function getAttributes(string name) {
    var attrs = createObject("java","java.util.LinkedList").init();
    for ( var att in variables._attributes ) {
      if (arguments.name.equals(att.getName())) {
        attrs.add(att);
      }
    }
    return attrs;
  }

  public any function getFirstAttribute(string name) {
    for ( var att in variables._attributes ) {
      if (arguments.name.equals(att.getName())) {
        return att;
      }
    }
  }

  public cfboom.security.saml.saml2.authentication.Assertion function addAuthenticationStatement(cfboom.security.saml.saml2.authentication.AuthenticationStatement statement) {
    variables._authenticationStatements.add(arguments.statement);
    return this;
  }

  public cfboom.security.saml.saml2.authentication.Assertion function addAttribute(Attribute attribute) {
    variables._attributes.add(arguments.attribute);
    return this;
  }

  public cfboom.security.saml.saml2.authentication.Assertion function setSigningKey(cfboom.security.saml.key.SimpleKey signingKey,
                                                                                    cfboom.security.saml.saml2.signature.AlgorithmMethod algorithm,
                                                                                    cfboom.security.saml.saml2.signature.DigestMethod digest) {
    variables['_signingKey'] = arguments.signingKey;
    variables['_algorithm'] = arguments.algorithm;
    variables['_digest'] = arguments.digest;
    return this;
  }

  public cfboom.security.saml.saml2.authentication.Assertion function setEncryptionKey(cfboom.security.saml.key.SimpleKey encryptionKey,
                                                                                       cfboom.security.saml.saml2.encrypt.KeyEncryptionMethod keyAlgorithm,
                                                                                       cfboom.security.saml.saml2.encrypt.DataEncryptionMethod dataAlgorithm) {
    variables['_encryptionKey'] = arguments.encryptionKey;
    variables['_keyAlgorithm'] = arguments.keyAlgorithm;
    variables['_dataAlgorithm'] = arguments.dataAlgorithm;
    return this;
  }

  public cfboom.security.saml.key.SimpleKey function getEncryptionKey() {
    return variables._encryptionKey;
  }

  public cfboom.security.saml.saml2.encrypt.KeyEncryptionMethod function getKeyAlgorithm() {
    return variables._keyAlgorithm;
  }

  public cfboom.security.saml.saml2.encrypt.DataEncryptionMethod function getDataAlgorithm() {
    return variables._dataAlgorithm;
  }
}
