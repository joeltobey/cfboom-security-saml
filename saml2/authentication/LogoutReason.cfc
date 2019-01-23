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
  displayname="Enum LogoutReason"
  output="false"
{
  import cfboom.security.saml.saml2.authentication.LogoutReason;

  variables['_map'] = {
    "urn:oasis:names:tc:SAML:2.0:logout:user" = "USER",
    "urn:oasis:names:tc:SAML:2.0:logout:admin" = "ADMIN",
    "urn:oasis:names:tc:SAML:2.0:logout:unknown" = "UNKNOWN"
  };

  public cfboom.security.saml.saml2.authentication.LogoutReason function enum() {
    variables['_values'] = [];

    this.USER = new NameIdFormat("urn:oasis:names:tc:SAML:2.0:logout:user");
    arrayAppend(variables._values, this.USER);

    this.ADMIN = new NameIdFormat("urn:oasis:names:tc:SAML:2.0:logout:admin");
    arrayAppend(variables._values, this.ADMIN);

    this.UNKNOWN = new NameIdFormat("urn:oasis:names:tc:SAML:2.0:logout:unknown");
    arrayAppend(variables._values, this.UNKNOWN);

    return this;
  }

  public cfboom.security.saml.saml2.authentication.LogoutReason function init(string urn) {
    variables['_urn'] = arguments.urn;
    variables['_name'] = variables._map[arguments.urn];
    return this;
  }

  public cfboom.security.saml.saml2.authentication.LogoutReason function fromUrn(string other) {
    for (var reason in variables._values) {
      if (arguments.other.equalsIgnoreCase(reason.toString())) {
        return reason;
      }
    }
    return this.UNKNOWN;
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
}
