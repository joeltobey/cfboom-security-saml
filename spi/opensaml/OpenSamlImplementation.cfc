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
 * @singleton
 */
component
  extends="cfboom.security.saml.spi.SecuritySaml"
  displayname="Class OpenSamlImplementation"
  output="false"
{
  property name="AlgorithmMethod" inject="AlgorithmMethod@cfboom-security-saml";
  property name="AttributeNameFormat" inject="AttributeNameFormat@cfboom-security-saml";
  property name="AuthenticationContextClassReference" inject="AuthenticationContextClassReference@cfboom-security-saml";
  property name="Binding" inject="Binding@cfboom-security-saml";
  property name="CanonicalizationMethod" inject="CanonicalizationMethod@cfboom-security-saml";
  property name="DigestMethod" inject="DigestMethod@cfboom-security-saml";
  property name="KeyType" inject="KeyType@cfboom-security-saml";
  property name="NameId" inject="NameId@cfboom-security-saml";
  property name="Namespace" inject="Namespace@cfboom-security-saml";
  property name="StatusCode" inject="StatusCode@cfboom-security-saml";
  property name="SubjectConfirmationMethod" inject="SubjectConfirmationMethod@cfboom-security-saml";

  property name="javaLoader" inject="JavaLoader@cfboom-security-saml";

  variables['Arrays'] = createObject("java", "java.util.Arrays");
  variables['Collections'] = createObject("java","java.util.Collections");
  variables['Optional'] = createObject("java","java.util.Optional");
  variables['StandardCharsets'] = createObject("java","java.nio.charset.StandardCharsets");
  variables['UUID'] = createObject("java","java.util.UUID");

  /**
   * @time.type java.time.Clock
   * @time.inject time@cfboom-security-saml
   */
  public cfboom.security.saml.spi.opensaml.OpenSamlImplementation function init( required any time) {
    super.init( arguments.time );
    return this;
  }

  public void function onDIComplete() {
    variables['Encrypter'] = variables.javaLoader.create("org.opensaml.saml.saml2.encryption.Encrypter");
    variables['JCEMapper'] = variables.javaLoader.create("org.apache.xml.security.algorithms.JCEMapper");
  }

  public any function getXMLObjectSupport() {
    return variables._XMLObjectSupport;
  }

  public any function getXMLObjectProviderRegistrySupport() {
    return variables._XMLObjectProviderRegistrySupport;
  }

  public any function getParserPool() {
    return variables._parserPool;
  }

  public any function getMarshallerFactory() {
    return variables._XMLObjectProviderRegistrySupport.getMarshallerFactory();
  }

  public any function getUnmarshallerFactory() {
    return variables._XMLObjectProviderRegistrySupport.getUnmarshallerFactory();
  }

  public any function getEntityDescriptor() {
    var builder = getBuilderFactory().getBuilder(variables.EntityDescriptor.DEFAULT_ELEMENT_NAME);
    return builder.buildObject();
  }

  public any function getSPSSODescriptor() {
    var builder = getBuilderFactory().getBuilder(variables.SPSSODescriptor.DEFAULT_ELEMENT_NAME);
    return builder.buildObject();
  }

  public any function getIDPSSODescriptor() {
    var builder = getBuilderFactory().getBuilder(variables.IDPSSODescriptor.DEFAULT_ELEMENT_NAME);
    return builder.buildObject();
  }

  public any function getMetadataExtensions() {
    var builder = getBuilderFactory().getBuilder(variables.Extensions.DEFAULT_ELEMENT_NAME);
    return builder.buildObject();
  }

  public any function getBuilderFactory() {
    return variables._XMLObjectProviderRegistrySupport.getBuilderFactory();
  }

  /**
   * @Override
   */
  private void function bootstrap() {
    variables['EntityDescriptor'] = variables.javaLoader.create("org.opensaml.saml.saml2.metadata.EntityDescriptor");
    variables['SPSSODescriptor'] = variables.javaLoader.create("org.opensaml.saml.saml2.metadata.SPSSODescriptor");
    variables['IDPSSODescriptor'] = variables.javaLoader.create("org.opensaml.saml.saml2.metadata.IDPSSODescriptor");
    variables['Extensions'] = variables.javaLoader.create("org.opensaml.saml.saml2.metadata.Extensions");
    variables['ConfigurationService'] = variables.javaLoader.create("org.opensaml.core.config.ConfigurationService");
    variables['DOMTypeSupport'] = variables.javaLoader.create("net.shibboleth.utilities.java.support.xml.DOMTypeSupport");
    variables['SignatureValidator'] = variables.javaLoader.create("org.opensaml.xmlsec.signature.support.SignatureValidator");
    variables['RequestInitiator'] = variables.javaLoader.create("org.opensaml.saml.ext.saml2mdreqinit.RequestInitiator");
    variables['DiscoveryResponse'] = variables.javaLoader.create("org.opensaml.saml.ext.idpdisco.DiscoveryResponse");
    variables['_XMLObjectSupport'] = variables.javaLoader.create("org.opensaml.core.xml.util.XMLObjectSupport");
    variables['_XMLObjectProviderRegistrySupport'] = variables.javaLoader.create("org.opensaml.core.xml.config.XMLObjectProviderRegistrySupport");
    variables['_parserPool'] = variables.javaLoader.create("net.shibboleth.utilities.java.support.xml.BasicParserPool").init();

    //configure default values
    //maxPoolSize = 5;
    variables._parserPool.setMaxPoolSize(javaCast("int",50));
    //coalescing = true;
    variables._parserPool.setCoalescing(true);
    //expandEntityReferences = false;
    variables._parserPool.setExpandEntityReferences(false);
    //ignoreComments = true;
    variables._parserPool.setIgnoreComments(true);
    //ignoreElementContentWhitespace = true;
    variables._parserPool.setIgnoreElementContentWhitespace(true);
    //namespaceAware = true;
    variables._parserPool.setNamespaceAware(true);
    //schema = null;
    variables._parserPool.setSchema(null);
    //dtdValidating = false;
    variables._parserPool.setDTDValidating(false);
    //xincludeAware = false;
    variables._parserPool.setXincludeAware(false);

    var builderAttributes = createObject("java","java.util.HashMap").init();
    variables._parserPool.setBuilderAttributes(builderAttributes);

    var parserBuilderFeatures = createObject("java","java.util.HashMap").init();
    parserBuilderFeatures.put("http://apache.org/xml/features/disallow-doctype-decl", Boolean.TRUE);
    parserBuilderFeatures.put("http://javax.xml.XMLConstants/feature/secure-processing", Boolean.TRUE);
    parserBuilderFeatures.put("http://xml.org/sax/features/external-general-entities", Boolean.FALSE);
    parserBuilderFeatures.put("http://apache.org/xml/features/validation/schema/normalized-value", Boolean.FALSE);
    parserBuilderFeatures.put("http://xml.org/sax/features/external-parameter-entities", Boolean.FALSE);
    parserBuilderFeatures.put("http://apache.org/xml/features/dom/defer-node-expansion", Boolean.FALSE);
    variables._parserPool.setBuilderFeatures(parserBuilderFeatures);

    variables._parserPool.initialize();

    variables.InitializationService.initialize();

    var registry = null;
    lock type="exclusive" name="org.opensaml.core.config.ConfigurationService" timeout="10" throwontimeout="true" {
      registry = variables.ConfigurationService.get( variables.javaLoader.loadClass("org.opensaml.core.xml.config.XMLObjectProviderRegistry") );
    }
    registry.setParserPool(variables._parserPool);
    variables['_encryptedKeyResolver'] = variables.javaLoader.create("org.opensaml.xmlsec.encryption.support.ChainingEncryptedKeyResolver").init(
      Arrays.asList([
        variables.javaLoader.create("org.opensaml.xmlsec.encryption.support.InlineEncryptedKeyResolver").init(),
        variables.javaLoader.create("org.opensaml.saml.saml2.encryption.EncryptedElementTypeEncryptedKeyResolver").init(),
        variables.javaLoader.create("org.opensaml.xmlsec.encryption.support.SimpleRetrievalMethodEncryptedKeyResolver").init()
      ])
    );
    variables.log.info("SAML ServiceProviderProvisioning bootstrap completed");
  }

  /**
   * @duration.type javax.xml.datatype.Duration
   */
  public numeric function toMillis(any duration) {
    if (!structKeyExists(arguments, "duration") || isNull(arguments.duration)) {
      return javaCast("long", -1);
    }
    else {
      return DOMTypeSupport.durationToLong(arguments.duration);
    }
  }

  /**
   * @millis.type java.lang.Long
   * @returns javax.xml.datatype.Duration
   */
  public any function toDuration(numeric millis) {
    if (!structKeyExists(arguments, "millis") || isNull(arguments.millis) || arguments.millis < 0) {
      return;
    }
    else {
      return DOMTypeSupport.getDataTypeFactory().newDuration(arguments.millis);
    }
  }

/*
  public string function toXml(cfboom.security.saml.saml2.Saml2Object saml2Object) {
    XMLObject result = null;
    if (saml2Object instanceof AuthenticationRequest) {
      result = internalToXml((AuthenticationRequest) saml2Object);
    }
    else if (saml2Object instanceof Assertion) {
      result = internalToXml((Assertion) saml2Object);
    }
    else if (saml2Object instanceof Metadata) {
      result = internalToXml((Metadata) saml2Object);
    }
    else if (saml2Object instanceof Response) {
      result = internalToXml((Response) saml2Object);
    }
    else if (saml2Object instanceof LogoutRequest) {
      result = internalToXml((LogoutRequest) saml2Object);
    }
    else if (saml2Object instanceof LogoutResponse) {
      result = internalToXml((LogoutResponse) saml2Object);
    }
    if (result != null) {
      return marshallToXml(result);
    }
    throw new SamlException("To xml transformation not supported for: " +
      saml2Object != null ?
      saml2Object.getClass().getName() :
      "null"
    );
  }
*/
  /**
   * @Override
   */
  public cfboom.security.saml.saml2.Saml2Object function resolve(string xmlString, any verificationKeys, any localKeys) {
    return resolveXmlBytes(arguments.xmlString.getBytes(StandardCharsets.UTF_8), arguments.verificationKeys, arguments.localKeys);
  }

  /**
   * @Override
   */
  public cfboom.security.saml.saml2.Saml2Object function resolveXmlBytes(any xmlBytes, any verificationKeys, any localKeys) {
    var parsed = parse(arguments.xmlBytes); // XMLObject
    var signature = validateSignature(parsed, arguments.verificationKeys); // Signature

    var result = null; // Saml2Object
    if (isInstanceOf(parsed, "org.opensaml.saml.saml2.metadata.EntityDescriptor")) {
      result = resolveMetadataFromEntityDescriptor(parsed).setSignature(signature);
    }
    else if (isInstanceOf(parsed, "org.opensaml.saml.saml2.metadata.EntitiesDescriptor")) {
      result = resolveMetadataFromEntitiesDescriptor(parsed, arguments.verificationKeys, arguments.localKeys);
    }
    else if (isInstanceOf(parsed, "org.opensaml.saml.saml2.core.AuthnRequest")) {
      result = resolveAuthenticationRequest(parsed).setSignature(signature);
    }
    else if (isInstanceOf(parsed, "org.opensaml.saml.saml2.core.Assertion")) {
      result = resolveAssertion(parsed, arguments.verificationKeys, arguments.localKeys);
    }
    else if (isInstanceOf(parsed, "org.opensaml.saml.saml2.core.Response")) {
      result = resolveResponse(parsed, arguments.verificationKeys, arguments.localKeys).setSignature(signature);
    }
    else if (isInstanceOf(parsed, "org.opensaml.saml.saml2.core.LogoutRequest")) {
      result = resolveLogoutRequest(parsed, arguments.verificationKeys, arguments.localKeys).setSignature(signature);
    }
    else if (isInstanceOf(parsed, "org.opensaml.saml.saml2.core.LogoutResponse")) {
      result = resolveLogoutResponse(parsed, arguments.verificationKeys, arguments.localKeys).setSignature(signature);
    }
    if (!isNull(result)) {
      if (isInstanceOf(result, "cfboom.security.saml.saml2.ImplementationHolder")) {
        result.setImplementation(parsed);
        result.setOriginalXML(createObject("java","java.lang.String").init(arguments.xmlBytes, StandardCharsets.UTF_8));
      }
      return result;
    }
    throw("Deserialization not yet supported for class: " & parsed.getClass().getName(), "SamlException");
  }

  /**
   * @Override
   */
  public cfboom.security.saml.saml2.signature.Signature function validateSignatureFromSaml2Object(cfboom.security.saml.saml2.Saml2Object saml2Object, any trustedKeys) {
    if (isNull(arguments.saml2Object) || isNull(arguments.saml2Object.getImplementation())) {
      throw("No object to validate signature against.", "SamlException");
    }

    if (isNull(arguments.trustedKeys) || arguments.trustedKeys.isEmpty()) {
      throw("At least one verification key has to be provided", "SamlKeyException");
    }

    if (isInstanceOf(arguments.saml2Object.getImplementation(), "org.opensaml.saml.common.SignableSAMLObject")) {
      return validateSignature(arguments.saml2Object.getImplementation(), arguments.trustedKeys);
    }
    else {
      throw("Unrecognized object type:" & arguments.saml2Object.getImplementation().getClass().getName(), "SamlException");
    }
  }

  public cfboom.security.saml.saml2.signature.Signature function validateSignature(any object, any keys) {
    var result = null;
    if (arguments.object.isSigned() && structKeyExists(arguments, "keys") && !isNull(arguments.keys) && !arguments.keys.isEmpty()) {
      var last = null;
      for (var key in arguments.keys) {
        try {
          var credential = getCredential(key, getCredentialsResolver(key));
          SignatureValidator.validate(arguments.object.getSignature(), credential);
          last = null;
          result = getSignature(arguments.object)
            .setValidated(true)
            .setValidatingKey(key);
          break;
        } catch (org.opensaml.xmlsec.signature.support.SignatureException ex) {
          last = ex;
        }
      }
      if (!isNull(last)) {
        throw("Signature validation against a " & arguments.object.getClass().getName() &
        " object failed using " & arguments.keys.size() & (arguments.keys.size() == 1 ? " key." : " keys."), "SignatureException");
      }
    }
    return result;
  }

  public org.opensaml.security.credential.Credential function getCredential(cfboom.security.saml.key.SimpleKey key, any resolver) {
    try {
      var cs = variables.javaLoader.create("net.shibboleth.utilities.java.support.resolver.CriteriaSet").init();
      var criteria = variables.javaLoader.create("org.opensaml.core.criterion.EntityIdCriterion").init(arguments.key.getName());
      cs.add(criteria);
      return arguments.resolver.resolveSingle(cs);
    } catch (net.shibboleth.utilities.java.support.resolver.ResolverException e) {
      throw("Can't obtain SP private key", "SamlKeyException");
    }
  }

  public org.opensaml.security.credential.impl.KeyStoreCredentialResolver function getCredentialsResolver(cfboom.security.saml.key.SimpleKey key) {
    var ks = getSamlKeyStoreProvider().getKeyStore(arguments.key);
    var passwords = hasText(arguments.key.getPrivateKey()) ?
      Collections.singletonMap(arguments.key.getName(), arguments.key.getPassphrase()) :
      Collections.emptyMap();
    var resolver = variables.javaLoader.create("org.opensaml.security.credential.impl.KeyStoreCredentialResolver").init(
      ks,
      passwords
    );
    return resolver;
  }

  /**
   * target.class org.opensaml.saml.common.SignableSAMLObject
   */
  public cfboom.security.saml.saml2.signature.Signature function getSignature(any target) {
    var signature = arguments.target.getSignature();
    var result = null;
    if (!isNull(signature) && isInstanceOf(signature, "org.opensaml.xmlsec.signature.impl.SignatureImpl")) {
      var impl = signature;
      try {
        result = new cfboom.security.saml.saml2.signature.Signature()
          .setSignatureAlgorithm(AlgorithmMethod.fromUrn(impl.getSignatureAlgorithm()))
          .setCanonicalizationAlgorithm(CanonicalizationMethod.fromUrn(impl
            .getCanonicalizationAlgorithm()))
          .setSignatureValue(variables.javaLoader.create("org.apache.xml.security.utils.Base64").encode(impl.getXMLSignature()
            .getSignatureValue()))
        ;
        //TODO extract the digest value
        for (var ref in
          Optional.ofNullable(signature.getContentReferences()).orElse(Collections.emptyList())) {
          if (isInstanceOf(ref, "org.opensaml.saml.common.SAMLObjectContentReference")) {
            var sref = ref;
            result.setDigestAlgorithm(DigestMethod.fromUrn(sref.getDigestAlgorithm()));
          }
        }

      } catch (org.apache.xml.security.signature.XMLSignatureException e) {
        //TODO - ignore for now
      }
    }
    return result;
  }

  /**
   * @assertion.class org.opensaml.saml.saml2.core.Assertion
   */
  public org.opensaml.saml.saml2.core.EncryptedAssertion function encryptAssertion(any assertion,
                                                                                   cfboom.security.saml.key.SimpleKey key,
                                                                                   cfboom.security.saml.saml2.encrypt.KeyEncryptionMethod keyAlgorithm,
                                                                                   cfboom.security.saml.saml2.encrypt.DataEncryptionMethod dataAlgorithm) {
    var encrypter = getEncrypter(arguments.key, arguments.keyAlgorithm, arguments.dataAlgorithm);
    try {
      var keyPlacement =
        variables.Encrypter.KeyPlacement.valueOf(
          System.getProperty("cfboom.security.saml.encrypt.key.placement", "PEER")
        );
      encrypter.setKeyPlacement(keyPlacement);
      return encrypter.encrypt(arguments.assertion);
    } catch (org.opensaml.xmlsec.encryption.support.EncryptionException e) {
      throw("Unable to encrypt assertion.", "SamlException");
    }
  }

  /**
   * @encrypted.class org.opensaml.saml.saml2.core.EncryptedElementType
   */
  public org.opensaml.saml.common.SAMLObject function decrypt(any encrypted, any keys) {
    var last = null;
    for (var key in arguments.keys) {
      var decrypter = getDecrypter(key);
      try {
        return decrypter.decryptData(arguments.encrypted.getEncryptedData());
      } catch (org.opensaml.xmlsec.encryption.support.DecryptionException e) {
        variables.log.debug(createObject("java","java.lang.String").format("Unable to decrypt element:%s", encrypted), e);
      }
    }
    if (!isNull(last)) {
      throw("Unable to decrypt object.", "SamlKeyException");
    }
    return null;
  }

  public org.opensaml.saml.saml2.encryption.Encrypter function getEncrypter(cfboom.security.saml.key.SimpleKey key,
                                                                            cfboom.security.saml.saml2.encrypt.KeyEncryptionMethod keyAlgorithm,
                                                                            cfboom.security.saml.saml2.encrypt.DataEncryptionMethod dataAlgorithm) {
    var credential = getCredential(arguments.key, getCredentialsResolver(arguments.key));

    var secretKey = generateKeyFromURI(arguments.dataAlgorithm);
    var dataCredential = variables.javaLoader.create("org.opensaml.security.credential.BasicCredential").init(secretKey);
    var dataEncryptionParameters = variables.javaLoader.create("org.opensaml.xmlsec.encryption.support.DataEncryptionParameters").init();
    dataEncryptionParameters.setEncryptionCredential(dataCredential);
    dataEncryptionParameters.setAlgorithm(arguments.dataAlgorithm.toString());

    var keyEncryptionParameters = variables.javaLoader.create("org.opensaml.xmlsec.encryption.support.KeyEncryptionParameters").init();
    keyEncryptionParameters.setEncryptionCredential(credential);
    keyEncryptionParameters.setAlgorithm(arguments.keyAlgorithm.toString());

    var encrypter = variables.javaLoader.create("org.opensaml.saml.saml2.encryption.Encrypter").init(dataEncryptionParameters, Arrays.asList(keyEncryptionParameters));

    return encrypter;
  }

  public javax.crypto.SecretKey function generateKeyFromURI(cfboom.security.saml.saml2.encrypt.DataEncryptionMethod algoURI) {
    try {
      var jceAlgorithmName = JCEMapper.getJCEKeyAlgorithmFromURI(arguments.algoURI.toString());
      var keyLength = JCEMapper.getKeyLengthFromURI(arguments.algoURI.toString());
      return generateKey(jceAlgorithmName, keyLength, null);
    } catch (java.security.NoSuchAlgorithmException ex) {
      throw(ex.getMessage(), "SamlException");
    } catch (java.security.NoSuchProviderException ex) {
      throw(ex.getMessage(), "SamlException");
    }
  }

  public org.opensaml.saml.saml2.encryption.Decrypter function getDecrypter(cfboom.security.saml.key.SimpleKey key) {
    var credential = getCredential(arguments.key, getCredentialsResolver(arguments.key));
    var resolver = variables.javaLoader.create("org.opensaml.xmlsec.keyinfo.impl.StaticKeyInfoCredentialResolver").init(credential);
    var decrypter = variables.javaLoader.create("org.opensaml.saml.saml2.encryption.Decrypter").init(null, resolver, variables._encryptedKeyResolver);
    decrypter.setRootInNewDocument(true);
    return decrypter;
  }

  public any function parse(any xmlBytes) {
    try {
      var document = getParserPool().parse(createObject("java","java.io.ByteArrayInputStream").init(arguments.xmlBytes));
      var element = document.getDocumentElement();
      return getUnmarshallerFactory().getUnmarshaller(element).unmarshall(element);
    } catch (org.opensaml.core.xml.io.UnmarshallingException ex) {
      throw(ex.message, "SamlException");
    } catch (net.shibboleth.utilities.java.support.xml.XMLParserException ex) {
      throw(ex.message, "SamlException");
    }
  }

  public any function getSsoProviders(any descriptor) {
    var providers = createObject("java","java.util.LinkedList").init();
    for (var roleDescriptor in arguments.descriptor.getRoleDescriptors()) {
      if (isInstanceOf(roleDescriptor, "org.opensaml.saml.saml2.metadata.IDPSSODescriptor") || isInstanceOf(roleDescriptor, "org.opensaml.saml.saml2.metadata.SPSSODescriptor")) {
        providers.add(getSsoProvider(roleDescriptor));
      }
      else {
        variables.log.debug("Ignoring unknown metadata descriptor:"+roleDescriptor.getClass().getName());
      }
    }
    return providers;
  }

  public cfboom.security.saml.saml2.metadata.SsoProvider function getSsoProvider(any descriptor) {
    if (isInstanceOf(arguments.descriptor, "org.opensaml.saml.saml2.metadata.SPSSODescriptor")) {
      var desc = arguments.descriptor;
      var provider = new cfboom.security.saml.saml2.metadata.ServiceProvider();
      provider.setId(desc.getID());
      provider.setValidUntil(desc.getValidUntil());
      if (!isNull(desc.getCacheDuration())) {
        provider.setCacheDuration(toDuration(desc.getCacheDuration()));
      }
      provider.setProtocolSupportEnumeration(desc.getSupportedProtocols());
      provider.setNameIds(getNameIDs(desc.getNameIDFormats()));
      provider.setArtifactResolutionService(getEndpoints(desc.getArtifactResolutionServices()));
      provider.setSingleLogoutService(getEndpoints(desc.getSingleLogoutServices()));
      provider.setManageNameIDService(getEndpoints(desc.getManageNameIDServices()));
      provider.setAuthnRequestsSigned(desc.isAuthnRequestsSigned());
      provider.setWantAssertionsSigned(desc.getWantAssertionsSigned());
      provider.setAssertionConsumerService(getEndpoints(desc.getAssertionConsumerServices()));
      provider.setRequestedAttributes(getRequestAttributes(desc));
      provider.setKeys(getProviderKeys(descriptor));
      provider.setDiscovery(getDiscovery(desc));
      provider.setRequestInitiation(getRequestInitiation(desc));
      //TODO
      //provider.setAttributeConsumingService(getEndpoints(desc.getAttributeConsumingServices()));
      return provider;
    }
    else if (isInstanceOf(arguments.descriptor, "org.opensaml.saml.saml2.metadata.IDPSSODescriptor")) {
      var desc = arguments.descriptor;
      var provider = new cfboom.security.saml.saml2.metadata.IdentityProvider();
      provider.setId(desc.getID());
      provider.setValidUntil(desc.getValidUntil());
      if (!isNull(desc.getCacheDuration())) {
        provider.setCacheDuration(toDuration(desc.getCacheDuration()));
      }
      provider.setProtocolSupportEnumeration(desc.getSupportedProtocols());
      provider.setNameIds(getNameIDs(desc.getNameIDFormats()));
      provider.setArtifactResolutionService(getEndpoints(desc.getArtifactResolutionServices()));
      provider.setSingleLogoutService(getEndpoints(desc.getSingleLogoutServices()));
      provider.setManageNameIDService(getEndpoints(desc.getManageNameIDServices()));
      provider.setWantAuthnRequestsSigned(desc.getWantAuthnRequestsSigned());
      provider.setSingleSignOnService(getEndpoints(desc.getSingleSignOnServices()));
      provider.setKeys(getProviderKeys(descriptor));
      provider.setDiscovery(getDiscovery(desc));
      provider.setRequestInitiation(getRequestInitiation(desc));
      return provider;
    }
    else {

    }
    throw(object=createObject("java","java.lang.UnsupportedOperationException").init(isNull(arguments.descriptor) ? null : arguments.descriptor.getClass().getName()));
  }

  public any function getRequestAttributes(any desc) {
    var result = createObject("java","java.util.LinkedList").init();
    if (!isNull(arguments.desc.getDefaultAttributeConsumingService())) {
      result.addAll(getRequestedAttributes(desc.getDefaultAttributeConsumingService().getRequestAttributes()));
    }
    else {
      for (var s in Optional.ofNullable(arguments.desc.getAttributeConsumingServices()).orElse(Collections.emptyList())) {
        if (!isNull(s)) {
          //take the first one
          result.addAll(getRequestedAttributes(s.getRequestAttributes()));
          break;
        }
      }
    }
    return result;
  }

  public cfboom.security.saml.saml2.metadata.Endpoint function getRequestInitiation(any desc) {
    if (isNull(arguments.desc.getExtensions())) {
      return null;
    }
    var result = null;
    for (var obj in arguments.desc.getExtensions().getUnknownXMLObjects()) {
      if (isInstanceOf(obj, "org.opensaml.saml.ext.saml2mdreqinit.RequestInitiator")) {
        var req = obj;
        result = new cfboom.security.saml.saml2.metadata.Endpoint()
          .setIndex(0)
          .setDefault(false)
          .setBinding(Binding.fromUrn(req.getBinding()))
          .setLocation(req.getLocation())
          .setResponseLocation(req.getResponseLocation());
      }
    }
    return result;
  }

  public cfboom.security.saml.saml2.metadata.Endpoint function getDiscovery(any desc) {
    if (isNull(arguments.desc.getExtensions())) {
      return null;
    }
    var result = null;
    for (var obj in arguments.desc.getExtensions().getUnknownXMLObjects()) {
      if (isInstanceOf(obj, "org.opensaml.saml.ext.idpdisco.DiscoveryResponse")) {
        var resp = obj;
        result = new cfboom.security.saml.saml2.metadata.Endpoint()
          .setDefault(resp.isDefault())
          .setIndex(resp.getIndex())
          .setBinding(Binding.fromUrn(resp.getBinding()))
          .setLocation(resp.getLocation())
          .setResponseLocation(resp.getResponseLocation());
      }
    }
    return result;
  }

  public any function getProviderKeys(any descriptor) {
    var result = createObject("java","java.util.LinkedList").init();
    for (var desc in Optional.ofNullable(arguments.descriptor.getKeyDescriptors()).orElse(Collections.emptyList())) {
      if (!isNull(desc)) {
        result.addAll(!isNull(getKeyFromDescriptor(desc)) ? getKeyFromDescriptor(desc) : Collections.emptyList());
      }
    }
    return result;
  }

  public any function getKeyFromDescriptor(any desc) {
    var result = createObject("java","java.util.LinkedList").init();
    if (isNull(arguments.desc.getKeyInfo())) {
      return null;
    }
    var type = !isNull(arguments.desc.getUse()) ? KeyType.valueOf(arguments.desc.getUse().name()) : KeyType.UNSPECIFIED;
    var index = javaCast("int",0);
    for (var x509 in Optional.ofNullable(arguments.desc.getKeyInfo().getX509Datas()).orElse(Collections.emptyList())) {
      for (var cert in Optional.ofNullable(x509.getX509Certificates()).orElse(Collections.emptyList())) {
        result.add(new cfboom.security.saml.key.SimpleKey(type.getTypeName() & "-" & (index++), null, cert.getValue(), null, type));
      }
    }
    return result;
  }

  public any function getEndpoints(any services) {
    var result = createObject("java","java.util.LinkedList").init();
    if (!isNull(arguments.services)) {
      arguments.services.each(function( s ) {
        var endpoint = new cfboom.security.saml.saml2.metadata.Endpoint()
          .setBinding(Binding.fromUrn(s.getBinding()))
          .setLocation(s.getLocation())
          .setResponseLocation(s.getResponseLocation());
        result.add(endpoint);
        if (isInstanceOf(s, "org.opensaml.saml.saml2.metadata.IndexedEndpoint")) {
          var idxEndpoint = s;
          endpoint
            .setIndex(idxEndpoint.getIndex())
            .setDefault(idxEndpoint.isDefault());
        }
      });
    }
    return result;
  }

  public any function getNameIDs(any nameIDFormats) {
    var result = createObject("java","java.util.LinkedList").init();
    if (!isNull(arguments.nameIDFormats)) {
      arguments.nameIDFormats.each( function(n) {
        result.add(NameId.fromUrn(n.getFormat()));
      });
    }
    return result;
  }
/*
  protected org.opensaml.saml.saml2.core.Response internalToXml(Response response) {
    org.opensaml.saml.saml2.core.Response result = buildSAMLObject(org.opensaml.saml.saml2.core.Response.class);
    result.setConsent(response.getConsent());
    result.setID(Optional.ofNullable(response.getId()).orElse("a" + UUID.randomUUID().toString()));
    result.setInResponseTo(response.getInResponseTo());
    result.setVersion(SAMLVersion.VERSION_20);
    result.setIssueInstant(response.getIssueInstant());
    result.setDestination(response.getDestination());
    result.setIssuer(toIssuer(response.getIssuer()));

    if (response.getStatus() == null || response.getStatus().getCode() == null) {
      throw new SamlException("Status cannot be null on a response");
    }
    org.opensaml.saml.saml2.core.Status status = buildSAMLObject(org.opensaml.saml.saml2.core.Status.class);
    org.opensaml.saml.saml2.core.StatusCode code = buildSAMLObject(org.opensaml.saml.saml2.core.StatusCode.class);
    code.setValue(response.getStatus().getCode().toString());
    status.setStatusCode(code);

    if (hasText(response.getStatus().getMessage())) {
      StatusMessage message = buildSAMLObject(StatusMessage.class);
      message.setMessage(response.getStatus().getMessage());
      status.setStatusMessage(message);
    }

    result.setStatus(status);

    for (Assertion a : Optional.ofNullable(response.getAssertions()).orElse(Collections.emptyList())) {
      org.opensaml.saml.saml2.core.Assertion osAssertion = internalToXml(a);
      if (a.getEncryptionKey() != null) {
        EncryptedAssertion encryptedAssertion =
          encryptAssertion(osAssertion, a.getEncryptionKey(), a.getKeyAlgorithm(), a.getDataAlgorithm());
        result.getEncryptedAssertions().add(encryptedAssertion);
      }
      else {
        result.getAssertions().add(osAssertion);
      }
    }
    if (response.getSigningKey() != null) {
      signObject(result, response.getSigningKey(), response.getAlgorithm(), response.getDigest());
    }
    return result;
  }
*/
/*
  protected EntityDescriptor internalToXml(Metadata<? extends Metadata> metadata) {
    EntityDescriptor desc = getEntityDescriptor();
    desc.setEntityID(metadata.getEntityId());
    if (hasText(metadata.getId())) {
      desc.setID(metadata.getId());
    }
    else {
      desc.setID(UUID.randomUUID().toString());
    }
    List<RoleDescriptor> descriptors = getRoleDescriptors(metadata);
    desc.getRoleDescriptors().addAll(descriptors);
    if (metadata.getSigningKey() != null) {
      signObject(desc, metadata.getSigningKey(), metadata.getAlgorithm(), metadata.getDigest());
    }
    return desc;
  }
*/
  public any function getRoleDescriptors(cfboom.security.saml.saml2.metadata.Metadata metadata) {
    var result = createObject("java","java.util.LinkedList").init();
    for (var p in arguments.metadata.getSsoProviders()) {
      var roleDescriptor = null;
      if (isInstanceOf(p, "cfboom.security.saml.saml2.metadata.ServiceProvider")) {
        var sp = p;
        var descriptor = getSPSSODescriptor();
        roleDescriptor = descriptor;
        descriptor.setAuthnRequestsSigned(sp.isAuthnRequestsSigned());
        descriptor.setWantAssertionsSigned(sp.isWantAssertionsSigned());

        for (var id in p.getNameIds()) {
          descriptor.getNameIDFormats().add(getNameIDFormat(id));
        }

        for (var i = 0; i < sp.getAssertionConsumerService().size(); i++) {
          var ep = sp.getAssertionConsumerService().get(i);
          descriptor.getAssertionConsumerServices().add(getAssertionConsumerService(ep, i));
        }
        for (var i = 0; i < sp.getArtifactResolutionService().size(); i++) {
          var ep = sp.getArtifactResolutionService().get(i);
          descriptor.getArtifactResolutionServices().add(getArtifactResolutionService(ep, i));
        }
        for (var i = 0; i < sp.getSingleLogoutService().size(); i++) {
          var ep = sp.getSingleLogoutService().get(i);
          descriptor.getSingleLogoutServices().add(getSingleLogoutService(ep));
        }
        if (!isNull(sp.getRequestedAttributes()) && !sp.getRequestedAttributes().isEmpty()) {
          descriptor
            .getAttributeConsumingServices()
            .add(getAttributeConsumingService(sp.getRequestedAttributes()));
        }

      }
      else if (isInstanceOf(p, "cfboom.security.saml.saml2.metadata.IdentityProvider")) {
        var idp = p;
        var descriptor = getIDPSSODescriptor();
        roleDescriptor = descriptor;
        descriptor.setWantAuthnRequestsSigned(idp.getWantAuthnRequestsSigned());
        for (var id in p.getNameIds()) {
          descriptor.getNameIDFormats().add(getNameIDFormat(id));
        }
        for (var i = 0; i < idp.getSingleSignOnService().size(); i++) {
          var ep = idp.getSingleSignOnService().get(i);
          descriptor.getSingleSignOnServices().add(getSingleSignOnService(ep, i));
        }
        for (var i = 0; i < p.getSingleLogoutService().size(); i++) {
          var ep = p.getSingleLogoutService().get(i);
          descriptor.getSingleLogoutServices().add(getSingleLogoutService(ep));
        }
        for (var i = 0; i < p.getArtifactResolutionService().size(); i++) {
          var ep = p.getArtifactResolutionService().get(i);
          descriptor.getArtifactResolutionServices().add(getArtifactResolutionService(ep, i));
        }
      }
      var now = getTime().millis();
      if (!isNull(p.getCacheDuration())) {
        roleDescriptor.setCacheDuration(p.getCacheDuration().getTimeInMillis(createObject("java","java.util.Date").init(now)));
      }
      roleDescriptor.setValidUntil(p.getValidUntil());
      roleDescriptor.addSupportedProtocol(Namespace.NS_PROTOCOL);
      roleDescriptor.setID(Optional.ofNullable(p.getId()).orElse(UUID.randomUUID().toString()));

      for (var key in p.getKeys()) {
        roleDescriptor.getKeyDescriptors().add(getKeyDescriptor(key));
      }

      //md:extensions
      var requestInitiation = p.getRequestInitiation();
      var discovery = p.getDiscovery();
      if (!isNull(requestInitiation) || !isNull(discovery)) {
        var extensionsBuilder = getBuilderFactory().getBuilder(Extensions.DEFAULT_ELEMENT_NAME);
        roleDescriptor.setExtensions(extensionsBuilder.buildObject());

        if (!isNull(requestInitiation)) {
          var builder = getBuilderFactory().getBuilder(RequestInitiator.DEFAULT_ELEMENT_NAME);
          var init = builder.buildObject();
          init.setBinding(requestInitiation.getBinding().toString());
          init.setLocation(requestInitiation.getLocation());
          init.setResponseLocation(requestInitiation.getResponseLocation());
          roleDescriptor.getExtensions().getUnknownXMLObjects().add(init);
        }
        if (!isNull(discovery)) {
          var builder = getBuilderFactory().getBuilder(DiscoveryResponse.DEFAULT_ELEMENT_NAME);
          var response = builder.buildObject(DiscoveryResponse.DEFAULT_ELEMENT_NAME);
          response.setBinding(discovery.getBinding().toString());
          response.setLocation(discovery.getLocation());
          response.setResponseLocation(discovery.getResponseLocation());
          response.setIsDefault(discovery.isDefault());
          response.setIndex(discovery.getIndex());
          roleDescriptor.getExtensions().getUnknownXMLObjects().add(response);
        }
      }
      result.add(roleDescriptor);
    }
    return result;
  }

  public org.opensaml.saml.saml2.metadata.AttributeConsumingService function getAttributeConsumingService(any attributes) {

    var service = buildSAMLObject(variables.javaLoader.loadClass("org.opensaml.saml.saml2.metadata.AttributeConsumingService"));
    service.setIsDefault(true);
    service.setIndex(0);
    var attrs = createObject("java","java.util.LinkedList").init();
    for (var a in arguments.attributes) {
      var ra = buildSAMLObject(variables.javaLoader.loadClass("org.opensaml.saml.saml2.metadata.RequestedAttribute"));
      ra.setIsRequired(a.isRequired());
      ra.setFriendlyName(a.getFriendlyName());
      ra.setName(a.getName());
      ra.setNameFormat(a.getNameFormat().toString());
      attrs.add(ra);
    }
    service.getRequestAttributes().addAll(attrs);
    return service;
  }

  public org.opensaml.saml.saml2.metadata.ArtifactResolutionService function getArtifactResolutionService(cfboom.security.saml.saml2.metadata.Endpoint ep, numeric i) {
    var service = buildSAMLObject(variables.javaLoader.loadClass("org.opensaml.saml.saml2.metadata.ArtifactResolutionService"));
    service.setLocation(ep.getLocation());
    service.setBinding(ep.getBinding().toString());
    service.setIndex(javaCast("int",i));
    service.setIsDefault(ep.isDefault());
    service.setResponseLocation(ep.getResponseLocation());
    return service;
  }
/*
	protected org.opensaml.saml.saml2.core.LogoutResponse internalToXml(LogoutResponse response) {
		org.opensaml.saml.saml2.core.LogoutResponse result =
			buildSAMLObject(org.opensaml.saml.saml2.core.LogoutResponse.class);
		result.setInResponseTo(response.getInResponseTo());
		result.setID(response.getId());
		result.setIssueInstant(response.getIssueInstant());
		result.setDestination(response.getDestination());

		org.opensaml.saml.saml2.core.Issuer issuer = buildSAMLObject(org.opensaml.saml.saml2.core.Issuer.class);
		issuer.setValue(response.getIssuer().getValue());
		issuer.setNameQualifier(response.getIssuer().getNameQualifier());
		issuer.setSPNameQualifier(response.getIssuer().getSpNameQualifier());
		result.setIssuer(issuer);

		org.opensaml.saml.saml2.core.Status status = buildSAMLObject(org.opensaml.saml.saml2.core.Status.class);
		org.opensaml.saml.saml2.core.StatusCode code = buildSAMLObject(org.opensaml.saml.saml2.core.StatusCode.class);
		code.setValue(response.getStatus().getCode().toString());
		status.setStatusCode(code);
		if (hasText(response.getStatus().getMessage())) {
			StatusMessage message = buildSAMLObject(StatusMessage.class);
			message.setMessage(response.getStatus().getMessage());
			status.setStatusMessage(message);
		}
		result.setStatus(status);

		if (response.getSigningKey() != null) {
			this.signObject(result, response.getSigningKey(), response.getAlgorithm(), response.getDigest());
		}

		return result;
	}
*/
/*
	protected org.opensaml.saml.saml2.core.LogoutRequest internalToXml(LogoutRequest request) {
		org.opensaml.saml.saml2.core.LogoutRequest lr =
			buildSAMLObject(org.opensaml.saml.saml2.core.LogoutRequest.class);
		lr.setDestination(request.getDestination().getLocation());
		lr.setID(request.getId());
		lr.setVersion(SAMLVersion.VERSION_20);
		org.opensaml.saml.saml2.core.Issuer issuer = buildSAMLObject(org.opensaml.saml.saml2.core.Issuer.class);
		issuer.setValue(request.getIssuer().getValue());
		issuer.setNameQualifier(request.getIssuer().getNameQualifier());
		issuer.setSPNameQualifier(request.getIssuer().getSpNameQualifier());
		lr.setIssuer(issuer);
		lr.setIssueInstant(request.getIssueInstant());
		lr.setNotOnOrAfter(request.getNotOnOrAfter());
		NameID nameID = buildSAMLObject(NameID.class);
		nameID.setFormat(request.getNameId().getFormat().toString());
		nameID.setValue(request.getNameId().getValue());
		nameID.setSPNameQualifier(request.getNameId().getSpNameQualifier());
		nameID.setNameQualifier(request.getNameId().getNameQualifier());
		lr.setNameID(nameID);
		if (request.getSigningKey() != null) {
			signObject(lr, request.getSigningKey(), request.getAlgorithm(), request.getDigest());
		}
		return lr;
	}
*/
/*
	protected org.opensaml.saml.saml2.core.Assertion internalToXml(Assertion request) {
		org.opensaml.saml.saml2.core.Assertion a = buildSAMLObject(org.opensaml.saml.saml2.core.Assertion
			.class);
		a.setVersion(SAMLVersion.VERSION_20);
		a.setIssueInstant(request.getIssueInstant());
		a.setID(request.getId());
		org.opensaml.saml.saml2.core.Issuer issuer = buildSAMLObject(org.opensaml.saml.saml2.core.Issuer
			.class);
		issuer.setValue(request.getIssuer().getValue());
		a.setIssuer(issuer);

		NameIdPrincipal principal = (NameIdPrincipal) request.getSubject().getPrincipal();

		NameID nid = buildSAMLObject(NameID.class);
		nid.setValue(request.getSubject().getPrincipal().getValue());
		nid.setFormat(principal.getFormat().toString());
		nid.setSPNameQualifier(principal.getSpNameQualifier());

		org.opensaml.saml.saml2.core.SubjectConfirmationData confData =
			buildSAMLObject(org.opensaml.saml.saml2.core.SubjectConfirmationData.class);
		confData.setInResponseTo(request.getSubject()
			.getConfirmations()
			.get(0)
			.getConfirmationData()
			.getInResponseTo());
		confData.setNotBefore(request.getSubject().getConfirmations().get(0).getConfirmationData().getNotBefore());
		confData.setNotOnOrAfter(request.getSubject()
			.getConfirmations()
			.get(0)
			.getConfirmationData()
			.getNotOnOrAfter());
		confData.setRecipient(request.getSubject().getConfirmations().get(0).getConfirmationData().getRecipient());

		org.opensaml.saml.saml2.core.SubjectConfirmation confirmation =
			buildSAMLObject(org.opensaml.saml.saml2.core.SubjectConfirmation.class);
		confirmation.setMethod(request.getSubject().getConfirmations().get(0).getMethod().toString());
		confirmation.setSubjectConfirmationData(confData);

		org.opensaml.saml.saml2.core.Subject subject =
			buildSAMLObject(org.opensaml.saml.saml2.core.Subject.class);
		a.setSubject(subject);
		subject.setNameID(nid);
		subject.getSubjectConfirmations().add(confirmation);

		org.opensaml.saml.saml2.core.Conditions conditions =
			buildSAMLObject(org.opensaml.saml.saml2.core.Conditions.class);
		conditions.setNotBefore(request.getConditions().getNotBefore());
		conditions.setNotOnOrAfter(request.getConditions().getNotOnOrAfter());
		a.setConditions(conditions);

		request.getConditions().getCriteria().forEach(c -> addCondition(conditions, c));


		for (AuthenticationStatement stmt : request.getAuthenticationStatements()) {
			org.opensaml.saml.saml2.core.AuthnStatement authnStatement =
				buildSAMLObject(org.opensaml.saml.saml2.core.AuthnStatement.class);
			org.opensaml.saml.saml2.core.AuthnContext actx =
				buildSAMLObject(org.opensaml.saml.saml2.core.AuthnContext.class);
			org.opensaml.saml.saml2.core.AuthnContextClassRef aref =
				buildSAMLObject(org.opensaml.saml.saml2.core.AuthnContextClassRef.class);
			aref.setAuthnContextClassRef(stmt.getAuthenticationContext().getClassReference().toString());
			actx.setAuthnContextClassRef(aref);
			authnStatement.setAuthnContext(actx);
			a.getAuthnStatements().add(authnStatement);
			authnStatement.setSessionIndex(stmt.getSessionIndex());
			authnStatement.setSessionNotOnOrAfter(stmt.getSessionNotOnOrAfter());
			authnStatement.setAuthnInstant(stmt.getAuthInstant());
		}

		org.opensaml.saml.saml2.core.AttributeStatement astmt =
			buildSAMLObject(org.opensaml.saml.saml2.core.AttributeStatement.class);
		for (Attribute attr : request.getAttributes()) {
			org.opensaml.saml.saml2.core.Attribute attribute =
				buildSAMLObject(org.opensaml.saml.saml2.core.Attribute.class);
			attribute.setName(attr.getName());
			attribute.setFriendlyName(attr.getFriendlyName());
			attribute.setNameFormat(attr.getNameFormat().toString());
			attr.getValues().stream().forEach(
				av -> attribute.getAttributeValues().add(objectToXmlObject(av))
			);
			astmt.getAttributes().add(attribute);
		}
		a.getAttributeStatements().add(astmt);

		if (request.getSigningKey() != null) {
			signObject(a, request.getSigningKey(), request.getAlgorithm(), request.getDigest());
		}

		return a;
	}
*/
/*
	protected void addCondition(org.opensaml.saml.saml2.core.Conditions conditions, AssertionCondition c) {
		if (c instanceof AudienceRestriction) {
			org.opensaml.saml.saml2.core.AudienceRestriction ar =
				buildSAMLObject(org.opensaml.saml.saml2.core.AudienceRestriction.class);
			for (String audience : ((AudienceRestriction) c).getAudiences()) {
				Audience aud = buildSAMLObject(Audience.class);
				aud.setAudienceURI(audience);
				ar.getAudiences().add(aud);
			}
			conditions.getAudienceRestrictions().add(ar);
		}
		else if (c instanceof OneTimeUse) {
			org.opensaml.saml.saml2.core.OneTimeUse otu =
				buildSAMLObject(org.opensaml.saml.saml2.core.OneTimeUse.class);
			conditions.getConditions().add(otu);
		}
	}
*/
/*
	protected AuthnRequest internalToXml(AuthenticationRequest request) {
		AuthnRequest auth = buildSAMLObject(AuthnRequest.class);
		auth.setID(request.getId());
		auth.setVersion(SAMLVersion.VERSION_20);
		auth.setIssueInstant(request.getIssueInstant());
		auth.setForceAuthn(request.isForceAuth());
		auth.setIsPassive(request.isPassive());
		auth.setProtocolBinding(request.getBinding().toString());
		// Azure AD as IdP will not accept index if protocol binding or AssertationCustomerServiceURL is set.
//		auth.setAssertionConsumerServiceIndex(request.getAssertionConsumerService().getIndex());
		auth.setAssertionConsumerServiceURL(request.getAssertionConsumerService().getLocation());
		auth.setDestination(request.getDestination().getLocation());
		auth.setNameIDPolicy(getNameIDPolicy(request.getNameIdPolicy()));
		auth.setRequestedAuthnContext(getRequestedAuthenticationContext(request));
		auth.setIssuer(toIssuer(request.getIssuer()));
		if (request.getSigningKey() != null) {
			this.signObject(auth, request.getSigningKey(), request.getAlgorithm(), request.getDigest());
		}

		return auth;
	}
*/
/*
	protected String marshallToXml(XMLObject auth) {
		try {
			Element element = getMarshallerFactory()
				.getMarshaller(auth)
				.marshall(auth);
			return SerializeSupport.nodeToString(element);
		} catch (MarshallingException e) {
			throw new SamlException(e);
		}
	}
*/
/*
	protected RequestedAuthnContext getRequestedAuthenticationContext(AuthenticationRequest request) {
		RequestedAuthnContext result = null;
		if (request.getRequestedAuthenticationContext() != null) {
			result = buildSAMLObject(RequestedAuthnContext.class);
			switch (request.getRequestedAuthenticationContext()) {
				case exact:
					result.setComparison(EXACT);
					break;
				case better:
					result.setComparison(AuthnContextComparisonTypeEnumeration.BETTER);
					break;
				case maximum:
					result.setComparison(AuthnContextComparisonTypeEnumeration.MAXIMUM);
					break;
				case minimum:
					result.setComparison(AuthnContextComparisonTypeEnumeration.MAXIMUM);
					break;
				default:
					result.setComparison(EXACT);
					break;
			}
			if (request.getAuthenticationContextClassReference() != null) {
				final AuthnContextClassRef authnContextClassRef = buildSAMLObject(AuthnContextClassRef.class);
				authnContextClassRef.setAuthnContextClassRef(request.getAuthenticationContextClassReference()
					.toString());
				result.getAuthnContextClassRefs().add(authnContextClassRef);
			}
		}
		return result;
	}
*/
/*
	protected NameIDPolicy getNameIDPolicy(
		NameIdPolicy nameIdPolicy
	) {
		NameIDPolicy result = null;
		if (nameIdPolicy != null) {
			result = buildSAMLObject(NameIDPolicy.class);
			result.setAllowCreate(nameIdPolicy.getAllowCreate());
			result.setFormat(nameIdPolicy.getFormat().toString());
			result.setSPNameQualifier(nameIdPolicy.getSpNameQualifier());
		}
		return result;
	}
*/
/*
	protected NameIdPolicy fromNameIDPolicy(NameIDPolicy nameIDPolicy) {
		NameIdPolicy result = null;
		if (nameIDPolicy != null) {
			result = new NameIdPolicy()
				.setAllowCreate(nameIDPolicy.getAllowCreate())
				.setFormat(NameId.fromUrn(nameIDPolicy.getFormat()))
				.setSpNameQualifier(nameIDPolicy.getSPNameQualifier());
		}
		return result;
	}
*/
  public cfboom.security.saml.saml2.authentication.Response function resolveResponse(any parsed, any verificationKeys, any localKeys) {
    var result = new cfboom.security.saml.saml2.authentication.Response()
      .setConsent(arguments.parsed.getConsent())
      .setDestination(arguments.parsed.getDestination())
      .setId(arguments.parsed.getID())
      .setInResponseTo(arguments.parsed.getInResponseTo())
      .setIssueInstant(arguments.parsed.getIssueInstant())
      .setIssuer(getIssuer(arguments.parsed.getIssuer()))
      .setVersion(arguments.parsed.getVersion().toString())
      .setStatus(getStatus(arguments.parsed.getStatus()));
    var assertions = createObject("java","java.util.LinkedList").init();
    for (var a in arguments.parsed.getAssertions()) {
      assertions.add(resolveAssertion(a, arguments.verificationKeys, arguments.localKeys));
    }
    result.setAssertions(assertions);
    if (!isNull(arguments.parsed.getEncryptedAssertions()) && !arguments.parsed.getEncryptedAssertions().isEmpty()) {
      for (var a in arguments.parsed.getEncryptedAssertions()) {
        result.addAssertion(
          resolveAssertion(decrypt(a, arguments.localKeys), arguments.verificationKeys, arguments.localKeys)
        );
      }
    }
    return result;
  }
/*
	protected LogoutResponse resolveLogoutResponse(org.opensaml.saml.saml2.core.LogoutResponse response,
												   List<SimpleKey> verificationKeys,
												   List<SimpleKey> localKeys) {
		LogoutResponse result = new LogoutResponse()
			.setId(response.getID())
			.setInResponseTo(response.getInResponseTo())
			.setConsent(response.getConsent())
			.setVersion(response.getVersion().toString())
			.setIssueInstant(response.getIssueInstant())
			.setIssuer(getIssuer(response.getIssuer()))
			.setDestination(response.getDestination())
			.setStatus(getStatus(response.getStatus()));

		return result;
	}
*/
/*
	protected LogoutRequest resolveLogoutRequest(org.opensaml.saml.saml2.core.LogoutRequest request,
												 List<SimpleKey> verificationKeys,
												 List<SimpleKey> localKeys) {
		LogoutRequest result = new LogoutRequest()
			.setId(request.getID())
			.setConsent(request.getConsent())
			.setVersion(request.getVersion().toString())
			.setNotOnOrAfter(request.getNotOnOrAfter())
			.setIssueInstant(request.getIssueInstant())
			.setReason(LogoutReason.fromUrn(request.getReason()))
			.setIssuer(getIssuer(request.getIssuer()))
			.setDestination(new Endpoint().setLocation(request.getDestination()));
		NameID nameID = getNameID(request.getNameID(), request.getEncryptedID(), localKeys);
		result.setNameId(getNameIdPrincipal(nameID));
		return result;
	}
*/
  public cfboom.security.saml.saml2.authentication.Status function getStatus(any status) {
    return new cfboom.security.saml.saml2.authentication.Status()
      .setCode(StatusCode.fromUrn(arguments.status.getStatusCode().getValue()))
      .setMessage(!isNull(arguments.status.getStatusMessage()) ? arguments.status.getStatusMessage().getMessage() : null);
  }

  public cfboom.security.saml.saml2.authentication.Assertion function resolveAssertion(any parsed, any verificationKeys, any localKeys) {
    var signature = validateSignature(arguments.parsed, arguments.verificationKeys);
    return new cfboom.security.saml.saml2.authentication.Assertion()
      .setSignature(signature)
      .setId(arguments.parsed.getID())
      .setIssueInstant(arguments.parsed.getIssueInstant())
      .setVersion(arguments.parsed.getVersion().toString())
      .setIssuer(getIssuer(arguments.parsed.getIssuer()))
      .setSubject(getSubject(arguments.parsed.getSubject(), arguments.localKeys))
      .setConditions(getConditions(arguments.parsed.getConditions()))
      .setAuthenticationStatements(getAuthenticationStatements(arguments.parsed.getAuthnStatements()))
      .setAttributes(getAttributes(arguments.parsed.getAttributeStatements(), arguments.localKeys))
      ;
  }

  public any function getRequestedAttributes(any attributes) {
    var result = createObject("java","java.util.LinkedList").init();
    for (var a in Optional.ofNullable(arguments.attributes).orElse(Collections.emptyList())) {
      result.add(
        new cfboom.security.saml.saml2.attribute.Attribute()
          .setFriendlyName(a.getFriendlyName())
          .setName(a.getName())
          .setNameFormat(AttributeNameFormat.fromUrn(a.getNameFormat()))
          .setValues(getJavaValues(a.getAttributeValues()))
          .setRequired(a.isRequired())
      );
    }
    return result;
  }

  public any function getAttributes(any attributeStatements, any localKeys) {
    var result = createObject("java","java.util.LinkedList").init();
    for (var stmt in Optional.ofNullable(attributeStatements).orElse(Collections.emptyList())) {
      for (var a in Optional.ofNullable(stmt.getAttributes()).orElse(Collections.emptyList())) {
        result.add(
          new cfboom.security.saml.saml2.attribute.Attribute()
            .setFriendlyName(a.getFriendlyName())
            .setName(a.getName())
            .setNameFormat(AttributeNameFormat.fromUrn(a.getNameFormat()))
            .setValues(getJavaValues(a.getAttributeValues()))
        );
      }
      for (var encryptedAttribute in Optional.ofNullable(stmt.getEncryptedAttributes()).orElse(Collections.emptyList())) {
        var a = decrypt(encryptedAttribute, arguments.localKeys);
        result.add(
          new cfboom.security.saml.saml2.attribute.Attribute()
            .setFriendlyName(a.getFriendlyName())
            .setName(a.getName())
            .setNameFormat(AttributeNameFormat.fromUrn(a.getNameFormat()))
            .setValues(getJavaValues(a.getAttributeValues()))
        );
      }
    }
    return result;
  }

  public any function getJavaValues(any attributeValues) {
    var result = createObject("java","java.util.LinkedList").init();
    for (var o in Optional.ofNullable(arguments.attributeValues).orElse(Collections.emptyList())) {
      if (isNull(o)) {
        // Do nothing
      }
      else if (isInstanceOf(o, "org.opensaml.core.xml.schema.XSString")) {
        result.add(o.getValue());
      }
      else if (isInstanceOf(o, "org.opensaml.core.xml.schema.XSURI")) {
        try {
          result.add(createObject("java","java.net.URI").init(o.getValue()));
        } catch (java.net.URISyntaxException e) {
          result.add(o.getValue());
        }
      }
      else if (isInstanceOf(o, "org.opensaml.core.xml.schema.XSBoolean")) {
        result.add(javaCast("boolean", o.getValue().getValue()));
      }
      else if (isInstanceOf(o, "org.opensaml.core.xml.schema.XSDateTime")) {
        result.add(o.getValue());
      }
      else if (isInstanceOf(o, "org.opensaml.core.xml.schema.XSInteger")) {
        result.add(o.getValue());
      }
      else if (isInstanceOf(o, "org.opensaml.core.xml.schema.XSAny")) {
        result.add(o.getTextContent());
      }
      else {
        //we don't know the type.
        result.add(o);
      }
    }
    return result;
  }

  public any function getAuthenticationStatements(any authnStatements) {
    var result = createObject("java","java.util.LinkedList").init();

    for (var s in Optional.ofNullable(arguments.authnStatements).orElse(Collections.emptyList())) {
      var authnContext = s.getAuthnContext();
      var authnContextClassRef = authnContext.getAuthnContextClassRef();
      var ref = null;
      if (!isNull(authnContextClassRef.getAuthnContextClassRef())) {
        ref = authnContextClassRef.getAuthnContextClassRef();
      }

      result.add(
        new cfboom.security.saml.saml2.authentication.AuthenticationStatement()
          .setSessionIndex(s.getSessionIndex())
          .setAuthInstant(s.getAuthnInstant())
          .setSessionNotOnOrAfter(s.getSessionNotOnOrAfter())
          .setAuthenticationContext(
            !isNull(authnContext) ?
              new cfboom.security.saml.saml2.authentication.AuthenticationContext()
                .setClassReference(AuthenticationContextClassReference.fromUrn(ref))
              : null
          )
      );

    }
    return result;
  }

  public cfboom.security.saml.saml2.authentication.Conditions function getConditions(any conditions) {
    return new cfboom.security.saml.saml2.authentication.Conditions()
      .setNotBefore(arguments.conditions.getNotBefore())
      .setNotOnOrAfter(arguments.conditions.getNotOnOrAfter())
      .setCriteria(getCriteria(arguments.conditions.getConditions()));
  }

  public any function getCriteria(any conditions) {
    var result = createObject("java","java.util.LinkedList").init();
    for (var c in arguments.conditions) {
      if (isInstanceOf(c, "org.opensaml.saml.saml2.core.AudienceRestriction")) {
          var aud = c;
          if (!isNull(aud.getAudiences())) {
            var audiences = createObject("java","java.util.LinkedList").init();
            for (var audience in aud.getAudiences()) {
              audiences.add(audience.getAudienceURI());
            }
            result.add(
              new cfboom.security.saml.saml2.authentication.AudienceRestriction()
                .setAudiences(audiences)
            );
          }
      }
      else if (isInstanceOf(c, "org.opensaml.saml.saml2.core.OneTimeUse")) {
        result.add(new cfboom.security.saml.saml2.authentication.OneTimeUse());
      }
    }
    return result;
  }

  public cfboom.security.saml.saml2.authentication.Subject function getSubject(any subject, any localKeys) {
    return new cfboom.security.saml.saml2.authentication.Subject()
      .setPrincipal(getPrincipal(arguments.subject, arguments.localKeys))
      .setConfirmations(getConfirmations(arguments.subject.getSubjectConfirmations(), arguments.localKeys))
      ;
  }

  public any function getConfirmations(any subjectConfirmations, any localKeys) {
    var result = createObject("java","java.util.LinkedList").init();
    for (var s in arguments.subjectConfirmations) {
      var nameID = getNameID(s.getNameID(), s.getEncryptedID(), arguments.localKeys);
      result.add(
        new cfboom.security.saml.saml2.authentication.SubjectConfirmation()
          .setNameId(!isNull(nameID) ? nameID.getValue() : null)
          .setFormat(!isNull(nameID) ? NameId.fromUrn(nameID.getFormat()) : null)
          .setMethod(SubjectConfirmationMethod.fromUrn(s.getMethod()))
          .setConfirmationData(
            new cfboom.security.saml.saml2.authentication.SubjectConfirmationData()
              .setRecipient(s.getSubjectConfirmationData().getRecipient())
              .setNotOnOrAfter(s.getSubjectConfirmationData().getNotOnOrAfter())
              .setNotBefore(s.getSubjectConfirmationData().getNotBefore())
              .setInResponseTo(s.getSubjectConfirmationData().getInResponseTo())
          )
      );
    }
    return result;
  }

  public any function getNameID(any id, any eid, any localKeys) {
    var result = arguments.id;
    if (isNull(result) && !isNull(arguments.eid) && !isNull(arguments.eid.getEncryptedData())) {
      result = decrypt(arguments.eid, arguments.localKeys);
    }
    return result;
  }

  public cfboom.security.saml.saml2.authentication.NameIdPrincipal function getPrincipal(any subject, any localKeys) {
    var p =
      getNameID(
        arguments.subject.getNameID(),
        arguments.subject.getEncryptedID(),
        arguments.localKeys
      );
    if (!isNull(p)) {
      return getNameIdPrincipal(p);
    }
    else {
      throw(object=createObject("java","java.lang.UnsupportedOperationException").init("Currently only supporting NameID subject principals"));
    }
  }

  public cfboom.security.saml.saml2.authentication.NameIdPrincipal function getNameIdPrincipal(any p) {
    return new cfboom.security.saml.saml2.authentication.NameIdPrincipal()
      .setSpNameQualifier(arguments.p.getSPNameQualifier())
      .setNameQualifier(arguments.p.getNameQualifier())
      .setFormat(NameId.fromUrn(arguments.p.getFormat()))
      .setSpProvidedId(arguments.p.getSPProvidedID())
      .setValue(arguments.p.getValue());
  }
/*
	protected org.opensaml.saml.saml2.core.Issuer toIssuer(Issuer issuer) {
		org.opensaml.saml.saml2.core.Issuer result =
			buildSAMLObject(org.opensaml.saml.saml2.core.Issuer.class);
		result.setValue(issuer.getValue());
		if (issuer.getFormat() != null) {
			result.setFormat(issuer.getFormat().toString());
		}
		result.setSPNameQualifier(issuer.getSpNameQualifier());
		result.setNameQualifier(issuer.getNameQualifier());
		return result;
	}
*/
  public cfboom.security.saml.saml2.authentication.Issuer function getIssuer(any issuer) {
    return (!structKeyExists(arguments, "issuer") || isNull(arguments.issuer)) ? null :
      new cfboom.security.saml.saml2.authentication.Issuer()
        .setValue(arguments.issuer.getValue())
        .setFormat(NameId.fromUrn(arguments.issuer.getFormat()))
        .setSpNameQualifier(arguments.issuer.getSPNameQualifier())
        .setNameQualifier(arguments.issuer.getNameQualifier());
  }
/*
	protected AuthenticationRequest resolveAuthenticationRequest(AuthnRequest parsed) {
		AuthnRequest request = parsed;
		AuthenticationRequest result = new AuthenticationRequest()
			.setBinding(Binding.fromUrn(request.getProtocolBinding()))
			.setAssertionConsumerService(
				getEndpoint(
					request.getAssertionConsumerServiceURL(),
					Binding.fromUrn(request.getProtocolBinding()),
					Optional.ofNullable(request.getAssertionConsumerServiceIndex()).orElse(-1),
					false
				)
			)
			.setDestination(
				getEndpoint(
					request.getDestination(),
					Binding.fromUrn(request.getProtocolBinding()),
					-1,
					false
				)
			)
			.setIssuer(getIssuer(request.getIssuer()))
			.setForceAuth(request.isForceAuthn())
			.setPassive(request.isPassive())
			.setId(request.getID())
			.setIssueInstant(request.getIssueInstant())
			.setVersion(request.getVersion().toString())
			.setRequestedAuthenticationContext(getRequestedAuthenticationContext(request))
			.setAuthenticationContextClassReference(getAuthenticationContextClassReference(request))
			.setNameIdPolicy(fromNameIDPolicy(request.getNameIDPolicy()));

		return result;
	}
*/
/*
	protected AuthenticationContextClassReference getAuthenticationContextClassReference(AuthnRequest request) {
		AuthenticationContextClassReference result = null;
		final RequestedAuthnContext context = request.getRequestedAuthnContext();
		if (context != null && !CollectionUtils.isEmpty(context.getAuthnContextClassRefs())) {
			final String urn = context.getAuthnContextClassRefs().get(0).getAuthnContextClassRef();
			result = AuthenticationContextClassReference.fromUrn(urn);
		}
		return result;
	}
*/
/*
	protected RequestedAuthenticationContext getRequestedAuthenticationContext(AuthnRequest request) {
		RequestedAuthenticationContext result = null;

		if (request.getRequestedAuthnContext() != null) {
			AuthnContextComparisonTypeEnumeration comparison = request.getRequestedAuthnContext().getComparison();
			if (null != comparison) {
				result = RequestedAuthenticationContext.valueOf(comparison.toString());
			}
		}
		return result;
	}
*/
/*
    // @parsed.javaType org.opensaml.saml.saml2.metadata.EntitiesDescriptor
	public cfboom.security.saml.saml2.metadata.Metadata function resolveMetadataFromEntitiesDescriptor(any parsed,
									   any verificationKeys,
									   any localKeys) {
		Metadata result = null, current = null;
		for (EntityDescriptor desc : parsed.getEntityDescriptors()) {
			if (result == null) {
				result = resolveMetadataFromEntityDescriptor(desc);
				current = result;
			}
			else {
				Metadata m = resolveMetadataFromEntityDescriptor(desc);
				current.setNext(m);
				current = m;
			}
			Signature signature = validateSignature(desc, verificationKeys);
			current.setSignature(signature);
		}
		return result;
	}
*/
  // @parsed.javaType org.opensaml.saml.saml2.metadata.EntityDescriptor
  public cfboom.security.saml.saml2.metadata.Metadata function resolveMetadataFromEntityDescriptor(any parsed) {
    var descriptor = arguments.parsed;
    var ssoProviders = getSsoProviders(descriptor);
    var desc = getProviderMetadata(ssoProviders); // TODO: Re-name from reserved ColdFusion word
    var duration = !isNull(descriptor.getCacheDuration()) ? descriptor.getCacheDuration() : javaCast("long",-1);
    desc.setCacheDuration(toDuration(duration));
    desc.setEntityId(descriptor.getEntityID());
    desc.setEntityAlias(descriptor.getEntityID());
    desc.setId(descriptor.getID());
    desc.setValidUntil(descriptor.getValidUntil());
    return desc;
  }

  public cfboom.security.saml.saml2.metadata.Metadata function getProviderMetadata(any ssoProviders) {
    var result = determineMetadataType(arguments.ssoProviders);
    result.setProviders(arguments.ssoProviders);
    return result;
  }

  private cfboom.security.saml.saml2.metadata.Metadata function determineMetadataType(any ssoProviders) {
    var result = new cfboom.security.saml.saml2.metadata.Metadata();
    var sps = javaCast("long", 0);
    arguments.ssoProviders.each( function( provider ) {
      if (isInstanceOf(provider, "cfboom.security.saml.saml2.metadata.ServiceProvider"))
        sps = javaCast("long", sps + 1);
    });
    var idps = javaCast("long", 0);
    arguments.ssoProviders.each( function( provider ) {
      if (isInstanceOf(provider, "cfboom.security.saml.saml2.metadata.IdentityProvider"))
        idps = javaCast("long", idps + 1);
    });

    if (arguments.ssoProviders.size() == sps) {
        result = new cfboom.security.saml.saml2.metadata.ServiceProviderMetadata();
    } else if (arguments.ssoProviders.size() == idps) {
        result = new cfboom.security.saml.saml2.metadata.IdentityProviderMetadata();
    }
    result.setProviders(arguments.ssoProviders);
    return result;
  }
/*
	protected XMLObject objectToXmlObject(Object o) {
		if (o == null) {
			return null;
		}
		else if (o instanceof String) {
			XSStringBuilder builder = (XSStringBuilder) getBuilderFactory().getBuilder(XSString.TYPE_NAME);
			XSString s = builder.buildObject(AttributeValue.DEFAULT_ELEMENT_NAME, XSString.TYPE_NAME);
			s.setValue((String) o);
			return s;
		}
		else if (o instanceof URI || o instanceof URL) {
			XSURIBuilder builder = (XSURIBuilder) getBuilderFactory().getBuilder(XSURI.TYPE_NAME);
			XSURI uri = builder.buildObject(AttributeValue.DEFAULT_ELEMENT_NAME, XSURI.TYPE_NAME);
			uri.setValue(o.toString());
			return uri;
		}
		else if (o instanceof Boolean) {
			XSBooleanBuilder builder = (XSBooleanBuilder) getBuilderFactory().getBuilder(XSBoolean.TYPE_NAME);
			XSBoolean b = builder.buildObject(AttributeValue.DEFAULT_ELEMENT_NAME, XSBoolean.TYPE_NAME);
			XSBooleanValue v = XSBooleanValue.valueOf(o.toString());
			b.setValue(v);
			return b;
		}
		else if (o instanceof DateTime) {
			XSDateTimeBuilder builder = (XSDateTimeBuilder) getBuilderFactory().getBuilder(XSDateTime.TYPE_NAME);
			XSDateTime dt = builder.buildObject(AttributeValue.DEFAULT_ELEMENT_NAME, XSDateTime.TYPE_NAME);
			dt.setValue((DateTime) o);
			return dt;
		}
		else if (o instanceof Integer) {
			XSIntegerBuilder builder = (XSIntegerBuilder) getBuilderFactory().getBuilder(XSInteger.TYPE_NAME);
			XSInteger i = builder.buildObject(AttributeValue.DEFAULT_ELEMENT_NAME, XSInteger.TYPE_NAME);
			i.setValue(((Integer) o).intValue());
			return i;
		}
		else {
			XSAnyBuilder builder = (XSAnyBuilder) getBuilderFactory().getBuilder(XSAny.TYPE_NAME);
			XSAny any = builder.buildObject(AttributeValue.DEFAULT_ELEMENT_NAME, XSAny.TYPE_NAME);
			any.setTextContent(o.toString());
			return any;
		}
	}
*/
/*
	protected String xmlObjectToString(XMLObject o) {
		String toMatch = null;
		if (o instanceof XSString) {
			toMatch = ((XSString) o).getValue();
		}
		else if (o instanceof XSURI) {
			toMatch = ((XSURI) o).getValue();
		}
		else if (o instanceof XSBoolean) {
			toMatch = ((XSBoolean) o).getValue().getValue() ? "1" : "0";
		}
		else if (o instanceof XSInteger) {
			toMatch = ((XSInteger) o).getValue().toString();
		}
		else if (o instanceof XSDateTime) {
			final DateTime dt = ((XSDateTime) o).getValue();
			if (dt != null) {
				toMatch = ((XSDateTime) o).getDateTimeFormatter().print(dt);
			}
		}
		else if (o instanceof XSBase64Binary) {
			toMatch = ((XSBase64Binary) o).getValue();
		}
		else if (o instanceof XSAny) {
			final XSAny wc = (XSAny) o;
			if (wc.getUnknownAttributes().isEmpty() && wc.getUnknownXMLObjects().isEmpty()) {
				toMatch = wc.getTextContent();
			}
		}
		if (toMatch != null) {
			return toMatch;
		}
		return null;
	}
*/
/*
	protected Endpoint getEndpoint(String url, Binding binding, int index, boolean isDefault) {
		return
			new Endpoint()
				.setIndex(index)
				.setBinding(binding)
				.setLocation(url)
				.setDefault(isDefault)
				.setIndex(index);
	}
*/
/*
	public NameIDFormat getNameIDFormat(NameId nameId) {
		SAMLObjectBuilder<NameIDFormat> builder =
			(SAMLObjectBuilder<NameIDFormat>) getBuilderFactory().getBuilder(NameIDFormat.DEFAULT_ELEMENT_NAME);
		NameIDFormat format = builder.buildObject();
		format.setFormat(nameId.toString());
		return format;
	}
*/
/*
	public SingleSignOnService getSingleSignOnService(Endpoint endpoint, int index) {
		SAMLObjectBuilder<SingleSignOnService> builder =
			(SAMLObjectBuilder<SingleSignOnService>) getBuilderFactory()
				.getBuilder(SingleSignOnService.DEFAULT_ELEMENT_NAME);
		SingleSignOnService sso = builder.buildObject();
		sso.setLocation(endpoint.getLocation());
		sso.setBinding(endpoint.getBinding().toString());
		return sso;
	}
*/
/*
	public AssertionConsumerService getAssertionConsumerService(Endpoint endpoint, int index) {
		SAMLObjectBuilder<AssertionConsumerService> builder =
			(SAMLObjectBuilder<AssertionConsumerService>) getBuilderFactory()
				.getBuilder(AssertionConsumerService.DEFAULT_ELEMENT_NAME);
		AssertionConsumerService consumer = builder.buildObject();
		consumer.setLocation(endpoint.getLocation());
		consumer.setBinding(endpoint.getBinding().toString());
		consumer.setIsDefault(endpoint.isDefault());
		consumer.setIndex(index);
		return consumer;
	}
*/
/*
	public SingleLogoutService getSingleLogoutService(Endpoint endpoint) {
		SAMLObjectBuilder<SingleLogoutService> builder =
			(SAMLObjectBuilder<SingleLogoutService>) getBuilderFactory()
				.getBuilder(SingleLogoutService.DEFAULT_ELEMENT_NAME);
		SingleLogoutService service = builder.buildObject();
		service.setBinding(endpoint.getBinding().toString());
		service.setLocation(endpoint.getLocation());
		return service;
	}
*/
/*
	public KeyDescriptor getKeyDescriptor(SimpleKey key) {
		SAMLObjectBuilder<KeyDescriptor> builder =
			(SAMLObjectBuilder<KeyDescriptor>) getBuilderFactory()
				.getBuilder(KeyDescriptor.DEFAULT_ELEMENT_NAME);
		KeyDescriptor descriptor = builder.buildObject();

		KeyStoreCredentialResolver resolver = getCredentialsResolver(key);
		Credential credential = getCredential(key, resolver);
		try {
			KeyInfo info = getKeyInfoGenerator(credential).generate(credential);
			descriptor.setKeyInfo(info);
			if (key.getType() != null) {
				descriptor.setUse(UsageType.valueOf(key.getType().toString()));
			}
			else {
				descriptor.setUse(UsageType.SIGNING);
			}
			return descriptor;
		} catch (SecurityException e) {
			throw new SamlKeyException(e);
		}
	}
*/
/*
	public KeyInfoGenerator getKeyInfoGenerator(Credential credential) {
		NamedKeyInfoGeneratorManager manager = DefaultSecurityConfigurationBootstrap
			.buildBasicKeyInfoGeneratorManager();
		return manager.getDefaultManager().getFactory(credential).newInstance();
	}
*/
/*
	public void signObject(SignableSAMLObject signable,
						   SimpleKey key,
						   AlgorithmMethod algorithm,
						   DigestMethod digest) {

		KeyStoreCredentialResolver resolver = getCredentialsResolver(key);
		Credential credential = getCredential(key, resolver);

		XMLObjectBuilder<org.opensaml.xmlsec.signature.Signature> signatureBuilder =
			(XMLObjectBuilder<org.opensaml.xmlsec.signature.Signature>) getBuilderFactory()
				.getBuilder(org.opensaml.xmlsec.signature.Signature.DEFAULT_ELEMENT_NAME);
		org.opensaml.xmlsec.signature.Signature signature = signatureBuilder.buildObject(org.opensaml.xmlsec
			.signature.Signature.DEFAULT_ELEMENT_NAME);

		signable.setSignature(signature);

		SignatureSigningParameters parameters = new SignatureSigningParameters();
		parameters.setSigningCredential(credential);
		parameters.setKeyInfoGenerator(getKeyInfoGenerator(credential));
		parameters.setSignatureAlgorithm(algorithm.toString());
		parameters.setSignatureReferenceDigestMethod(digest.toString());
		parameters.setSignatureCanonicalizationAlgorithm(
			CanonicalizationMethod.ALGO_ID_C14N_EXCL_OMIT_COMMENTS.toString()
		);

		try {
			SignatureSupport.prepareSignatureParams(signature, parameters);
			Marshaller marshaller = XMLObjectProviderRegistrySupport.getMarshallerFactory().getMarshaller(signable);
			marshaller.marshall(signable);
			Signer.signObject(signature);
		} catch (SecurityException | MarshallingException | SignatureException e) {
			throw new SamlKeyException(e);
		}
	}
*/
/*
	public <T> T buildSAMLObject(final Class<T> clazz) {
		T object = null;
		try {
			QName defaultElementName = (QName) clazz.getDeclaredField("DEFAULT_ELEMENT_NAME").get(null);
			object = (T) getBuilderFactory().getBuilder(defaultElementName).buildObject(defaultElementName);
		} catch (IllegalAccessException e) {
			throw new SamlException("Could not create SAML object", e);
		} catch (NoSuchFieldException e) {
			throw new SamlException("Could not create SAML object", e);
		}

		return object;
	}
*/
  private boolean function hasText( string str ) {
    if (!structKeyExists(arguments, "str"))
      return false;
    var strData = trim(arguments.str);
    return !strData.isEmpty();
  }
}
