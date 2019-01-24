/*
 * Copyright 2017-2019 Joel Tobey <joeltobey@gmail.com>
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
  extends="cfboom.security.interceptors.SecurityInterceptor"
  displayname="Security SAML Interceptor"
  output="false"
{
  property name="javaLoader" inject="JavaLoader@cfboom-security-saml";
  property name="samlServiceProviderProvisioning" inject="SamlServiceProviderProvisioning@cfboom-security-saml";

  /**
   * Configure this interceptor.
   */
  public void function configure() {}

  /**
   * The preProcess() interceptor point.
   */
  public void function preProcess( event, interceptData, buffer, rc, prc ) {
    arguments.rc['SAMLResponse'] = fileRead(expandPath("/tests/resources/testSAMLResponse.txt"));
    arguments.rc['RelayState'] = "/yodaHome";
    if ( requiresAuthentication( argumentCollection = arguments ) ) {
      return attemptAuthentication( argumentCollection = arguments );

      var metadata = variables.metadataCache.getMetadata(arguments.prc.ssoIdp.metadata);
// org.opensaml.saml.saml2.core.impl.ResponseImpl (org.opensaml.saml.saml2.core.Response)
      var assertion = charsetEncode( binaryDecode( getSamlResponseData( argumentCollection = arguments ), "Base64" ), "utf-8" );
      var assertionStream = variables.javaLoader.create("java.io.ByteArrayInputStream").init(assertion.getBytes());
      var parserPool = variables._XMLObjectProviderRegistrySupport.getParserPool();
writeDump(parserPool);abort;
      var response = variables._XMLObjectSupport.unmarshallFromInputStream( variables._XMLObjectProviderRegistrySupport.getParserPool(), assertionStream );
      assertionStream.close();
writeDump(response);abort;
    }
  }

  public boolean function requiresAuthentication( event, interceptData, buffer, rc, prc ) {
    return arguments.event.METHODS.GET.equals( arguments.event.getHTTPMethod() )
      && hasText(getSamlResponseData( argumentCollection = arguments ))
      && onRecipientRoutedUrl( argumentCollection = arguments )
      && super.requiresAuthentication( argumentCollection = arguments );
  }

  public any function attemptAuthentication( event, interceptData, buffer, rc, prc ) {

    var responseData = getSamlResponseData( argumentCollection = arguments );
    if (!hasText(responseData)) {
      throw("SAMLResponse parameter missing", "AuthenticationCredentialsNotFoundException");
    }

    var provider = variables.samlServiceProviderProvisioning;
writeDump(provider);
writeDump(arguments.prc.ssoIdp);
abort;
/*
    var r = provider.fromXml(responseData, true, GET.matches(request.getMethod()), Response.class);
    if (logger.isTraceEnabled()) {
      logger.trace("Received SAMLResponse XML:" + r.getOriginalXML());
    }
    IdentityProviderMetadata remote = variables._provider.getRemoteProvider(r);

    ValidationResult validationResult = variables._provider.validate(r);
    if (validationResult.hasErrors()) {
      throw new InsufficientAuthenticationException(
        validationResult.toString()
              );
    }

    Authentication authentication = new DefaultSamlAuthentication(
            true,
        r.getAssertions().get(0),
      remote.getEntityId(),
        variables._provider.getMetadata().getEntityId(),
      request.getParameter("RelayState")
            );

    return getAuthenticationManager().authenticate(authentication);
*/
  }

  private string function getSamlResponseData( event, interceptData, buffer, rc, prc ) {
    var SAMLResponseData = "";
    if (structKeyExists(arguments.rc, "SAMLResponse"))
      SAMLResponseData = trim(arguments.rc.SAMLResponse);
    return SAMLResponseData;
  }

  private boolean function hasText( string str ) {
    if (!structKeyExists(arguments, "str"))
      return false;
    var strData = trim(arguments.str);
    return !strData.isEmpty();
  }

  private boolean function onRecipientRoutedUrl( event, interceptData, buffer, rc, prc ) {
    if (!structKeyExists(arguments.prc, "currentRoutedURL")) return false; // No need to check
    var sp = samlServiceProviderProvisioning.getConfigurationRepository().getServerConfiguration().getServiceProvider();
    var defaultSsoIdp = sp.getDefaultProvider();
    var ssoIdpAlias = arguments.event.getValue("ssoIdp", defaultSsoIdp.getAlias());
    var ssoIdp = javaCast("null","");
    if (ssoIdpAlias.equals(defaultSsoIdp.getAlias())) {
      ssoIdp = defaultSsoIdp;
    } else {
      ssoIdp = sp.getProvider(ssoIdpAlias);
    }
    if (!isNull(ssoIdp)
        && !isNull(ssoIdp.getRecipientRoutedUrl())
        && arguments.prc.currentRoutedURL.equals(ssoIdp.getRecipientRoutedUrl())) {
      arguments.prc['ssoIdp'] = ssoIdp;
      return true;
    }
    return false;
  }
}
