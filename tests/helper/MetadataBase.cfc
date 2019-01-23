/*
 * Copyright 2016-2019 the original author or authors and Joel Tobey <joeltobey@gmail.com>
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
  extends="coldbox.system.testing.BaseTestCase"
  appMapping="/root"
  displayname="Class MetadataBase"
  output="false"
{
  // this will run once after initialization and before setUp()
  public void function beforeTests() {
    super.beforeTests();
    variables['Arrays'] = createObject("java", "java.util.Arrays");
    variables['ExamplePemKey'] = createObject("component","tests.mocks.ExamplePemKey").enum();
    variables['KeyType'] = createObject("component","cfboom.security.saml.key.KeyType").enum();
    variables['time'] = createObject("java","java.time.Clock").systemUTC();
    variables['config'] = new cfboom.security.saml.spi.DefaultSamlTransformer(new cfboom.security.saml.spi.opensaml.OpenSamlImplementation(variables.time)._init());
    variables.config.onDIComplete();
  }

  public void function setup() {
    variables['idpSigning'] = ExamplePemKey.IDP_RSA_KEY.getSimpleKey("idp");
    variables['idpVerifying'] = new cfboom.security.saml.key.SimpleKey("idp-verify", null, ExamplePemKey.SP_RSA_KEY.getPublic(), null, KeyType.SIGNING);
    variables['spSigning'] = ExamplePemKey.SP_RSA_KEY.getSimpleKey("sp");
    variables['spVerifying'] = new cfboom.security.saml.key.SimpleKey("sp-verify", null, ExamplePemKey.IDP_RSA_KEY.getPublic(), null, KeyType.SIGNING);
    variables['spBaseUrl'] = "http://sp.localhost:8080/uaa";
    variables['idpBaseUrl'] = "http://idp.localhost:8080/uaa";
    variables['helper'] = new SamlTestObjectHelper(time);

    variables.serviceProviderMetadata = helper.serviceProviderMetadata(
      spBaseUrl,
      spSigning,
      Arrays.asList(spSigning),
      "saml/sp/",
      "sp-alias",
      AlgorithmMethod.RSA_SHA1,
      DigestMethod.SHA1
    );
    //variables.identityProviderMetadata = helper.identityProviderMetadata(
      //idpBaseUrl,
      //idpSigning,
      //Arrays.asList(idpSigning),
      //"saml/idp/",
      //"idp-alias",
      //AlgorithmMethod.RSA_SHA1,
      //DigestMethod.SHA1
    //);
  }

  public void function teardown() {
    structDelete(variables, "idpSigning");
    structDelete(variables, "idpVerifying");
    structDelete(variables, "spSigning");
    structDelete(variables, "spVerifying");
    structDelete(variables, "spBaseUrl");
    structDelete(variables, "idpBaseUrl");
    structDelete(variables, "helper");
    structDelete(variables, "serviceProviderMetadata");
    structDelete(variables, "identityProviderMetadata");
  }

  // this will run once after all tests have been run
  public void function afterTests() {
    structDelete(variables, "Arrays");
    structDelete(variables, "ExamplePemKey");
    structDelete(variables, "KeyType");
    structDelete(variables, "time");
    structDelete(variables, "config");
    super.afterTests();
  }

  /**
   * @Test
   * /
  public void function testInitNull() {
    var simpleKey = new cfboom.security.saml.key.SimpleKey();
    $assert.null(simpleKey.getName());
    $assert.null(simpleKey.getPrivateKey());
    $assert.null(simpleKey.getCertificate());
    $assert.null(simpleKey.getPassphrase());
    $assert.null(simpleKey.getType());
  }*/
}
