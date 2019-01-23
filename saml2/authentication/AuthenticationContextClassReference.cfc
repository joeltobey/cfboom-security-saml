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
 *
 */
component
  displayname="Enum AuthenticationContextClassReference"
  output="false"
{
  import cfboom.security.saml.saml2.authentication.AuthenticationContextClassReference;

  variables['_map'] = {
    "urn:oasis:names:tc:SAML:2.0:ac:classes:InternetProtocol" = "INTERNET_PROTOCOL",
    "urn:oasis:names:tc:SAML:2.0:ac:classes:InternetProtocolPassword" = "INTERNET_PROTOCOL_PASSWORD",
    "urn:oasis:names:tc:SAML:2.0:ac:classes:Kerberos" = "KERBEROS",
    "urn:oasis:names:tc:SAML:2.0:ac:classes:MobileOneFactorUnregistered" = "MOBILE_ONE_FACTOR_UNREG",
    "urn:oasis:names:tc:SAML:2.0:ac:classes:MobileTwoFactorUnregistered" = "MOBILE_TWO_FACTOR_UNREG",
    "urn:oasis:names:tc:SAML:2.0:ac:classes:MobileOneFactorContract" = "MOBILE_ONE_FACTOR_CONTRACT",
    "urn:oasis:names:tc:SAML:2.0:ac:classes:MobileTwoFactorContract" = "MOBILE_TWO_FACTOR_CONTRACT",
    "urn:oasis:names:tc:SAML:2.0:ac:classes:Password" = "PASSWORD",
    "urn:oasis:names:tc:SAML:2.0:ac:classes:PasswordProtectedTransport" = "PASSWORD_PROTECTED_TRANSPORT",
    "urn:oasis:names:tc:SAML:2.0:ac:classes:PreviousSession" = "PREVIOUS_SESSION",
    "urn:oasis:names:tc:SAML:2.0:ac:classes:X509" = "X509_PUBLIC_KEY",
    "urn:oasis:names:tc:SAML:2.0:ac:classes:PGP" = "PGP",
    "urn:oasis:names:tc:SAML:2.0:ac:classes:SPKI" = "SPKI",
    "urn:oasis:names:tc:SAML:2.0:ac:classes:XMLDSig" = "XML_DIGITAL_SIGNATURE",
    "urn:oasis:names:tc:SAML:2.0:ac:classes:Smartcard" = "SMARTCARD",
    "urn:oasis:names:tc:SAML:2.0:ac:classes:SmartcardPKI" = "SMARTCARD_PKI",
    "urn:oasis:names:tc:SAML:2.0:ac:classes:SoftwarePKI" = "SOFTWARE_PKI",
    "urn:oasis:names:tc:SAML:2.0:ac:classes:Telephony" = "TELEPHONY",
    "urn:oasis:names:tc:SAML:2.0:ac:classes:NomadTelephony" = "NOMADIC_TELEPHONY",
    "urn:oasis:names:tc:SAML:2.0:ac:classes:PersonalTelephony" = "PERSONAL_TELEPHONY",
    "urn:oasis:names:tc:SAML:2.0:ac:classes:AuthenticatedTelephony" = "AUTHENTICATED_TELEPHONY",
    "urn:oasis:names:tc:SAML:2.0:ac:classes:SecureRemotePassword" = "SECURE_REMOTE_PASSWORD",
    "urn:oasis:names:tc:SAML:2.0:ac:classes:TLSClient" = "TLS_CLIENT",
    "urn:oasis:names:tc:SAML:2.0:ac:classes:TimeSyncToken" = "TIME_SYNC_TOKEN",
    "urn:oasis:names:tc:SAML:2.0:ac:classes:unspecified" = "UNSPECIFIED"
  };

  public cfboom.security.saml.saml2.authentication.AuthenticationContextClassReference function enum() {
    variables['_values'] = [];

    /**
     * Internet Protocol
     */
    this.INTERNET_PROTOCOL = new AuthenticationContextClassReference("urn:oasis:names:tc:SAML:2.0:ac:classes:InternetProtocol");
    arrayAppend(variables._values, this.INTERNET_PROTOCOL);

    /**
     * Internet Protocol Password
     */
    this.INTERNET_PROTOCOL_PASSWORD = new AuthenticationContextClassReference("urn:oasis:names:tc:SAML:2.0:ac:classes:InternetProtocolPassword");
    arrayAppend(variables._values, this.INTERNET_PROTOCOL_PASSWORD);

    /**
     * Kerberos
     */
    this.KERBEROS = new AuthenticationContextClassReference("urn:oasis:names:tc:SAML:2.0:ac:classes:Kerberos");
    arrayAppend(variables._values, this.KERBEROS);

    /**
     * Mobile One Factor Unregistered
     */
    this.MOBILE_ONE_FACTOR_UNREG = new AuthenticationContextClassReference("urn:oasis:names:tc:SAML:2.0:ac:classes:MobileOneFactorUnregistered");
    arrayAppend(variables._values, this.MOBILE_ONE_FACTOR_UNREG);

    /**
     * Mobile Two Factor Unregistered
     */
    this.MOBILE_TWO_FACTOR_UNREG = new AuthenticationContextClassReference("urn:oasis:names:tc:SAML:2.0:ac:classes:MobileTwoFactorUnregistered");
    arrayAppend(variables._values, this.MOBILE_TWO_FACTOR_UNREG);

    /**
     * Mobile One Factor Contract
     */
    this.MOBILE_ONE_FACTOR_CONTRACT = new AuthenticationContextClassReference("urn:oasis:names:tc:SAML:2.0:ac:classes:MobileOneFactorContract");
    arrayAppend(variables._values, this.MOBILE_ONE_FACTOR_CONTRACT);

    /**
     * Mobile Two Factor Contract
     */
    this.MOBILE_TWO_FACTOR_CONTRACT = new AuthenticationContextClassReference("urn:oasis:names:tc:SAML:2.0:ac:classes:MobileTwoFactorContract");
    arrayAppend(variables._values, this.MOBILE_TWO_FACTOR_CONTRACT);

    /**
     * Password
     */
    this.PASSWORD = new AuthenticationContextClassReference("urn:oasis:names:tc:SAML:2.0:ac:classes:Password");
    arrayAppend(variables._values, this.PASSWORD);

    /**
     * Password Protected Transport
     */
    this.PASSWORD_PROTECTED_TRANSPORT = new AuthenticationContextClassReference("urn:oasis:names:tc:SAML:2.0:ac:classes:PasswordProtectedTransport");
    arrayAppend(variables._values, this.PASSWORD_PROTECTED_TRANSPORT);

    /**
     * Previous Session
     */
    this.PREVIOUS_SESSION = new AuthenticationContextClassReference("urn:oasis:names:tc:SAML:2.0:ac:classes:PreviousSession");
    arrayAppend(variables._values, this.PREVIOUS_SESSION);

    /**
	 * X509 Public Key
	 */
    this.X509_PUBLIC_KEY = new AuthenticationContextClassReference("urn:oasis:names:tc:SAML:2.0:ac:classes:X509");
    arrayAppend(variables._values, this.X509_PUBLIC_KEY);

    /**
     * PGP
     */
    this.PGP = new AuthenticationContextClassReference("urn:oasis:names:tc:SAML:2.0:ac:classes:PGP");
    arrayAppend(variables._values, this.PGP);

    /**
     * SPKI
     */
    this.SPKI = new AuthenticationContextClassReference("urn:oasis:names:tc:SAML:2.0:ac:classes:SPKI");
    arrayAppend(variables._values, this.SPKI);

    /**
     * XML Digital Signature
     */
    this.XML_DIGITAL_SIGNATURE = new AuthenticationContextClassReference("urn:oasis:names:tc:SAML:2.0:ac:classes:XMLDSig");
    arrayAppend(variables._values, this.XML_DIGITAL_SIGNATURE);

    /**
     * Smart Card
     */
    this.SMARTCARD = new AuthenticationContextClassReference("urn:oasis:names:tc:SAML:2.0:ac:classes:Smartcard");
    arrayAppend(variables._values, this.SMARTCARD);

    /**
     * Smart Card PKI
     */
    this.SMARTCARD_PKI = new AuthenticationContextClassReference("urn:oasis:names:tc:SAML:2.0:ac:classes:SmartcardPKI");
    arrayAppend(variables._values, this.SMARTCARD_PKI);

    /**
     * Software PKI
     */
    this.SOFTWARE_PKI = new AuthenticationContextClassReference("urn:oasis:names:tc:SAML:2.0:ac:classes:SoftwarePKI");
    arrayAppend(variables._values, this.SOFTWARE_PKI);

    /**
     * Telephony
     */
    this.TELEPHONY = new AuthenticationContextClassReference("urn:oasis:names:tc:SAML:2.0:ac:classes:Telephony");
    arrayAppend(variables._values, this.TELEPHONY);

    /**
     * Nomadic Telephony
     */
    this.NOMADIC_TELEPHONY = new AuthenticationContextClassReference("urn:oasis:names:tc:SAML:2.0:ac:classes:NomadTelephony");
    arrayAppend(variables._values, this.NOMADIC_TELEPHONY);

    /**
     * Personalized Telephony
     */
    this.PERSONAL_TELEPHONY = new AuthenticationContextClassReference("urn:oasis:names:tc:SAML:2.0:ac:classes:PersonalTelephony");
    arrayAppend(variables._values, this.PERSONAL_TELEPHONY);

    /**
     * Authenticated Telephony
     */
    this.AUTHENTICATED_TELEPHONY = new AuthenticationContextClassReference("urn:oasis:names:tc:SAML:2.0:ac:classes:AuthenticatedTelephony");
    arrayAppend(variables._values, this.AUTHENTICATED_TELEPHONY);

    /**
     * Secure Remote Password
     */
    this.SECURE_REMOTE_PASSWORD = new AuthenticationContextClassReference("urn:oasis:names:tc:SAML:2.0:ac:classes:SecureRemotePassword");
    arrayAppend(variables._values, this.SECURE_REMOTE_PASSWORD);

    /**
     * SSL/TLS Client
     */
    this.TLS_CLIENT = new AuthenticationContextClassReference("urn:oasis:names:tc:SAML:2.0:ac:classes:TLSClient");
    arrayAppend(variables._values, this.TLS_CLIENT);

    /**
     * Time Synchornized Token
     */
    this.TIME_SYNC_TOKEN = new AuthenticationContextClassReference("urn:oasis:names:tc:SAML:2.0:ac:classes:TimeSyncToken");
    arrayAppend(variables._values, this.TIME_SYNC_TOKEN);

    /**
     * unspecified
     */
    this.UNSPECIFIED = new AuthenticationContextClassReference("urn:oasis:names:tc:SAML:2.0:ac:classes:unspecified");
    arrayAppend(variables._values, this.UNSPECIFIED);

    return this;
  }

  public cfboom.security.saml.saml2.authentication.AuthenticationContextClassReference function init(string urn) {
    variables['_urn'] = arguments.urn;
    variables['_name'] = variables._map[arguments.urn];
    return this;
  }

  public cfboom.security.saml.saml2.authentication.AuthenticationContextClassReference function fromUrn(string other) {
    for (var ref in variables._values) {
      if (arguments.other.equalsIgnoreCase(ref.toString())) {
        return ref;
      }
    }
    return this.UNSPECIFIED;
  }

  public string function name() {
    return variables._name;
  }

  /**
   * @Override
   */
  public string function toString() {
    return variables._urn;
  }
}
