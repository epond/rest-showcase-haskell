module Main where

import Control.Monad
import Happstack.Server
import Happstack.Server.Types

main :: IO ()
main = simpleHTTP (nullConf { port = 9000}) $ msum
    [ dir "basic"    $ do method POST
                          basicHandler
    , dir "showcase" $ do method POST
                          showcaseHandler
    , seeOther "" "Usage: POST to either /basic or /showcase"
    ]

basicHandler :: ServerPart String
basicHandler = ok "Hello, basic!"

showcaseHandler :: ServerPart String
showcaseHandler = ok "Hello, showcase!"
