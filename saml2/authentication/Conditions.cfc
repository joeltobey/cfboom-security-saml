/*
 * Copyright 2019 the original author or authors and Joel Tobey <joeltobey@gmail.com>
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
 * Implementation saml:ConditionsType as defined by
 * https://www.oasis-open.org/committees/download.php/35711/sstc-saml-core-errata-2.0-wd-06-diff.pdf
 * Page 22, Line 897
 */
component
  extends="cfboom.lang.Object"
  displayname="Class Conditions"
  output="false"
{
  variables['Collections'] = createObject("java","java.util.Collections");
  //private DateTime notBefore;
  //private DateTime notOnOrAfter;
  variables['_criteria'] = createObject("java","java.util.LinkedList").init();

  public cfboom.security.saml.saml2.authentication.Conditions function init() {
    return this;
  }

  public any function getNotBefore() {
    return variables._notBefore;
  }

  public cfboom.security.saml.saml2.authentication.Conditions function setNotBefore(any notBefore) {
    variables['_notBefore'] = arguments.notBefore;
    return this;
  }

  public any function getNotOnOrAfter() {
    return variables._notOnOrAfter;
  }

  public cfboom.security.saml.saml2.authentication.Conditions function setNotOnOrAfter(any notOnOrAfter) {
    variables['_notOnOrAfter'] = arguments.notOnOrAfter;
    return this;
  }

  public any function getCriteria() {
    return Collections.unmodifiableList(variables._criteria);
  }

  public cfboom.security.saml.saml2.authentication.Conditions function setCriteria(any criteria) {
    variables._criteria.clear();
    variables._criteria.addAll(arguments.criteria);
    return this;
  }

  public cfboom.security.saml.saml2.authentication.Conditions function addCriteria(any condition) {
    variables._criteria.add(arguments.condition);
    return this;
  }
}
