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
 * Defines EntityDescriptor as defined by
 * https://www.oasis-open.org/committees/download.php/35391/sstc-saml-metadata-errata-2.0-wd-04-diff.pdf
 * Page 13, Line 268
 */
component
  extends="cfboom.security.saml.saml2.ImplementationHolder"
  displayname="Class EntityDescriptor"
  output="false"
{
  public cfboom.security.saml.saml2.metadata.EntityDescriptor function init(cfboom.security.saml.saml2.metadata.EntityDescriptor other) {
    if (structKeyExists(arguments, "other") && !isNull(arguments.other)) {
      variables['_id'] = arguments.other.getId();
      variables['_entityId'] = arguments.other.getEntityId();
      variables['_entityAlias'] = arguments.other.getEntityAlias();
      variables['_validUntil'] = arguments.other.getValidUntil();
      variables['_cacheDuration'] = arguments.other.getCacheDuration();
      variables['_providers'] = arguments.other.getProviders();
      variables['_signature'] = arguments.other.getSignature();
      variables['_signingKey'] = arguments.other.getSigningKey();
      variables['_algorithm'] = arguments.other.getAlgorithm();
      variables['_digest'] = arguments.other.getDigest();
    }
    return this;
  }

  public string function getId() {
    return variables._id;
  }

  public cfboom.security.saml.saml2.metadata.EntityDescriptor function setId(string id) {
    variables['_id'] = arguments.id;
    return this;
  }

  public string function getEntityId() {
    return variables._entityId;
  }

  public cfboom.security.saml.saml2.metadata.EntityDescriptor function setEntityId(string entityId) {
    variables['_entityId'] = arguments.entityId;
    return this;
  }

  /**
   * @return the timestamp (org.joda.time.DateTime) of the metadata expiration date. null if this value has not been set.
   */
  public any function getValidUntil() {
    return variables._validUntil;
  }

  /**
   * @validUntil.class org.joda.time.DateTime
   */
  public cfboom.security.saml.saml2.metadata.EntityDescriptor function setValidUntil(any validUntil) {
    variables['_validUntil'] = arguments.validUntil;
    return this;
  }

  /**
   * The time interval in format "PnYnMnDTnHnMnS"
   * <ul>
   * <li>P indicates the period (required)</li>
   * <li>nY indicates the number of years</li>
   * <li>nM indicates the number of months</li>
   * <li>nD indicates the number of days</li>
   * <li>T indicates the start of a time section (required if you are going to specify hours, minutes, or
   * seconds)</li>
   * <li>nH indicates the number of hours</li>
   * <li>nM indicates the number of minutes</li>
   * <li>nS indicates the number of seconds</li>
   * </ul>
   *
   * @return the cache duration (javax.xml.datatype.Duration) for the metadata. null if no duration has been set.
   */
  public any function getCacheDuration() {
    return variables._cacheDuration;
  }

  /**
   * @cacheDuration.class javax.xml.datatype.Duration
   */
  public cfboom.security.saml.saml2.metadata.EntityDescriptor function setCacheDuration(any cacheDuration) {
    variables['_cacheDuration'] = arguments.cacheDuration;
    return this;
  }

  public any function getSsoProviders() {
    var result = createObject("java","java.util.LinkedList").init();
    if (!isNull(getProviders())) {
      for (var provider in getProviders()) {
        if (isInstanceOf(provider, "cfboom.security.saml.saml2.metadata.SsoProvider")) {
          result.add(provider);
        }
      }
    }
    return result;
  }

  public any function getProviders() {
    if (structKeyExists(variables, "_providers"))
      return variables._providers;
  }

  public cfboom.security.saml.saml2.metadata.EntityDescriptor function setProviders(any providers) {
    variables['_providers'] = arguments.providers;
    return this;
  }

  public cfboom.security.saml.saml2.signature.Signature function getSignature() {
    return variables._signature;
  }

  public cfboom.security.saml.saml2.metadata.EntityDescriptor function setSignature(cfboom.security.saml.saml2.signature.Signature signature) {
    variables['_signature'] = arguments.signature;
    return this;
  }

  public cfboom.security.saml.key.SimpleKey function getSigningKey() {
    return variables._signingKey;
  }

  public cfboom.security.saml.saml2.signature.AlgorithmMethod function getAlgorithm() {
    return variables._algorithm;
  }

  public cfboom.security.saml.saml2.signature.DigestMethod function getDigest() {
    return variables._digest;
  }

  public string function getEntityAlias() {
    return variables._entityAlias;
  }

  public cfboom.security.saml.saml2.metadata.EntityDescriptor function setEntityAlias(string entityAlias) {
    variables['_entityAlias'] = arguments.entityAlias;
    return this;
  }

  public cfboom.security.saml.saml2.metadata.EntityDescriptor function setSigningKey(cfboom.security.saml.key.SimpleKey signingKey,
                                                                                     cfboom.security.saml.saml2.signature.AlgorithmMethod algorithm,
                                                                                     cfboom.security.saml.saml2.signature.DigestMethod digest) {
    variables['_signingKey'] = arguments.signingKey;
    variables['_algorithm'] = arguments.algorithm;
    variables['_digest'] = arguments.digest;
    return this;
  }

}
