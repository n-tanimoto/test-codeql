/**
 * @name Email content injection
 * @description Incorporating untrusted input directly into an email message can enable
 *              content spoofing, which in turn may lead to information leaks and other
 *              security issues.
 * @id go/email-injection
 * @kind path-problem
 * @problem.severity error
 * @security-severity 9.8
 * @tags security
 *       external/cwe/cwe-640
 * @precision high
 */

import go
import EmailInjection::EmailInjection
import Flow::PathGraph

from Flow::PathNode source, Flow::PathNode sink
where Flow::flowPath(source, sink)
select sink, source, sink, "Email content may contain $@.", source.getNode(), "untrusted input"
