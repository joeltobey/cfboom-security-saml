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
 * Defines EndpointType as defined by
 * https://www.oasis-open.org/committees/download.php/35391/sstc-saml-metadata-errata-2.0-wd-04-diff.pdf
 * Page 9, Line 294
 */
component
  extends="cfboom.lang.Object"
  displayname="Class Endpoint"
  output="false"
{
  variables['_index'] = javaCast("int", 0);

  public cfboom.security.saml.saml2.metadata.Endpoint function init() {
    return this;
  }

  public numeric function getIndex() {
    return variables._index;
  }

  public cfboom.security.saml.saml2.metadata.Endpoint function setIndex(numeric index) {
    variables['_index'] = javaCast("int",arguments.index);
    return this;
  }

  public boolean function isDefault() {
    return variables._isDefault;
  }

  public cfboom.security.saml.saml2.metadata.Endpoint function setDefault(boolean isDefault) {
    variables['_isDefault'] = arguments.isDefault;
    return this;
  }

  public cfboom.security.saml.saml2.metadata.Binding function getBinding() {
    return variables._binding;
  }

  public cfboom.security.saml.saml2.metadata.Endpoint function setBinding(cfboom.security.saml.saml2.metadata.Binding binding) {
    variables['_binding'] = binding;
    return this;
  }

  public string function getLocation() {
    return variables._location;
  }

  public cfboom.security.saml.saml2.metadata.Endpoint function setLocation(string location) {
    variables['_location'] = arguments.location;
    return this;
  }

  public string function getResponseLocation() {
    return variables._responseLocation;
  }

  public cfboom.security.saml.saml2.metadata.Endpoint function setResponseLocation(string responseLocation) {
    variables['_responseLocation'] = arguments.responseLocation;
    return this;
  }

  /**
   * @Override
   */
  public string function toString() {
    var sb = createObject("java","java.lang.StringBuffer").init("Endpoint{");
    sb.append("index=").append(variables._index);
    sb.append(", isDefault=").append(variables._isDefault);
    sb.append(", binding=").append(variables._binding.toString());
    sb.append(", location='").append(variables._location).append("'");
    sb.append('}');
    return sb.toString();
  }
}
