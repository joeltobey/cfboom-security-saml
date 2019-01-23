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
 * Implementation samlp:StatusType as defined by
 * https://www.oasis-open.org/committees/download.php/35711/sstc-saml-core-errata-2.0-wd-06-diff.pdf
 * Page 39, Line 1675
 */
component
  extends="cfboom.lang.Object"
  displayname="Class Status"
  output="false"
{
  public cfboom.security.saml.saml2.authentication.Status function init() {
    return this;
  }

  public cfboom.security.saml.saml2.authentication.StatusCode function getCode() {
    return variables._code;
  }

  public cfboom.security.saml.saml2.authentication.Status function setCode(cfboom.security.saml.saml2.authentication.StatusCode code) {
    variables['_code'] = arguments.code;
    return this;
  }

  public string function getMessage() {
    return variables._message;
  }

  public cfboom.security.saml.saml2.authentication.Status function setMessage(string message) {
    variables['_message'] = arguments.message;
    return this;
  }

  public string function getDetail() {
    return variables._detail;
  }

  public cfboom.security.saml.saml2.authentication.Status function setDetail(string detail) {
    variables['_detail'] = arguments.detail;
    return this;
  }
}
