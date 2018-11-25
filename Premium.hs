module Premium
  ( expectedPremiumFlow
  , premiumPerPolicyFlow
  , premiumPerPolicyFlow2
  )
  where

import Utils

expectedPremiumFlow :: [Double] -> [Double] ->[Double]
expectedPremiumFlow xs ys = zipWith (*) xs ys

premiumPerPolicyFlow :: Int -> Double -> [Double]
premiumPerPolicyFlow policyTermM premium = premiumperPolicy ++ [0] -- time adjustment for the last day
                                          where
                                            premiumperPolicy = concat $ replicate (policyTermM `div` 12) [premium,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]

premiumPerPolicyFlow2 :: Int -> Int -> Double -> [Double]
premiumPerPolicyFlow2 mode policyTermM premium = premPerPolicy mode ++ [0]
                                                where
                                                  premPerPolicy mode | mode == 1 = concat $ replicate (policyTermM `div` 12) [premium,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]
                                                                     | mode == 4 = concat $ replicate (policyTermM `div` 4) [premium,0.0,0.0]
                                                                     | mode == 12 = concat $ replicate (policyTermM `div` 1) [premium]
