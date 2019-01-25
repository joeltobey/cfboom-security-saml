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
 * Represents metadata for a
 * <ul>
 * <li>SSO Service Provider</li>
 * <li>SSO Identity Provider</li>
 * </ul>
 * May be chained if read from EntitiesDescriptor element.
 *
 * Currently does <b>not support</b> metadata for
 * <ul>
 * <li>Authentication Authority</li>
 * <li>Attribute Authority</li>
 * <li>Policy Decision Point</li>
 * <li>Affiliation</li>
 * </ul>
 */
component
  extends="cfboom.security.saml.saml2.metadata.EntityDescriptor"
  implements="cfboom.security.saml.saml2.Saml2Object"
  displayname="Class Metadata"
  output="false"
{
  /*
   * In case of parsing EntitiesDescriptor, we can have more than one provider
   */
  property name="_next" type="cfboom.security.saml.saml2.metadata.Metadata" class="<T extends EntityDescriptor<T>>";

  public cfboom.security.saml.saml2.metadata.Metadata function init(cfboom.security.saml.saml2.metadata.EntityDescriptor other) {
    super.init( argumentCollection = arguments );
    return this;
  }

  public cfboom.security.saml.saml2.metadata.EntityDescriptor function getNext() {
    return structKeyExists(variables, "_next") ? variables._next : null;
  }

  public cfboom.security.saml.saml2.metadata.Metadata function setNext(cfboom.security.saml.saml2.metadata.EntityDescriptor next) {
    if (structKeyExists(arguments, "next") && !isNull(arguments.next)) {
      variables['_next'] = arguments.next;
    }
    else {
      structDelete(variables, "_next");
    }
    return this;
  }

  public boolean function hasNext() {
    return structKeyExists(variables, "_next");
  }
}
