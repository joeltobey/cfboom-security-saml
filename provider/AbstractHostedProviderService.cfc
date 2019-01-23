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
  implements="cfboom.security.saml.provider.HostedProviderService"
  displayname="Abstract Class AbstractHostedProviderService"
  output="false"
{
  property name="log" inject="logbox:logger:{this}";
  property name="wirebox" injext="wirebox";
  variables['UUID'] = createObject("java","java.util.UUID");

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
  public cfboom.security.saml.saml2.metadata.Metadata function getRemoteProvider(string entityId) {
    for (var m in getRemoteProviders()) {
      while (!isNull(m)) {
        if (arguments.entityId.equals(m.getEntityId())) {
          return m;
        }
        m = m.hasNext() ? m.getNext() : null;
      }
    }
    return
      throwIfNull(
        null,
        "remote provider entityId",
        arguments.entityId
      );
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
    if (result != null) {
      addStaticKeys(c, result);
    }
    return result;
  }

  private void function addStaticKeys(cfboom.security.saml.provider.config.ExternalProviderConfiguration config, cfboom.security.saml.saml2.metadata.Metadata metadata) {
    if (!config.getVerificationKeys().isEmpty() && metadata != null) {
      for (SsoProvider provider : metadata.getSsoProviders()) {
        List<SimpleKey> keys = new LinkedList(provider.getKeys());
        keys.addAll(config.getVerificationKeyData());
        provider.setKeys(keys);
      }
    }
  }

  private cfboom.security.saml.saml2.metadata.Metadata function metadataTrustCheck(cfboom.security.saml.provider.config.ExternalProviderConfiguration c, cfboom.security.saml.saml2.metadata.Metadata result) {
    if (!c.isMetadataTrustCheck()) {
      return result;
    }
    if (c.getVerificationKeys().isEmpty()) {
      log.warn("No keys to verify metadata for "+c.getMetadata() + " with. Unable to trust.");
      return null;
    }
    try {
      Signature signature = validator.validateSignature(result, c.getVerificationKeyData());
      if (signature != null &&
        signature.isValidated() &&
        signature.getValidatingKey() != null) {
        return result;
      }
      else {
        log.warn("Missing signature for "+c.getMetadata() + ". Unable to trust.");
      }
    } catch (SignatureException e) {
      log.warn("Invalid signature for remote provider metadata "+c.getMetadata() + ". Unable to trust.", e);
    }
    return null;
  }

  /**
   * @Override
   */
  public cfboom.security.saml.validation.ValidationResult validate(cfboom.security.saml.saml2.Saml2Object saml2Object) {
    var remote = getRemoteProvider(saml2Object);
    List<SimpleKey> verificationKeys = getVerificationKeys(remote);
    try {
      if (verificationKeys != null && !verificationKeys.isEmpty()) {
        getValidator().validateSignature(saml2Object, verificationKeys);
      }
    } catch (SignatureException x) {
      return new ValidationResult(saml2Object).addError(
        new ValidationResult.ValidationError(x.getMessage())
      );
    }
    try {
      getValidator().validate(saml2Object, this);
    } catch (ValidationException e) {
      return e.getErrors();
    }
    return new cfboom.security.saml.validation.ValidationResult(saml2Object);
  }

  private any function getVerificationKeys(cfboom.security.saml.saml2.metadata.Metadata remote) {
    List<SimpleKey> verificationKeys = emptyList();
    if (remote instanceof ServiceProviderMetadata) {
      verificationKeys = ((ServiceProviderMetadata) remote).getServiceProvider().getKeys();
    }
    else if (remote instanceof IdentityProviderMetadata) {
      verificationKeys = ((IdentityProviderMetadata) remote).getIdentityProvider().getKeys();
    }
    return verificationKeys;
  }

  public cfboom.security.saml.SamlValidator function getValidator() {
    return variables._validator;
  }

  /**
   * @Override
   */
  public cfboom.security.saml.saml2.Saml2Object function fromXml(string xml, boolean encoded, boolean deflated) {
    var decryptionKeys = getConfiguration().getKeys().toList();
    if (arguments.encoded) {
      arguments.xml = getTransformer().samlDecode(arguments.xml, arguments.deflated);
    }
    var result = getTransformer().fromXml(arguments.xml, null, decryptionKeys);
    //in order to add signatures, we need the verification keys from the remote provider
    var remote = getRemoteProvider(result);
    var verificationKeys = remote.getSsoProviders().get(0).getKeys();
    //perform transformation with verification keys
    return getTransformer().fromXml(arguments.xml, verificationKeys, decryptionKeys);
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
    var xmlString = toXml(saml2Object);
    return toEncodedXml(xmlString, arguments.deflate);
  }

  /**
   * @Override
   */
  public string function toEncodedXml(string xml, boolean deflate) {
    return getTransformer().samlEncode(arguments.xml, arguments.deflate);
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
    var result;
    if (isUri(metadata)) {
      try {
        byte[] data = cache.getMetadata(metadata, skipSslValidation);
        result = transformMetadata(new String(data, StandardCharsets.UTF_8));
      } catch (SamlException x) {
        throw x;
      } catch (Exception x) {
        String message = format("Unable to fetch metadata from: %s with message: %s", metadata, x.getMessage());
        if (log.isDebugEnabled()) {
          log.debug(message, x);
        }
        else {
          log.info(message);
        }
        throw new SamlMetadataException("Unable to successfully get metadata from:" + metadata, x);
      }
    }
    else {
      result = transformMetadata(metadata);
    }
    return throwIfNull(
      result,
      "metadata",
      metadata
    );
  }

  public cfboom.security.saml.saml2.metadata.Metadata function transformMetadata(string data) {
    throw(object=createObject("java", "java.lang.AbstractMethodError").init("Subcass must implement 'transformMetadata(saml2Object)'"));
  }

  private boolean isUri(string uri) {
    var isUri = false;
    try {
      createObject("java","java.net.URI").init(arguments.uri);
      isUri = true;
    } catch (java.net.URISyntaxException e) {
    }
    return isUri;
  }

  public cfboom.security.saml.saml2.metadata.Metadata function getRemoteProviderFromLogoutResponse(cfboom.security.saml.saml2.authentication.LogoutResponse res) {
    String issuer = response.getIssuer() != null ?
      response.getIssuer().getValue() :
      null;
    return getRemoteProvider(issuer);
  }

  public cfboom.security.saml.saml2.metadata.Metadata function getRemoteProviderFromLogoutRequest(cfboom.security.saml.saml2.authentication.LogoutRequest req) {
    String issuer = request.getIssuer() != null ?
      request.getIssuer().getValue() :
      null;
    return getRemoteProvider(issuer);
  }
}
