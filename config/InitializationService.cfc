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
 * @author Joel Tobey
 * @singleton
 */
component
  extends="cfboom.lang.Object"
  displayname="Class InitializationService"
  output="false"
{
  property name="javaLoader" inject="JavaLoader@cfboom-security-saml";

  public cfboom.security.saml.config.InitializationService function init() {
    return this;
  }

  public void function initialize() {
    /*
     * When calling InitializationService.initialize(), it doesn't use the right ClassLoader so
     * the ServiceLoader doesn't find all the Initializer services. So we manually
     * initialize all the Initializer services.
     */
    var coreXMLObjectProviderInitializer = variables.javaLoader.create("org.opensaml.core.xml.config.XMLObjectProviderInitializer").init().init();
    var GlobalParserPoolInitializer = variables.javaLoader.create("org.opensaml.core.xml.config.GlobalParserPoolInitializer").init().init();
    var MetricRegistryInitializer = variables.javaLoader.create("org.opensaml.core.metrics.impl.MetricRegistryInitializer").init().init();

    var samlXMLObjectProviderInitializer = variables.javaLoader.create("org.opensaml.saml.config.impl.XMLObjectProviderInitializer").init().init();
    var SAMLConfigurationInitializer = variables.javaLoader.create("org.opensaml.saml.config.impl.SAMLConfigurationInitializer").init().init();

    var clientTLSValidationConfiguratonInitializer = variables.javaLoader.create("org.opensaml.security.config.impl.ClientTLSValidationConfiguratonInitializer").init().init();
    var httpClientSecurityConfigurationInitalizer = variables.javaLoader.create("org.opensaml.security.config.impl.HttpClientSecurityConfigurationInitalizer").init().init();

    var soapXMLObjectProviderInitializer = variables.javaLoader.create("org.opensaml.soap.config.impl.XMLObjectProviderInitializer").init().init();

    var xacmlXMLObjectProviderInitializer = variables.javaLoader.create("org.opensaml.xacml.config.impl.XMLObjectProviderInitializer").init().init();

    var xacmlProfileXMLObjectProviderInitializer = variables.javaLoader.create("org.opensaml.xacml.profile.saml.config.impl.XMLObjectProviderInitializer").init().init();

    var globalAlgorithmRegistryInitializer = variables.javaLoader.create("org.opensaml.xmlsec.config.GlobalAlgorithmRegistryInitializer").init().init();
    var decryptionParserPoolInitializer = variables.javaLoader.create("org.opensaml.xmlsec.config.DecryptionParserPoolInitializer").init().init();

    var javaCryptoValidationInitializer = variables.javaLoader.create("org.opensaml.xmlsec.config.impl.JavaCryptoValidationInitializer").init().init();

    /*
     * We need to manually initialize XMLObjectProviderInitializer. AbstractXMLObjectProviderInitializer uses
     * Thread.currentThread().getContextClassLoader(), which finds the wrong ClassLoader.
     */
    var classLoader = variables.javaLoader.getClassLoader();
    var configurator = variables.javaLoader.create("org.opensaml.core.xml.config.XMLConfigurator").init();
    var defaultConfigIS = classLoader.getResourceAsStream("default-config.xml");
    configurator.load(defaultConfigIS);
    var schemaConfigIS = classLoader.getResourceAsStream("schema-config.xml");
    configurator.load(schemaConfigIS);
    var registry = variables.javaLoader.create("org.opensaml.core.config.ConfigurationService").get(classLoader.loadClass("org.opensaml.core.xml.config.XMLObjectProviderRegistry"));
    registry.registerIDAttribute(variables.javaLoader.create("javax.xml.namespace.QName").init(variables.javaLoader.create("javax.xml.XMLConstants").XML_NS_URI, "id"));

    var apacheXMLSecurityInitializer = variables.javaLoader.create("org.opensaml.xmlsec.config.impl.ApacheXMLSecurityInitializer").init().init();
    var globalSecurityConfigurationInitializer = variables.javaLoader.create("org.opensaml.xmlsec.config.impl.GlobalSecurityConfigurationInitializer").init().init();
  }
}
