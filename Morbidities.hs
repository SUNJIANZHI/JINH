module Morbidities
  ( MorbidityTable(..)
  , expectedPoliciesInForceWithMorb
  , ageMorbToMonthMorb
  )
  where

import Mortalities
import Utils

data MorbidityTable =
  MorbidityTable
    { age :: Int
    , rate :: Double
    }
    deriving (Show, Eq)

ageMorbToMonthMorb :: [MorbidityTable] -> [Double]
ageMorbToMonthMorb morbTable = map yearToMonth (replicateList 12 morbTable)
                              where yearToMonth = \record -> 1 - (1 - Morbidities.rate record) ** (1 / 12)

expectedPoliciesInForceWithMorb :: Double -> [Double] -> [Double] -> [Double]
expectedPoliciesInForceWithMorb initial mortTable morbTable = expectedPoliciesTemplate initial rate
                                                          where rate = zipWith (+) mortTable morbTable
