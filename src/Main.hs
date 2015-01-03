{-# LANGUAGE DeriveDataTypeable, OverloadedStrings #-}

-- Taken from https://gist.github.com/folsen/5064951

module Main where

import qualified Data.ByteString.Lazy.Char8 as L
import Control.Monad.IO.Class (liftIO)
import Control.Monad (msum, mzero)
import Data.Data (Data, Typeable)
import Data.Maybe (fromJust)
import Data.Aeson
import Happstack.Server
import Happstack.Server.Types
import Control.Applicative ((<$>), (<*>))

main :: IO ()
main = simpleHTTP nullConf myApp

myPolicy :: BodyPolicy
myPolicy = (defaultBodyPolicy "/tmp/" 0 1000 1000)

myApp :: ServerPart Response
myApp = do decodeBody myPolicy
           msum [ dir "unit"   $ postUnit
                , dir "public" $ fileServing
                ]

fileServing :: ServerPart Response
fileServing =
  serveDirectory EnableBrowsing ["index.html"] "public/"

data Unit = Unit { x :: Int, y :: Int } deriving (Show, Eq, Data, Typeable)

instance FromJSON Unit where
  parseJSON (Object v) = Unit <$>
                         v .: "x" <*>
                         v .: "y"
  parseJSON _ = mzero

instance ToJSON Unit where
  toJSON (Unit x y) = object ["x" .= x, "y" .= y]

getBody :: ServerPart L.ByteString
getBody = do
    req  <- askRq
    body <- liftIO $ takeRequestBody req
    case body of
        Just rqbody -> return . unBody $ rqbody
        Nothing     -> return ""

postUnit :: ServerPart Response
postUnit = do
  body <- getBody
--  ok $ toResponse (show body)
  case decode body :: Maybe Unit of
    Just unit -> ok $ toResponse $ encode $ unit {x = x unit + 1 }
    Nothing   -> badRequest $ toResponse $ ("Could not parse" :: String)
