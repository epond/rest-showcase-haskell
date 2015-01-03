{-# LANGUAGE OverloadedStrings, DeriveGeneric #-}

module Main where

import Web.Scotty

import Data.Text.Lazy.Encoding
import Data.Text.Lazy
import Data.Aeson
import GHC.Generics

main = scotty 9000 $ do
  post "/basic" $ do
    rqBody <- body
    html $ (toUpper . decodeUtf8) rqBody

  post "/showcase" $ do
    rqBody <- body
    Web.Scotty.json $ ((showcaseHandler rqBody) :: MD5Response)

showcaseHandler x =
  case ((eitherDecode x) :: Either String MD5Request) of
    Right (MD5Request original) -> MD5Response (textToMD5 original) original
    Left  err                   -> MD5Response "n/a" (pack err)

textToMD5 :: Text -> Text
textToMD5 original = "MD5 goes here"

-- Type representing the input JSON message
data MD5Request =
  MD5Request { input :: Text
           } deriving (Show,Generic)

instance FromJSON MD5Request
instance ToJSON MD5Request

-- Type representing the JSON response message
data MD5Response =
  MD5Response { md5            :: Text
              , originalString :: Text
           } deriving (Show,Generic)

instance FromJSON MD5Response
instance ToJSON MD5Response
