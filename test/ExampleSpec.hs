module ExampleSpec where

import Test.Hspec

spec :: Spec
spec = do
  describe "The thing under test" $ do
    context "You can describe additional context here" $ do
      it "can be tested using equality" $ do
        head [23 ..] `shouldBe` (23 :: Int)
      it "can be tested using a predicate" $ do
        [1,2,3] `shouldSatisfy` (not . null)
      it "does something that is not yet implemented" $ do
        pending
      it "does something that is not yet implemented, with explanation" $ do
        pendingWith "this feature needs x"


main :: IO ()
main = hspec spec

