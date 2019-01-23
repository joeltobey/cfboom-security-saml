/**
* Copyright Since 2005 Ortus Solutions, Corp
* www.coldbox.org | www.luismajano.com | www.ortussolutions.com | www.gocontentbox.org
**************************************************************************************
*/
component
  output="false"
{
  this.name = "A TestBox Runner Suite " & hash( getCurrentTemplatePath() );
  // any other application.cfc stuff goes below:
  this.sessionManagement = true;

  // any mappings go here, we create one that points to the root called test.
  this.mappings[ "/tests" ] = getDirectoryFromPath( getCurrentTemplatePath() );
  rootPath = REReplaceNoCase( this.mappings[ "/tests" ], "tests(\\|/)", "" );
  this.mappings[ "/root" ] = expandPath("/");

  // Java Integration
  this.javaSettings = {
    loadPaths = [ "./modules/cfboom/modules/cfboom-security/lib", "./modules/cfboom/modules/cfboom-security-saml/lib" ],
    loadColdFusionClassPath = true,
    reloadOnChange= false
  };
}