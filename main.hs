{-# LANGUAGE OverloadedStrings #-}

import DataLoader
import PolicyHolders
import Mortalities
import Morbidities
import Premium
import Lapse
import Claim
import Reserve
import Utils

-- Timer
import Control.Exception
import Formatting
import Formatting.Clock
import System.Clock

main :: IO ()
main = do start <- getTime Monotonic
          p <- DataLoader.loadPolicyHolder
          loopList p
          end <- getTime Monotonic
          fprint (timeSpecs % "\n") start end
          return ()

loopList [] = putStr "end\n"
loopList (x:xs) = do  l <- DataLoader.loadLapseTable
                      let policyHolder = x
                      let policyTermMonth = policyTermM policyHolder
                      m <- readMortTable policyHolder
                      mb <- readMorbTable policyHolder
                      let mortalityTable = sublist (ageEntry policyHolder) (policyTermMonth `div` 12) m
                      -- putStr $ show mortalityTable
                      let monthlyTable = ageMortToMonthMort mortalityTable
                      -- putStr $ show $ length monthlyTable
                      --Morbidity table
                      let morbidityTable = sublist (ageEntry policyHolder) (policyTermMonth `div` 12) mb
                      -- putStr $ show mortalityTable
                      let monthlyTable_Morb = ageMorbToMonthMorb morbidityTable
                      -- putStr $ show $ length monthlyTable
                      let lapseTable = take (policyTermMonth `div` 12) l
                      -- putStr $ show lapseTable
                      let lapseFlow = lapseFlowPerPolicy (lapseMode policyHolder) lapseTable
                      -- putStr $ show lapseFlow
                      let policyFlow = expectedPoliciesInForceWithMorbLapse 1 monthlyTable monthlyTable_Morb lapseFlow
                      --putStr $ show policyFlow
                      --putStr $ "\n"
                      let premPerPolicy = premiumPerPolicyFlow policyTermMonth (premium policyHolder)
                      --putStr $ show  premPerPolicy
                      --putStr $ "\n"
                      let premiumFlow = expectedPremiumFlow policyFlow premPerPolicy
                      -- putStr $ show premiumFlow
                      -- putStr $ "\n"
                      let claim = expectedClaim policyFlow monthlyTable (sumAssd policyHolder) monthlyTable_Morb 100 lapseFlow 0.0
                      --putStr $ show claim
                      --putStr $ "\n"
                      let mortClaim = expectedClaimOfMort policyFlow monthlyTable (sumAssd policyHolder)
                      let morbClaim = expectedClaimOfMorb policyFlow monthlyTable_Morb 100
                      let reserve = reserveDiscount premiumFlow mortClaim morbClaim 0.00426532
                      putStr $ "Reserve in month \n"
                      putStr $ show reserve
                      return ()
                      --putStr "-----------------------------"
                      loopList xs

--A demo of a 5 year term
singleTest :: IO ()
singleTest = do p <- DataLoader.loadPolicyHolder
                l <- DataLoader.loadLapseTable
                let policyHolder = head p
                let policyTermMonth = policyTermM policyHolder
                m <- readMortTable policyHolder
                mb <- readMorbTable policyHolder
                let mortalityTable = sublist (ageEntry policyHolder) (policyTermMonth `div` 12) m
                -- putStr $ show mortalityTable
                let monthlyTable = ageMortToMonthMort mortalityTable
                -- putStr $ show $ length monthlyTable
                let morbidityTable = sublist (ageEntry policyHolder) (policyTermMonth `div` 12) mb
                -- putStr $ show mortalityTable
                let monthlyTable_Morb = ageMorbToMonthMorb morbidityTable
                --putStr $ show monthlyTable_Morb
                --putStr $ "\n"
                let lapseTable = take (policyTermMonth `div` 12) l
                -- putStr $ show lapseTable
                let lapseFlow = lapseFlowPerPolicy (lapseMode policyHolder) lapseTable
                -- putStr $ show lapseFlow
                let policyFlow = expectedPoliciesInForceWithMorbLapse 1 monthlyTable monthlyTable_Morb lapseFlow
                --putStr $ show policyFlow
                let premPerPolicy = premiumPerPolicyFlow policyTermMonth (premium policyHolder)
                --putStr $ show  premPerPolicy
                --putStr $ "\n"
                let premiumFlow = expectedPremiumFlow policyFlow premPerPolicy
                -- putStr $ show premiumFlow
                -- putStr $ "\n"
                let claim = expectedClaim policyFlow monthlyTable (sumAssd policyHolder) monthlyTable_Morb 100 lapseFlow 0.0
                --putStr $ show claim
                --putStr $ "\n"
                let mortClaim = expectedClaimOfMort policyFlow monthlyTable (sumAssd policyHolder)
                --putStr $ show mortClaim
                --putStr $ "\n"
                let morbClaim = expectedClaimOfMorb policyFlow monthlyTable_Morb 100
                --putStr $ show morbClaim
                let reserve = reserveDiscount premiumFlow mortClaim morbClaim 0.00426532
                putStr $ show reserve
                return()


endowmentTest :: IO ()
endowmentTest =  do p <- DataLoader.loadPolicyHolder
                    l <- DataLoader.loadLapseTable
                    let policyHolder = head p
                    let policyTermMonth = policyTermM policyHolder
                    m <- readMortTable policyHolder
                    mb <- readMorbTable policyHolder
                    let mortalityTable = sublist (ageEntry policyHolder) (policyTermMonth `div` 12) m
                    -- putStr $ show mortalityTable
                    let monthlyTable = ageMortToMonthMort mortalityTable
                    -- putStr $ show $ length monthlyTable
                    let morbidityTable = sublist (ageEntry policyHolder) (policyTermMonth `div` 12) mb
                    -- putStr $ show mortalityTable
                    let monthlyTable_Morb = replicate policyTermMonth 0
                    --putStr $ show monthlyTable_Morb
                    --putStr $ "\n"
                    let lapseTable = take (policyTermMonth `div` 12) l
                    -- putStr $ show lapseTable
                    let lapseFlow = lapseFlowPerPolicy (lapseMode policyHolder) lapseTable
                    -- putStr $ show lapseFlow
                    let policyFlow = expectedPoliciesInForceWithMorbLapse 1 monthlyTable monthlyTable_Morb lapseFlow
                    --putStr $ show policyFlow
                    let premPerPolicy = premiumPerPolicyFlow policyTermMonth (premium policyHolder)
                    --putStr $ show  premPerPolicy
                    --putStr $ "\n"
                    let premiumFlow = expectedPremiumFlow policyFlow premPerPolicy
                    -- putStr $ show premiumFlow
                    -- putStr $ "\n"
                    let claim = expectedClaim policyFlow monthlyTable (sumAssd policyHolder) monthlyTable_Morb 100 lapseFlow 0.0
                    --putStr $ show claim
                    --putStr $ "\n"
                    let mortClaim = expectedClaimOfMort policyFlow monthlyTable (sumAssd policyHolder)
                    --putStr $ show mortClaim
                    --putStr $ "\n"
                    let morbClaim = expectedClaimOfMorb policyFlow monthlyTable_Morb 100
                    --putStr $ show morbClaim
                    let reserve = reserveDiscount premiumFlow mortClaim morbClaim 0.00426532
                    putStr $ show reserve
                    return()


readMortTable policyHolder =
  case sex policyHolder of
       'M' -> DataLoader.loadMortalityMTables
       'F' -> DataLoader.loadMortalityFTables


readMorbTable policyHolder =
 case sex policyHolder of
      'M' -> DataLoader.loadMorbidityMTables
      'F' -> DataLoader.loadMorbidityFTables
