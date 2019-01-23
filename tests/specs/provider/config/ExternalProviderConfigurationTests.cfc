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
  displayname="Class ExternalProviderConfigurationTests"
  output="false"
{
  // this will run once after initialization and before setUp()
  public void function beforeTests() {
    super.beforeTests();
    variables['Arrays'] = createObject("java", "java.util.Arrays");
  }

  // this will run once after all tests have been run
  public void function afterTests() {
    structDelete(variables, "Arrays");
    super.afterTests();
  }

  /**
   * @Test
   */
  public void function testNullInit() {
    var epc = new cfboom.security.saml.provider.config.ExternalProviderConfiguration();
    $assert.null( epc.getAlias() );
    $assert.null( epc.getMetadata() );
    $assert.null( epc.getLinktext() );
    assertFalse( epc.isSkipSslValidation() );
    assertFalse( epc.isMetadataTrustCheck() );
    assertTrue(epc.getVerificationKeys().isEmpty());
    assertTrue(epc.getVerificationKeyData().isEmpty());
  }

  /**
   * @Test
   */
  public void function testDefault() {
    var epc = new cfboom.security.saml.provider.config.ExternalProviderConfiguration()
      .setAlias("alias123")
      .setMetadata("metadata456")
      .setLinktext("linktext789")
      .setSkipSslValidation(true)
      .setMetadataTrustCheck(true)
      .setVerificationKeys(Arrays.asList(["a","b","c"]));
    assertEqualsCase( "alias123", epc.getAlias() );
    assertEqualsCase( "metadata456", epc.getMetadata() );
    assertEqualsCase( "linktext789", epc.getLinktext() );
    assertTrue( epc.isSkipSslValidation() );
    assertTrue( epc.isMetadataTrustCheck() );
    assertFalse(epc.getVerificationKeys().isEmpty());
    assertEquals(3, epc.getVerificationKeys().size());
    assertEqualsCase("a", epc.getVerificationKeys().get(0));
    assertEqualsCase("b", epc.getVerificationKeys().get(1));
    assertEqualsCase("c", epc.getVerificationKeys().get(2));
    assertFalse(epc.getVerificationKeyData().isEmpty());
    var simpleKey1 = epc.getVerificationKeyData().get(0);
    assertTrue(find("from-config-", simpleKey1.getName()));
    assertEqualsCase("a",simpleKey1.getCertificate());
    var simpleKey2 = epc.getVerificationKeyData().get(1);
    assertTrue(find("from-config-", simpleKey1.getName()));
    assertEqualsCase("b",simpleKey2.getCertificate());
    var simpleKey3 = epc.getVerificationKeyData().get(2);
    assertTrue(find("from-config-", simpleKey1.getName()));
    assertEqualsCase("c",simpleKey3.getCertificate());
  }
}
