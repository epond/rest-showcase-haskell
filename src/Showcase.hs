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
    , defaultHandler
    ]

basicHandler :: ServerPart String
basicHandler = do req <- askRq
                  maybeBody <- takeRequestBody req
                  ok $ bodyToString maybeBody

bodyToString :: Maybe RqBody -> String
bodyToString body =
    case body of
        Just rqbody -> show . unBody $ rqbody
        Nothing     -> ""

showcaseHandler :: ServerPart String
showcaseHandler = ok "Hello, showcase!"

defaultHandler :: ServerPart String
defaultHandler = badRequest "Usage: POST to either /basic or /showcase"
