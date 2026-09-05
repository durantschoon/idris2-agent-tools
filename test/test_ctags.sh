#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
OPTIONS_FILE="${ROOT_DIR}/ctags.d/idris2.ctags"
FIXTURES_DIR="${ROOT_DIR}/test/fixtures"
SAMPLE_FILE="${FIXTURES_DIR}/Sample.idr"

mkdir -p "${FIXTURES_DIR}"

cat << 'EOF' > "${SAMPLE_FILE}"
module Sample

%default total

public export
data Nat : Type where
  Z : Nat
  S : Nat -> Nat

public export
interface Describe a where
  describe : a -> String

public export
record Config where
  constructor MkConfig
  timeout : Int
  retries : Nat

public export
add : Nat -> Nat -> Nat
add Z y = y
add (S k) y = S (add k y)
EOF

echo "Running Universal Ctags with idris2.ctags on ${SAMPLE_FILE}..."
OUTPUT=$(ctags --options="${OPTIONS_FILE}" -f - --fields=+K+n+S "${SAMPLE_FILE}")

echo "${OUTPUT}"

# Assertions
echo "Verifying tags..."
echo "${OUTPUT}" | grep -E "Sample.*module" > /dev/null || (echo "FAILED: Sample module tag missing" && exit 1)
echo "${OUTPUT}" | grep -E "Nat.*data" > /dev/null || (echo "FAILED: Nat data tag missing" && exit 1)
echo "${OUTPUT}" | grep -E "Describe.*interface" > /dev/null || (echo "FAILED: Describe interface tag missing" && exit 1)
echo "${OUTPUT}" | grep -E "Config.*record" > /dev/null || (echo "FAILED: Config record tag missing" && exit 1)
echo "${OUTPUT}" | grep -E "add.*type" > /dev/null || (echo "FAILED: add type tag missing" && exit 1)

echo "All Universal Ctags tests for Idris 2 passed successfully!"
