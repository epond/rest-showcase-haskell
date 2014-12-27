module Main where

import Control.Monad
import Data.Char (toLower)
import Happstack.Server

-- The simpleHTTP function listens for HTTP requests. Here is its type:
-- simpleHTTP :: (ToMessage a) => Conf -> ServerPartT IO a -> IO ()

-- The behaviour of msum is to try each ServerPartT in succession, until one succeeds.

-- path :: (FromReqURI a, MonadPlus m, ServerMonad m) => (a -> m b) -> m b

main :: IO ()
main = simpleHTTP (nullConf { port = 9000}) $ msum
    [ dir "hello"     $ path $ \subject -> ok $ sayHello subject
    , dir "greetings" $ greetingsHandler
    , dir "hellopart" $ helloHandler
    , dir "echo"      $ echoHandler
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

-- The type can also be expressed as ServerPartT IO String
helloHandler :: ServerPart String
helloHandler =
    do greeting <- look "greeting"
       noun     <- look "noun"
       ok $ greeting ++ ", " ++ noun

greetingsHandler :: ServerPart String
greetingsHandler = path $ \x -> ok $ "Greetings to " ++ x

-- Try adding askRq to get request then takeRequestBody to get the request body
-- askRq :: m Request
-- takeRequestBody :: MonadIO m => Request -> m (Maybe RqBody)
echoHandler :: ServerPart String
echoHandler =
    do request <- askRq                     -- :: Request
       maybeBody <- takeRequestBody request -- :: Maybe RqBody
       ok $ "echo " ++ bodyToString maybeBody

bodyToString :: Maybe RqBody -> String
bodyToString body =
    case body of
        Just rqbody -> "found body: " ++ (show . unBody $ rqbody)
        Nothing     -> "no body"
