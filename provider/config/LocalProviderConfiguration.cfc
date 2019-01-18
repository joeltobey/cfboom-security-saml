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
 * @author Joel Tobey
 */
component
  extends="cfboom.lang.Object"
  displayname="Class LocalProviderConfiguration"
  output="false"
{
  variables['_singleLogoutEnabled'] = true;
  variables['_nameIds'] = createObject("java","java.util.LinkedList").init();
  variables['_defaultSigningAlgorithm'] = "http://www.w3.org/2001/04/xmldsig-more##rsa-sha256";
  variables['_defaultDigest'] = createObject("java","javax.xml.crypto.dsig.DigestMethod").SHA256;
  variables['_providers'] = createObject("java","java.util.LinkedList").init();

  public cfboom.security.saml.provider.config.LocalProviderConfiguration function init(string prefix) {
    setPrefix(arguments.prefix);
    return this;
  }

  public string function cleanPrefix(string prefix) {
    if (len(trim(arguments.prefix)) && arguments.prefix.startsWith("/")) {
      arguments.prefix = arguments.prefix.substring(1);
    }
    if (len(trim(arguments.prefix)) && !arguments.prefix.endsWith("/")) {
      arguments.prefix &= "/";
    }
    return arguments.prefix;
  }

  public string function getEntityId() {
    if (structKeyExists(variables, "_entityId"))
      return variables._entityId;
  }

  public cfboom.security.saml.provider.config.LocalProviderConfiguration function setEntityId(string entityId) {
    variables['_entityId'] = arguments.entityId;
    return this;
  }

  public boolean function isSignMetadata() {
    return variables._signMetadata;
  }

  public cfboom.security.saml.provider.config.LocalProviderConfiguration function setSignMetadata(boolean signMetadata) {
    variables['_signMetadata'] = arguments.signMetadata;
    return this;
  }

  public string function getMetadata() {
    if (structKeyExists(variables, "_metadata"))
      return variables._metadata;
  }

  public cfboom.security.saml.provider.config.LocalProviderConfiguration function setMetadata(string metadata) {
    variables['_metadata'] = arguments.metadata;
    return this;
  }

  public cfboom.security.saml.provider.config.RotatingKeys function getKeys() {
    return variables._keys;
  }

  public cfboom.security.saml.provider.config.LocalProviderConfiguration function setKeys(cfboom.security.saml.provider.config.RotatingKeys keys) {
    variables['_keys'] = arguments.keys;
    return this;
  }

  public string function getAlias() {
    if (structKeyExists(variables, "_alias"))
      return variables._alias;
  }

  public cfboom.security.saml.provider.config.LocalProviderConfiguration function setAlias(string alias) {
    variables['_alias'] = arguments.alias;
    return this;
  }

  public string function getPrefix() {
    if (structKeyExists(variables, "_prefix"))
      return variables._prefix;
  }

  public cfboom.security.saml.provider.config.LocalProviderConfiguration function setPrefix(string prefix) {
    arguments.prefix = cleanPrefix(arguments.prefix);
    variables['_prefix'] = arguments.prefix;

    return this;
  }

  public boolean function isSingleLogoutEnabled() {
    return variables._singleLogoutEnabled;
  }

  public cfboom.security.saml.provider.config.LocalProviderConfiguration function setSingleLogoutEnabled(boolean singleLogoutEnabled) {
    variables['_singleLogoutEnabled'] = arguments.singleLogoutEnabled;
    return this;
  }

  public any function getNameIds() {
    return variables._nameIds;
  }

  public cfboom.security.saml.provider.config.LocalProviderConfiguration function setNameIds(any nameIds) {
    //variables._nameIds = arguments.nameIds.stream().map(
      //n -> n instanceof String ? NameId.fromUrn((String)n) : (NameId)n).collect(Collectors.toList()
    //);
    variables['_nameIds'] = arguments.nameIds;
    return this;
  }

  public string function getDefaultSigningAlgorithm() {
    return variables._defaultSigningAlgorithm;
  }

  public cfboom.security.saml.provider.config.LocalProviderConfiguration function setDefaultSigningAlgorithm(string defaultSigningAlgorithm) {
    variables['_defaultSigningAlgorithm'] = arguments.defaultSigningAlgorithm;
    return this;
  }

  public any function getDefaultDigest() {
    return variables._defaultDigest;
  }

  public cfboom.security.saml.provider.config.LocalProviderConfiguration function setDefaultDigest(any defaultDigest) {
    variables['_defaultDigest'] = arguments.defaultDigest;
    return this;
  }

  public string function getBasePath() {
    if (structKeyExists(variables, "_basePath"))
      return variables._basePath;
  }

  public cfboom.security.saml.provider.config.LocalProviderConfiguration function setBasePath(string basePath) {
    variables['_basePath'] = arguments.basePath;
    return this;
  }

  /**
   * @Override
   */
  public cfboom.security.saml.provider.config.LocalProviderConfiguration function clone() {
    var result = super.clone();
    var newProviders = createObject("java","java.util.LinkedList").init();
    for (var externalConfiguration in getProviders()) {
      newProviders.add(externalConfiguration.clone());
    }
    result.setProviders(newProviders);
    return result;
  }

  public any function getProviders() {
    return variables._providers;
  }

  public cfboom.security.saml.provider.config.LocalProviderConfiguration function setProviders(any providers) {
    variables['_providers'] = arguments.providers;
    return this;
  }
}