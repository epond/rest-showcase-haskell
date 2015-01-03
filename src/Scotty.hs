{-# LANGUAGE OverloadedStrings #-}

module Main where

import Web.Scotty

import Data.Monoid (mconcat)
import qualified Data.Text.Lazy.Encoding as TE

main = scotty 3000 $ do
  post "" $ do
    rqBody <- body
    html $ mconcat ["<h1>Scotty, ", TE.decodeUtf8 rqBody, " me up!</h1>"]
