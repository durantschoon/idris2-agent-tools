---
description: Workflow for verifying totality and discharging termination proofs in Idris 2
---

# Idris 2 Totality Workflow

1. **Set Module Totality**:
   Ensure `%default total` is present after the `module` declaration.

2. **Run Totality Check**:
   ```bash
   idris2 --check src/MyModule.idr
   ```

3. **Diagnosing Totality Failures**:
   - If marked *possibly not total due to recursive call*:
     Check whether arguments decrease strictly in size (e.g. `n` to `k` in `S k`).
   - If recursing over complex structures, prove well-founded recursion or use `size` / `Nat` indices.
   - If coverage fails, ensure all constructors in the data type are covered or explicitly marked impossible (`_ = impossible`).
