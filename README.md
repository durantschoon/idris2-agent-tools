# idris2-agent-tools

High-performance Developer & LLM Agent Tooling for Idris 2.

Provides:
- **`ast-grep` Tree-Sitter Support for Idris 2**: Native AST pattern matching, structural search, and linting rules for Idris 2 codebases.
- **Universal Ctags Optlib Rules**: Jump-to-definition tags for Idris 2 modules, data types, constructors, interfaces, records, and type signatures.
- **Agent Directives & Rules**: Battle-tested drop-ins for `CLAUDE.md`, `AGENTS.md`, Cursor (`.cursorrules`), and Antigravity (`.agents/rules/`, workflows) enforcing totality (`%default total`), hole auditing, and Chez Scheme stack hygiene.
- **CLI Utility**: `bin/idris2-agent-tools` for zero-friction command-line scanning, running, and tagging.

---

## 1. ast-grep (`sg`) Tree-Sitter Support for Idris 2

`ast-grep` provides fast structural code search for Idris 2.

### Setup & Compilation
```bash
# 1. Install ast-grep
brew install ast-grep

# 2. Build the Tree-sitter dylib
make dylib

# 3. Run rule tests
make test-ast
```

### Pre-Configured Rule Catalogue (`rules/`)

| Rule ID | Description | Match Kind |
| :--- | :--- | :--- |
| `find-data-declarations` | Data type declarations (`data Name ... where`) | `data_declaration` |
| `find-constructors` | Data constructor declarations | `constructor_declaration` |
| `find-type-signatures` | Top-level type signatures (`name : Type`) | `type_signature` |
| `find-function-definitions` | Function pattern matching equations | `function_definition` |
| `find-module-declarations` | Module declarations (`module Name`) | `module_declaration` |
| `find-import-declarations` | Import declarations (`import Name`) | `import_declaration` |
| `find-with-declarations` | Dependent pattern matching with-rules | `with_declaration` |
| `find-case-expressions` | Case expressions | `case_expression` |
| `find-holes` | Implementation and proof holes (`?hole`) | `hole` |

### CLI Usage
```bash
# Scan a directory against all Idris 2 rules:
./bin/idris2-agent-tools scan src/

# Find all remaining unproven holes in the codebase:
./bin/idris2-agent-tools run -k hole src/

# Find all data declarations:
./bin/idris2-agent-tools run -k data_declaration src/
```

---

## 2. Universal Ctags Optlib (`ctags.d/idris2.ctags`)

Universal Ctags does not include built-in support for Idris 2. This optlib provides a complete language definition for `.idr` and `.lidr` files.

### Supported Language Kinds
- `m`: Modules (`module Module.Name`)
- `d`: Data types (`data TypeName ... where`)
- `i`: Interfaces (`interface InterfaceName ... where`)
- `r`: Records (`record RecordName ... where`)
- `t`: Type signatures (`name : Type`)

### Generating Tags
```bash
# Project-level generation:
./bin/idris2-agent-tools tags src/ tags

# Or install globally for Universal Ctags:
make install-ctags
```

---

## 3. LLM Agent Directives (`directives/`)

Drop-in directives for autonomous coding assistants:
- **`directives/claude/CLAUDE.md`**: Tailored for Claude Code agents. Includes test commands, totality enforcement, hole discovery, and Chez Scheme limits.
- **`directives/codex/AGENTS.md`**: Invariants for autonomous agent workers (totality checking, visibility rules, proof rewriting, zero unresolved holes).
- **`directives/antigravity/`**: Antigravity rules (`.agents/rules/idris2.md`) and workflows (`totality.md`, `interactive-editing.md`).
- **`directives/cursor/`**: `.cursorrules` optimized for Idris 2 development.

### Installing Directives to a Target Repository
```bash
./bin/idris2-agent-tools install-directives /path/to/my-idris2-repo
```

---

## 4. Verification & Testing

Run all test suites across ast-grep and Universal Ctags:
```bash
make test
```

Expected output:
- `ast-grep`: 9 passed, 0 failed.
- Universal Ctags: all tag assertions passed.

---

## License
MIT License.
