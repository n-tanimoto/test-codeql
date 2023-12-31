/*
 * Copyright 2001-2005 (C) MetaStuff, Ltd. All Rights Reserved.
 *
 * This software is open source. See the bottom of this file for the licence.
 */

/*
 * Adapted from DOM4J version 2.1.1 as available at
 * https://search.maven.org/remotecontent?filepath=org/dom4j/dom4j/2.1.1/dom4j-2.1.1-sources.jar
 * Only relevant stubs of this file have been retained for test purposes.
 */

package org.dom4j.xpath;

import java.io.Serializable;
import java.util.List;
import java.util.Map;
import org.dom4j.InvalidXPathException;
import org.dom4j.Node;
import org.dom4j.XPath;
import org.jaxen.FunctionContext;
import org.jaxen.NamespaceContext;
import org.jaxen.VariableContext;

public class DefaultXPath implements org.dom4j.XPath, Serializable {
  public DefaultXPath(String text) throws InvalidXPathException {}

  public FunctionContext getFunctionContext() {
    return null;
  }

  public List selectNodes(Object p0) {
    return null;
  }

  public List selectNodes(Object p0, XPath p1) {
    return null;
  }

  public List selectNodes(Object p0, XPath p1, boolean p2) {
    return null;
  }

  public NamespaceContext getNamespaceContext() {
    return null;
  }

  public Node selectSingleNode(Object p0) {
    return null;
  }

  public Number numberValueOf(Object p0) {
    return null;
  }

  public Object evaluate(Object p0) {
    return null;
  }

  public Object selectObject(Object p0) {
    return null;
  }

  public String getText() {
    return null;
  }

  public String valueOf(Object p0) {
    return null;
  }

  public VariableContext getVariableContext() {
    return null;
  }

  public boolean booleanValueOf(Object p0) {
    return false;
  }

  public boolean matches(Node p0) {
    return false;
  }

  public void setFunctionContext(FunctionContext p0) {}

  public void setNamespaceContext(NamespaceContext p0) {}

  public void setNamespaceURIs(Map p0) {}

  public void setVariableContext(VariableContext p0) {}

  public void sort(List p0) {}

  public void sort(List p0, boolean p1) {}

}

/*
 * Redistribution and use of this software and associated documentation ("Software"), with or
 * without modification, are permitted provided that the following conditions are met:
 * 
 * 1. Redistributions of source code must retain copyright statements and notices. Redistributions
 * must also contain a copy of this document.
 * 
 * 2. Redistributions in binary form must reproduce the above copyright notice, this list of
 * conditions and the following disclaimer in the documentation and/or other materials provided with
 * the distribution.
 * 
 * 3. The name "DOM4J" must not be used to endorse or promote products derived from this Software
 * without prior written permission of MetaStuff, Ltd. For written permission, please contact
 * dom4j-info@metastuff.com.
 * 
 * 4. Products derived from this Software may not be called "DOM4J" nor may "DOM4J" appear in their
 * names without prior written permission of MetaStuff, Ltd. DOM4J is a registered trademark of
 * MetaStuff, Ltd.
 * 
 * 5. Due credit should be given to the DOM4J Project - http://www.dom4j.org
 * 
 * THIS SOFTWARE IS PROVIDED BY METASTUFF, LTD. AND CONTRIBUTORS ``AS IS'' AND ANY EXPRESSED OR
 * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
 * FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL METASTUFF, LTD. OR ITS
 * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY
 * WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 * 
 * Copyright 2001-2005 (C) MetaStuff, Ltd. All Rights Reserved.
 */
