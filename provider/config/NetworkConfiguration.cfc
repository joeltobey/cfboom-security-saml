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
 * @author Joel Tobey
 */
component
  extends="cfboom.lang.Object"
  displayname="Class NetworkConfiguration"
{
  public cfboom.security.saml.provider.config.NetworkConfiguration function init() {
    return this;
  }

  public numeric function getReadTimeout() {
    return variables._readTimeout;
  }

  public cfboom.security.saml.provider.config.NetworkConfiguration function setReadTimeout(numeric readTimeout) {
    variables['_readTimeout'] = javaCast("int",arguments.readTimeout);
    return this;
  }

  public numeric function getConnectTimeout() {
    return variables._connectTimeout;
  }

  public cfboom.security.saml.provider.config.NetworkConfiguration function setConnectTimeout(numeric connectTimeout) {
    variables['_connectTimeout'] = arguments.connectTimeout;
    return this;
  }

  /**
   * @Override
   */
  public cfboom.security.saml.provider.config.NetworkConfiguration function clone() {
    return super.clone();
  }
}
