/** Provides models of commonly used functions and types in the gqlgen packages. */

import go

/** Provides models of commonly used functions and types in the gqlgen packages. */
module Gqlgen {
  /** An autogenerated file containing gqlgen code. */
  private class GqlgenGeneratedFile extends File {
    GqlgenGeneratedFile() {
      exists(DataFlow::CallNode call |
        call.getReceiver().getType().hasQualifiedName("github.com/99designs/gqlgen/graphql", _) and
        call.getFile() = this
      )
    }
  }

  /** A resolver interface. */
  private class ResolverInterface extends Type {
    ResolverInterface() {
      this.getQualifiedName().matches("%Resolver") and
      this.getEntity().getDeclaration().getFile() instanceof GqlgenGeneratedFile
    }
  }

  /** A resolver implementation. */
  private class ResolverInterfaceMethod extends Method {
    ResolverInterfaceMethod() { this.getReceiver().getType() instanceof ResolverInterface }
  }

  /** A resolver method which is exposed as a Graphql endpoint */
  private class ResolverImplementationMethod extends Method {
    ResolverImplementationMethod() { this.implements(any(ResolverInterfaceMethod r)) }

    Parameter getAnUntrustedParameter() {
      result.getFunction() = this.getFuncDecl() and
      not result.getType().hasQualifiedName("context", "Context") and
      result.getIndex() > 0
    }
  }

  /** A parameter of a resolver method which receives untrusted input. */
  class ResolverParameter extends UntrustedFlowSource::Range instanceof DataFlow::ParameterNode {
    ResolverParameter() {
      this.asParameter() = any(ResolverImplementationMethod h).getAnUntrustedParameter()
    }
  }
}
