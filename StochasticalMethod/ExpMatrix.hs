module JointLife
    ( pMatrix
    ) where

import Numeric.LinearAlgebra
import Prelude hiding ((<>))
--This file offer a more abstract, high level continous probability solver.

testMatrix :: Matrix Double
testMatrix = (3><3) [-0.03,0.01,0.02,0.03,-0.05,0.02,0,0,0]


pMatrix :: Matrix Double -> Complex Double -> Matrix (Complex Double)
pMatrix m scalar = v <> (diag (cmap (\x -> exp (x * scalar)) l)) <> (inv v)
  where (l, v) = eig m
