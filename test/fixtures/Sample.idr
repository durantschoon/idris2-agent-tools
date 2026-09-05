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
