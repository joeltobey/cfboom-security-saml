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
  extends="cfboom.lang.Object"
  implements="cfboom.security.saml.provider.HostedProviderService"
  displayname="Abstract Class AbstractHostedProviderService"
  output="false"
{
  property name="log" inject="logbox:logger:{this}";
  property name="wirebox" inject="wirebox";
  variables['UUID'] = createObject("java","java.util.UUID");
  variables['Collections'] = createObject("java","java.util.Collections");
  variables['StandardCharsets'] = createObject("java","java.nio.charset.StandardCharsets");

  //private final cfboom.security.saml.provider.config.LocalProviderConfiguration configuration;
  //private final cfboom.security.saml.saml2.metadata.Metadata metadata;
  //private final SamlTransformer transformer;
  //private final SamlValidator validator;
  //private final SamlMetadataCache cache;
  variables['_clock'] = createObject("java","java.time.Clock").systemUTC();

  public cfboom.security.saml.provider.AbstractHostedProviderService function init(cfboom.security.saml.provider.config.LocalProviderConfiguration configuration,
                                                                                   cfboom.security.saml.saml2.metadata.Metadata metadata,
                                                                                   cfboom.security.saml.SamlTransformer transformer,
                                                                                   cfboom.security.saml.SamlValidator validator,
                                                                                   cfboom.security.saml.SamlMetadataCache cache) {
    variables['_configuration'] = arguments.configuration;
    variables['_metadata'] = arguments.metadata;
    variables['_transformer'] = arguments.transformer;
    variables['_validator'] = arguments.validator;
    variables['_cache'] = arguments.cache;
    return this;
  }

  public void function onDIComplete() {
    //org.joda.time.DateTime
    variables['StatusCode'] = variables.wirebox.getInstance("StatusCode@cfboom-security-saml");
  }

  public any function getClock() {
    return variables._clock;
  }

  public cfboom.security.saml.provider.AbstractHostedProviderService function setClock(any clock) {
    variables.clock = arguments.clock;
    return this;
  }

  public cfboom.security.saml.SamlMetadataCache function getCache() {
    return variables._cache;
  }

  public any function getRemoteProviderFromIssuer(cfboom.security.saml.saml2.authentication.Issuer issuer) {
    if (!structKeyExists(arguments, "issuer") || isNull(arguments.issuer)) {
      return;
    }
    else {
      return getRemoteProvider(arguments.issuer.getValue());
    }
  }

  public cfboom.security.saml.saml2.metadata.Metadata function throwIfNull(any metadata, string key = "", string value = "") {
    if (!structKeyExists(arguments, "metadata") || isNull(arguments.metadata)) {
      var message = "Provider for key '#arguments.key#' with value '#arguments.value#' not found.";
      throw(message, "SamlProviderNotFoundException");
    }
    else {
      return arguments.metadata;
    }
  }

  /**
   * @Override
   */
  public cfboom.security.saml.provider.config.LocalProviderConfiguration function getConfiguration() {
    return variables._configuration;
  }

  /**
   * @Override
   */
  public cfboom.security.saml.saml2.metadata.Metadata function getMetadata() {
    return variables._metadata;
  }

  /**
   * @Override
   */
  public any function getRemoteProviders() {
    var result = createObject("java","java.util.LinkedList").init();
    var providers = getConfiguration().getProviders();
    for (var c in providers) {
      try {
        var m = getRemoteProvider(c);
        if (!isNull(m)) {
          m.setEntityAlias(c.getAlias());

          result.add(m);
        }
      } catch (SamlException x) {
        log.debug("Unable to resolve identity provider metadata.", x);
      }
    }
    return result;
  }

  /**
   * @Override
   */
  public cfboom.security.saml.saml2.authentication.LogoutRequest function logoutRequest(cfboom.security.saml.saml2.metadata.Metadata recipient, cfboom.security.saml.saml2.authentication.NameIdPrincipal principal) {
    var localMetadata = this.getMetadata();

    var ssoProviders = arguments.recipient.getSsoProviders();
    var result = new cfboom.security.saml.saml2.authentication.LogoutRequest()
      .setId(UUID.randomUUID().toString())
      .setDestination(
        getPreferredEndpoint(
          ssoProviders.get(0).getSingleLogoutService(),
          null,
          -1
        )
      )
      .setIssuer(new cfboom.security.saml.saml2.authentication.Issuer().setValue(localMetadata.getEntityId()))
      .setIssueInstant(DateTime.now())
      .setNameId(principal)
      .setSigningKey(localMetadata.getSigningKey(), localMetadata.getAlgorithm(), localMetadata.getDigest());

    return result;
  }

  /**
   * @Override
   */
  public cfboom.security.saml.saml2.authentication.LogoutResponse function logoutResponse(cfboom.security.saml.saml2.authentication.LogoutRequest req, cfboom.security.saml.saml2.metadata.Metadata recipient) {
    var ssoProviders = arguments.recipient.getSsoProviders();
    var destination = getPreferredEndpoint(
      ssoProviders.get(0).getSingleLogoutService(),
      null,
      -1
    );
    return new cfboom.security.saml.saml2.authentication.LogoutResponse()
      .setId(UUID.randomUUID().toString())
      .setInResponseTo(structKeyExists(arguments, "req") ? arguments.req.getId() : null)
      .setDestination(!isNull(destination) ? destination.getLocation() : null)
      .setStatus(new cfboom.security.saml.saml2.authentication.Status().setCode(StatusCode.SUCCESS))
      .setIssuer(new cfboom.security.saml.saml2.authentication.Issuer().setValue(getMetadata().getEntityId()))
      .setSigningKey(getMetadata().getSigningKey(), getMetadata().getAlgorithm(), getMetadata().getDigest())
      .setIssueInstant(new DateTime())
      .setVersion("2.0");
  }

  /**
   * @Override
   */
  public cfboom.security.saml.saml2.metadata.Metadata function getRemoteProviderFromSaml2Object(cfboom.security.saml.saml2.Saml2Object saml2Object) {
    throw(object=createObject("java", "java.lang.AbstractMethodError").init("Subcass must implement 'getRemoteProvider(saml2Object)'"));
  }

  /**
   * @Override
   */
  public cfboom.security.saml.saml2.metadata.Metadata function getRemoteProvider(any obj) {
    if (isValid("string", arguments.obj)) {
      for (var m in getRemoteProviders()) {
        while (!isNull(m)) {
          if (arguments.obj.equals(m.getEntityId())) {
            return m;
          }
          m = m.hasNext() ? m.getNext() : null;
        }
      }
      return
      throwIfNull(
        null,
        "remote provider entityId",
        arguments.obj
      );
    }
    else if (isInstanceOf(arguments.obj, "cfboom.security.saml.saml2.Saml2Object")) {
      return getRemoteProviderFromSaml2Object(arguments.obj);
    }
    else if (isInstanceOf(arguments.obj, "cfboom.security.saml.provider.config.ExternalProviderConfiguration")) {
      return getRemoteProviderFromExternalProviderConfiguration(arguments.obj);
    }
    else if (isInstanceOf(arguments.obj, "cfboom.security.saml.saml2.authentication.Issuer")) {
      return getRemoteProviderFromIssuer(arguments.obj);
    }
    else if (isInstanceOf(arguments.obj, "cfboom.security.saml.saml2.authentication.LogoutResponse")) {
      return getRemoteProviderFromLogoutResponse(arguments.obj);
    }
    else if (isInstanceOf(arguments.obj, "cfboom.security.saml.saml2.authentication.LogoutRequest")) {
      return getRemoteProviderFromLogoutRequest(arguments.obj);
    }
  }

  /**
   * @Override
   */
  public cfboom.security.saml.saml2.metadata.Metadata function getRemoteProviderFromExternalProviderConfiguration(cfboom.security.saml.provider.config.ExternalProviderConfiguration c) {
    var metadata = c.getMetadata();
    var result = resolve(metadata, c.isSkipSslValidation());
    if (c.isMetadataTrustCheck()) {
      result = metadataTrustCheck(c, result);
    }
    if (!isNull(result)) {
      addStaticKeys(c, result);
    }
    return result;
  }

  private void function addStaticKeys(cfboom.security.saml.provider.config.ExternalProviderConfiguration config, cfboom.security.saml.saml2.metadata.Metadata metadata) {
    if (!arguments.config.getVerificationKeys().isEmpty() && structKeyExists(arguments, "metadata")) {
      for (var provider in arguments.metadata.getSsoProviders()) {
        var keys = createObject("java","java.util.LinkedList").init( provider.getKeys() );
        keys.addAll(arguments.config.getVerificationKeyData());
        provider.setKeys(keys);
      }
    }
  }

  /**
   * @return cfboom.security.saml.saml2.metadata.Metadata
   */
  private any function metadataTrustCheck(cfboom.security.saml.provider.config.ExternalProviderConfiguration c, cfboom.security.saml.saml2.metadata.Metadata result) {
    if (!arguments.c.isMetadataTrustCheck()) {
      return arguments.result;
    }
    if (arguments.c.getVerificationKeys().isEmpty()) {
      log.warn("No keys to verify metadata for " & arguments.c.getMetadata() & " with. Unable to trust.");
      return;
    }
    try {
      var signature = variables._validator.validateSignature(arguments.result, arguments.c.getVerificationKeyData());
      if (!isNull(signature) &&
        signature.isValidated() &&
        !isNull(signature.getValidatingKey())) {
        return arguments.result;
      }
      else {
        variables.log.warn("Missing signature for " & arguments.c.getMetadata() & ". Unable to trust.");
      }
    } catch (SignatureException ex) {
      variables.log.warn("Invalid signature for remote provider metadata " & arguments.c.getMetadata() & ". Unable to trust.", ex);
    }
    return;
  }

  /**
   * @Override
   */
  public cfboom.security.saml.validation.ValidationResult function validate(cfboom.security.saml.saml2.Saml2Object saml2Object) {
    var remoteProvider = getRemoteProviderFromSaml2Object(arguments.saml2Object);
    var verificationKeys = getVerificationKeys(remoteProvider);
    try {
      if (!isNull(verificationKeys) && !verificationKeys.isEmpty()) {
        getValidator().validateSignature(arguments.saml2Object, verificationKeys);
      }
    } catch (SignatureException ex) {
      return new cfboom.security.saml.validation.ValidationResult(arguments.saml2Object).addError(
        new cfboom.security.saml.validation.ValidationError(ex.getMessage())
      );
    }
    try {
      getValidator().validate(arguments.saml2Object, this);
    } catch (ValidationException ex) {
      writeDump(ex);abort;
      return ex.getErrors();
    }
    return new cfboom.security.saml.validation.ValidationResult(arguments.saml2Object);
  }

  private any function getVerificationKeys(cfboom.security.saml.saml2.metadata.Metadata remoteProvider) {
    var verificationKeys = Collections.emptyList();
    if (isInstanceOf(arguments.remoteProvider, "cfboom.security.saml.saml2.metadata.ServiceProviderMetadata")) {
      verificationKeys = arguments.remoteProvider.getServiceProvider().getKeys();
    }
    else if (isInstanceOf(arguments.remoteProvider, "cfboom.security.saml.saml2.metadata.IdentityProviderMetadata")) {
      verificationKeys = arguments.remoteProvider.getIdentityProvider().getKeys();
    }
    return verificationKeys;
  }

  public cfboom.security.saml.SamlValidator function getValidator() {
    return variables._validator;
  }

  /**
   * @Override
   */
  public cfboom.security.saml.saml2.Saml2Object function fromXml(string xmlString, boolean encoded, boolean deflated, string type) {
    var decryptionKeys = getConfiguration().getKeys().toList();
    if (arguments.encoded) {
      arguments.xmlString = getTransformer().samlDecode(arguments.xmlString, arguments.deflated);
    }
    var result = getTransformer().fromXml(arguments.xmlString, null, decryptionKeys); // Saml2Object (arguments.type)

    //in order to add signatures, we need the verification keys from the remote provider
    var remote = getRemoteProviderFromSaml2Object(result); // Metadata

    var verificationKeys = remote.getSsoProviders().get(0).getKeys();
    //perform transformation with verification keys
    return getTransformer().fromXml(arguments.xmlString, verificationKeys, decryptionKeys);
  }

  /**
   * @Override
   */
  public string function toXml(cfboom.security.saml.saml2.Saml2Object saml2Object) {
    return getTransformer().toXml(arguments.saml2Object);
  }

  /**
   * @Override
   */
  public string function toEncodedXmlFromSaml2Object(cfboom.security.saml.saml2.Saml2Object saml2Object, boolean deflate) {
    var xmlString = toXml(arguments.saml2Object);
    return toEncodedXml(xmlString, arguments.deflate);
  }

  /**
   * @Override
   */
  public string function toEncodedXml(string xmlString, boolean deflate) {
    return getTransformer().samlEncode(arguments.xmlString, arguments.deflate);
  }

  /**
   * @Override
   */
  public any function getPreferredEndpoint(any endpoints, cfboom.security.saml.saml2.metadata.Binding preferredBinding, numeric preferredIndex) {
    if (!structKeyExists(arguments, "endpoints") || isNull(arguments.endpoints) || arguments.endpoints.isEmpty()) {
      return;
    }
    var eps = arguments.endpoints;
    var result = null;
    //find the preferred binding
    if (structKeyExists(arguments, "preferredBinding")) {
      for (var e in eps) {
        if (arguments.preferredBinding == e.getBinding()) {
          result = e;
          break;
        }
      }
    }
    //find the configured index
    if (isNull(result)) {
      arguments.preferredIndex = javaCast("int",arguments.preferredIndex);
      for (var e in eps) {
        if (e.getIndex() == arguments.preferredIndex) {
          result = e;
          break;
        }
      }
    }
    //find the default endpoint
    if (isNull(result)) {
      for (var e in eps) {
        if (e.isDefault()) {
          result = e;
          break;
        }
      }
    }
    //fallback to the very first available endpoint
    if (isNull(result)) {
      result = eps.get(0);
    }
    return result;
  }

  public cfboom.security.saml.SamlTransformer function getTransformer() {
    return variables._transformer;
  }

  private cfboom.security.saml.saml2.metadata.Metadata function resolve(string metadata, boolean skipSslValidation) {
    var result = null;
    if (isUri(arguments.metadata)) {
      try {
        var data = variables._cache.getMetadata(arguments.metadata, arguments.skipSslValidation);
        result = transformMetadata(createObject("java","java.lang.String").init(data, StandardCharsets.UTF_8));
      } catch (SamlException ex) {
        rethrow;
      } catch (any ex) {
writeDump(ex);abort;
        var message = "Unable to fetch metadata from: #arguments.metadata# with message: #ex.message#";
        if (variables.log.canDebug()) {
          variables.log.debug(message, ex);
        }
        else {
          variables.log.info(message);
        }
        throw("Unable to successfully get metadata from:" & arguments.metadata, "SamlMetadataException");
      }
    }
    else {
      result = transformMetadata(arguments.metadata);
    }
    return throwIfNull(
      result,
      "metadata",
      arguments.metadata
    );
  }

  public cfboom.security.saml.saml2.metadata.Metadata function transformMetadata(string data) {
    throw(object=createObject("java", "java.lang.AbstractMethodError").init("Subcass must implement 'transformMetadata(saml2Object)'"));
  }

  private boolean function isUri(string uri) {
    var isUri = false;
    try {
      createObject("java","java.net.URI").init(arguments.uri);
      isUri = true;
    } catch (java.net.URISyntaxException e) {
    }
    return isUri;
  }

  public cfboom.security.saml.saml2.metadata.Metadata function getRemoteProviderFromLogoutResponse(cfboom.security.saml.saml2.authentication.LogoutResponse res) {
    return getRemoteProvider(!isNull(arguments.res.getIssuer()) ? arguments.res.getIssuer().getValue() : null);
  }

  public cfboom.security.saml.saml2.metadata.Metadata function getRemoteProviderFromLogoutRequest(cfboom.security.saml.saml2.authentication.LogoutRequest req) {
    return getRemoteProvider(!isNull(arguments.req.getIssuer()) ? arguments.req.getIssuer().getValue() : null);
  }
}
