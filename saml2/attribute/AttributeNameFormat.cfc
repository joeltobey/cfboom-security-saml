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
  displayname="Enum AttributeNameFormat"
  output="false"
{
  import cfboom.security.saml.saml2.attribute.AttributeNameFormat;

  variables['_map'] = {
    "urn:oasis:names:tc:SAML:2.0:attrname-format:unspecified" = "UNSPECIFIED",
    "urn:oasis:names:tc:SAML:2.0:attrname-format:uri" = "URI",
    "urn:oasis:names:tc:SAML:2.0:attrname-format:basic" = "BASIC"
  };

  public cfboom.security.saml.saml2.attribute.AttributeNameFormat function enum() {
    variables['_values'] = [];

    this.UNSPECIFIED = new AttributeNameFormat("urn:oasis:names:tc:SAML:2.0:attrname-format:unspecified");
    arrayAppend(variables._values, this.UNSPECIFIED);

    this.URI = new AttributeNameFormat("urn:oasis:names:tc:SAML:2.0:attrname-format:uri");
    arrayAppend(variables._values, this.URI);

    this.BASIC = new AttributeNameFormat("urn:oasis:names:tc:SAML:2.0:attrname-format:basic");
    arrayAppend(variables._values, this.BASIC);

    return this;
  }

  public cfboom.security.saml.saml2.attribute.AttributeNameFormat function init(string urn) {
    variables['_urn'] = arguments.urn;
    variables['_name'] = variables._map[arguments.urn];
    return this;
  }

  public cfboom.security.saml.saml2.attribute.AttributeNameFormat function fromUrn(string other) {
    for (var name in variables._values) {
      if (arguments.other.equalsIgnoreCase(name.toString())) {
        return name;
      }
    }
    return this.UNSPECIFIED;
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
