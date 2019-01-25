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
 * @singleton
 */
component
  displayname="Class EncodingUtils"
  output="false"
{
  variables['StandardCharsets'] = createObject("java","java.nio.charset.StandardCharsets");
  variables['Deflater'] = createObject("java","java.util.zip.Deflater");

  public cfboom.security.saml.spi.EncodingUtils function init() {
    return this;
  }

  public string function encode(any b) {
    return binaryEncode( arguments.b, "Base64" );
  }

  public any function decode(string s) {
    return binaryDecode( arguments.s, "Base64" );
  }

  public any function deflate(string s) {
    try {
      var b = createObject("java","java.io.ByteArrayOutputStream").init();
      var deflater = createObject("java","java.util.zip.DeflaterOutputStream").init(b, createObject("java","java.util.zip.Deflater").init(Deflater.DEFLATED, javaCast("boolean", true)));
      deflater.write(s.getBytes(StandardCharsets.UTF_8));
      deflater.finish();
      return b.toByteArray();
    } catch (java.io.IOException ex) {
      throw("Unable to deflate string", "SamlException");
    }
  }

  public string function inflate(any b) {
    try {
      var out = createObject("java","java.io.ByteArrayOutputStream").init();
      var iout = createObject("java","java.util.zip.InflaterOutputStream").init(out, createObject("java","java.util.zip.Inflater").init(javaCast("boolean", true)));
      iout.write(b);
      iout.finish();
      return createObject("java","java.lang.String").init(out.toByteArray(), StandardCharsets.UTF_8);
    } catch (java.io.IOException ex) {
      throw("Unable to inflate string", "SamlException");
    }
  }
}
