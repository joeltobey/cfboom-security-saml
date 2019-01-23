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
 *
 */
component
  extends="cfboom.lang.Object"
  displayname="Class AuthenticationContext"
  output="false"
{
  variables['AuthenticationContextClassReference'] = createObject("component","cfboom.security.saml.saml2.authentication.AuthenticationContextClassReference").enum();
  variables['_classReference'] = AuthenticationContextClassReference.UNSPECIFIED;

  public cfboom.security.saml.saml2.authentication.AuthenticationContext function init() {
    return this;
  }

  public cfboom.security.saml.saml2.authentication.AuthenticationContextClassReference function getClassReference() {
    return variables._classReference;
  }

  public cfboom.security.saml.saml2.authentication.AuthenticationContext function setClassReference(cfboom.security.saml.saml2.authentication.AuthenticationContextClassReference classReference) {
    variables['_classReference'] = arguments.classReference;
    return this;
  }
}
