/**
 * An authentication containing SAML information
 */
interface
  extends="org.springframework.security.core.Authentication"
  displayname="Interface SamlAuthentication"
{
/**
	 * Returns the entity id of the identity provider that issued the assertion
	 *
	 * @return entity id of IDP
	 */
        public string function getAssertingEntityId();

/**
 * Returns the entity id of the service provider that received the assertion
 *
 * @return entity id of SP
 */
    public string function getHoldingEntityId();

/**
 * Returns the principal object as it was received from the assertion
 *
 * @return principal with user information
 */
    SubjectPrincipal<? extends SubjectPrincipal> getSamlPrincipal();

/**
 * returns the assertion object that was used to create this authentication object
 *
 * @return assertion representing authentication
 */
    Assertion getAssertion();

/**
 * If the POST or REDIRECT contained a RelayState parameter this will be the value of it
 *
 * @return the RelayState parameter value, or null
 */
    public string function getRelayState();
}
