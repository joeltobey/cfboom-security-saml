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
  displayname="Enum DataEncryptionMethod"
  output="false"
{
  import cfboom.security.saml.saml2.encrypt.DataEncryptionMethod;

  variables['_map'] = {
    "http://www.w3.org/2001/04/xmlenc##tripledes-cbc" = "TRIPLEDES_CBS",
    "http://www.w3.org/2001/04/xmlenc##aes128-cbc" = "AES128_CBC",
    "http://www.w3.org/2001/04/xmlenc##aes256-cbc" = "AES256_CBC",
    "http://www.w3.org/2001/04/xmlenc##aes192-cbc" = "AES192_CBC"
  };

  public cfboom.security.saml.saml2.encrypt.DataEncryptionMethod function enum() {
    variables['_values'] = [];

    this.TRIPLEDES_CBS = new DataEncryptionMethod("http://www.w3.org/2001/04/xmlenc##tripledes-cbc");
    arrayAppend(variables._values, this.TRIPLEDES_CBS);

    this.AES128_CBC = new DataEncryptionMethod("http://www.w3.org/2001/04/xmlenc##aes128-cbc");
    arrayAppend(variables._values, this.AES128_CBC);

    this.AES256_CBC = new DataEncryptionMethod("http://www.w3.org/2001/04/xmlenc##aes256-cbc");
    arrayAppend(variables._values, this.AES256_CBC);

    this.AES192_CBC = new DataEncryptionMethod("http://www.w3.org/2001/04/xmlenc##aes192-cbc");
    arrayAppend(variables._values, this.AES192_CBC);

    return this;
  }

  public cfboom.security.saml.saml2.encrypt.DataEncryptionMethod function init(string urn) {
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
