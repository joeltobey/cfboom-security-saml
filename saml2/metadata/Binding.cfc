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
  displayname="Enum Binding"
  output="false"
{
  import cfboom.security.saml.saml2.metadata.Binding;
  variables['BindingType'] = createObject("component","cfboom.security.saml.saml2.metadata.BindingType").enum();

  public cfboom.security.saml.saml2.metadata.Binding function enum() {
    variables['_values'] = [];

    this.POST = new Binding(BindingType.POST.toUri());
    arrayAppend(variables._values, this.POST);

    this.REDIRECT = new Binding(BindingType.REDIRECT.toUri());
    arrayAppend(variables._values, this.REDIRECT);

    this.URI = new Binding(BindingType.URI.toUri());
    arrayAppend(variables._values, this.URI);

    this.ARTIFACT = new Binding(BindingType.ARTIFACT.toUri());
    arrayAppend(variables._values, this.ARTIFACT);

    this.POST_SIMPLE_SIGN = new Binding(BindingType.POST_SIMPLE_SIGN.toUri());
    arrayAppend(variables._values, this.POST_SIMPLE_SIGN);

    this.PAOS = new Binding(BindingType.PAOS.toUri());
    arrayAppend(variables._values, this.PAOS);

    this.SOAP = new Binding(BindingType.SOAP.toUri());
    arrayAppend(variables._values, this.SOAP);

    this.DISCOVERY = new Binding(BindingType.DISCOVERY.toUri());
    arrayAppend(variables._values, this.DISCOVERY);

    this.REQUEST_INITIATOR = new Binding(BindingType.REQUEST_INITIATOR.toUri());
    arrayAppend(variables._values, this.REQUEST_INITIATOR);

    this.SAML_1_0_BROWSER_POST = new Binding(BindingType.SAML_1_0_BROWSER_POST.toUri());
    arrayAppend(variables._values, this.SAML_1_0_BROWSER_POST);

    this.SAML_1_0_BROWSER_ARTIFACT = new Binding(BindingType.SAML_1_0_BROWSER_ARTIFACT.toUri());
    arrayAppend(variables._values, this.SAML_1_0_BROWSER_ARTIFACT);

    this.CUSTOM = new Binding(BindingType.CUSTOM.toUri());
    arrayAppend(variables._values, this.CUSTOM);

    return this;
  }

  public cfboom.security.saml.saml2.metadata.Binding function init(any uri, cfboom.security.saml.saml2.metadata.BindingType type) {
    if (isInstanceOf(arguments.uri, "java.lang.String"))
      arguments.uri = createObject("java","java.net.URI").init(arguments.uri);
    if (!structKeyExists(arguments, "type"))
      arguments['type'] = BindingType.fromUrn(arguments.uri.toString());
    variables['_value'] = arguments.uri;
    variables['_type'] = arguments.type;
    return this;
  }

  public any function fromUrn(string other) {
    if (!structKeyExists(arguments, "other") || isNull(arguments.other) || !len(trim(arguments.other))) {
      return;
    }

    var uri = createObject("java","java.net.URI").init(arguments.other);

    var type = BindingType.fromUrn(arguments.other);
    switch (type.name()) {
      case "REDIRECT": return this.REDIRECT;
      case "POST": return this.POST;
      case "URI": return this.URI;
      case "ARTIFACT": return this.ARTIFACT;
      case "POST_SIMPLE_SIGN": return this.POST_SIMPLE_SIGN;
      case "PAOS": return this.PAOS;
      case "SOAP": return this.SOAP;
      case "DISCOVERY": return this.DISCOVERY;
      case "REQUEST_INITIATOR": return this.REQUEST_INITIATOR;
      case "SAML_1_0_BROWSER_ARTIFACT": return this.SAML_1_0_BROWSER_ARTIFACT;
      case "SAML_1_0_BROWSER_POST": return this.SAML_1_0_BROWSER_POST;
      case "CUSTOM": return this.CUSTOM;
    }
    throw("Unknown binding type: " & arguments.other, "SamlException");
  }

  public any function getValue() {
    return variables._value;
  }

  public cfboom.security.saml.saml2.metadata.BindingType function getType() {
    return variables._type;
  }

  /**
   * @Override
   */
  public string function toString() {
    return getValue().toString();
  }
}
