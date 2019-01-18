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
  this.RSA_SHA1 = "http://www.w3.org/2000/09/xmldsig##rsa-sha1";
  this.RSA_SHA256 = "http://www.w3.org/2001/04/xmldsig-more##rsa-sha256";
  this.RSA_SHA512 = "http://www.w3.org/2001/04/xmldsig-more##rsa-sha512";
  this.RSA_RIPEMD160 = "http://www.w3.org/2001/04/xmldsig-more##rsa-ripemd160";

  public cfboom.security.saml.saml2.signature.AlgorithmMethod function init() {
    return this;
  }
}
