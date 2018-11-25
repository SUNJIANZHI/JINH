module Investment
  ( investmentFlow
  )
  where

investmentFlow :: Double -> [Double] -> [Double]
investmentFlow rate = map (*rate)
