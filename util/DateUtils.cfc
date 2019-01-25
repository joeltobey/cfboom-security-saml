/*
 * Copyright 2002-2019 the original author or authors and Joel Tobey <joeltobey@gmail.com>
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
 * @singleton
 */
component
  displayname="Class DateUtils"
  output="false"
{
  property name="javaLoader" inject="JavaLoader@cfboom-security-saml";

  public cfboom.security.saml.util.DateUtils function init() {
    return this;
  }

  public void function onDIComplete() {
    variables['ISODateTimeFormat'] = variables.javaLoader.create("org.joda.time.format.ISODateTimeFormat");
    variables['ISOChronology'] = variables.javaLoader.create("org.joda.time.chrono.ISOChronology");
  }

  public string function toZuluTime(any d) {
    return arguments.d.toString(zulu());
  }

  public org.joda.time.format.DateTimeFormatter function zulu() {
    return variables.ISODateTimeFormat.dateTime().withChronology(variables.ISOChronology.getInstanceUTC());
  }

  public org.joda.time.DateTime function fromZuluTime(string instant) {
    return zulu().parseDateTime(arguments.instant);
  }
}
