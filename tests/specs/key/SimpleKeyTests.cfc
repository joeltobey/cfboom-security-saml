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
  displayname="Class SimpleKeyTest"
  output="false"
{
  // this will run once after initialization and before setUp()
  public void function beforeTests() {
    super.beforeTests();
    var test = new cfboom.security.saml.saml2.authentication.SubjectPrincipal();
    writeDump(test);
    abort;
    variables['KeyType'] = createObject("component","cfboom.security.saml.key.KeyType").enum();
  }

  // this will run once after all tests have been run
  public void function afterTests() {
    structDelete(variables, "KeyType");
    super.afterTests();
  }

  /**
   * @Test
   */
  public void function testInit() {
    var simpleKey = new cfboom.security.saml.key.SimpleKey("name","privateKey","certificate","passphrase",KeyType.SIGNING);
    assertEquals( "name", simpleKey.getName() );
    assertEquals( "privateKey", simpleKey.getPrivateKey() );
    assertEquals( "certificate", simpleKey.getCertificate() );
    assertEquals( "passphrase", simpleKey.getPassphrase() );
    assertEquals( "signing", simpleKey.getType().getTypeName() );
  }

  /**
   * @Test
   */
  public void function testInitNull() {
    var simpleKey = new cfboom.security.saml.key.SimpleKey();
    $assert.null(simpleKey.getName());
    $assert.null(simpleKey.getPrivateKey());
    $assert.null(simpleKey.getCertificate());
    $assert.null(simpleKey.getPassphrase());
    $assert.null(simpleKey.getType());
  }

  /**
   * @Test
   */
  public void function testClone() {
    var simpleKey = new cfboom.security.saml.key.SimpleKey("name","privateKey","certificate","passphrase",KeyType.SIGNING);
    var clone1 = simpleKey.clone("clone1");
    assertEquals( "clone1", clone1.getName() );
    $assert.null(clone1.getType());
    var clone2 = simpleKey.clone("clone2", KeyType.UNSPECIFIED);
    assertEquals( "clone2", clone2.getName() );
    assertEquals( "unspecified", clone2.getType().getTypeName() );

    assertEquals( "privateKey", simpleKey.getPrivateKey() );
    assertEquals( "certificate", simpleKey.getCertificate() );
    assertEquals( "passphrase", simpleKey.getPassphrase() );

    assertEquals( "privateKey", clone1.getPrivateKey() );
    assertEquals( "certificate", clone1.getCertificate() );
    assertEquals( "passphrase", clone1.getPassphrase() );

    assertEquals( "privateKey", clone2.getPrivateKey() );
    assertEquals( "certificate", clone2.getCertificate() );
    assertEquals( "passphrase", clone2.getPassphrase() );
  }
}
