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
interface
  displayname="Interface HostedProviderService"
{
  public cfboom.security.saml.provider.config.LocalProviderConfiguration function getConfiguration();

  public cfboom.security.saml.saml2.metadata.Metadata function getMetadata();

  public any function getRemoteProviders();

  public cfboom.security.saml.saml2.authentication.LogoutRequest function logoutRequest(cfboom.security.saml.saml2.metadata.Metadata recipient, cfboom.security.saml.saml2.authentication.NameIdPrincipal principal);

  public cfboom.security.saml.saml2.authentication.LogoutResponse function logoutResponse(cfboom.security.saml.saml2.authentication.LogoutRequest req, cfboom.security.saml.saml2.metadata.Metadata recipient);

  public cfboom.security.saml.saml2.metadata.Metadata function getRemoteProviderFromSaml2Object(cfboom.security.saml.saml2.Saml2Object saml2Object);

  public cfboom.security.saml.saml2.metadata.Metadata function getRemoteProvider(any obj);

  public cfboom.security.saml.saml2.metadata.Metadata function getRemoteProviderFromExternalProviderConfiguration(cfboom.security.saml.provider.config.ExternalProviderConfiguration c);

  public cfboom.security.saml.validation.ValidationResult function validate(cfboom.security.saml.saml2.Saml2Object saml2Object);

  public cfboom.security.saml.saml2.Saml2Object function fromXml(string xmlString, boolean encoded, boolean deflated, string type);

  public string function toXml(cfboom.security.saml.saml2.Saml2Object saml2Object);

  public string function toEncodedXmlFromSaml2Object(cfboom.security.saml.saml2.Saml2Object saml2Object, boolean deflate);

  public string function toEncodedXml(string xmlString, boolean deflate);

  public any function getPreferredEndpoint(any endpoints, cfboom.security.saml.saml2.metadata.Binding preferredBinding, numeric preferredIndex);
}
