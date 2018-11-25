module Tax
  ( taxFlow
  )
  where

taxFlow :: Double -> [Double] -> [Double]
taxFlow taxRate = map (*taxRate)
