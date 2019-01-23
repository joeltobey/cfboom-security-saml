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
 * https://www.oasis-open.org/committees/download.php/35711/sstc-saml-core-errata-2.0-wd-06-diff.pdf
 * Page 82, Line 3528
 */
component
  displayname="Enum KeyEncryptionMethod"
  output="false"
{
  import cfboom.security.saml.saml2.encrypt.KeyEncryptionMethod;

  variables['_map'] = {
    "http://www.w3.org/2001/04/xmlenc##rsa-1_5" = "RSA_1_5",
    "http://www.w3.org/2001/04/xmlenc##rsa-oaep-mgf1p" = "RSA_OAEP_MGF1P"
  };

  public cfboom.security.saml.saml2.encrypt.KeyEncryptionMethod function enum() {
    variables['_values'] = [];

    this.RSA_1_5 = new KeyEncryptionMethod("http://www.w3.org/2001/04/xmlenc##rsa-1_5");
    arrayAppend(variables._values, this.RSA_1_5);

    this.RSA_OAEP_MGF1P = new KeyEncryptionMethod("http://www.w3.org/2001/04/xmlenc##rsa-oaep-mgf1p");
    arrayAppend(variables._values, this.RSA_OAEP_MGF1P);

    return this;
  }

  public cfboom.security.saml.saml2.encrypt.KeyEncryptionMethod function init(string urn) {
    variables['_urn'] = arguments.urn;
    variables['_name'] = variables._map[arguments.urn];
    return this;
  }

  public any function fromUrn(string other) {
    for (var name in variables._values) {
      if (arguments.other.equalsIgnoreCase(name.toString())) {
        return name;
      }
    }
  }

  public string function name() {
    return variables._name;
  }

  /**
   * @Override
   */
  public string function toString() {
    return variables._urn;
  }

  public any function toUri() {
    return createObject("java","java.net.URI").init(variables._urn);
  }
}
