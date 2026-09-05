---
description: Workflow for type-driven hole development and proof solving in Idris 2
---

# Idris 2 Interactive Editing & Holes Workflow

1. **Place Holes**:
   Use `?hole_name` on the right-hand side of any definition to inspect expected types and available hypotheses.

2. **Query Hole Type**:
   Launch Idris 2 REPL:
   ```bash
   idris2 src/MyModule.idr
   :t hole_name
   ```

3. **Audit Holes Programmatically**:
   Run `ast-grep` to list all remaining holes in the project:
   ```bash
   ast-grep run -c sgconfig.yml -k hole src/
   ```
