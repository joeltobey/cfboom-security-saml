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
 * Defines binding type as part of an Endpoint as defined by
 * https://www.oasis-open.org/committees/download.php/35391/sstc-saml-metadata-errata-2.0-wd-04-diff.pdf
 * Page 8, Line 271
 */
component
  displayname="Enum NameIdFormat"
  output="false"
{
  import cfboom.security.saml.saml2.metadata.BindingType;

  variables['_map'] = {
    "urn:oasis:names:tc:SAML:2.0:bindings:HTTP-POST" = "POST",
    "urn:oasis:names:tc:SAML:2.0:bindings:HTTP-Redirect" = "REDIRECT",
    "urn:oasis:names:tc:SAML:2.0:bindings:URI" = "URI",
    "urn:oasis:names:tc:SAML:2.0:bindings:HTTP-Artifact" = "ARTIFACT",
    "urn:oasis:names:tc:SAML:2.0:bindings:HTTP-POST-SimpleSign" = "POST_SIMPLE_SIGN",
    "urn:oasis:names:tc:SAML:2.0:bindings:PAOS" = "PAOS",
    "urn:oasis:names:tc:SAML:2.0:bindings:SOAP" = "SOAP",
    "urn:oasis:names:tc:SAML:profiles:SSO:idp-discovery-protocol" = "DISCOVERY",
    "urn:oasis:names:tc:SAML:profiles:SSO:request-init" = "REQUEST_INITIATOR",
    "urn:oasis:names:tc:SAML:1.0:profiles:browser-post" = "SAML_1_0_BROWSER_POST",
    "urn:oasis:names:tc:SAML:1.0:profiles:artifact-01" = "SAML_1_0_BROWSER_ARTIFACT",
    "urn:cfboom-security:SAML:2.0:custom" = "CUSTOM"
  };

  public cfboom.security.saml.saml2.metadata.BindingType function enum() {
    variables['_values'] = [];

    this.POST = new BindingType("urn:oasis:names:tc:SAML:2.0:bindings:HTTP-POST");
    arrayAppend(variables._values, this.POST);

    this.REDIRECT = new BindingType("urn:oasis:names:tc:SAML:2.0:bindings:HTTP-Redirect");
    arrayAppend(variables._values, this.REDIRECT);

    this.URI = new BindingType("urn:oasis:names:tc:SAML:2.0:bindings:URI");
    arrayAppend(variables._values, this.URI);

    this.ARTIFACT = new BindingType("urn:oasis:names:tc:SAML:2.0:bindings:HTTP-Artifact");
    arrayAppend(variables._values, this.ARTIFACT);

    this.POST_SIMPLE_SIGN = new BindingType("urn:oasis:names:tc:SAML:2.0:bindings:HTTP-POST-SimpleSign");
    arrayAppend(variables._values, this.POST_SIMPLE_SIGN);

    this.PAOS = new BindingType("urn:oasis:names:tc:SAML:2.0:bindings:PAOS");
    arrayAppend(variables._values, this.PAOS);

    this.SOAP = new BindingType("urn:oasis:names:tc:SAML:2.0:bindings:SOAP");
    arrayAppend(variables._values, this.SOAP);

    this.DISCOVERY = new BindingType("urn:oasis:names:tc:SAML:profiles:SSO:idp-discovery-protocol");
    arrayAppend(variables._values, this.DISCOVERY);

    this.REQUEST_INITIATOR = new BindingType("urn:oasis:names:tc:SAML:profiles:SSO:request-init");
    arrayAppend(variables._values, this.REQUEST_INITIATOR);

    this.SAML_1_0_BROWSER_POST = new BindingType("urn:oasis:names:tc:SAML:1.0:profiles:browser-post");
    arrayAppend(variables._values, this.SAML_1_0_BROWSER_POST);

    this.SAML_1_0_BROWSER_ARTIFACT = new BindingType("urn:oasis:names:tc:SAML:1.0:profiles:artifact-01");
    arrayAppend(variables._values, this.SAML_1_0_BROWSER_ARTIFACT);

    this.CUSTOM = new BindingType("urn:cfboom-security:SAML:2.0:custom");
    arrayAppend(variables._values, this.CUSTOM);

    return this;
  }

  public cfboom.security.saml.saml2.metadata.BindingType function init(string urn) {
    variables['_urn'] = arguments.urn;
    variables['_name'] = variables._map[arguments.urn];
    return this;
  }

  public cfboom.security.saml.saml2.metadata.BindingType function fromUrn(string other) {
    for (var binding in variables._values) {
      if (arguments.other.equalsIgnoreCase(binding.toString())) {
        return binding;
      }
    }
    return this.CUSTOM;
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
