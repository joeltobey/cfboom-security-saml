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
 */
component
  extends="cfboom.lang.Object"
  displayname="Class SimpleKey"
  output="false"
{
  public cfboom.security.saml.key.SimpleKey function init(string name,
                                                          string privateKey,
                                                          string certificate,
                                                          string passphrase,
                                                          string type) {
    if (structKeyExists(arguments, "name") && !isNull(arguments.name))
      variables['_name'] = arguments.name;
    if (structKeyExists(arguments, "privateKey") && !isNull(arguments.privateKey))
      variables['_privateKey'] = arguments.privateKey;
    if (structKeyExists(arguments, "certificate") && !isNull(arguments.certificate))
      variables['_certificate'] = arguments.certificate;
    if (structKeyExists(arguments, "passphrase") && !isNull(arguments.passphrase))
      variables['_passphrase'] = arguments.passphrase;
    if (structKeyExists(arguments, "type") && !isNull(arguments.type))
      variables['_type'] = arguments.type;
    return this;
  }

  public string function getName() {
    if (structKeyExists(variables, "_name"))
      return variables._name;
  }

  public cfboom.security.saml.key.SimpleKey function setName(string name) {
    variables['_name'] = arguments.name;
    return this;
  }

  public string function getType() {
    if (structKeyExists(variables, "_type"))
      return variables._type;
  }

  public cfboom.security.saml.key.SimpleKey function setType(string type) {
    variables['_type'] = arguments.type;
    return this;
  }

  public cfboom.security.saml.key.SimpleKey function clone(string alias, string type) {
    return new cfboom.security.saml.key.SimpleKey(arguments.alias, getPrivateKey(), getCertificate(), getPassphrase(), arguments.type);
  }

  public string function getPrivateKey() {
    if (structKeyExists(variables, "_privateKey"))
      return variables._privateKey;
  }

  public string function getCertificate() {
    if (structKeyExists(variables, "_certificate"))
      return variables._certificate;
  }

  public string function getPassphrase() {
    if (structKeyExists(variables, "_passphrase"))
      return variables._passphrase;
  }

  public cfboom.security.saml.key.SimpleKey function setPassphrase(string passphrase) {
    variables['_passphrase'] = arguments.passphrase;
    return this;
  }

  public cfboom.security.saml.key.SimpleKey function setCertificate(string certificate) {
    variables['_certificate'] = arguments.certificate;
    return this;
  }

  public cfboom.security.saml.key.SimpleKey function setPrivateKey(string privateKey) {
    variables['_privateKey'] = arguments.privateKey;
    return this;
  }
}
