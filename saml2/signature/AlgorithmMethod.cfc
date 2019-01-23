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
  displayname="Enum AlgorithmMethod"
  output="false"
{
  import cfboom.security.saml.saml2.signature.AlgorithmMethod;

  public cfboom.security.saml.saml2.signature.AlgorithmMethod function enum() {
    variables['_values'] = [];

    this.RSA_SHA1 = new AlgorithmMethod("http://www.w3.org/2000/09/xmldsig##rsa-sha1");
    arrayAppend(variables._values, this.RSA_SHA1);

    this.RSA_SHA256 = new AlgorithmMethod("http://www.w3.org/2001/04/xmldsig-more##rsa-sha256");
    arrayAppend(variables._values, this.RSA_SHA256);

    this.RSA_SHA512 = new AlgorithmMethod("http://www.w3.org/2001/04/xmldsig-more##rsa-sha512");
    arrayAppend(variables._values, this.RSA_SHA512);

    this.RSA_RIPEMD160 = new AlgorithmMethod("http://www.w3.org/2001/04/xmldsig-more##rsa-ripemd160");
    arrayAppend(variables._values, this.RSA_RIPEMD160);

    return this;
  }

  public cfboom.security.saml.saml2.signature.AlgorithmMethod function init(string urn) {
    variables['_urn'] = arguments.urn;
    return this;
  }

  public any function fromUrn(string urn) {
    for (var m in variables._values) {
      if (arguments.urn.equalsIgnoreCase(m.toString())) {
        return m;
      }
    }
    return;
  }

  /**
   * @Override
   */
  public string function toString() {
    return variables._urn;
  }
}
