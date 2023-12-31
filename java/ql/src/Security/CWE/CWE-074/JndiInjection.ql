/**
 * @name JNDI lookup with user-controlled name
 * @description Performing a JNDI lookup with a user-controlled name can lead to the download of an untrusted
 *              object and to execution of arbitrary code.
 * @kind path-problem
 * @problem.severity error
 * @security-severity 9.8
 * @precision high
 * @id java/jndi-injection
 * @tags security
 *       external/cwe/cwe-074
 */

import java
import semmle.code.java.security.JndiInjectionQuery
import JndiInjectionFlow::PathGraph

from JndiInjectionFlow::PathNode source, JndiInjectionFlow::PathNode sink
where JndiInjectionFlow::flowPath(source, sink)
select sink.getNode(), source, sink, "JNDI lookup might include name from $@.", source.getNode(),
  "this user input"
