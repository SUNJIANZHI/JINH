module Lapse
  ( LapseTable(..)
  , lapseFlowPerPolicy
  , expectedPoliciesInForceWithMorbLapse
  )
  where

import Mortalities

data LapseTable =
  LapseTable
    { year :: Int
    , rate :: Double
    }
    deriving (Show, Eq)

lapseFlowPerPolicy :: Int -> [LapseTable] -> [Double]
lapseFlowPerPolicy mode [] = []
lapseFlowPerPolicy mode lapseTable | mode == 1 = concat $ map (\x -> concat $ replicate 1 [0,0,0,0,0,0,0,0,0,0,0,x]) lapsesM
                                   | mode == 4 = concat $ map (\x -> concat $ replicate 4 [0,0,x]) lapsesM
                                   | mode == 12 = concat $ map (\x -> concat $ replicate 12 [x]) lapsesM
                                where
                                  lapsesM = map (\l -> 1 - (1 - Lapse.rate l) ** (1 / fromIntegral (mode))) lapseTable

expectedPoliciesInForceWithMorbLapse :: Double -> [Double] -> [Double] -> [Double] -> [Double]
expectedPoliciesInForceWithMorbLapse initial mortTable morbTable lapseTable = expectedPoliciesTemplate initial rate
                                                                            where rate = zipWith3 (\x -> (\y -> (\z -> x + y + z))) mortTable morbTable lapseTable
