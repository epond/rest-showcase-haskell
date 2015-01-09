{-# LANGUAGE OverloadedStrings #-}

module ShowcaseSpec where

import Test.Hspec
import Showcase

spec :: Spec
spec = do
    describe "Showcase" $ do
        it "converts text to md5" $ do
            (textToMD5 "md5 me please") `shouldBe` "3A8A0599298E789DF9B33561A6AFD89F"

main :: IO ()
main = hspec spec