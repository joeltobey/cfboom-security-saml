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
interface
  displayname="Interface SamlValidator"
{
  /**
   * Validates a signature on a SAML object. Returns the key that validated the signature
   *
   * @saml2Object.hint      - a signed object to validate
   * @verificationKeys.hint a list of keys to use for validation
   * @return the key that successfully validated the signature
   * @throws SignatureException if object failed signature validation
   */
  public cfboom.security.saml.saml2.signature.Signature function validateSignature(cfboom.security.saml.saml2.Saml2Object saml2Object, any verificationKeys);

  /**
   * Performs an object validation on the respective object
   *
   * @saml2Object.hint the object to be validated according to SAML specification rules
   * @provider.hint    the object used to resolve metadata
   * @throws ValidationException if validation failed. Details in the exception.
   */
  public void function validate(cfboom.security.saml.saml2.Saml2Object saml2Object, cfboom.security.saml.provider.HostedProviderService provider);
}
