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
 * @author Joel Tobey
 */
interface
  displayname="Interface SamlTransformer"
{
  /**
   * Converts a SAML object into an XML string.
   * If the object contains signing keys, the XML object will be signed prior to converting it
   * to a string
   *
   * @param saml2Object - object to be converted to XML
   * @return string representation of the XML object
   */
  public string function toXml(cfboom.security.saml.saml2.Saml2Object saml2Object);

  /**
   * Converts an SAML/XML string into a Java object
   *
   * @param xml              the XML representation of the object
   * @param verificationKeys Nullable. If not null, object signature will be validated upon conversion.
   *                         The implementation will attempt each key until one succeeds
   * @param localKeys        the configured local private keys. Used for decryption when needed.
   * @return the Java object that was
   * @throws org.springframework.security.saml.saml2.signature.SignatureException if signature validation
   *                                                                              fails
   * @throws IllegalArgumentException                                             if the XML object
   *                                                                              structure
   *                                                                              is not
   *                                                                              recognized or implemeted
   */
  public cfboom.security.saml.saml2.Saml2Object function fromXml(string xmlString, any verificationKeys, any localKeys);

  /**
   * Converts an SAML/XML string into a Java object
   *
   * @param xml              the XML representation of the object
   * @param verificationKeys Nullable. If not null, object signature will be validated upon conversion.
   *                         The implementation will attempt each key until one succeeds
   * @param localKeys        the configured local private keys. Used for decryption when needed.
   * @return the Java object that was
   * @throws org.springframework.security.saml.saml2.signature.SignatureException if signature validation
   *                                                                              fails
   * @throws IllegalArgumentException                                             if the XML object
   *                                                                              structure
   *                                                                              is not
   *                                                                              recognized or implemeted
   * /
  public cfboom.security.saml.saml2.Saml2Object function fromXml(byte[] xml, List<SimpleKey> verificationKeys, List<SimpleKey> localKeys);*/

  /**
   * Deflates and base64 encodes the SAML message readying it for transport.
   * If the result is used as a query parameter, it still has to be URL encoded.
   *
   * @param s       - original string
   * @param deflate - if set to true the DEFLATE encoding will be applied
   * @return encoded string
   */
  public string function samlEncode(string s, boolean deflate = false);

  /**
   * base64 decodes and inflates the SAML message.
   *
   * @param s       base64 encoded deflated string
   * @param inflate - if set to true the value will be deflated
   * @return the original string
   */
  public string function samlDecode(string s, boolean inflate = false);
}
