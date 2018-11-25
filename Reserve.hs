module Reserve
  ( reserveDiscount
  )
  where

staticReserveTemplate :: [Double] -> Double -> Double -> [Double]
staticReserveTemplate pl lastReserve interestRate = scanr f lastReserve pl
                                                  where f = \x -> (\y -> y / (1 + interestRate) + x )


reserveDiscount :: [Double] -> [Double] -> [Double] -> Double -> [Double]
reserveDiscount premium mortClaim morbClaim interestRate = staticReserveTemplate pl lastReserve interestRate
                                                        where
                                                          pl = init $ zipWith3 (\x-> \y-> (\z-> y + z - x)) premium mortClaim morbClaim
                                                          lastReserve = last mortClaim + last morbClaim - last premium
