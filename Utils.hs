module Utils
  ( replicateList
  , sublist
  , appendSublist
  , customScanl
  , timingAdjustment
  )
  where

-- replicateList 2 [1,3] = [1,1,3,3]
replicateList :: Int -> [a] -> [a]
replicateList n xs = concat $ map (replicate n) xs

-- sublist [1,2,3,4,5] 2 2 = [2,3]
sublist :: Int -> Int -> [a] -> [a]
sublist _ _ [] = []
sublist sIndex len xs = take len $ drop sIndex xs

--appendSublist [1,2,3,4,5] 2 = [(1,[0,0]), (2,[1,0]), (3,[2,1]), (4,[3,2]), (5,[4,3])]
appendSublist' :: [a] -> Int -> [(a,[a])]
appendSublist' [] num = []
appendSublist' (x:xs) num = (x, sublist 0 num xs) : appendSublist' xs num

appendSublist :: [Double] -> Int -> [(Double,[Double])]
appendSublist xs num = reverse $ take (length xs) (appendSublist' l num)
                    where
                      l = (reverse xs) ++ (replicate num 0)

-- a generic scanl
customScanl :: (b -> a -> [c] -> b) -> b -> [a] -> [c] -> [b]
customScanl = customScanlGo
  where
    customScanlGo :: (b -> a -> [c] -> b) -> b -> [a] -> [c] -> [b]
    customScanlGo f q ls1 ls2 = q : (case ls1 of
                                []   -> []
                                x:xs -> customScanlGo f (f q x ls2) xs ls2)

timingAdjustment :: [Double] -> [Double] -> [Double] -> Double -> [Double]
timingAdjustment deathRates claimRates lapseRates timing = [ (1-timing) * death + 1 / 3 * (claim * death + death * lapse) - 1/4 * (death * lapse * claim) | (death,claim,lapse) <- lists ]
  where lists = zip3 deathRates claimRates lapseRates
