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
 *
 */
component
  displayname="Class ValidationException"
  output="false"
{
  public cfboom.security.saml.validation.ValidationException function init(string message, cfboom.security.saml.validation.ValidationResult errors) {
    variables['_errors'] = arguments.errors;
    return this;
  }

  public cfboom.security.saml.validation.ValidationResult function getErrors() {
    return variables._errors;
  }

  public string function getMessage() {
    var sb = createObject("java","java.lang.StringBuffer").init("SAML Validation Errors:");
    for (var error in variables._errors.getErrors()) {
      sb.append(" ");
      sb.append(error.getMessage());
      sb.append(";");
    }
    return sb.toString();
  }
}
