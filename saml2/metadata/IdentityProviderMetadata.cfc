/*
 * Copyright 2019 the original author or authors and Joel Tobey <joeltobey@gmail.com>
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
 * Represents metadata providing the IDPSSODescriptor entity
 */
component
  extends="cfboom.security.saml.saml2.metadata.Metadata"
  displayname="Class IdentityProviderMetadata"
  output="false"
{
  property name="_defaultNameId" type="cfboom.security.saml.saml2.metadata.NameId";

  public cfboom.security.saml.saml2.metadata.IdentityProviderMetadata function init(cfboom.security.saml.saml2.metadata.EntityDescriptor other) {
    super.init( argumentCollection = arguments );
    if (structKeyExists(arguments, "other") && isInstanceOf(arguments.other, "cfboom.security.saml.saml2.metadata.IdentityProviderMetadata"))
      variables['_defaultNameId'] = arguments.other.getDefaultNameId();
    return this;
  }

  public any function getIdentityProvider() {
    if (!isNull(getProviders())) {
      for (var provider in getProviders()) {
        if (isInstanceOf(provider, "cfboom.security.saml.saml2.metadata.IdentityProvider")) {
          return provider;
        }
      }
    }
  }

  public cfboom.security.saml.saml2.metadata.NameId function getDefaultNameId() {
    return variables._defaultNameId;
  }

  public cfboom.security.saml.saml2.metadata.IdentityProviderMetadata function setDefaultNameId(cfboom.security.saml.saml2.metadata.NameId defaultNameId) {
    variables['_defaultNameId'] = arguments.defaultNameId;
    return this;
  }
}
