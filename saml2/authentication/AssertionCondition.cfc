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
  displayname="Abstract Class AssertionCondition"
  output="false"
{
  property name="javaLoader" inject="JavaLoader@cfboom-security-saml";

  variables['_valid'] = false;
  variables['_evaluated'] = false;
  //private DateTime evaluationTime = null;
  //private EvaluationCritera evaluationCriteria = null;

  public cfboom.security.saml.saml2.authentication.AssertionCondition function init() {
    return this;
  }

  public boolean function isValid() {
    return variables._valid;
  }

  public any function getEvaluationTime() {
    return variables._evaluationTime;
  }

  public any function getEvaluationCriteria() {
    return variables._evaluationCriteria;
  }

  public boolean function evaluate(any evaluationCriteria, any time) {
    variables['_valid'] = internalEvaluate(arguments.evaluationCriteria);
    variables['_evaluated'] = true;
    variables['_evaluationCriteria'] = arguments.evaluationCriteria;
    variables['_evaluationTime'] = variables.javaLoader.create("org.joda.time.DateTime").init(arguments.time.millis());
    return variables._valid;
  }

  public boolean function internalEvaluate(any evaluationCriteria) {
    throw(object=createObject("java", "java.lang.AbstractMethodError").init("Subcass must implement 'internalEvaluate()'"));
  }

  public boolean function wasEvaluated() {
    return variables._evaluated;
  }
}
