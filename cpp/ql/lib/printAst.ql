/**
 * @name Print AST
 * @description Outputs a representation of a file's Abstract Syntax Tree. This
 *              query is used by the VS Code extension.
 * @id cpp/print-ast
 * @kind graph
 * @tags ide-contextual-queries/print-ast
 */

import cpp
import semmle.code.cpp.PrintAST
import definitions

/**
 * The source file to generate an AST from.
 */
external string selectedSourceFile();

class Cfg extends PrintAstConfiguration {
  /**
   * Holds if the AST for `decl` should be printed.
   * Print All declarations from the selected file.
   */
  override predicate shouldPrintDeclaration(Declaration decl) {
    decl.getFile() = getFileBySourceArchiveName(selectedSourceFile())
  }
}
