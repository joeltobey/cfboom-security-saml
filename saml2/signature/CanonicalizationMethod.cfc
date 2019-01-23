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
  displayname="Enum CanonicalizationMethod"
  output="false"
{
  import cfboom.security.saml.saml2.signature.CanonicalizationMethod;

  public cfboom.security.saml.saml2.signature.CanonicalizationMethod function enum() {
    variables['_values'] = [];

    this.ALGO_ID_C14N_OMIT_COMMENTS = new CanonicalizationMethod("http://www.w3.org/TR/2001/REC-xml-c14n-20010315");
    arrayAppend(variables._values, this.ALGO_ID_C14N_OMIT_COMMENTS);

    this.ALGO_ID_C14N_WITH_COMMENTS = new CanonicalizationMethod(this.ALGO_ID_C14N_OMIT_COMMENTS.toString() & "##WithComments");
    arrayAppend(variables._values, this.ALGO_ID_C14N_WITH_COMMENTS);

    this.ALGO_ID_C14N11_OMIT_COMMENTS = new CanonicalizationMethod("http://www.w3.org/2006/12/xml-c14n11");
    arrayAppend(variables._values, this.ALGO_ID_C14N11_OMIT_COMMENTS);

    this.ALGO_ID_C14N11_WITH_COMMENTS = new CanonicalizationMethod(this.ALGO_ID_C14N11_OMIT_COMMENTS.toString() & "##WithComments");
    arrayAppend(variables._values, this.ALGO_ID_C14N11_WITH_COMMENTS);

    this.ALGO_ID_C14N_EXCL_OMIT_COMMENTS = new CanonicalizationMethod("http://www.w3.org/2001/10/xml-exc-c14n##");
    arrayAppend(variables._values, this.ALGO_ID_C14N_EXCL_OMIT_COMMENTS);

    this.ALGO_ID_C14N_EXCL_WITH_COMMENTS = new CanonicalizationMethod(this.ALGO_ID_C14N_EXCL_OMIT_COMMENTS.toString() & "WithComments");
    arrayAppend(variables._values, this.ALGO_ID_C14N_EXCL_WITH_COMMENTS);

    return this;
  }

  public cfboom.security.saml.saml2.signature.CanonicalizationMethod function init(string urn) {
    variables['_urn'] = arguments.urn;
    return this;
  }

  public any function fromUrn(string urn) {
    for (var m in variables._values) {
      if (arguments.urn.equalsIgnoreCase(m.toString())) {
        return m;
      }
    }
    return;
  }

  /**
   * @Override
   */
  public string function toString() {
    return variables._urn;
  }
}
