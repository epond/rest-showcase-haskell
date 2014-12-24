Haskell Rest Showcase
=================================

So this is not complete yet. It doesn't conform with the other REST showcases. I'm still getting to grips with Haskell
and its web frameworks. Happstack seems an ok starting point but that might change because Yesod looks pretty cool,
but it has a ton of boilerplate, and I haven't looked at Snap yet.

ps. I love Haskell!!!

Build and run
-----

`cabal run` will build the module and run it. It may give a message telling you what dependencies need to be installed first using `cabal install`.

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