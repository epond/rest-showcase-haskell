Haskell Rest Showcase
=================================

Build and run
-----

`cabal run` will build the module and run it. It may give a message telling you what dependencies need to be installed
first using `cabal install`.

`cabal repl` will fire up a repl with the project loaded so you can do things like check types and generally poke around.

Basic Endpoint
-----

`POST /basic`

Post a string in the request body and it will respond with the same string in uppercase

Showcase Endpoint
--------

`POST /showcase`

Post json in the request body like the following:

```
{
    "input": "md5 me please"
}
```

and it will return json containing an MD5 hash and the original string:

```
{
    "md5": "3A8A0599298E789DF9B33561A6AFD89F",
    "originalString": "md5 me please"
}
```