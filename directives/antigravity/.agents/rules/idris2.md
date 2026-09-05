---
description: Formal verification and engineering standards for Idris 2 codebases
globs: ["**/*.idr", "**/*.lidr", "**/*.ipkg"]
---

# Idris 2 Engineering Rules for Antigravity

## Core Directives
1. **Enforce Totality**: Always write `%default total` at the head of every `.idr` file. Verify with `idris2 --check`.
2. **Audit Holes**: Type-driven holes (`?hole`) must not be left unproven in released code. Search for them with `ast-grep run -k hole`.
3. **Tail Recursion**: Respect Chez Scheme stack limits by structuring large traversals and data processing with tail recursion or standard folds.
4. **Symbol Indexing**: Use `ctags --options=ctags.d/idris2.ctags -R src` for instant navigation across types and interfaces.
5. **AST Search**: Use `ast-grep` (`sg`) with `sgconfig.yml` for structural queries over Idris 2 syntax.
