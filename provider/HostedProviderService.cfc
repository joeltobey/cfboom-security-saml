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
 * @author Joel Tobey
 */
interface
  displayname="Interface HostedProviderService"
{
/*
  Configuration getConfiguration();

  LocalMetadata getMetadata();

  List<RemoteMetadata> getRemoteProviders();

  LogoutRequest logoutRequest(RemoteMetadata recipient,
                NameIdPrincipal principal);

  LogoutResponse logoutResponse(LogoutRequest request,
                  RemoteMetadata recipient);

  RemoteMetadata getRemoteProvider(Saml2Object saml2Object);

  RemoteMetadata getRemoteProvider(String entityId);

  RemoteMetadata getRemoteProvider(ExternalProviderConfiguration c);

  ValidationResult validate(Saml2Object saml2Object);

  <T extends Saml2Object> T fromXml(String xml, boolean encoded, boolean deflated, Class<T> type);

  String toXml(Saml2Object saml2Object);

  String toEncodedXml(Saml2Object saml2Object, boolean deflate);

  String toEncodedXml(String xml, boolean deflate);

  Endpoint getPreferredEndpoint(List<Endpoint> endpoints,
                  Binding preferredBinding,
                  int preferredIndex);
*/
}
