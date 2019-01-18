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
  displayname="Class ExternalProviderConfiguration"
  output="false"
{
  variables['_skipSslValidation'] = false;
  variables['_metadataTrustCheck'] = false;
  variables['_verificationKeys'] = createObject("java","java.util.LinkedList").init();

  variables['Collections'] = createObject("java","java.util.Collections");
  variables['Optional'] = createObject("java","java.util.Optional");
  variables['UUID'] = createObject("java","java.util.UUID");

  public cfboom.security.saml.provider.config.ExternalProviderConfiguration function init() {
    return this;
  }

  public string function getAlias() {
    if (structKeyExists(variables, "_alias"))
      return variables._alias;
  }

  public cfboom.security.saml.provider.config.ExternalProviderConfiguration function setAlias(string alias) {
    variables['_alias'] = arguments.alias;
    return this;
  }

  public string function getMetadata() {
    if (structKeyExists(variables, "_metadata"))
      return variables._metadata;
  }

  public cfboom.security.saml.provider.config.ExternalProviderConfiguration function setMetadata(string metadata) {
    variables['_metadata'] = arguments.metadata;
    return this;
  }

  public string function getLinktext() {
    if (structKeyExists(variables, "_linktext"))
      return variables._linktext;
  }

  public cfboom.security.saml.provider.config.ExternalProviderConfiguration function setLinktext(string linktext) {
    variables['_linktext'] = arguments.linktext;
    return this;
  }

  public boolean function isSkipSslValidation() {
    return variables._skipSslValidation;
  }

  public cfboom.security.saml.provider.config.ExternalProviderConfiguration function setSkipSslValidation(boolean skipSslValidation) {
    variables['_skipSslValidation'] = arguments.skipSslValidation;
    return this;
  }

  public boolean function isMetadataTrustCheck() {
    return variables._metadataTrustCheck;
  }

  public cfboom.security.saml.provider.config.ExternalProviderConfiguration function setMetadataTrustCheck(boolean metadataTrustCheck) {
    variables['_metadataTrustCheck'] = arguments.metadataTrustCheck;
    return this;
  }

  public any function getVerificationKeys() {
    return Optional.ofNullable(variables._verificationKeys).orElse(Collections.emptyList());
  }

  public cfboom.security.saml.provider.config.ExternalProviderConfiguration function setVerificationKeys(any verificationKeys) {
    variables['_verificationKeys'] = arguments.verificationKeys;
    return this;
  }

  public any function getVerificationKeyData() {
    return getVerificationKeys()
      .stream()
      .map(
        s -> new SimpleKey()
          .setName("from-config-" & UUID.randomUUID().toString())
          .setCertificate(s)
      )
      .collect(Collectors.toList());
  }

  /**
   * @Override
   */
  public cfboom.security.saml.provider.config.ExternalProviderConfiguration function clone() {
    return super.clone();
  }

}