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
 */
component
  displayname="Enum NameId"
  output="false"
{
  import cfboom.security.saml.saml2.metadata.NameId;
  variables['NameIdFormat'] = createObject("component","cfboom.security.saml.saml2.metadata.NameIdFormat").enum();

  public cfboom.security.saml.saml2.metadata.NameId function enum() {
    variables['_values'] = [];

    this.UNSPECIFIED = new NameId(NameIdFormat.UNSPECIFIED.toUri());
    arrayAppend(variables._values, this.UNSPECIFIED);

    this.EMAIL = new NameId(NameIdFormat.EMAIL.toUri());
    arrayAppend(variables._values, this.EMAIL);

    this.TRANSIENT = new NameId(NameIdFormat.TRANSIENT.toUri());
    arrayAppend(variables._values, this.TRANSIENT);

    this.PERSISTENT = new NameId(NameIdFormat.PERSISTENT.toUri());
    arrayAppend(variables._values, this.PERSISTENT);

    this.X509_SUBJECT = new NameId(NameIdFormat.X509_SUBJECT.toUri());
    arrayAppend(variables._values, this.X509_SUBJECT);

    this.WIN_DOMAIN_QUALIFIED = new NameId(NameIdFormat.WIN_DOMAIN_QUALIFIED.toUri());
    arrayAppend(variables._values, this.WIN_DOMAIN_QUALIFIED);

    this.KERBEROS = new NameId(NameIdFormat.KERBEROS.toUri());
    arrayAppend(variables._values, this.KERBEROS);

    this.ENTITY = new NameId(NameIdFormat.ENTITY.toUri());
    arrayAppend(variables._values, this.ENTITY);

    this.ENCRYPTED = new NameId(NameIdFormat.ENCRYPTED.toUri());
    arrayAppend(variables._values, this.ENCRYPTED);

    return this;
  }

  public cfboom.security.saml.saml2.metadata.NameId function init(any uri, cfboom.security.saml.saml2.metadata.NameIdFormat format) {
    if (isInstanceOf(arguments.uri, "java.lang.String"))
      arguments.uri = createObject("java","java.net.URI").init(arguments.uri);
    if (!structKeyExists(arguments, "format"))
      arguments['format'] = NameIdFormat.fromUrn(arguments.uri.toString());
    variables['_value'] = arguments.uri;
    variables['_format'] = arguments.format;
    return this;
  }

  public any function fromUrn(string other) {
    if (!structKeyExists(arguments, "other") || isNull(arguments.other) || !len(trim(arguments.other))) {
      return;
    }

    var uri = createObject("java","java.net.URI").init(arguments.other);

    var format = NameIdFormat.fromUrn(arguments.other);
    switch (format.name()) {
      case "PERSISTENT": return this.PERSISTENT;
      case "EMAIL": return this.EMAIL;
      case "ENTITY": return this.ENTITY;
      case "KERBEROS": return this.KERBEROS;
      case "ENCRYPTED": return this.ENCRYPTED;
      case "TRANSIENT": return this.TRANSIENT;
      case "X509_SUBJECT": return this.X509_SUBJECT;
      case "WIN_DOMAIN_QUALIFIED": return this.WIN_DOMAIN_QUALIFIED;
    }
    if (uri.equals(NameIdFormat.UNSPECIFIED.toUri())) {
      return this.UNSPECIFIED;
    }
    return new NameId(uri, NameIdFormat.UNSPECIFIED);
  }

  public any function getValue() {
    return variables._value;
  }

  public cfboom.security.saml.saml2.metadata.NameIdFormat function getFormat() {
    return variables._format;
  }

  /**
   * @Override
   */
  public string function toString() {
    return getValue().toString();
  }
}
