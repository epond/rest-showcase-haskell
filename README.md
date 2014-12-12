Haskell Rest Showcase
=================================

Basic
-----

`POST /basic`

Post a string in the request body and it will respond with the same string in uppercase

Showcase
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