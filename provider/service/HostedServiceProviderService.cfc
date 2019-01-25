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
  extends="cfboom.security.saml.provider.AbstractHostedProviderService"
  implements="cfboom.security.saml.provider.service.ServiceProviderService"
  displayname="Class HostedServiceProviderService"
  output="false"
{
  property name="javaLoader" inject="JavaLoader@cfboom-security-saml";

  public cfboom.security.saml.provider.service.HostedServiceProviderService function init(cfboom.security.saml.provider.config.LocalProviderConfiguration configuration,
                                                                                          cfboom.security.saml.saml2.metadata.Metadata metadata,
                                                                                          cfboom.security.saml.SamlTransformer transformer,
                                                                                          cfboom.security.saml.SamlValidator validator,
                                                                                          cfboom.security.saml.SamlMetadataCache cache) {
    super.init( argumentCollection = arguments );
    return this;
  }

  /**
   * @Override
   */
  public cfboom.security.saml.saml2.metadata.Metadata function getRemoteProviderFromExternalProviderConfiguration(cfboom.security.saml.provider.config.ExternalProviderConfiguration c) {
    var metadata = super.getRemoteProviderFromExternalProviderConfiguration(arguments.c);
    if (!isNull(metadata) && isInstanceOf(arguments.c, "cfboom.security.saml.provider.service.config.ExternalIdentityProviderConfiguration")) {
      var ec = arguments.c;
      if (!isNull(ec.getNameId())) {
        metadata.setDefaultNameId(ec.getNameId());
      }
    }
    return metadata;
  }

  /**
   * @Override
   */
  public cfboom.security.saml.saml2.metadata.Metadata function transformMetadata(string data) {
    var metadata = getTransformer().fromXml(arguments.data, null, null);
    var result = null;
    if (isInstanceOf(metadata, "cfboom.security.saml.saml2.metadata.IdentityProviderMetadata")) {
      result =  metadata;
    } else {
      var providers = metadata.getSsoProviders();
      var newProviders = createObject("java","java.util.LinkedList").init();
      for ( var provider in providers ) {
        if (isInstanceOf(provider, "cfboom.security.saml.saml2.metadata.IdentityProvider")) {
          newProviders.add(provider);
        }
      }
      result = new cfboom.security.saml.saml2.metadata.IdentityProviderMetadata(metadata);
      result.setProviders(newProviders);
    }
    return result;
  }

  /**
   * @Override
   */
  public cfboom.security.saml.saml2.metadata.Metadata function getRemoteProviderFromSaml2Object(cfboom.security.saml.saml2.Saml2Object saml2Object) {
    if (isInstanceOf(arguments.saml2Object, "cfboom.security.saml.saml2.authentication.Assertion")) {
      return getRemoteProviderFromAssertion(arguments.saml2Object);
    }
    else if (isInstanceOf(arguments.saml2Object, "cfboom.security.saml.saml2.authentication.Response")) {
      return getRemoteProviderFromResponse(arguments.saml2Object);
    }
    else if (isInstanceOf(arguments.saml2Object, "cfboom.security.saml.saml2.authentication.LogoutRequest")) {
      return getRemoteProviderFromLogoutRequest(arguments.saml2Object);
    }
      else if (isInstanceOf(arguments.saml2Object, "cfboom.security.saml.saml2.authentication.LogoutResponse")) {
      return getRemoteProviderFromLogoutResponse(arguments.saml2Object);
    }
    else {
      throw(object=createObject("java","java.lang.UnsupportedOperationException").init("Class:" &
        arguments.saml2Object.getComponentName() &
        " not yet implemented"));
    }
  }

  public cfboom.security.saml.saml2.metadata.Metadata function getRemoteProviderFromAssertion(cfboom.security.saml.saml2.authentication.Assertion assertion) {
    return getRemoteProvider(!isNull(arguments.assertion.getIssuer()) ? arguments.assertion.getIssuer().getValue() : null);
  }

  public cfboom.security.saml.saml2.metadata.Metadata function getRemoteProviderFromResponse(cfboom.security.saml.saml2.authentication.Response response) {
    return getRemoteProvider(!isNull(arguments.response.getIssuer()) ? arguments.response.getIssuer().getValue() : null);
  }

  /**
   * @Override
   */
  public cfboom.security.saml.saml2.authentication.AuthenticationRequest function authenticationRequest(cfboom.security.saml.saml2.metadata.IdentityProviderMetadata idp) {
    var endpoint = getPreferredEndpoint(arguments.idp.getIdentityProvider().getSingleSignOnService(), Binding.REDIRECT, 0);
    var sp = getMetadata();
    var req = new cfboom.security.saml.saml2.authentication.AuthenticationRequest()
          // Some service providers will not accept first character if 0..9
          // Azure AD IdP for example.
      .setId("_" & UUID.randomUUID().toString().substring(1))
      .setIssueInstant(variables.javaLoader.create("org.joda.time.DateTime").init(getClock().millis()))
      .setForceAuth(Boolean.FALSE)
      .setPassive(Boolean.FALSE)
      .setBinding(endpoint.getBinding())
      .setAssertionConsumerService(
        getPreferredEndpoint(
          sp.getServiceProvider().getAssertionConsumerService(),
          null,
          -1
        )
      )
      .setIssuer(new cfboom.security.saml.saml2.authentication.Issuer().setValue(sp.getEntityId()))
      .setDestination(endpoint);
    if (sp.getServiceProvider().isAuthnRequestsSigned()) {
      req.setSigningKey(sp.getSigningKey(), sp.getAlgorithm(), sp.getDigest());
    }
    if (!isNull(arguments.idp.getDefaultNameId())) {
      req.setNameIdPolicy(new cfboom.security.saml.saml2.authentication.NameIdPolicy(
        arguments.idp.getDefaultNameId(),
        sp.getEntityAlias(),
        true
      ));
    }
    else if (arguments.idp.getIdentityProvider().getNameIds().size() > 0){
      req.setNameIdPolicy(new cfboom.security.saml.saml2.authentication.NameIdPolicy(
        arguments.idp.getIdentityProvider().getNameIds().get(0),
        sp.getEntityAlias(),
        true
      ));
    }
    return req;
  }
}
