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
 *
 */
component
  extends="cfboom.lang.Object"
  displayname="Class ValidationError"
  output="false"
{
  public cfboom.security.saml.validation.ValidationError function init(string message) {
    if (structKeyExists(arguments, "message"))
      variables['_message'] = arguments.message;
    return this;
  }

  public string function getMessage() {
    return variables._message;
  }

  public cfboom.security.saml.validation.ValidationError function setMessage(string message) {
    variables['_message'] = arguments.message;
    return this;
  }

  /**
   * @Override
   */
  public string function toString() {
    return variables._message;
  }
}
