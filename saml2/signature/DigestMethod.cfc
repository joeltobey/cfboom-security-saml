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
  /**
   * The <a href="http://www.w3.org/2000/09/xmldsig#sha1">
   * SHA1</a> digest method algorithm URI.
   */
  this.SHA1 = createObject("java","javax.xml.crypto.dsig.DigestMethod").SHA1;

  /**
   * The <a href="http://www.w3.org/2001/04/xmlenc#sha256">
   * SHA256</a> digest method algorithm URI.
   */
  this.SHA256 = createObject("java","javax.xml.crypto.dsig.DigestMethod").SHA256;

  /**
   * The <a href="http://www.w3.org/2001/04/xmlenc#sha512">
   * SHA512</a> digest method algorithm URI.
   */
  this.SHA512 = createObject("java","javax.xml.crypto.dsig.DigestMethod").SHA512;

  /**
   * The <a href="http://www.w3.org/2001/04/xmlenc#ripemd160">
   * RIPEMD-160</a> digest method algorithm URI.
   */
  this.RIPEMD160 = createObject("java","javax.xml.crypto.dsig.DigestMethod").RIPEMD160;

  public cfboom.security.saml.saml2.signature.DigestMethod function init() {
    return this;
  }
}