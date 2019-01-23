/*
 * Copyright 2016-2019 the original author or authors and Joel Tobey <joeltobey@gmail.com>
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
  extends="cfboom.lang.Object"
  implements="cfboom.security.saml.saml2.Saml2Object"
  displayname="Abstract Class ImplementationHolder"
  output="false"
{
  public cfboom.security.saml.saml2.ImplementationHolder function init() {
    return this;
  }

  /**
   * @Override
   */
  public any function getImplementation() {
    return variables._implementation;
  }

  public cfboom.security.saml.saml2.ImplementationHolder function setImplementation(any implementation) {
    variables['_implementation'] = arguments.implementation;
    return this;
  }

  /**
   * @Override
   */
  public string function getOriginalXML() {
    return variables._originalXML;
  }

  public cfboom.security.saml.saml2.ImplementationHolder function setOriginalXML(string originalXML) {
    variables['_originalXML'] = arguments.originalXML;
    return this;
  }
}
