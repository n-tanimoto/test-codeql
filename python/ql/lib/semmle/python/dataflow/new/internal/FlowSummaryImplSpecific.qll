/**
 * Provides Python specific classes and predicates for defining flow summaries.
 */

private import python
private import DataFlowPrivate
private import DataFlowPublic
private import DataFlowImplCommon
private import FlowSummaryImpl::Private
private import FlowSummaryImpl::Public
private import semmle.python.dataflow.new.FlowSummary as FlowSummary

class SummarizedCallableBase = string;

DataFlowCallable inject(SummarizedCallable c) { result.asLibraryCallable() = c }

/** Gets the parameter position of the instance parameter. */
ArgumentPosition instanceParameterPosition() { none() } // disables implicit summary flow to `this` for callbacks

/** Gets the synthesized summary data-flow node for the given values. */
Node summaryNode(SummarizedCallable c, SummaryNodeState state) { result = TSummaryNode(c, state) }

/** Gets the synthesized data-flow call for `receiver`. */
SummaryCall summaryDataFlowCall(Node receiver) { receiver = result.getReceiver() }

/** Gets the type of content `c`. */
DataFlowType getContentType(Content c) { any() }

/** Gets the return type of kind `rk` for callable `c`. */
bindingset[c, rk]
DataFlowType getReturnType(SummarizedCallable c, ReturnKind rk) { any() }

/**
 * Gets the type of the `i`th parameter in a synthesized call that targets a
 * callback of type `t`.
 */
bindingset[t, i]
DataFlowType getCallbackParameterType(DataFlowType t, int i) { any() }

/**
 * Gets the return type of kind `rk` in a synthesized call that targets a
 * callback of type `t`.
 */
DataFlowType getCallbackReturnType(DataFlowType t, ReturnKind rk) { any() }

/**
 * Holds if an external flow summary exists for `c` with input specification
 * `input`, output specification `output`, kind `kind`, and a flag `generated`
 * stating whether the summary is autogenerated.
 */
predicate summaryElement(
  FlowSummary::SummarizedCallable c, string input, string output, string kind, boolean generated
) {
  exists(boolean preservesValue |
    c.propagatesFlowExt(input, output, preservesValue) and
    (if preservesValue = true then kind = "value" else kind = "taint") and
    generated = false
  )
}

/**
 * Gets the summary component for specification component `c`, if any.
 *
 * This covers all the Python-specific components of a flow summary.
 */
SummaryComponent interpretComponentSpecific(AccessPathToken c) {
  c = "Argument[_]" and // Ruby has this
  result = FlowSummary::SummaryComponent::argument(any(ParameterPosition pos | pos.isPositional(_)))
  or
  c = "ListElement" and
  result = FlowSummary::SummaryComponent::listElement()
}

/** Gets the textual representation of a summary component in the format used for flow summaries. */
string getComponentSpecificCsv(SummaryComponent sc) {
  sc = TContentSummaryComponent(any(ListElementContent c)) and
  result = "ListElement"
}

/** Gets the textual representation of a parameter position in the format used for flow summaries. */
string getParameterPositionCsv(ParameterPosition pos) { result = pos.toString() }

/** Gets the textual representation of an argument position in the format used for flow summaries. */
string getArgumentPositionCsv(ArgumentPosition pos) { result = pos.toString() }

/** Holds if input specification component `c` needs a reference. */
predicate inputNeedsReferenceSpecific(string c) { none() }

/** Holds if output specification component `c` needs a reference. */
predicate outputNeedsReferenceSpecific(string c) { none() }

/** Gets the return kind corresponding to specification `"ReturnValue"`. */
ReturnKind getReturnValueKind() { any() }

/**
 * All definitions in this module are required by the shared implementation
 * (for source/sink interpretation), but they are unused for Python, where
 * we rely on API graphs instead.
 */
private module UnusedSourceSinkInterpretation {
  /**
   * Holds if an external source specification exists for `n` with output specification
   * `output`, kind `kind`, and a flag `generated` stating whether the source specification is
   * autogenerated.
   */
  predicate sourceElement(AstNode n, string output, string kind, boolean generated) { none() }

  /**
   * Holds if an external sink specification exists for `n` with input specification
   * `input`, kind `kind` and a flag `generated` stating whether the sink specification is
   * autogenerated.
   */
  predicate sinkElement(AstNode n, string input, string kind, boolean generated) { none() }

  class SourceOrSinkElement = AstNode;

  /** An entity used to interpret a source/sink specification. */
  class InterpretNode extends AstNode_ {
    // InterpretNode is going away, this is just a dummy implementation.
    // However, we have some old location tests picking them up, so we
    // explicitly define them to not exist.
    InterpretNode() { none() }

    /** Gets the element that this node corresponds to, if any. */
    SourceOrSinkElement asElement() { none() }

    /** Gets the data-flow node that this node corresponds to, if any. */
    Node asNode() { none() }

    /** Gets the call that this node corresponds to, if any. */
    DataFlowCall asCall() { none() }

    /** Gets the callable that this node corresponds to, if any. */
    DataFlowCallable asCallable() { none() }

    /** Gets the target of this call, if any. */
    SourceOrSinkElement getCallTarget() { none() }
  }

  /** Provides additional sink specification logic. */
  predicate interpretOutputSpecific(string c, InterpretNode mid, InterpretNode node) { none() }

  /** Provides additional source specification logic. */
  predicate interpretInputSpecific(string c, InterpretNode mid, InterpretNode node) { none() }
}

import UnusedSourceSinkInterpretation

module ParsePositions {
  private import FlowSummaryImpl

  private predicate isParamBody(string body) {
    exists(AccessPathToken tok |
      tok.getName() = "Parameter" and
      body = tok.getAnArgument()
    )
  }

  private predicate isArgBody(string body) {
    exists(AccessPathToken tok |
      tok.getName() = "Argument" and
      body = tok.getAnArgument()
    )
  }

  predicate isParsedParameterPosition(string c, int i) {
    isParamBody(c) and
    i = AccessPath::parseInt(c)
  }

  predicate isParsedArgumentPosition(string c, int i) {
    isArgBody(c) and
    i = AccessPath::parseInt(c)
  }
}

/** Gets the argument position obtained by parsing `X` in `Parameter[X]`. */
ArgumentPosition parseParamBody(string s) {
  exists(int i |
    ParsePositions::isParsedParameterPosition(s, i) and
    result.isPositional(i)
  )
}

/** Gets the parameter position obtained by parsing `X` in `Argument[X]`. */
ParameterPosition parseArgBody(string s) {
  exists(int i |
    ParsePositions::isParsedArgumentPosition(s, i) and
    result.isPositional(i)
  )
}
