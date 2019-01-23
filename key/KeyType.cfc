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
  displayname="Enum KeyType"
  output="false"
{
  import cfboom.security.saml.key.KeyType;

  variables['_map'] = {
    "signing" = "SIGNING",
    "unspecified" = "UNSPECIFIED",
    "encryption" = "ENCRYPTION"
  };

  public cfboom.security.saml.key.KeyType function enum() {
    variables['_values'] = [];
    this.SIGNING = new KeyType("signing");
    arrayAppend(variables._values, this.SIGNING);
    this.UNSPECIFIED = new KeyType("unspecified");
    arrayAppend(variables._values, this.UNSPECIFIED);
    this.ENCRYPTION = new KeyType("encryption");
    arrayAppend(variables._values, this.ENCRYPTION);
    return this;
  }

  public cfboom.security.saml.key.KeyType function init(string type) {
    variables['_type'] = arguments.type;
    variables['_name'] = variables._map[arguments.type];
    return this;
  }

  public cfboom.security.saml.key.KeyType function fromTypeName(string name) {
    for (var t in variables._values) {
      if (arguments.name.equals(t.getTypeName())) {
        return t;
      }
    }
    return this.UNSPECIFIED;
  }

  public string function name() {
    return variables._name;
  }

  public string function getTypeName() {
    return variables._type;
  }
}
