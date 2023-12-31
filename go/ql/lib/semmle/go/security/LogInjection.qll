/**
 * Provides a taint tracking configuration for reasoning about log injection vulnerabilities.
 *
 * Note: for performance reasons, only import this file if `LogInjection::Configuration` is needed,
 * otherwise `LogInjectionCustomizations` should be imported instead.
 */

import go

/**
 * Provides a taint-tracking configuration for reasoning about
 * log injection vulnerabilities.
 */
module LogInjection {
  import LogInjectionCustomizations::LogInjection

  /**
   * DEPRECATED: Use `Flow` instead.
   *
   * A taint-tracking configuration for reasoning about log injection vulnerabilities.
   */
  deprecated class Configuration extends TaintTracking::Configuration {
    Configuration() { this = "LogInjection" }

    override predicate isSource(DataFlow::Node source) { source instanceof Source }

    override predicate isSink(DataFlow::Node sink) { sink instanceof Sink }

    override predicate isSanitizer(DataFlow::Node sanitizer) { sanitizer instanceof Sanitizer }

    deprecated override predicate isSanitizerGuard(DataFlow::BarrierGuard guard) {
      guard instanceof SanitizerGuard
    }
  }

  /** Config for reasoning about log injection vulnerabilities. */
  module Config implements DataFlow::ConfigSig {
    predicate isSource(DataFlow::Node source) { source instanceof Source }

    predicate isSink(DataFlow::Node sink) { sink instanceof Sink }

    predicate isBarrier(DataFlow::Node sanitizer) { sanitizer instanceof Sanitizer }
  }

  /** Tracks taint flow for reasoning about log injection vulnerabilities. */
  module Flow = TaintTracking::Global<Config>;
}
