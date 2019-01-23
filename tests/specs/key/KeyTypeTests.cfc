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
  displayname="Class KeyTypeTests"
  output="false"
{
  // this will run once after initialization and before setUp()
  public void function beforeTests() {
    super.beforeTests();

    variables['KeyTypes'] = {
      "SIGNING" = "signing",
      "UNSPECIFIED" = "unspecified",
      "ENCRYPTION" = "encryption"
    };

    variables['KeyTypeMap'] = {
      "signing" = "SIGNING",
      "unspecified" = "UNSPECIFIED",
      "encryption" = "ENCRYPTION"
    };

    variables['KeyType'] = getInstance("KeyType@cfboom-security-saml");
  }

  // this will run once after all tests have been run
  public void function afterTests() {
    structDelete(variables, "KeyTypes");
    structDelete(variables, "KeyTypeMap");
    structDelete(variables, "KeyType");
    super.afterTests();
  }

  /**
   * @Test
   */
  public void function testFromMapToEnum() {
    for (var key in KeyTypeMap) {
      var typeName = key;
      var type = KeyType.fromTypeName(typeName);
      assertEqualsCase(typeName, type.getTypeName(), "Invalid type");
      assertEqualsCase(KeyTypeMap[key], type.name(), "Invalid name for [" & typeName & "]");
    }
  }

  /**
   * @Test
   */
  public void function testFromEnumToMap() {
    for (var key in KeyTypes) {
      var type = KeyType[key];
      var typeName = type.getTypeName();
      var name = type.name();
      assertEqualsCase(typeName, KeyTypes[key], "Invalid type");
      assertEqualsCase(name, key, "Invalid name for [" & typeName & "]");
    }
  }

  /**
   * @Test
   */
  public void function testSpeed() {
    var type = KeyType.SIGNING;
    assertEqualsCase("SIGNING", type.name());
    assertEqualsCase("signing", type.getTypeName());
  }
}
