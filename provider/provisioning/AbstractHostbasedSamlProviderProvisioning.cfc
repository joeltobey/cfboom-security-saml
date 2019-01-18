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
/*
	protected String getAliasPath(LocalProviderConfiguration configuration) {
		try {
			return hasText(configuration.getAlias()) ?
				UriUtils.encode(configuration.getAlias(), StandardCharsets.ISO_8859_1.name()) :
				UriUtils.encode(configuration.getEntityId(), StandardCharsets.ISO_8859_1.name());
		} catch (UnsupportedEncodingException e) {
			throw new SamlException(e);
		}
	}
*/
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
/*
	protected ServiceProviderService getHostedServiceProvider(LocalServiceProviderConfiguration spConfig) {
		String basePath = spConfig.getBasePath();

		List<SimpleKey> keys = new LinkedList<>();
		SimpleKey activeKey = spConfig.getKeys().getActive();
		keys.add(activeKey);
		keys.add(activeKey.clone(activeKey.getName()+"-encryption",KeyType.ENCRYPTION));
		keys.addAll(spConfig.getKeys().getStandBy());
		SimpleKey signingKey = spConfig.isSignMetadata() ? spConfig.getKeys().getActive() : null;

		String prefix = hasText(spConfig.getPrefix()) ? spConfig.getPrefix() : "saml/sp/";
		String aliasPath = getAliasPath(spConfig);
		ServiceProviderMetadata metadata =
			serviceProviderMetadata(
				basePath,
				signingKey,
				keys,
				prefix,
				aliasPath,
				spConfig.getDefaultSigningAlgorithm(),
				spConfig.getDefaultDigest()
			);
		if (!spConfig.getNameIds().isEmpty()) {
			metadata.getServiceProvider().setNameIds(spConfig.getNameIds());
		}

		if (!spConfig.isSingleLogoutEnabled()) {
			metadata.getServiceProvider().setSingleLogoutService(Collections.emptyList());
		}
		if (hasText(spConfig.getEntityId())) {
			metadata.setEntityId(spConfig.getEntityId());
		}
		if (hasText(spConfig.getAlias())) {
			metadata.setEntityAlias(spConfig.getAlias());
		}
		metadata.getServiceProvider().setWantAssertionsSigned(spConfig.isWantAssertionsSigned());
		metadata.getServiceProvider().setAuthnRequestsSigned(spConfig.isSignRequests());

		return new HostedServiceProviderService(
			spConfig,
			metadata,
			getTransformer(),
			getValidator(),
			getCache()
		);
	}
*/
/*
	protected ServiceProviderMetadata serviceProviderMetadata(String baseUrl,
															  SimpleKey signingKey,
															  List<SimpleKey> keys,
															  String prefix,
															  String aliasPath,
															  AlgorithmMethod signAlgorithm,
															  DigestMethod signDigest) {

		return new ServiceProviderMetadata()
			.setEntityId(baseUrl)
			.setId(UUID.randomUUID().toString())
			.setSigningKey(signingKey, signAlgorithm, signDigest)
			.setProviders(
				asList(
					new org.springframework.security.saml.saml2.metadata.ServiceProvider()
						.setKeys(keys)
						.setWantAssertionsSigned(true)
						.setAuthnRequestsSigned(signingKey != null)
						.setAssertionConsumerService(
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
}
