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
  public any function preProcess( event, interceptData, buffer, rc, prc ) {
    if ( requiresAuthentication( argumentCollection = arguments ) ) {
      writeDump(attemptAuthentication( argumentCollection = arguments ));
      return attemptAuthentication( argumentCollection = arguments );
    }
  }

  public boolean function requiresAuthentication( event, interceptData, buffer, rc, prc ) {
    return hasText(getSamlResponseData( argumentCollection = arguments ))
      && super.requiresAuthentication( argumentCollection = arguments );
  }

  public any function attemptAuthentication( event, interceptData, buffer, rc, prc ) {

    var responseData = getSamlResponseData( argumentCollection = arguments );
    if (!hasText(responseData)) {
      throw("SAMLResponse parameter missing", "AuthenticationCredentialsNotFoundException");
    }

    var provider = variables.samlServiceProviderProvisioning.getHostedProvider();

    var r = provider.fromXml(responseData, true, arguments.event.METHODS.GET.equals( arguments.event.getHTTPMethod() ), "cfboom.security.saml.saml2.authentication.Response");
    variables.log.debug("Received SAMLResponse XML:" & r.getOriginalXML());
    var remoteProvider = provider.getRemoteProvider(r);

    var validationResult = provider.validate(r);
    if (validationResult.hasErrors()) {
      throw(validationResult.toString(), "cfboom.security.saml.InsufficientAuthenticationException");
    }

    var authentication = new cfboom.security.saml.spi.DefaultSamlAuthentication(
      true,
      r.getAssertions().get(0),
      remoteProvider.getEntityId(),
      provider.getMetadata().getEntityId(),
      arguments.event.getValue("RelayState", "")
    );

    return getAuthenticationManager().authenticate(authentication);
  }

  private string function getSamlResponseData( event, interceptData, buffer, rc, prc ) {
    var SAMLResponseData = arguments.event.getValue("SAMLResponse", "");
    return trim(SAMLResponseData);
  }

  private boolean function hasText( string str ) {
    if (!structKeyExists(arguments, "str"))
      return false;
    var strData = trim(arguments.str);
    return !strData.isEmpty();
  }
}
