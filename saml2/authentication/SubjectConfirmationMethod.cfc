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
  displayname="Enum SubjectConfirmationMethod"
  output="false"
{
  import cfboom.security.saml.saml2.authentication.SubjectConfirmationMethod;

  variables['_map'] = {
    "urn:oasis:names:tc:SAML:2.0:cm:holder-of-key" = "HOLDER_OF_KEY",
    "urn:oasis:names:tc:SAML:2.0:cm:sender-vouches" = "SENDER_VOUCHES",
    "urn:oasis:names:tc:SAML:2.0:cm:bearer" = "BEARER"
  };

  public cfboom.security.saml.saml2.authentication.SubjectConfirmationMethod function enum() {
    variables['_values'] = [];

    this.HOLDER_OF_KEY = new SubjectConfirmationMethod("urn:oasis:names:tc:SAML:2.0:cm:holder-of-key");
    arrayAppend(variables._values, this.HOLDER_OF_KEY);

    this.SENDER_VOUCHES = new SubjectConfirmationMethod("urn:oasis:names:tc:SAML:2.0:cm:sender-vouches");
    arrayAppend(variables._values, this.SENDER_VOUCHES);

    this.BEARER = new SubjectConfirmationMethod("urn:oasis:names:tc:SAML:2.0:cm:bearer");
    arrayAppend(variables._values, this.BEARER);

    return this;
  }

  public cfboom.security.saml.saml2.authentication.SubjectConfirmationMethod function init(string urn) {
    variables['_urn'] = arguments.urn;
    variables['_name'] = variables._map[arguments.urn];
    return this;
  }

  public cfboom.security.saml.saml2.authentication.SubjectConfirmationMethod function fromUrn(string other) {
    for (var name in variables._values) {
      if (arguments.other.equalsIgnoreCase(name.toString())) {
        return name;
      }
    }
    throw("No SubjectConfirmationMethod enum for: " & arguments.other, "SamlException");
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
