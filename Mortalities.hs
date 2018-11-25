module Mortalities
  ( MortalityTable(..)
  , ageMortToMonthMort
  , expectedPoliciesTemplate
  , expectedPoliciesWeightedTemplate
  , expectedPoliciesInForce
  )
  where

import Utils

data MortalityTable =
  MortalityTable
    { age :: Int
    , rate :: Double
    }
    deriving (Show, Eq)

ageMortToMonthMort :: [MortalityTable] -> [Double]
ageMortToMonthMort mortTable = map yearToMonth (replicateList 12 mortTable)
                               where yearToMonth = \record -> 1 - (1 - rate record) ** (1 / 12)

expectedPoliciesTemplate :: Double -> [Double] -> [Double]
expectedPoliciesTemplate initial rate = scanl f initial rate
                                        where f = \base -> (\x -> base * (1 - x))

expectedPoliciesWeightedTemplate :: Double -> [Double] -> [Double] -> [Double]
expectedPoliciesWeightedTemplate initial rate weight = customScanl op initial r weight
                                                       where
                                                         r :: [(Double,[Double])]
                                                         r = appendSublist rate (length weight)
                                                         op :: Double -> (Double,[Double]) -> [Double] -> Double
                                                         op initial (r,prevR) weight = initial * (1 - (sum $ zipWith (*) weight (r:prevR)))

expectedPoliciesInForce :: Double -> [Double] -> [Double]
expectedPoliciesInForce initial mortTable = expectedPoliciesTemplate initial mortTable
