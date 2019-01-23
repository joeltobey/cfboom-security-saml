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
 * Base class for SAML providers
 */
component
  extends="cfboom.lang.Object"
  displayname="Class Provider"
  output="false"
{
  variables['Collections'] = createObject("java","java.util.Collections");
  //private Signature signature;
  variables['_keys'] = createObject("java","java.util.LinkedList").init();
  //private String id;
  //private DateTime validUntil;
  //private Duration cacheDuration;
  //private List<String> protocolSupportEnumeration;

  public cfboom.security.saml.saml2.metadata.Provider function init() {
    return this;
  }

  public cfboom.security.saml.saml2.signature.Signature function getSignature() {
    return variables._signature;
  }

  public cfboom.security.saml.saml2.metadata.Provider function setSignature(cfboom.security.saml.saml2.signature.Signature signature) {
    variables['_signature'] = arguments.signature;
    return this;
  }

  public any function getKeys() {
    return Collections.unmodifiableList(variables._keys);
  }

  public cfboom.security.saml.saml2.metadata.Provider function setKeys(any keys) {
    variables._keys.clear();
    if (structKeyExists(arguments, "keys")) {
        variables._keys.addAll(arguments.keys);
    }
    return this;
  }

  public string function getId() {
    return variables._id;
  }

  public cfboom.security.saml.saml2.metadata.Provider function setId(string id) {
    variables['_id'] = arguments.id;
    return this;
  }

  public any function getValidUntil() {
    return variables._validUntil;
  }

  /**
   * @validUntil.class org.joda.time.DateTime
   */
  public cfboom.security.saml.saml2.metadata.Provider function setValidUntil(any validUntil) {
    variables['_validUntil'] = arguments.validUntil;
    return this;
  }

  public any function getCacheDuration() {
    return variables._cacheDuration;
  }

  /**
   * @cacheDuration.class javax.xml.datatype.Duration
   */
  public cfboom.security.saml.saml2.metadata.Provider function setCacheDuration(any cacheDuration) {
    variables['_cacheDuration'] = arguments.cacheDuration;
    return this;
  }

  public any function getProtocolSupportEnumeration() {
    return variables._protocolSupportEnumeration;
  }

  public cfboom.security.saml.saml2.metadata.Provider function setProtocolSupportEnumeration(any protocolSupportEnumeration) {
    variables['_protocolSupportEnumeration'] = arguments.protocolSupportEnumeration;
    return this;
  }
}
