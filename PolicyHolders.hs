module PolicyHolders
  ( PolicyHolder(..)
  )
  where

data PolicyHolder =
  PolicyHolder
    { policyId :: Int
    , ageEntry :: Int
    , sex :: Char
    , smokeStatus :: Char
    , durationM :: Int
    , policyTermM :: Int
    , premium :: Double
    , sumAssd :: Double
    , interestRate :: Double
    , discountRate :: Double
    , lapseMode :: Int
    }
    deriving (Show, Eq)
