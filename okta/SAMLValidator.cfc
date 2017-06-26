/**
 * Class SAMLValidator
 *
 * @author joeltobey
 * @date 6/9/17
 **/
component singleton
  extends="cfboom.lang.Object"
  implements="cfboom.security.saml.Validator"
  displayname="Class SAMLValidator"
  output=false
{
  property name="wirebox" inject="wirebox";
  property name="configurationLoader" inject="coldbox:setting:samlConfigurationLoader@cfboom-security-saml";

  _instance['useJavaLoader'] = false;

  public cfboom.security.saml.okta.SAMLValidator function init() {
    return this;
  }

  public void function onDIComplete() {
    try {
      _instance['validator'] = createObject("java", "com.okta.saml.SAMLValidator").init();
    } catch (any ex) {
      _instance['useJavaLoader'] = true;
      _instance['validator'] = javaLoader.create("com.okta.saml.SAMLValidator").init();
    }
    // TODO: Make this work!
    //_instance['configuration'] = _instance.validator.getConfiguration( wirebox.getInstance( configurationLoader ).getConfiguration() );
    //_instance['app'] = _instance.configuration.getDefaultApplication();
  }

  public any function getSAMLResponse(required string assertion) {
    return _instance.validator.getSAMLResponse(assertion, _instance.configuration);
  }
}
