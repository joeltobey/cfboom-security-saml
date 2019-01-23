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
 * Attribute Name Format Identifiers
 * https://www.oasis-open.org/committees/download.php/35711/sstc-saml-core-errata-2.0-wd-06-diff.pdf
 * Page 82, Line 3528
 */
component
  displayname="Enum StatusCode"
  output="false"
{
  import cfboom.security.saml.saml2.authentication.StatusCode;

  variables['_map'] = {
    "urn:oasis:names:tc:SAML:2.0:status:Success" = "SUCCESS",
    "urn:oasis:names:tc:SAML:2.0:status:Requester" = "REQUESTER",
    "urn:oasis:names:tc:SAML:2.0:status:Responder" = "RESPONDER",
    "urn:oasis:names:tc:SAML:2.0:status:VersionMismatch" = "VERSION_MISMATCH",
    "urn:oasis:names:tc:SAML:2.0:status:AuthnFailed" = "AUTHENTICATION_FAILED",
    "urn:oasis:names:tc:SAML:2.0:status:InvalidAttrNameOrValue" = "INVALID_ATTRIBUTE",
    "urn:oasis:names:tc:SAML:2.0:status:InvalidNameIDPolicy" = "INVALID_NAME_ID",
    "urn:oasis:names:tc:SAML:2.0:status:NoAuthnContext" = "NO_AUTH_CONTEXT",
    "urn:oasis:names:tc:SAML:2.0:status:NoAvailableIDP" = "NO_AVAILABLE_IDP",
    "urn:oasis:names:tc:SAML:2.0:status:NoPassive" = "NO_PASSIVE",
    "urn:oasis:names:tc:SAML:2.0:status:NoSupportedIDP" = "NO_SUPPORTED_IDP",
    "urn:oasis:names:tc:SAML:2.0:status:PartialLogout" = "PARTIAL_LOGOUT",
    "urn:oasis:names:tc:SAML:2.0:status:ProxyCountExceeded" = "PROXY_COUNT_EXCEEDED",
    "urn:oasis:names:tc:SAML:2.0:status:RequestDenied" = "REQUEST_DENIED",
    "urn:oasis:names:tc:SAML:2.0:status:RequestUnsupported" = "REQUEST_UNSUPPORTED",
    "urn:oasis:names:tc:SAML:2.0:status:RequestVersionDeprecated" = "REQUEST_VERSION_DEPRECATED",
    "urn:oasis:names:tc:SAML:2.0:status:RequestVersionTooHigh" = "REQUEST_VERSION_TOO_HIGH",
    "urn:oasis:names:tc:SAML:2.0:status:RequestVersionTooLow" = "REQUEST_VERSION_TOO_LOW",
    "urn:oasis:names:tc:SAML:2.0:status:ResourceNotRecognized" = "RESOURCE_NOT_RECOGNIZED",
    "urn:oasis:names:tc:SAML:2.0:status:TooManyResponses" = "TOO_MANY_RESPONSES",
    "urn:oasis:names:tc:SAML:2.0:status:UnknownPrincipal" = "UNKNOWN_PRINCIPAL",
    "urn:oasis:names:tc:SAML:2.0:status:UnsupportedBinding" = "UNSUPPORTED_BINDING",
    "urn:oasis:names:tc:SAML:2.0:status:Unknown" = "UNKNOWN_STATUS"
  };

  public cfboom.security.saml.saml2.authentication.StatusCode function enum() {
    variables['_values'] = [];

    this.SUCCESS = new StatusCode("urn:oasis:names:tc:SAML:2.0:status:Success","The request succeeded.");
    arrayAppend(variables._values, this.SUCCESS);

    this.REQUESTER = new StatusCode("urn:oasis:names:tc:SAML:2.0:status:Requester","The request could not be performed due to an error on the part of the requester.");
    arrayAppend(variables._values, this.REQUESTER);

    this.RESPONDER = new StatusCode("urn:oasis:names:tc:SAML:2.0:status:Responder","The request could not be performed due to an error on the part of the SAML responder or SAML authority.");
    arrayAppend(variables._values, this.RESPONDER);

    this.VERSION_MISMATCH = new StatusCode("urn:oasis:names:tc:SAML:2.0:status:VersionMismatch","The SAML responder could not process the request because the version of the request message was incorrect.");
    arrayAppend(variables._values, this.VERSION_MISMATCH);

    this.AUTHENTICATION_FAILED = new StatusCode("urn:oasis:names:tc:SAML:2.0:status:AuthnFailed","The responding provider was unable to successfully authenticate the principal.");
    arrayAppend(variables._values, this.AUTHENTICATION_FAILED);

    this.INVALID_ATTRIBUTE = new StatusCode("urn:oasis:names:tc:SAML:2.0:status:InvalidAttrNameOrValue","Unexpected or invalid content was encountered within an attribute or attribute value.");
    arrayAppend(variables._values, this.INVALID_ATTRIBUTE);

    this.INVALID_NAME_ID = new StatusCode("urn:oasis:names:tc:SAML:2.0:status:InvalidNameIDPolicy","The responding provider cannot or will not support the requested name identifier policy.");
    arrayAppend(variables._values, this.INVALID_NAME_ID);

    this.NO_AUTH_CONTEXT = new StatusCode("urn:oasis:names:tc:SAML:2.0:status:NoAuthnContext","The specified authentication context requirements cannot be met by the responder.");
    arrayAppend(variables._values, this.NO_AUTH_CONTEXT);

    this.NO_AVAILABLE_IDP = new StatusCode("urn:oasis:names:tc:SAML:2.0:status:NoAvailableIDP","No available identity providers from the supplied Loc or IDPList values.");
    arrayAppend(variables._values, this.NO_AVAILABLE_IDP);

    this.NO_PASSIVE = new StatusCode("urn:oasis:names:tc:SAML:2.0:status:NoPassive","Unable to authenticate principal passively.");
    arrayAppend(variables._values, this.NO_PASSIVE);

    this.NO_SUPPORTED_IDP = new StatusCode("urn:oasis:names:tc:SAML:2.0:status:NoSupportedIDP","No supported identity providers from the supplied Loc or IDPList values.");
    arrayAppend(variables._values, this.NO_SUPPORTED_IDP);

    this.PARTIAL_LOGOUT = new StatusCode("urn:oasis:names:tc:SAML:2.0:status:PartialLogout","Federated logout was only partially successful.");
    arrayAppend(variables._values, this.PARTIAL_LOGOUT);

    this.PROXY_COUNT_EXCEEDED = new StatusCode("urn:oasis:names:tc:SAML:2.0:status:ProxyCountExceeded","Unable to authenticate principal and forwarding to proxy is prohibited.");
    arrayAppend(variables._values, this.PROXY_COUNT_EXCEEDED);

    this.REQUEST_DENIED = new StatusCode("urn:oasis:names:tc:SAML:2.0:status:RequestDenied","Unable to process request, request denied.");
    arrayAppend(variables._values, this.REQUEST_DENIED);

    this.REQUEST_UNSUPPORTED = new StatusCode("urn:oasis:names:tc:SAML:2.0:status:RequestUnsupported","Unable to process request, request denied.");
    arrayAppend(variables._values, this.REQUEST_UNSUPPORTED);

    this.REQUEST_VERSION_DEPRECATED = new StatusCode("urn:oasis:names:tc:SAML:2.0:status:RequestVersionDeprecated","Request version is deprecated.");
    arrayAppend(variables._values, this.REQUEST_VERSION_DEPRECATED);

    this.REQUEST_VERSION_TOO_HIGH = new StatusCode("urn:oasis:names:tc:SAML:2.0:status:RequestVersionTooHigh","Request version is not supported, too high.");
    arrayAppend(variables._values, this.REQUEST_VERSION_TOO_HIGH);

    this.REQUEST_VERSION_TOO_LOW = new StatusCode("urn:oasis:names:tc:SAML:2.0:status:RequestVersionTooLow","Request version is not supported, too low.");
    arrayAppend(variables._values, this.REQUEST_VERSION_TOO_LOW);

    this.RESOURCE_NOT_RECOGNIZED = new StatusCode("urn:oasis:names:tc:SAML:2.0:status:ResourceNotRecognized","The resource identified in the request is not recognized.");
    arrayAppend(variables._values, this.RESOURCE_NOT_RECOGNIZED);

    this.TOO_MANY_RESPONSES = new StatusCode("urn:oasis:names:tc:SAML:2.0:status:TooManyResponses","Unable to produce response message, too many responses to process.");
    arrayAppend(variables._values, this.TOO_MANY_RESPONSES);

    this.UNKNOWN_PRINCIPAL = new StatusCode("urn:oasis:names:tc:SAML:2.0:status:UnknownPrincipal","Principal not recognized.");
    arrayAppend(variables._values, this.UNKNOWN_PRINCIPAL);

    this.UNSUPPORTED_BINDING = new StatusCode("urn:oasis:names:tc:SAML:2.0:status:UnsupportedBinding","Requested binding not supported.");
    arrayAppend(variables._values, this.UNSUPPORTED_BINDING);

    this.UNKNOWN_STATUS = new StatusCode("urn:oasis:names:tc:SAML:2.0:status:Unknown","Unknown error occurred.");
    arrayAppend(variables._values, this.UNKNOWN_STATUS);

    return this;
  }

  public cfboom.security.saml.saml2.authentication.StatusCode function init(string urn, string description) {
    variables['_urn'] = arguments.urn;
    variables['_description'] = arguments.description;
    variables['_name'] = variables._map[arguments.urn];
    return this;
  }

  public cfboom.security.saml.saml2.authentication.StatusCode function fromUrn(string other) {
    for (var name in variables._values) {
      if (arguments.other.equalsIgnoreCase(name.toString())) {
        return name;
      }
    }
    return this.UNKNOWN_STATUS;
  }

  public string function name() {
    return variables._name;
  }

  public string function getDescription() {
    return variables._description;
  }

  /**
   * @Override
   */
  public string function toString() {
    return variables._urn;
  }
}
