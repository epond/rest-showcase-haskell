{-# LANGUAGE OverloadedStrings #-}

module Main where

import Web.Scotty

import Data.Text.Lazy.Encoding
import Data.Text.Lazy

main = scotty 9000 $ do
  post "/basic" $ do
    rqBody <- body
    html $ (toUpper . decodeUtf8) rqBody
