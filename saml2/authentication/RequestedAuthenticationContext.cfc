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
 * Implementation samlp:RequestedAuthnContextType comparison values as defined by
 * https://www.oasis-open.org/committees/download.php/35711/sstc-saml-core-errata-2.0-wd-06-diff.pdf
 * Page 44, Line 1871
 */
component
  displayname="Enum RequestedAuthenticationContext"
  output="false"
{
  import cfboom.security.saml.saml2.authentication.RequestedAuthenticationContext;

  variables['_map'] = {
    "exact" = "exact",
    "minimum" = "minimum",
    "maximum" = "maximum",
    "better" = "better"
  };

  public cfboom.security.saml.saml2.authentication.RequestedAuthenticationContext function enum() {
    variables['_values'] = [];

    this.exact = new RequestedAuthenticationContext("exact");
    arrayAppend(variables._values, this.exact);

    this.minimum = new RequestedAuthenticationContext("minimum");
    arrayAppend(variables._values, this.minimum);

    this.maximum = new RequestedAuthenticationContext("maximum");
    arrayAppend(variables._values, this.maximum);

    this.better = new RequestedAuthenticationContext("better");
    arrayAppend(variables._values, this.better);

    return this;
  }

  public cfboom.security.saml.saml2.authentication.RequestedAuthenticationContext function init(string value) {
    variables['_value'] = arguments.value;
    variables['_name'] = variables._map[arguments.value];
    return this;
  }

  public any function fromValue(string other) {
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
    return variables._value;
  }
}
