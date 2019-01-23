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
 * Static utility class that serves as the delimiter between Security SAML and underlying implementation.
 * @author Joel Tobey
 * @singleton
 */
component
  extends="cfboom.lang.Object"
  displayname="Abstract Class SecuritySaml"
  output="false"
{
  property name="InitializationService" inject="InitializationService@cfboom-security-saml";

  property name="javaLoader" inject="JavaLoader@cfboom-security-saml";

  property name="log" inject="logbox:logger:{this}";

  variables['_hasInitCompleted'] = createObject("java","java.util.concurrent.atomic.AtomicBoolean").init(false);

  /**
   * @time.type java.time.Clock
   */
  public cfboom.security.saml.spi.SecuritySaml function init(any time) {
    variables['_time'] = arguments.time;
    return this;
  }

  /**
   * @returns java.time.Clock
   */
  public any function getTime() {
    return variables._time;
  }

  public cfboom.security.saml.spi.SecuritySaml function _init() {
    if (!variables._hasInitCompleted.get()) {
      performInit();
    }
    return this;
  }

  private void function performInit() {
    if (variables._hasInitCompleted.compareAndSet(false, true)) {
      variables.javaLoader.create("java.security.Security").addProvider( variables.javaLoader.create("org.bouncycastle.jce.provider.BouncyCastleProvider").init() );
      bootstrap();
    }
  }

  private void function bootstrap() {
    throw(object=createObject("java", "java.lang.AbstractMethodError").init("Subcass must implement 'bootstrap()'"));
  }

  public numeric function toMillis(any duration) {
    throw(object=createObject("java", "java.lang.AbstractMethodError").init("Subcass must implement 'toMillis(javax.xml.datatype.Duration duration)'"));
  }

  public any function toDuration(numeric millis) {
    throw(object=createObject("java", "java.lang.AbstractMethodError").init("Subcass must implement 'toDuration(java.lang.Long millis)'"));
  }
/*
public abstract String toXml(Saml2Object saml2Object);

public abstract Saml2Object resolve(
String xml, List<SimpleKey> verificationKeys, List<SimpleKey>
localKeys
);

public abstract Saml2Object resolve(byte[] xml, List<SimpleKey> trustedKeys, List<SimpleKey> localKeys);

public abstract Signature validateSignature(Saml2Object saml2Object, List<SimpleKey> trustedKeys);
*/
}
