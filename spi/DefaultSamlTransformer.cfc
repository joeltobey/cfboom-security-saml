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
  implements="cfboom.security.saml.SamlTransformer"
  displayname="Class DefaultSamlTransformer"
  output="false"
{
  variables['UTF_8'] = createObject("java","java.nio.charset.StandardCharsets").UTF_8;

  /**
   * @implementation.inject SamlImplementation@cfboom-security-saml
   */
  public cfboom.security.saml.spi.DefaultSamlTransformer function init( required cfboom.security.saml.spi.SecuritySaml implementation ) {
    setImplementation( arguments.implementation );
    return this;
  }

  public cfboom.security.saml.SamlTransformer function setImplementation( cfboom.security.saml.spi.SecuritySaml implementation ) {
    variables['_implementation'] = arguments.implementation;
    return this;
  }

  public void function onDIComplete() {
    variables._implementation._init();
  }

  /**
   * @Override
   */
  public string function toXml(cfboom.security.saml.saml2.Saml2Object saml2Object) {
    return variables._implementation.toXml(arguments.saml2Object);
  }

  /**
   * @Override
   */
  public cfboom.security.saml.saml2.Saml2Object function fromXml(string xmlString, any verificationKeys, any localKeys) {
    var xmlBytes = arguments.xmlString.getBytes(UTF_8);
    return variables._implementation.resolve(xmlBytes, arguments.verificationKeys, arguments.localKeys);
  }

  /**
   * @Override
   */
  public string function samlEncode(string s, boolean deflate = false) {
    var b = null;
    if (arguments.deflate) {
      b = variables._implementation.deflate(arguments.s);
    }
    else {
      b = arguments.s.getBytes(UTF_8);
    }
    return variables._implementation.encode(b);
  }

  /**
   * @Override
   */
  public string function samlDecode(string s, boolean inflate = false) {
    var b = variables._implementation.decode(arguments.s);
    if (arguments.inflate) {
      return variables._implementation.inflate(b);
    }
    else {
      return createObject("java","java.lang.String").init(b, UTF_8);
    }
  }
}
