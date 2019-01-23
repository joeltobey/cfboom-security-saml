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
 * Implementation samlp:ResponseType as defined by
 * https://www.oasis-open.org/committees/download.php/35711/sstc-saml-core-errata-2.0-wd-06-diff.pdf
 * Page 47, Line 1995
 */
component
  extends="cfboom.security.saml.saml2.authentication.StatusResponse"
  displayname="Class Response"
  output="false"
{
  variables['Collections'] = createObject("java","java.util.Collections");

  variables['_assertions'] = createObject("java","java.util.LinkedList").init();

  //private SimpleKey signingKey = null;
  //private AlgorithmMethod algorithm;
  //private DigestMethod digest;

  public cfboom.security.saml.saml2.authentication.Response function init() {
    return this;
  }

  public any function getAssertions() {
    return Collections.unmodifiableList(variables._assertions);
  }

  public cfboom.security.saml.saml2.authentication.Response function setAssertions(any assertions) {
    variables._assertions.clear();
    variables._assertions.addAll(arguments.assertions);
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

  public cfboom.security.saml.saml2.authentication.Response function setSigningKey(cfboom.security.saml.key.SimpleKey signingKey,
                                cfboom.security.saml.saml2.signature.AlgorithmMethod algorithm,
                                cfboom.security.saml.saml2.signature.DigestMethod digest) {
    variables['_signingKey'] = arguments.signingKey;
    variables['_algorithm'] = arguments.algorithm;
    variables['_digest'] = arguments.digest;
    return this;
  }

  public cfboom.security.saml.saml2.authentication.Response function addAssertion(cfboom.security.saml.saml2.authentication.Assertion assertion) {
    variables._assertions.add(arguments.assertion);
    return this;
  }
}
