/*
 * Copyright 2002-2019 the original author or authors and Joel Tobey <joeltobey@gmail.com>
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
  extends="cfboom.security.saml.provider.config.ExternalProviderConfiguration"
  displayname="Class ExternalIdentityProviderConfiguration"
  output="false"
{
  property name="NameId" inject="NameId@cfboom-security-saml";

  public cfboom.security.saml.provider.service.config.ExternalIdentityProviderConfiguration function init() {
    return this;
  }

  public any function getNameId() {
    if (structKeyExists(variables, "_nameId"))
      return variables._nameId;
  }

  public cfboom.security.saml.provider.service.config.ExternalIdentityProviderConfiguration function setNameId(any nameId) {
    if (!structKeyExists(arguments, "nameId") || isNull(arguments.nameId)) {
      structDelete(variables, "_nameId");
    }
    else if (isInstanceOf(arguments.nameId, "java.lang.String")) {
      variables['_nameId'] = variables.NameId.fromUrn(arguments.nameId);
    }
    else if (isInstanceOf(arguments.nameId, "cfboom.security.saml.saml2.metadata.NameId")) {
      variables['_nameId'] = arguments.nameId;
    }
    else {
      throw("Unknown NameId type:" & arguments.nameId.getClass().getName(), "SamlException");
    }
    return this;
  }

  public numeric function getAssertionConsumerServiceIndex() {
    return variables._assertionConsumerServiceIndex;
  }

  public cfboom.security.saml.provider.service.config.ExternalIdentityProviderConfiguration function setAssertionConsumerServiceIndex(numeric assertionConsumerServiceIndex) {
    variables._assertionConsumerServiceIndex = javaCast("int", arguments.assertionConsumerServiceIndex);
    return this;
  }
}
