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
  displayname="Class ValidationResult"
  output="false"
{
  variables['Collections'] = createObject("java","java.util.Collections");

  //private final Saml2Object saml2Object;
  variables['_errors'] = createObject("java","java.util.LinkedList").init();

  public cfboom.security.saml.validation.ValidationResult function init(cfboom.security.saml.saml2.Saml2Object saml2Object) {
    variables['_saml2Object'] = arguments.saml2Object;
    return this;
  }

  public cfboom.security.saml.saml2.Saml2Object function getSaml2Object() {
    return variables._saml2Object;
  }

  /**
   * @Override
   */
  public string function toString() {
    var sb = createOjbect("java","java.lang.StringBuffer").init("Validation Errors: ");
    if (hasErrors()) {
      for (var i = 0; i < getErrors().size(); i++) {
        sb.append("\n");
        var error = getErrors().get(i);
        sb.append(i + 1);
        sb.append(". ");
        sb.append(error.getMessage());
      }
    }
    else {
      sb.append("None");
    }

    return sb.toString();
  }

  public cfboom.security.saml.validation.ValidationResult function addError(any error) {
    if (isInstanceOf(arguments.error, "cfboom.security.saml.validation.ValidationError")) {
      variables._errors.add(arguments.error);
    } else {
      variables._errors.add(new cfboom.security.saml.validation.ValidationError(error));
    }
    return this;
  }

  public boolean function hasErrors() {
    return !isSuccess();
  }

  public any function getErrors() {
    return Collections.unmodifiableList(variables._errors);
  }

  public boolean function isSuccess() {
    return variables._errors.isEmpty();
  }

  public cfboom.security.saml.validation.ValidationResult function setErrors(any errors) {
    variables._errors.clear();
    variables._errors.addAll(arguments.errors);
    return this;
  }
}
