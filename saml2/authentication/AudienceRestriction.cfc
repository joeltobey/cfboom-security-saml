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
 * Implementation saml:AudienceRestrictionType as defined by
 * https://www.oasis-open.org/committees/download.php/35711/sstc-saml-core-errata-2.0-wd-06-diff.pdf
 * Page 24, Line 976
 */
component
  extends="cfboom.security.saml.saml2.authentication.AssertionCondition"
  displayname="Class AudienceRestriction"
  output="false"
{
  variables['Collections'] = createObject("java","java.util.Collections");
  variables['_audiences'] = createObject("java","java.util.LinkedList").init();

  public cfboom.security.saml.saml2.authentication.AudienceRestriction function init() {
    return this;
  }

  public any function getAudiences() {
    return Collections.unmodifiableList(variables._audiences);
  }

  public cfboom.security.saml.saml2.authentication.AudienceRestriction function setAudiences(any audiences) {
    variables._audiences.clear();
    variables._audiences.addAll(arguments.audiences);
    return this;
  }

  /**
   * @Override
   */
  public boolean function internalEvaluate(any evaluationCriteria) {
    return audiences.contains(arguments.evaluationCriteria);
  }

  public cfboom.security.saml.saml2.authentication.AudienceRestriction function addAudience(string audience) {
    variables._audiences.add(arguments.audience);
    return this;
  }
}
