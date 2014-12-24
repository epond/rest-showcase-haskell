module Main where

import Control.Monad
import Happstack.Server
import Happstack.Server.Types
import Data.Char (toLower)

-- The simpleHTTP function listens for HTTP requests. Here is its type:
-- simpleHTTP :: (ToMessage a) => Conf -> ServerPartT IO a -> IO ()

-- The behaviour of msum is to try each ServerPartT in succession, until one succeeds.

main :: IO ()
main = simpleHTTP (nullConf { port = 9000}) $ msum
    [ dir "hello"     $ path $ \subject -> ok $ sayHello subject
    , dir "greetings" $ path $ \subject -> ok $ doSomethingWith subject
    , seeOther "" "Request not recognised"
    ]

data Subject = World | Haskell

sayHello :: Subject -> String
sayHello World = "Hello, World!"
sayHello Haskell = "Greetings, Haskell!"

instance FromReqURI Subject where
    fromReqURI sub =
        case map toLower sub of
            "haskell" -> Just Haskell
            "world"   -> Just World
            _         -> Nothing

doSomethingWith :: String -> String
doSomethingWith x = "I'm doing something with " ++ x