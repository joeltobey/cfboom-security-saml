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
 * Implementation saml:AttributeType as defined by
 * https://www.oasis-open.org/committees/download.php/35711/sstc-saml-core-errata-2.0-wd-06-diff.pdf
 * Page 30, Line 1284
 */
component
  extends="cfboom.lang.Object"
  displayname="Class Attribute"
  output="false"
{
  variables['Arrays'] = createObject("java", "java.util.Arrays");
  variables['Collections'] = createObject("java","java.util.Collections");
  variables['AttributeNameFormat'] = createObject("component","cfboom.security.saml.saml2.attribute.AttributeNameFormat").enum();
  //private String name;
  //private String friendlyName;
  variables['_values'] = createObject("java","java.util.LinkedList").init();
  variables['_nameFormat'] = AttributeNameFormat.UNSPECIFIED;
  //private boolean required;

  public cfboom.security.saml.saml2.attribute.Attribute function init() {
    return this;
  }

  public string function getName() {
    return variables._name;
  }

  public cfboom.security.saml.saml2.attribute.Attribute function setName(String name) {
    variables['_name'] = arguments.name;
    return this;
  }

  public any function getValues() {
    return Collections.unmodifiableList(variables._values);
  }

  public cfboom.security.saml.saml2.attribute.Attribute function setValues(any values) {
    variables._values.clear();
    variables._values.addAll(arguments.values);
    return this;
  }

  public cfboom.security.saml.saml2.attribute.AttributeNameFormat function getNameFormat() {
    return variables._nameFormat;
  }

  public cfboom.security.saml.saml2.attribute.Attribute function setNameFormat(cfboom.security.saml.saml2.attribute.AttributeNameFormat nameFormat) {
    variables['_nameFormat'] = arguments.nameFormat;
    return this;
  }

  public string function getFriendlyName() {
    return variables._friendlyName;
  }

  public cfboom.security.saml.saml2.attribute.Attribute function setFriendlyName(String friendlyName) {
    variables['_friendlyName'] = arguments.friendlyName;
    return this;
  }

  public boolean function isRequired() {
    return variables._required;
  }

  public cfboom.security.saml.saml2.attribute.Attribute function setRequired(boolean required_flag) {
    variables['_required'] = arguments.required_flag;
    return this;
  }

  public cfboom.security.saml.saml2.attribute.Attribute function addValues(array values) {
    variables.values.addAll(Arrays.asList(arguments.values));
    return this;
  }
}
