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
  displayname="Abstract Class AbstractHostbasedSamlProviderProvisioning"
  output="false"
{
  property name="Binding" inject="Binding@cfboom-security-saml";
  property name="KeyType" inject="KeyType@cfboom-security-saml";
  property name="NameId" inject="NameId@cfboom-security-saml";

  variables['Arrays'] = createObject("java", "java.util.Arrays");
  variables['UUID'] = createObject("java","java.util.UUID");

  public cfboom.security.saml.provider.provisioning.AbstractHostbasedSamlProviderProvisioning function init(cfboom.security.saml.provider.config.SamlConfigurationRepository configuration,
                                                                                                            cfboom.security.saml.SamlTransformer transformer,
                                                                                                            cfboom.security.saml.SamlValidator validator,
                                                                                                            cfboom.security.saml.SamlMetadataCache cache) {
    variables['_configuration'] = arguments.configuration;
    variables['_transformer'] = arguments.transformer;
    variables['_validator'] = arguments.validator;
    variables['_cache'] = arguments.cache;
    return this;
  }

  public cfboom.security.saml.provider.config.SamlConfigurationRepository function getConfigurationRepository() {
    return variables._configuration;
  }
/*
	protected IdentityProviderService getHostedIdentityProvider(LocalIdentityProviderConfiguration idpConfig) {
		String basePath = idpConfig.getBasePath();
		List<SimpleKey> keys = new LinkedList<>();
		SimpleKey activeKey = idpConfig.getKeys().getActive();
		keys.add(activeKey);
		keys.add(activeKey.clone(activeKey.getName()+"-encryption",KeyType.ENCRYPTION));
		keys.addAll(idpConfig.getKeys().getStandBy());
		SimpleKey signingKey = idpConfig.isSignMetadata() ? activeKey : null;

		String prefix = hasText(idpConfig.getPrefix()) ? idpConfig.getPrefix() : "saml/idp/";
		String aliasPath = getAliasPath(idpConfig);
		IdentityProviderMetadata metadata =
			identityProviderMetadata(
				basePath,
				signingKey,
				keys,
				prefix,
				aliasPath,
				idpConfig.getDefaultSigningAlgorithm(),
				idpConfig.getDefaultDigest()
			);

		if (!idpConfig.getNameIds().isEmpty()) {
			metadata.getIdentityProvider().setNameIds(idpConfig.getNameIds());
		}

		if (!idpConfig.isSingleLogoutEnabled()) {
			metadata.getIdentityProvider().setSingleLogoutService(Collections.emptyList());
		}
		if (hasText(idpConfig.getEntityId())) {
			metadata.setEntityId(idpConfig.getEntityId());
		}
		if (hasText(idpConfig.getAlias())) {
			metadata.setEntityAlias(idpConfig.getAlias());
		}

		metadata.getIdentityProvider().setWantAuthnRequestsSigned(idpConfig.isWantRequestsSigned());

		return new HostedIdentityProviderService(
			idpConfig,
			metadata,
			getTransformer(),
			getValidator(),
			getCache()
		);
	}
*/

  public string function getAliasPath(cfboom.security.saml.provider.config.LocalProviderConfiguration configuration) {
    try {
      return !isNull(arguments.configuration.getAlias()) && len(trim(arguments.configuration.getAlias())) ?
        URLEncodedFormat(arguments.configuration.getAlias(), "iso-8859-1") :
        URLEncodedFormat(arguments.configuration.getEntityId(), "iso-8859-1");
    } catch (java.io.UnsupportedEncodingException ex) {
      throw(ex.getMessage(), "SamlException");
    }
  }

/*
	private IdentityProviderMetadata identityProviderMetadata(String baseUrl,
															  SimpleKey signingKey,
															  List<SimpleKey> keys,
															  String prefix,
															  String aliasPath,
															  AlgorithmMethod signAlgorithm,
															  DigestMethod signDigest) {

		return new IdentityProviderMetadata()
			.setEntityId(baseUrl)
			.setId(UUID.randomUUID().toString())
			.setSigningKey(signingKey, signAlgorithm, signDigest)
			.setProviders(
				asList(
					new org.springframework.security.saml.saml2.metadata.IdentityProvider()
						.setWantAuthnRequestsSigned(true)
						.setSingleSignOnService(
							asList(
								getEndpoint(baseUrl, prefix + "SSO/alias/" + aliasPath, Binding.POST, 0, true),
								getEndpoint(baseUrl, prefix + "SSO/alias/" + aliasPath, REDIRECT, 1, false)
							)
						)
						.setNameIds(asList(NameId.PERSISTENT, NameId.EMAIL))
						.setKeys(keys)
						.setSingleLogoutService(
							asList(
								getEndpoint(baseUrl, prefix + "logout/alias/" + aliasPath, REDIRECT, 0, true)
							)
						)
				)
			);

	}
*/
  public cfboom.security.saml.SamlTransformer function getTransformer() {
    return variables._transformer;
  }

  public cfboom.security.saml.SamlValidator function getValidator() {
    return variables._validator;
  }

  public cfboom.security.saml.SamlMetadataCache function getCache() {
    return variables._cache;
  }
/*
	protected Endpoint getEndpoint(String baseUrl, String path, Binding binding, int index, boolean isDefault) {
		UriComponentsBuilder builder = UriComponentsBuilder.fromUriString(baseUrl);
		builder.pathSegment(path);
		return getEndpoint(builder.build().toUriString(), binding, index, isDefault);
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
  public cfboom.security.saml.provider.service.ServiceProviderService function getHostedServiceProvider(cfboom.security.saml.provider.service.config.LocalServiceProviderConfiguration spConfig) {
    var basePath = arguments.spConfig.getBasePath();

    var keys = createObject("java","java.util.LinkedList").init();
    var activeKey = arguments.spConfig.getKeys().getActive();
    keys.add(activeKey);
    keys.add(activeKey.clone(activeKey.getName()+"-encryption",KeyType.ENCRYPTION));
    keys.addAll(arguments.spConfig.getKeys().getStandBy());
    var signingKey = arguments.spConfig.isSignMetadata() ? arguments.spConfig.getKeys().getActive() : null;

    var prefix = !isNull(arguments.spConfig.getPrefix()) && len(trim(arguments.spConfig.getPrefix())) ? arguments.spConfig.getPrefix() : "saml/sp/";
    var aliasPath = getAliasPath(arguments.spConfig);
    var metadata =
      serviceProviderMetadata(
        basePath,
        signingKey,
        keys,
        prefix,
        aliasPath,
        arguments.spConfig.getDefaultSigningAlgorithm(),
        arguments.spConfig.getDefaultDigest()
      );
    if (!arguments.spConfig.getNameIds().isEmpty()) {
      metadata.getServiceProvider().setNameIds(arguments.spConfig.getNameIds());
    }

    if (!arguments.spConfig.isSingleLogoutEnabled()) {
      metadata.getServiceProvider().setSingleLogoutService(Collections.emptyList());
    }
    if (!isNull(arguments.spConfig.getEntityId()) && len(trim(arguments.spConfig.getEntityId()))) {
      metadata.setEntityId(arguments.spConfig.getEntityId());
    }
    if (!isNull(arguments.spConfig.getAlias()) && len(trim(arguments.spConfig.getAlias()))) {
      metadata.setEntityAlias(arguments.spConfig.getAlias());
    }
    metadata.getServiceProvider().setWantAssertionsSigned(arguments.spConfig.isWantAssertionsSigned());
    metadata.getServiceProvider().setAuthnRequestsSigned(arguments.spConfig.isSignRequests());

    return new cfboom.security.saml.provider.service.HostedServiceProviderService(
      arguments.spConfig,
      metadata,
      getTransformer(),
      getValidator(),
      getCache()
    );
  }

  public cfboom.security.saml.saml2.metadata.ServiceProviderMetadata function serviceProviderMetadata(string baseUrl,
                                                                                                      cfboom.security.saml.key.SimpleKey signingKey,
                                                                                                      any keys,
                                                                                                      string prefix,
                                                                                                      string aliasPath,
                                                                                                      cfboom.security.saml.saml2.signature.AlgorithmMethod signAlgorithm,
                                                                                                      cfboom.security.saml.saml2.signature.DigestMethod signDigest) {

    return new cfboom.security.saml.saml2.metadata.ServiceProviderMetadata()
      .setEntityId(arguments.baseUrl)
      .setId(UUID.randomUUID().toString())
      .setSigningKey(arguments.signingKey, arguments.signAlgorithm, arguments.signDigest)
      .setProviders(
        Arrays.asList([
          new org.springframework.security.saml.saml2.metadata.ServiceProvider()
            .setKeys(arguments.keys)
            .setWantAssertionsSigned(true)
            .setAuthnRequestsSigned(structKeyExists(arguments, "signingKey"))
            .setAssertionConsumerService(
              Arrays.asList([
                getEndpoint(arguments.baseUrl, arguments.prefix & "SSO/alias/" & arguments.aliasPath, Binding.POST, 0, true),
                getEndpoint(arguments.baseUrl, arguments.prefix & "SSO/alias/" & arguments.aliasPath, Binding.REDIRECT, 1, false)
              ])
            )
            .setNameIds(Arrays.asList([NameId.PERSISTENT, NameId.EMAIL]))
            .setKeys(arguments.keys)
            .setSingleLogoutService(
              Arrays.asList([
                getEndpoint(arguments.baseUrl, arguments.prefix & "logout/alias/" & arguments.aliasPath, Binding.REDIRECT, 0, true)
              ])
            )
        ])
      );
  }
}
