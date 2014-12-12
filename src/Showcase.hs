module Main where

import Control.Monad
import Happstack.Server
import Happstack.Server.Types

main :: IO ()
main = simpleHTTP nullConf $ msum
    [ dir "basic"    $ do method POST
                          ok "Hello, basic!"
    , dir "showcase" $ do method POST
                          ok "Hello, showcase!"
    , seeOther "" "Usage: POST to either /basic or /showcase"
    ]
