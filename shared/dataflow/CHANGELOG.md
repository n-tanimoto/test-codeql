## 0.0.2

### Major Analysis Improvements

* Initial release. Adds a library to implement flow through captured variables that properly adheres to inter-procedural control flow.

## 0.0.1

### New Features

* The `StateConfigSig` signature now supports a unary `isSink` predicate that does not specify the `FlowState` for which the given node is a sink. Instead, any `FlowState` is considered a valid `FlowState` for such a sink.

### Minor Analysis Improvements

* Initial release. Moves the shared inter-procedural data-flow library into its own qlpack.
