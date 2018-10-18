Running haskell from REPL
===

* Open a REPL:

```[bash]
stack ghci
```

* Load a script filename.hs:

```[haskell]
Prelude> :l filename
```

* Reload on changes

```[haskell]
Prelude> :r
```

* Run a .hs file as a script

```[haskell]
Prelude> :script filename.hs
```


* Exit ghci

```[haskell]
Prelude> :q
```