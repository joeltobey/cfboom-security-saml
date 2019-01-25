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
  property name="_implementation" type="cfboom.security.saml.spi.SecuritySaml";
  property name="_responseSkewTimeMillis" type="numeric" javaType="int";
  property name="_allowUnsolicitedResponses" type="boolean";
  property name="_maxAuthenticationAgeMillis" type="numeric" javaType="int";

  property name="_time" inject="time@cfboom-security-saml";

  property name="NameId" inject="NameId@cfboom-security-saml";
  property name="StatusCode" inject="StatusCode@cfboom-security-saml";

  property name="DateUtils" inject="DateUtils@cfboom-security-saml";
  property name="javaLoader" inject="JavaLoader@cfboom-security-saml";

  variables['Collections'] = createObject("java","java.util.Collections");
  variables['Optional'] = createObject("java","java.util.Optional");

  /**
   * @implementation.inject SamlImplementation@cfboom-security-saml
   */
  public cfboom.security.saml.spi.DefaultValidator function init( required cfboom.security.saml.spi.SecuritySaml implementation ) {
    setImplementation( arguments.implementation );
    setResponseSkewTimeMillis(1000 * 60 * 2); //two minutes
    setAllowUnsolicitedResponses(true);
    setMaxAuthenticationAgeMillis(1000 * 60 * 60 * 24); //24 hours
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
      var ex = new cfboom.security.saml.validation.ValidationException("Unable to validate SAML object.", result);
      throw(ex.getMessage(), "ValidationException");
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
        new cfboom.security.saml.validation.ValidationResult(assertion).addError(
          new cfboom.security.saml.validation.ValidationError("Assertion is not signed or signature was not validated")
        );
    }

    if (isNull(arguments.responder)) {
      return new cfboom.security.saml.validation.ValidationResult(assertion)
        .addError("Remote provider for assertion was not found");
    }

    List<SubjectConfirmation> validConfirmations = new LinkedList<>();
    var assertionValidation = new cfboom.security.saml.validation.ValidationResult(assertion);
    for (SubjectConfirmation conf : assertion.getSubject().getConfirmations()) {

      assertionValidation.setErrors(Collections.emptyList());
      //verify assertion subject for BEARER
      if (!BEARER.equals(conf.getMethod())) {
        assertionValidation.addError("Invalid confirmation method:" + conf.getMethod());
        continue;
      }

      //for each subject confirmation data
      //1. data must not be null
      SubjectConfirmationData data = conf.getConfirmationData();
      if (data == null) {
        assertionValidation.addError(new cfboom.security.saml.validation.ValidationError("Empty subject confirmation data"));
        continue;
      }


      //2. NotBefore must be null (saml-profiles-2.0-os 558)
      // Not before forbidden by saml-profiles-2.0-os 558
      if (data.getNotBefore() != null) {
        assertionValidation.addError(
          new cfboom.security.saml.validation.ValidationError("Subject confirmation data should not have NotBefore date")
        );
        continue;
      }
      //3. NotOnOfAfter must not be null and within skew
      if (data.getNotOnOrAfter() == null) {
        assertionValidation.addError(
          new cfboom.security.saml.validation.ValidationError("Subject confirmation data is missing NotOnOfAfter date")
        );
        continue;
      }

      if (data.getNotOnOrAfter().plusMillis(getResponseSkewTimeMillis()).isBeforeNow()) {
        assertionValidation.addError(
          new cfboom.security.saml.validation.ValidationError(format("Invalid NotOnOrAfter date: '%s'", data.getNotOnOrAfter()))
        );
      }
      //4. InResponseTo if it exists
      if (hasText(data.getInResponseTo())) {
        if (arguments.mustMatchInResponseTo != null) {
          if (!arguments.mustMatchInResponseTo.contains(data.getInResponseTo())) {
            assertionValidation.addError(
              new cfboom.security.saml.validation.ValidationError(
                format("No match for InResponseTo: '%s' found", data.getInResponseTo())
              )
            );
            continue;
          }
        }
        else if (!isAllowUnsolicitedResponses()) {
          assertionValidation.addError(
            new cfboom.security.saml.validation.ValidationError(
              "InResponseTo missing and system not configured to allow unsolicited messages")
          );
          continue;
        }
      }
      //5. Recipient must match ACS URL
      if (!hasText(data.getRecipient())) {
        assertionValidation.addError(new cfboom.security.saml.validation.ValidationError("Assertion Recipient field missing"));
        continue;
      }
      else if (!compareURIs(
        requester.getServiceProvider().getAssertionConsumerService(),
        data.getRecipient()
      )) {
        assertionValidation.addError(
          new cfboom.security.saml.validation.ValidationError("Invalid assertion Recipient field: " + data.getRecipient())
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
      return new cfboom.security.saml.validation.ValidationResult(assertion).addError("Assertion principal is missing");
    }
    return new cfboom.security.saml.validation.ValidationResult(assertion);
  }
*/

  public cfboom.security.saml.validation.ValidationResult function validateResponse(cfboom.security.saml.saml2.authentication.Response response,
                                                                                    any mustMatchInResponseTo,
                                                                                    cfboom.security.saml.saml2.metadata.ServiceProviderMetadata requester,
                                                                                    cfboom.security.saml.saml2.metadata.IdentityProviderMetadata responder) {
    var entityId = arguments.requester.getEntityId();

    if (isNull(arguments.response)) {
      return new cfboom.security.saml.validation.ValidationResult(arguments.response).addError(new cfboom.security.saml.validation.ValidationError("Response is null"));
    }

    if (isNull(arguments.response.getStatus()) || isNull(arguments.response.getStatus().getCode())) {
      return new cfboom.security.saml.validation.ValidationResult(arguments.response).addError(new cfboom.security.saml.validation.ValidationError("Response status or code is null"));
    }

    var statusCode = arguments.response.getStatus().getCode();
    if (statusCode.name() != variables.StatusCode.SUCCESS.name()) {
      return new cfboom.security.saml.validation.ValidationResult(arguments.response).addError(
        new cfboom.security.saml.validation.ValidationError("An error response was returned: " & statusCode.toString())
      );
    }

    if (isNull(arguments.responder)) {
      return new cfboom.security.saml.validation.ValidationResult(arguments.response)
        .addError("Remote provider for response was not found");
    }

    if (!isNull(arguments.response.getSignature()) && !arguments.response.getSignature().isValidated()) {
      return new cfboom.security.saml.validation.ValidationResult(arguments.response).addError(new cfboom.security.saml.validation.ValidationError("No validated signature present"));
    }

    //verify issue time
    var issueInstant = arguments.response.getIssueInstant();
    if (!isDateTimeSkewValid(getResponseSkewTimeMillis(), 0, issueInstant)) {
      return new cfboom.security.saml.validation.ValidationResult(arguments.response).addError(
        new cfboom.security.saml.validation.ValidationError("Issue time is either too old or in the future:" & issueInstant.toString())
      );
    }

    //validate InResponseTo
    var replyTo = arguments.response.getInResponseTo();
    if (!isAllowUnsolicitedResponses() && !hasText(replyTo)) {
      return new cfboom.security.saml.validation.ValidationResult(arguments.response).addError(
        new cfboom.security.saml.validation.ValidationError("InResponseTo is missing and unsolicited responses are disabled")
      );
    }

    if (hasText(replyTo)) {
      if (!isAllowUnsolicitedResponses() && (isNull(arguments.mustMatchInResponseTo) || !arguments.mustMatchInResponseTo.contains(replyTo))) {
        return new cfboom.security.saml.validation.ValidationResult(arguments.response).addError(
          new cfboom.security.saml.validation.ValidationError("Invalid InResponseTo ID, not found in supplied list")
        );
      }
    }

    //validate destination
    if (hasText(arguments.response.getDestination()) && !compareURIs(arguments.requester.getServiceProvider()
      .getAssertionConsumerService(), arguments.response.getDestination())) {
      return new cfboom.security.saml.validation.ValidationResult(arguments.response).addError(
        new cfboom.security.saml.validation.ValidationError("Destination mismatch: " & arguments.response.getDestination())
      );
    }

    //validate issuer
    //name id if not null should be "urn:oasis:names:tc:SAML:2.0:nameid-format:entity"
    //value should be the entity ID of the responder
    var result = verifyIssuer(arguments.response.getIssuer(), arguments.responder);
    if (!isNull(result)) {
      return result;
    }

    var requireAssertionSigned = arguments.requester.getServiceProvider().isWantAssertionsSigned();
    if (!isNull(arguments.response.getSignature())) {
      requireAssertionSigned = requireAssertionSigned && (!arguments.response.getSignature().isValidated());
    }

    var validAssertion = null;
    var assertionValidation = new cfboom.security.saml.validation.ValidationResult(arguments.response);
    //DECRYPT ENCRYPTED ASSERTIONS
    for (var assertion in arguments.response.getAssertions()) {

      var assertionResult = validate(
        assertion,
        arguments.mustMatchInResponseTo,
        arguments.requester,
        arguments.responder, requireAssertionSigned
      );
      if (!assertionResult.hasErrors()) {
        validAssertion = assertion;
        break;
      }
    }
    if (isNull(validAssertion)) {
      assertionValidation.addError(new cfboom.security.saml.validation.ValidationError("No valid assertion with principal found."));
      return assertionValidation;
    }

    for (var statement in Optional.ofNullable(validAssertion.getAuthenticationStatements())
      .orElse(Collections.emptyList())) {
      //VERIFY authentication statements
      if (!isDateTimeSkewValid(
        getResponseSkewTimeMillis(),
        getMaxAuthenticationAgeMillis(),
        statement.getAuthInstant()
      )) {
        return new cfboom.security.saml.validation.ValidationResult(arguments.response)
          .addError(
            "Authentication statement is too old to be used with value: '#DateUtils.toZuluTime(statement.getAuthInstant())#' current time: '#DateUtils.toZuluTime(variables.javaLoader.create("org.joda.time.DateTime").init())#'"
          );
      }

      if (statement.getSessionNotOnOrAfter() != null && statement.getSessionNotOnOrAfter().isBeforeNow
        ()) {
        return new cfboom.security.saml.validation.ValidationResult(arguments.response)
          .addError(
            "Authentication session expired on: '#DateUtils.toZuluTime(statement.getSessionNotOnOrAfter())#', current time: '#DateUtils.toZuluTime(variables.javaLoader.create("org.joda.time.DateTime").init())#'"
          );
      }

      //possibly check the
      //statement.getAuthenticationContext().getClassReference()
    }

    var conditions = validAssertion.getConditions();
    if (!isNull(conditions)) {
      //VERIFY conditions
      if (!isNull(conditions.getNotBefore()) && conditions.getNotBefore().minusMillis
        (getResponseSkewTimeMillis()).isAfterNow()) {
        return new cfboom.security.saml.validation.ValidationResult(arguments.response)
          .addError("Conditions expired (not before): " & conditions.getNotBefore());
      }

      if (!isNull(conditions.getNotOnOrAfter()) && conditions.getNotOnOrAfter().plusMillis
        (getResponseSkewTimeMillis()).isBeforeNow()) {
        return new cfboom.security.saml.validation.ValidationResult(arguments.response)
          .addError("Conditions expired (not on or after): " & conditions.getNotOnOrAfter());
      }

      for (var c in conditions.getCriteria()) {
        if (isInstanceOf(c, "cfboom.security.saml.saml2.authentication.AudienceRestriction")) {
          var ac = c;
          ac.evaluate(entityId, time());
          if (!ac.isValid()) {
            return new cfboom.security.saml.validation.ValidationResult(arguments.response)
              .addError(
                "Audience restriction evaluation failed for assertion condition. Expected '#entityId#' Was '#ac.getAudiences()#'"
              );
          }
        }
      }
    }

    //the only assertion that we validated - may not be the first one
    arguments.response.setAssertions(Arrays.asList(validAssertion));
    return new cfboom.security.saml.validation.ValidationResult(arguments.response);
  }

  public boolean function isDateTimeSkewValid(numeric skewMillis, numeric forwardMillis, any time) {
    if (isNull(arguments.time)) {
      return false;
    }
    var reference = variables.javaLoader.create("org.joda.time.DateTime").init();
    var validTimeInterval = variables.javaLoader.create("org.joda.time.Interval").init(
      reference.minusMillis(javaCast("int", arguments.skewMillis + arguments.forwardMillis)),
      reference.plusMillis(arguments.skewMillis)
    );
    return validTimeInterval.contains(arguments.time);
  }

  public numeric function getResponseSkewTimeMillis() {
    return variables._responseSkewTimeMillis;
  }

  public cfboom.security.saml.spi.DefaultValidator function setResponseSkewTimeMillis(numeric responseSkewTimeMillis) {
    variables['_responseSkewTimeMillis'] = javaCast("int", arguments.responseSkewTimeMillis);
    return this;
  }

  public boolean function isAllowUnsolicitedResponses() {
    return variables._allowUnsolicitedResponses;
  }

  public cfboom.security.saml.spi.DefaultValidator function setAllowUnsolicitedResponses(boolean allowUnsolicitedResponses) {
    variables['_allowUnsolicitedResponses'] = arguments.allowUnsolicitedResponses;
    return this;
  }

  public cfboom.security.saml.validation.ValidationResult function verifyIssuer(cfboom.security.saml.saml2.authentication.Issuer issuer, cfboom.security.saml.saml2.metadata.Metadata entity) {
    if (!isNull(arguments.issuer)) {
      if (!arguments.entity.getEntityId().equals(arguments.issuer.getValue())) {
        return new cfboom.security.saml.validation.ValidationResult(arguments.entity)
          .addError(
            new cfboom.security.saml.validation.ValidationError(
              "Issuer mismatch. Expected: '#arguments.entity.getEntityId()#' Actual: '#arguments.issuer.getValue()#'"
            )
          );
      }
      if (!isNull(arguments.issuer.getFormat()) && arguments.issuer.getFormat().toString() != NameId.ENTITY.toString()) {
        return new cfboom.security.saml.validation.ValidationResult(arguments.entity)
          .addError(
            new cfboom.security.saml.validation.ValidationError(
              "Issuer name format mismatch. Expected: '#NameId.ENTITY.toString()#' Actual: '#arguments.issuer.getFormat().toString()#'"
            )
          );
      }
    }
    return null;
  }

  public numeric function getMaxAuthenticationAgeMillis() {
    return variables._maxAuthenticationAgeMillis;
  }

  public any function time() {
    return variables._time;
  }

  public boolean function compareURIs(any endpoints, string uri) {
    if (isValid("string", arguments.endpoints)) {
      return doCompareURIs(arguments.endpoints, arguments.uri);
    }
    else {
      for (var ep in arguments.endpoints) {
        if (doCompareURIs(ep.getLocation(), arguments.uri)) {
          return true;
        }
      }
      return false;
    }
  }

  private boolean function doCompareURIs(string uri1, string uri2) {
    if (isNull(arguments.uri1) && isNull(arguments.uri2)) {
      return true;
    }
    try {
      createObject("java","java.net.URI").init(arguments.uri1);
      createObject("java","java.net.URI").init(arguments.uri2);
      return removeQueryString(arguments.uri1).equalsIgnoreCase(removeQueryString(arguments.uri2));
    } catch (java.net.URISyntaxException e) {
      return false;
    }
  }

  public string function removeQueryString(string uri) {
    var queryStringIndex = arguments.uri.indexOf('?');
    if (queryStringIndex >= 0) {
      return arguments.uri.substring(0, queryStringIndex);
    }
    return arguments.uri;
  }

  public void function setMaxAuthenticationAgeMillis(numeric maxAuthenticationAgeMillis) {
    variables['_maxAuthenticationAgeMillis'] = javaCast("int", arguments.maxAuthenticationAgeMillis);
  }

  private boolean function hasText( string str ) {
    if (!structKeyExists(arguments, "str"))
      return false;
    var strData = trim(arguments.str);
    return !strData.isEmpty();
  }
}
