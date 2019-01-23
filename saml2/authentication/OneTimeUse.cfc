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
 * Implementation samlp:OneTimeUseType as defined by
 * https://www.oasis-open.org/committees/download.php/35711/sstc-saml-core-errata-2.0-wd-06-diff.pdf
 * Page 25, Line 1013
 */
component
  extends="cfboom.security.saml.saml2.authentication.AssertionCondition"
  displayname="Class OneTimeUse"
  output="false"
{
  public cfboom.security.saml.saml2.authentication.OneTimeUse function init() {
    return this;
  }

  /**
   * @Override
   */
  public boolean function internalEvaluate(any evaluationCriteria) {
    return !wasEvaluated();
  }
}