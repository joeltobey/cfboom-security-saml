/*
 * Copyright 2017-2019 Joel Tobey <joeltobey@gmail.com>
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
 * Caches metadata that has been retrieved over the network
 *
 * @author fhanik
 * @author Joel Tobey
 * @singleton
 */
component
  extends="cfboom.lang.Object"
  implements="cfboom.security.saml.SamlMetadataCache"
  displayname="Class DefaultMetadataCache"
  output="false"
{
  property name="httpClient" inject="BasicHttpClient@cfboom-http";
  property name="javaLoader" inject="JavaLoader@cfboom-security-saml";

  property name="InitializationService" inject="InitializationService@cfboom-security-saml";

  property name="cache" inject="cachebox:IdPMetadataCache";
  property name="misses" inject="cachebox:IdPMetadataCacheMisses";

  public cfboom.security.saml.spi.DefaultMetadataCache function init() {
    return this;
  }

  public void function onDIComplete() {
    //variables['_XMLObjectSupport'] = variables.InitializationService.getXMLObjectSupport();
    //variables['_XMLObjectProviderRegistrySupport'] = variables.InitializationService.getXMLObjectProviderRegistrySupport();
  }

  /**
   * Returns an org.opensaml.saml.saml2.metadata.impl.EntityDescriptorImpl (org.opensaml.saml.saml2.metadata.EntityDescriptor) object.
   */
  public any function getMetadata(string uri, boolean skipSslValidation = false) {
    var hasMiss = misses.get(arguments.uri);
    if (!isNull(hasMiss)) {
      throw(object = hasMiss);
    }
    var data = cache.get(arguments.uri);
    var metadata = javaCast("null", "");
    if (isNull(data)) {
      try {
        if (arguments.skipSslValidation) {
          metadata = variables.httpClient.get(arguments.uri).getFileContent();
        } else {
          metadata = variables.httpClient.get(arguments.uri).getFileContent();
        }
        var metadataStream = variables.javaLoader.create("java.io.ByteArrayInputStream").init(metadata.getBytes());
        data = variables._XMLObjectSupport.unmarshallFromInputStream( variables._XMLObjectProviderRegistrySupport.getParserPool(), metadataStream );
        metadataStream.close();
        cache.set(arguments.uri, data);
      } catch (any ex) {
        misses.set(arguments.uri, ex);
        rethrow;
      }
    }
    return data;
  }

  public void function clear() {
    misses.clear();
    cache.clear();
  }

  public any function remove(string uri) {
    misses.remove(arguments.uri);
    return cache.remove(arguments.uri);
  }
}
