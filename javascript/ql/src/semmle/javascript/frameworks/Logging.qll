/**
 * Provides classes for working with logging libraries.
 */

import javascript

/**
 * A call to a logging mechanism.
 */
abstract class LoggerCall extends DataFlow::CallNode {
  /**
   * Gets a node that contributes to the logged message.
   */
  abstract DataFlow::Node getAMessageComponent();
}

/**
 * Gets a log level name that is used in RFC5424, `npm`, `console`.
 */
string getAStandardLoggerMethodName() {
  result = "crit" or
  result = "dir" or
  result = "debug" or
  result = "error" or
  result = "emerg" or
  result = "fatal" or
  result = "info" or
  result = "log" or
  result = "notice" or
  result = "silly" or
  result = "trace" or
  result = "verbose" or
  result = "warn"
}

/**
 * Provides classes for working the builtin Node.js/Browser `console`.
 */
private module Console {
  /**
   * An API entrypoint for the global `console` variable.
   */
  private class ConsoleGlobalEntry extends API::EntryPoint {
    ConsoleGlobalEntry() { this = "ConsoleGlobalEntry" }

    override DataFlow::SourceNode getAUse() { result = DataFlow::globalVarRef("console") }

    override DataFlow::Node getARhs() { none() }
  }

  /**
   * Gets a api node for the console library.
   */
  private API::Node console() {
    result = API::moduleImport("console") or
    result = API::root().getASuccessor(any(ConsoleGlobalEntry e))
  }

  /**
   * A call to the console logging mechanism.
   */
  class ConsoleLoggerCall extends LoggerCall {
    string name;

    ConsoleLoggerCall() {
      (
        name = getAStandardLoggerMethodName() or
        name = "assert"
      ) and
      this = console().getMember(name).getACall()
    }

    override DataFlow::Node getAMessageComponent() {
      (
        if name = "assert"
        then result = getArgument([1 .. getNumArgument()])
        else result = getAnArgument()
      )
      or
      result = getASpreadArgument()
    }

    /**
     * Gets the name of the console logging method, e.g. "log", "error", "assert", etc.
     */
    string getName() { result = name }
  }
}

/**
 * Provides classes for working with [loglevel](https://github.com/pimterry/loglevel).
 */
private module Loglevel {
  /**
   * A call to the loglevel logging mechanism.
   */
  class LoglevelLoggerCall extends LoggerCall {
    LoglevelLoggerCall() {
      this = API::moduleImport("loglevel").getMember(getAStandardLoggerMethodName()).getACall()
    }

    override DataFlow::Node getAMessageComponent() { result = getAnArgument() }
  }
}

/**
 * Provides classes for working with [winston](https://github.com/winstonjs/winston).
 */
private module Winston {
  /**
   * A call to the winston logging mechanism.
   */
  class WinstonLoggerCall extends LoggerCall, DataFlow::MethodCallNode {
    WinstonLoggerCall() {
      this =
        API::moduleImport("winston")
            .getMember("createLogger")
            .getReturn()
            .getMember(getAStandardLoggerMethodName())
            .getACall()
    }

    override DataFlow::Node getAMessageComponent() {
      if getMethodName() = "log"
      then result = getOptionArgument(0, "message")
      else result = getAnArgument()
    }
  }
}

/**
 * Provides classes for working with [log4js](https://github.com/log4js-node/log4js-node).
 */
private module log4js {
  /**
   * A call to the log4js logging mechanism.
   */
  class Log4jsLoggerCall extends LoggerCall {
    Log4jsLoggerCall() {
      this =
        API::moduleImport("log4js")
            .getMember("getLogger")
            .getReturn()
            .getMember(getAStandardLoggerMethodName())
            .getACall()
    }

    override DataFlow::Node getAMessageComponent() { result = getAnArgument() }
  }
}

/**
 * Provides classes for working with [npmlog](https://github.com/npm/npmlog)
 */
private module Npmlog {
  /**
   * A call to the npmlog logging mechanism.
   */
  class Npmlog extends LoggerCall {
    string name;

    Npmlog() {
      this = API::moduleImport("npmlog").getMember(name).getACall() and
      name = getAStandardLoggerMethodName()
    }

    override DataFlow::Node getAMessageComponent() {
      (
        if name = "log"
        then result = getArgument([1 .. getNumArgument()])
        else result = getAnArgument()
      )
      or
      result = getASpreadArgument()
    }
  }
}

/**
 * Provides classes for working with [fancy-log](https://github.com/gulpjs/fancy-log).
 */
private module Fancylog {
  /**
   * A call to the fancy-log logging mechanism.
   */
  class Fancylog extends LoggerCall {
    Fancylog() {
      this = API::moduleImport("fancy-log").getMember(getAStandardLoggerMethodName()).getACall() or
      this = API::moduleImport("fancy-log").getACall()
    }

    override DataFlow::Node getAMessageComponent() { result = getAnArgument() }
  }
}

/**
 * A class modelling [debug](https://npmjs.org/package/debug) as a logging mechanism.
 */
private class DebugLoggerCall extends LoggerCall, API::CallNode {
  DebugLoggerCall() { this = API::moduleImport("debug").getReturn().getACall() }

  override DataFlow::Node getAMessageComponent() { result = getAnArgument() }
}

/**
 * A step through the [`ansi-colors`](https://https://npmjs.org/package/ansi-colors) library.
 */
class AnsiColorsStep extends TaintTracking::SharedTaintStep {
  override predicate stringManipulationStep(DataFlow::Node pred, DataFlow::Node succ) {
    exists(API::CallNode call | call = API::moduleImport("ansi-colors").getAMember*().getACall() |
      pred = call.getArgument(0) and
      succ = call
    )
  }
}

/**
 * A step through the [`colors`](https://npmjs.org/package/colors) library.
 * This step ignores the `String.prototype` modifying part of the `colors` library.
 */
class ColorsStep extends TaintTracking::SharedTaintStep {
  override predicate stringManipulationStep(DataFlow::Node pred, DataFlow::Node succ) {
    exists(API::CallNode call |
      call = API::moduleImport(["colors", "colors/safe"]).getAMember*().getACall()
    |
      pred = call.getArgument(0) and
      succ = call
    )
  }
}

/**
 * A step through the [`wrap-ansi`](https://npmjs.org/package/wrap-ansi) library.
 */
class WrapAnsiStep extends TaintTracking::SharedTaintStep {
  override predicate stringManipulationStep(DataFlow::Node pred, DataFlow::Node succ) {
    exists(API::CallNode call | call = API::moduleImport("wrap-ansi").getACall() |
      pred = call.getArgument(0) and
      succ = call
    )
  }
}

/**
 * A step through the [`colorette`](https://npmjs.org/package/colorette) library.
 */
class ColoretteStep extends TaintTracking::SharedTaintStep {
  override predicate stringManipulationStep(DataFlow::Node pred, DataFlow::Node succ) {
    exists(API::CallNode call | call = API::moduleImport("colorette").getAMember().getACall() |
      pred = call.getArgument(0) and
      succ = call
    )
  }
}

/**
 * A step through the [`cli-highlight`](https://npmjs.org/package/cli-highlight) library.
 */
class CliHighlightStep extends TaintTracking::SharedTaintStep {
  override predicate stringManipulationStep(DataFlow::Node pred, DataFlow::Node succ) {
    exists(API::CallNode call |
      call = API::moduleImport("cli-highlight").getMember("highlight").getACall()
    |
      pred = call.getArgument(0) and
      succ = call
    )
  }
}
