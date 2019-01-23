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
  extends="cfboom.lang.Object"
  implements="cfboom.security.saml.SamlValidator"
  displayname="Class DefaultValidator"
  output="false"
{
/*
  private SpringSecuritySaml implementation;
  private int responseSkewTimeMillis = 1000 * 60 * 2; //two minutes
  private boolean allowUnsolicitedResponses = true;
  private int maxAuthenticationAgeMillis = 1000 * 60 * 60 * 24; //24 hours
  private Clock time = Clock.systemUTC();
*/
  /**
   * @implementation.inject SamlImplementation@cfboom-security-saml
   */
  public cfboom.security.saml.spi.DefaultValidator function init( required cfboom.security.saml.spi.SecuritySaml implementation ) {
    setImplementation( arguments.implementation );
    return this;
  }

  public cfboom.security.saml.spi.DefaultValidator function setImplementation( cfboom.security.saml.spi.SecuritySaml implementation ) {
    variables['_implementation'] = arguments.implementation;
    return this;
  }

  public cfboom.security.saml.spi.DefaultValidator function setTime(any time) {
    variables['_time'] = arguments.time;
    return this;
  }

  /**
   * @Override
   */
  public cfboom.security.saml.saml2.signature.Signature function validateSignature(cfboom.security.saml.saml2.Saml2Object saml2Object, any verificationKeys) {
    return variables._implementation.validateSignature(arguments.saml2Object, arguments.verificationKeys);
  }

  /**
   * @Override
   */
  public void function validate(cfboom.security.saml.saml2.Saml2Object saml2Object, cfboom.security.saml.provider.HostedProviderService provider) {
    var result = null;
    if (isInstanceOf(arguments.saml2Object, "cfboom.security.saml.saml2.metadata.ServiceProviderMetadata")) {
      result = validateServiceProviderMetadata(arguments.saml2Object, arguments.provider);
    }
    else if (isInstanceOf(arguments.saml2Object, "cfboom.security.saml.saml2.metadata.IdentityProviderMetadata")) {
      result = validateIdentityProviderMetadata(arguments.saml2Object, arguments.provider);
    }
    else if (isInstanceOf(arguments.saml2Object, "cfboom.security.saml.saml2.authentication.AuthenticationRequest")) {
      result = validateAuthenticationRequest(arguments.saml2Object, arguments.provider);
    }
    else if (isInstanceOf(arguments.saml2Object, "cfboom.security.saml.saml2.authentication.LogoutRequest")) {
      result = validateLogoutRequest(arguments.saml2Object, arguments.provider);
    }
    else if (isInstanceOf(arguments.saml2Object, "cfboom.security.saml.saml2.authentication.LogoutResponse")) {
      result = validateLogoutResponse(arguments.saml2Object, arguments.provider);
    }
    else if (isInstanceOf(arguments.saml2Object, "cfboom.security.saml.saml2.authentication.Response")) {
      var r = arguments.saml2Object; // Response
      var requester = arguments.provider.getMetadata(); // ServiceProviderMetadata
      var responder = arguments.provider.getRemoteProvider(r); // IdentityProviderMetadata
      result = validateResponse(r, null, requester, responder);
    }
    else if (isInstanceOf(arguments.saml2Object, "cfboom.security.saml.saml2.authentication.Assertion")) {
      var a = arguments.saml2Object; // Assertion
      var requester = arguments.provider.getMetadata(); // ServiceProviderMetadata
      var responder = arguments.provider.getRemoteProvider(a); // IdentityProviderMetadata
      result = validateAssertion(a, null, requester, responder, requester.getServiceProvider().isWantAssertionsSigned());
    }
    else {
      throw("No validation implemented for class:" & arguments.saml2Object.getComponentName() & ". Unable to validate SAML object. No implementation.", "ValidationException");
    }
    if (!result.isSuccess()) {
      throw("Unable to validate SAML object.", "ValidationException");
    }
  }

  public cfboom.security.saml.validation.ValidationResult function validateIdentityProviderMetadata(cfboom.security.saml.saml2.metadata.IdentityProviderMetadata metadata, cfboom.security.saml.provider.HostedProviderService provider) {
    return new cfboom.security.saml.validation.ValidationResult(arguments.metadata);
  }

  public cfboom.security.saml.validation.ValidationResult function validateServiceProviderMetadata(cfboom.security.saml.saml2.metadata.ServiceProviderMetadata metadata, cfboom.security.saml.provider.HostedProviderService provider) {
    return new cfboom.security.saml.validation.ValidationResult(arguments.metadata);
  }

  public cfboom.security.saml.validation.ValidationResult function validateAuthenticationRequest(cfboom.security.saml.saml2.authentication.AuthenticationRequest authnRequest, cfboom.security.saml.provider.HostedProviderService provider) {
    return new cfboom.security.saml.validation.ValidationResult(arguments.authnRequest);
  }

  public cfboom.security.saml.validation.ValidationResult function validateLogoutRequest(cfboom.security.saml.saml2.authentication.LogoutRequest logoutRequest, cfboom.security.saml.provider.HostedProviderService provider) {
    return new cfboom.security.saml.validation.ValidationResult(arguments.logoutRequest);
  }

  public cfboom.security.saml.validation.ValidationResult function validateLogoutResponse(cfboom.security.saml.saml2.authentication.LogoutResponse logoutResponse, cfboom.security.saml.provider.HostedProviderService provider) {
    return new cfboom.security.saml.validation.ValidationResult(arguments.logoutResponse);
  }
/*
  public cfboom.security.saml.validation.ValidationResult function validateAssertion(cfboom.security.saml.saml2.authentication.Assertion assertion,
                    List<String> mustMatchInResponseTo,
                    ServiceProviderMetadata requester,
                    IdentityProviderMetadata responder,
                    boolean requireAssertionSigned) {
    //verify assertion
    //issuer
    //signature
    if (requireAssertionSigned && (assertion.getSignature() == null || !assertion.getSignature().isValidated())) {
      return
        new ValidationResult(assertion).addError(
          new ValidationError("Assertion is not signed or signature was not validated")
        );
    }

    if (responder == null) {
      return new ValidationResult(assertion)
        .addError("Remote provider for assertion was not found");
    }

    List<SubjectConfirmation> validConfirmations = new LinkedList<>();
    ValidationResult assertionValidation = new ValidationResult(assertion);
    for (SubjectConfirmation conf : assertion.getSubject().getConfirmations()) {

      assertionValidation.setErrors(emptyList());
      //verify assertion subject for BEARER
      if (!BEARER.equals(conf.getMethod())) {
        assertionValidation.addError("Invalid confirmation method:" + conf.getMethod());
        continue;
      }

      //for each subject confirmation data
      //1. data must not be null
      SubjectConfirmationData data = conf.getConfirmationData();
      if (data == null) {
        assertionValidation.addError(new ValidationError("Empty subject confirmation data"));
        continue;
      }


      //2. NotBefore must be null (saml-profiles-2.0-os 558)
      // Not before forbidden by saml-profiles-2.0-os 558
      if (data.getNotBefore() != null) {
        assertionValidation.addError(
          new ValidationError("Subject confirmation data should not have NotBefore date")
        );
        continue;
      }
      //3. NotOnOfAfter must not be null and within skew
      if (data.getNotOnOrAfter() == null) {
        assertionValidation.addError(
          new ValidationError("Subject confirmation data is missing NotOnOfAfter date")
        );
        continue;
      }

      if (data.getNotOnOrAfter().plusMillis(getResponseSkewTimeMillis()).isBeforeNow()) {
        assertionValidation.addError(
          new ValidationError(format("Invalid NotOnOrAfter date: '%s'", data.getNotOnOrAfter()))
        );
      }
      //4. InResponseTo if it exists
      if (hasText(data.getInResponseTo())) {
        if (mustMatchInResponseTo != null) {
          if (!mustMatchInResponseTo.contains(data.getInResponseTo())) {
            assertionValidation.addError(
              new ValidationError(
                format("No match for InResponseTo: '%s' found", data.getInResponseTo())
              )
            );
            continue;
          }
        }
        else if (!isAllowUnsolicitedResponses()) {
          assertionValidation.addError(
            new ValidationError(
              "InResponseTo missing and system not configured to allow unsolicited messages")
          );
          continue;
        }
      }
      //5. Recipient must match ACS URL
      if (!hasText(data.getRecipient())) {
        assertionValidation.addError(new ValidationError("Assertion Recipient field missing"));
        continue;
      }
      else if (!compareURIs(
        requester.getServiceProvider().getAssertionConsumerService(),
        data.getRecipient()
      )) {
        assertionValidation.addError(
          new ValidationError("Invalid assertion Recipient field: " + data.getRecipient())
        );
        continue;
      }

      if (!assertionValidation.hasErrors()) {
        validConfirmations.add(conf);
      }

    }
    if (assertionValidation.hasErrors()) {
      return assertionValidation;
    }
    assertion.getSubject().setConfirmations(validConfirmations);
    //6. DECRYPT NAMEID if it is encrypted
    //6b. Use regular NameID
    if ((assertion.getSubject().getPrincipal()) == null) {
      //we have a valid assertion, that's the one we will be using
      return new ValidationResult(assertion).addError("Assertion principal is missing");
    }
    return new ValidationResult(assertion);
  }
*/
/*
  public cfboom.security.saml.validation.ValidationResult function validateResponse(cfboom.security.saml.saml2.authentication.Response response,
                    List<String> mustMatchInResponseTo,
                    ServiceProviderMetadata requester,
                    IdentityProviderMetadata responder) {
    String entityId = requester.getEntityId();

    if (response == null) {
      return new ValidationResult(response).addError(new ValidationError("Response is null"));
    }

    if (response.getStatus() == null || response.getStatus().getCode() == null) {
      return new ValidationResult(response).addError(new ValidationError("Response status or code is null"));
    }

    StatusCode statusCode = response.getStatus().getCode();
    if (statusCode != StatusCode.SUCCESS) {
      return new ValidationResult(response).addError(
        new ValidationError("An error response was returned: " + statusCode.toString())
      );
    }

    if (responder == null) {
      return new ValidationResult(response)
        .addError("Remote provider for response was not found");
    }

    if (response.getSignature() != null && !response.getSignature().isValidated()) {
      return new ValidationResult(response).addError(new ValidationError("No validated signature present"));
    }

    //verify issue time
    DateTime issueInstant = response.getIssueInstant();
    if (!isDateTimeSkewValid(getResponseSkewTimeMillis(), 0, issueInstant)) {
      return new ValidationResult(response).addError(
        new ValidationError("Issue time is either too old or in the future:" + issueInstant.toString())
      );
    }

    //validate InResponseTo
    String replyTo = response.getInResponseTo();
    if (!isAllowUnsolicitedResponses() && !hasText(replyTo)) {
      return new ValidationResult(response).addError(
        new ValidationError("InResponseTo is missing and unsolicited responses are disabled")
      );
    }

    if (hasText(replyTo)) {
      if (!isAllowUnsolicitedResponses() && (mustMatchInResponseTo == null || !mustMatchInResponseTo
        .contains(replyTo))) {
        return new ValidationResult(response).addError(
          new ValidationError("Invalid InResponseTo ID, not found in supplied list")
        );
      }
    }

    //validate destination
    if (hasText(response.getDestination()) && !compareURIs(requester.getServiceProvider()
      .getAssertionConsumerService(), response.getDestination())) {
      return new ValidationResult(response).addError(
        new ValidationError("Destination mismatch: " + response.getDestination())
      );
    }

    //validate issuer
    //name id if not null should be "urn:oasis:names:tc:SAML:2.0:nameid-format:entity"
    //value should be the entity ID of the responder
    ValidationResult result = verifyIssuer(response.getIssuer(), responder);
    if (result != null) {
      return result;
    }

    boolean requireAssertionSigned = requester.getServiceProvider().isWantAssertionsSigned();
    if (response.getSignature() != null) {
      requireAssertionSigned = requireAssertionSigned && (!response.getSignature().isValidated());
    }


    Assertion validAssertion = null;
    ValidationResult assertionValidation = new ValidationResult(response);
    //DECRYPT ENCRYPTED ASSERTIONS
    for (Assertion assertion : response.getAssertions()) {

      ValidationResult assertionResult = validate(
        assertion,
        mustMatchInResponseTo,
        requester,
        responder, requireAssertionSigned
      );
      if (!assertionResult.hasErrors()) {
        validAssertion = assertion;
        break;
      }
    }
    if (validAssertion == null) {
      assertionValidation.addError(new ValidationError("No valid assertion with principal found."));
      return assertionValidation;
    }

    for (AuthenticationStatement statement : ofNullable(validAssertion.getAuthenticationStatements())
      .orElse(emptyList())) {
      //VERIFY authentication statements
      if (!isDateTimeSkewValid(
        getResponseSkewTimeMillis(),
        getMaxAuthenticationAgeMillis(),
        statement.getAuthInstant()
      )) {
        return new ValidationResult(response)
          .addError(
            format(
              "Authentication statement is too old to be used with value: '%s' current time: '%s'",
              toZuluTime(statement.getAuthInstant()),
              toZuluTime(new DateTime())
            )
          );
      }

      if (statement.getSessionNotOnOrAfter() != null && statement.getSessionNotOnOrAfter().isBeforeNow
        ()) {
        return new ValidationResult(response)
          .addError(
            format(
              "Authentication session expired on: '%s', current time: '%s'",
              toZuluTime(statement.getSessionNotOnOrAfter()),
              toZuluTime(new DateTime())
            )
          );
      }

      //possibly check the
      //statement.getAuthenticationContext().getClassReference()
    }

    Conditions conditions = validAssertion.getConditions();
    if (conditions != null) {
      //VERIFY conditions
      if (conditions.getNotBefore() != null && conditions.getNotBefore().minusMillis
        (getResponseSkewTimeMillis()).isAfterNow()) {
        return new ValidationResult(response)
          .addError("Conditions expired (not before): " + conditions.getNotBefore());
      }

      if (conditions.getNotOnOrAfter() != null && conditions.getNotOnOrAfter().plusMillis
        (getResponseSkewTimeMillis()).isBeforeNow()) {
        return new ValidationResult(response)
          .addError("Conditions expired (not on or after): " + conditions.getNotOnOrAfter());
      }

      for (AssertionCondition c : conditions.getCriteria()) {
        if (c instanceof AudienceRestriction) {
          AudienceRestriction ac = (AudienceRestriction) c;
          ac.evaluate(entityId, time());
          if (!ac.isValid()) {
            return new ValidationResult(response)
              .addError(
                format(
                  "Audience restriction evaluation failed for assertion condition. Expected '%s' Was '%s'",
                  entityId,
                  ac.getAudiences()
                )
              );
          }
        }
      }
    }

    //the only assertion that we validated - may not be the first one
    response.setAssertions(Arrays.asList(validAssertion));
    return new ValidationResult(response);
  }
*/
/*
  protected boolean isDateTimeSkewValid(int skewMillis, int forwardMillis, DateTime time) {
    if (time == null) {
      return false;
    }
    final DateTime reference = new DateTime();
    final Interval validTimeInterval = new Interval(
      reference.minusMillis(skewMillis + forwardMillis),
      reference.plusMillis(skewMillis)
    );
    return validTimeInterval.contains(time);
  }
*/
/*
  public int getResponseSkewTimeMillis() {
    return responseSkewTimeMillis;
  }
*/
/*
  public DefaultValidator setResponseSkewTimeMillis(int responseSkewTimeMillis) {
    this.responseSkewTimeMillis = responseSkewTimeMillis;
    return this;
  }
*/
/*
  public boolean isAllowUnsolicitedResponses() {
    return allowUnsolicitedResponses;
  }
*/
/*
  public DefaultValidator setAllowUnsolicitedResponses(boolean allowUnsolicitedResponses) {
    this.allowUnsolicitedResponses = allowUnsolicitedResponses;
    return this;
  }
*/
/*
  protected boolean compareURIs(List<Endpoint> endpoints, String uri) {
    for (Endpoint ep : endpoints) {
      if (compareURIs(ep.getLocation(), uri)) {
        return true;
      }
    }
    return false;
  }
*/
/*
  public cfboom.security.saml.validation.ValidationResult function verifyIssuer(Issuer issuer, Metadata entity) {
    if (issuer != null) {
      if (!entity.getEntityId().equals(issuer.getValue())) {
        return new ValidationResult(entity)
          .addError(
            new ValidationError(
              format(
                "Issuer mismatch. Expected: '%s' Actual: '%s'",
                entity.getEntityId(),
                issuer.getValue()
              )
            )
          );
      }
      if (issuer.getFormat() != null && !issuer.getFormat().equals(ENTITY)) {
        return new ValidationResult(entity)
          .addError(
            new ValidationError(
              format(
                "Issuer name format mismatch. Expected: '%s' Actual: '%s'",
                ENTITY,
                issuer.getFormat()
              )
            )
          );
      }
    }
    return null;
  }
*/
/*
  public int getMaxAuthenticationAgeMillis() {
    return maxAuthenticationAgeMillis;
  }
*/
/*
  public Clock time() {
    return time;
  }
*/
/*
  protected boolean compareURIs(String uri1, String uri2) {
    if (uri1 == null && uri2 == null) {
      return true;
    }
    try {
      new URI(uri1);
      new URI(uri2);
      return removeQueryString(uri1).equalsIgnoreCase(removeQueryString(uri2));
    } catch (URISyntaxException e) {
      return false;
    }
  }
*/
/*
  public String removeQueryString(String uri) {
    int queryStringIndex = uri.indexOf('?');
    if (queryStringIndex >= 0) {
      return uri.substring(0, queryStringIndex);
    }
    return uri;
  }
*/
/*
  public void setMaxAuthenticationAgeMillis(int maxAuthenticationAgeMillis) {
    this.maxAuthenticationAgeMillis = maxAuthenticationAgeMillis;
  }
*/
}
