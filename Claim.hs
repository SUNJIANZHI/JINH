module Claim
  ( expectedClaim
  , expectedClaimTemplate
  , expectedClaimOfMort
  , expectedClaimOfMorb
  , expectedClaimOfLapse
  )
  where

expectedClaim :: [Double] -> [Double] -> Double -> [Double] -> Double -> [Double] -> Double -> [Double]
expectedClaim policyTable mortTable sumAssured morbTable benefit lapseTable surrender = zipWith3 (\x -> (\y -> (\z -> x + y + z))) mortClaim morbClaim lapseClaim
                                                                                    where
                                                                                      mortClaim = expectedClaimOfMort policyTable mortTable sumAssured
                                                                                      morbClaim = expectedClaimOfMorb policyTable morbTable benefit
                                                                                      lapseClaim = expectedClaimOfLapse policyTable lapseTable surrender

expectedClaimTemplate :: [Double] -> [Double] -> Double -> [Double]
expectedClaimTemplate policyTable decrementTable money = [0] ++ (map (*money) $ zipWith (*) policyTable decrementTable)

expectedClaimOfMort :: [Double] -> [Double] -> Double -> [Double]
expectedClaimOfMort policyTable mortTable sumAssured = expectedClaimTemplate policyTable mortTable sumAssured

expectedClaimOfMorb :: [Double] -> [Double] -> Double -> [Double]
expectedClaimOfMorb policyTable morbTable benefit = expectedClaimTemplate policyTable morbTable benefit

expectedClaimOfLapse :: [Double] -> [Double] -> Double -> [Double]
expectedClaimOfLapse policyTable lapseTable surrender = expectedClaimTemplate policyTable lapseTable surrender
