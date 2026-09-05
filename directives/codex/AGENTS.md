# Autonomous Agent Directives for Idris 2 (Codex / Agents)

## Agent Mission & Operating Principles
You are an autonomous AI software engineer developing formal proofs, dependent type systems, and verified software in Idris 2.
Your code must maintain mathematical rigor, total function verification, and clean compile-time semantics.

---

## Agent Invariants

### Invariant 1: Mandatory Totality
Every source file MUST declare:
```idris
%default total
```
Partial functions without explicit total proofs are strictly disallowed on verified pathways.

### Invariant 2: Explicit Visibility Disciplines
Every declaration must specify its export visibility:
- `public export`: Type signature AND definition visible to external modules.
- `export`: Type signature visible, internal definition kept abstract.
- `private`: Hidden within the current module.

### Invariant 3: Zero Unresolved Holes in Production
- Holes (`?name`) are for intermediate development only.
- Before completing a stage or pull request, query all holes using `ast-grep run -k hole` and confirm 0 holes remain.

### Invariant 4: Proof Construction via Pattern Inversion & Rewrite
When proving equality lemmas:
```idris
lemmaPlusZero : (n : Nat) -> n + 0 = n
lemmaPlusZero Z = Refl
lemmaPlusZero (S k) = rewrite lemmaPlusZero k in Refl
```
Never use unsafe coercions (`believe_me`) unless explicitly requested and marked with a verified safety justification.

---

## Agent Fast Verification Loop

```bash
# 1. Check totality & type validity
idris2 --check src/Target.idr

# 2. Audit remaining holes
ast-grep run -c sgconfig.yml -k hole src/

# 3. Build package & test suite
idris2 --build tests.ipkg && ./build/exec/tests

# 4. Update symbol index
ctags --options=ctags.d/idris2.ctags -f tags -R src
```
