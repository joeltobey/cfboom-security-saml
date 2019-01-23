<!---
/*
 * Copyright 2016-2017 the original author or authors and Joel Tobey <joeltobey@gmail.com>
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
--->
<cfscript>
  strategy = new docbox.strategy.api.HTMLAPIStrategy(
    expandPath("/modules/cfboom/modules/cfboom-security-saml/apidocs"),
    "&ltcfboom/&gt Security SAML"
  );

  docbox = new docbox.DocBox( strategy );

  docbox.generate(
    source  = expandPath( "/modules/cfboom/modules/cfboom-security-saml" ),
    mapping = "cfboom.security.saml",
    excludes = "tests|ModuleConfig.cfc|Coldbox.cfc"
  );
</cfscript>