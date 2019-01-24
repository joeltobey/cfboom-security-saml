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
 *
 */
component
  extends="cfboom.lang.Object"
  displayname="Class RotatingKeys"
  output="false"
{
  variables['_standBy'] = createObject("java","java.util.LinkedList").init();

  public cfboom.security.saml.provider.config.RotatingKeys function init() {
    return this;
  }

  public any function toList() {
    var result = createObject("java","java.util.LinkedList").init();
    result.add(getActive());
    result.addAll(getStandBy());
    return result;
  }

  public any function getActive() {
    if (structKeyExists(variables, "_active"))
      return variables._active;
  }

  public cfboom.security.saml.provider.config.RotatingKeys function setActive(cfboom.security.saml.key.SimpleKey active) {
    variables['_active'] = arguments.active;
    if (!len(trim(variables._active.getName()))) {
      variables._active.setName("active-signing-key");
    }
    return this;
  }

  public any function getStandBy() {
    return variables._standBy;
  }

  public cfboom.security.saml.provider.config.RotatingKeys function setStandBy(any standBy) {
    variables['_standBy'] = arguments.standBy;
    return this;
  }
}
