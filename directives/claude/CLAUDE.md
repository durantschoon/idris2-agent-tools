# Idris 2 Project Instructions for Claude Code

## Project Overview & Conventions
- **Language**: Idris 2 (v0.6.0+ / v0.7.0+)
- **Core Paradigm**: Pure functional programming with first-class dependent types, totality enforcement, and linear resource typing.
- **Backend**: Chez Scheme (default high-performance backend).
- **Package Management**: `.ipkg` files (build with `idris2 --build <package>.ipkg`).

---

## Commands & Workflows

### Building & Testing
```bash
# Build main package
idris2 --build package.ipkg

# Run tests
idris2 --build tests.ipkg && ./build/exec/tests

# Check a single file for totality and types
idris2 --check src/MyModule.idr
```

### AST Structural Search (via ast-grep / sg)
```bash
# Find all data type definitions
ast-grep run -c sgconfig.yml -k data_declaration

# Find all proof / implementation holes (?hole)
ast-grep run -c sgconfig.yml -k hole

# Find all with-clause declarations
ast-grep run -c sgconfig.yml -k with_declaration

# Scan project for AST issues
ast-grep scan -c sgconfig.yml
```

### Symbol Indexing (Universal Ctags)
```bash
# Generate tags for Idris 2 code
ctags --options=ctags.d/idris2.ctags -f tags -R src
```

---

## Critical Idris 2 Engineering Rules

### 1. Totality & Coverage Enforcement
- Always declare `%default total` at the top of every module.
- If a function cannot be checked as structurally recursive by the totality checker, provide an explicit termination argument, well-founded recursion metric, or assert totality with `assert_total` accompanied by an explanatory proof comment.

### 2. Type-Driven Development & Holes
- When implementing complex dependent algorithms or proofs, leave holes `?rhs_name` and inspect their required context and type:
  ```idris
  myLemma : (n : Nat) -> n + 0 = n
  myLemma Z = Refl
  myLemma (S k) = ?step_hole
  ```
- Use `ast-grep run -k hole` to audit remaining holes before merging code.

### 3. Chez Scheme Runtime Limits
- Avoid unbounded deep non-tail recursion which exhausts the Chez Scheme call stack. Prefer tail-recursive loops with accumulators or iterate with `Vect` / `List` folds.

### 4. Interfaces & Implementation Disambiguation
- When defining implementations that might overlap, use named implementations:
  ```idris
  [MyEq] Eq CustomType where ...
  ```
- Use `@{MyEq}` to pass named implementations explicitly where multiple candidates exist.
