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
  displayname="Enum DigestMethod"
  output="false"
{
  import cfboom.security.saml.saml2.signature.DigestMethod;

  public cfboom.security.saml.saml2.signature.DigestMethod function enum() {
    variables['_values'] = [];

    /**
     * The <a href="http://www.w3.org/2000/09/xmldsig#sha1">
     * SHA1</a> digest method algorithm URI.
     */
    this.SHA1 = new DigestMethod(createObject("java","javax.xml.crypto.dsig.DigestMethod").SHA1);
    arrayAppend(variables._values, this.SHA1);

    /**
     * The <a href="http://www.w3.org/2001/04/xmlenc#sha256">
     * SHA256</a> digest method algorithm URI.
     */
    this.SHA256 = new DigestMethod(createObject("java","javax.xml.crypto.dsig.DigestMethod").SHA256);
    arrayAppend(variables._values, this.SHA256);

    /**
     * The <a href="http://www.w3.org/2001/04/xmlenc#sha512">
     * SHA512</a> digest method algorithm URI.
     */
    this.SHA512 = new DigestMethod(createObject("java","javax.xml.crypto.dsig.DigestMethod").SHA512);
    arrayAppend(variables._values, this.SHA512);

    /**
     * The <a href="http://www.w3.org/2001/04/xmlenc#ripemd160">
     * RIPEMD-160</a> digest method algorithm URI.
     */
    this.RIPEMD160 = new DigestMethod(createObject("java","javax.xml.crypto.dsig.DigestMethod").RIPEMD160);
    arrayAppend(variables._values, this.RIPEMD160);

    return this;
  }

  public cfboom.security.saml.saml2.signature.DigestMethod function init(string urn) {
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
