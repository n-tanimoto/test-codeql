// generated by codegen/codegen.py
private import codeql.swift.generated.Synth
private import codeql.swift.generated.Raw
import codeql.swift.elements.decl.OperatorDecl
import codeql.swift.elements.decl.PrecedenceGroupDecl

module Generated {
  class InfixOperatorDecl extends Synth::TInfixOperatorDecl, OperatorDecl {
    override string getAPrimaryQlClass() { result = "InfixOperatorDecl" }

    /**
     * Gets the precedence group of this infix operator declaration, if it exists.
     */
    PrecedenceGroupDecl getPrecedenceGroup() {
      result =
        Synth::convertPrecedenceGroupDeclFromRaw(Synth::convertInfixOperatorDeclToRaw(this)
              .(Raw::InfixOperatorDecl)
              .getPrecedenceGroup())
    }

    /**
     * Holds if `getPrecedenceGroup()` exists.
     */
    final predicate hasPrecedenceGroup() { exists(this.getPrecedenceGroup()) }
  }
}
