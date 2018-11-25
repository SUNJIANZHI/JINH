{-# LANGUAGE OverloadedStrings #-}

module DataLoader
  ( loadPolicyHolder
  , loadMortalityMTables
  , loadMortalityFTables
  , loadMorbidityMTables
  , loadMorbidityFTables
  , loadLapseTable
  )
  where

-- Hackages
import qualified Data.ByteString.Lazy as BL
import qualified Data.Vector as V
import Data.Csv

-- Custom module
import PolicyHolders
import Mortalities
import Morbidities
import Lapse

instance FromNamedRecord PolicyHolder where
  parseNamedRecord r =
    PolicyHolder
      <$> r .: "POL_ID"
      <*> r .: "AGE_AT_ENTRY"
      <*> r .: "SEX"
      <*> r .: "SMOKE_STATUS"
      <*> r .: "DUR_M"
      <*> r .: "POL_TERM_M"
      <*> r .: "PREMIUM"
      <*> r .: "SUM_ASSD"
      <*> r .: "RISK_FREE_INTEREST_RATE"
      <*> r .: "MONTHLY_DISCOUNT_RATE"
      <*> r .: "LAPSE_MODE"

loadPolicyHolder :: IO [PolicyHolder]
loadPolicyHolder = do
  csvData <- BL.readFile "Data/Policy/Policy.csv"
  case decodeByName csvData of
    Left err -> return []
    Right (_, v) -> return $ V.toList v

instance FromNamedRecord MortalityTable where
  parseNamedRecord r =
    MortalityTable
    <$> r .: "Age"
    <*> r .: "Rate"

loadMortalityMTables :: IO [MortalityTable]
loadMortalityMTables = do
  csvData <- BL.readFile "Data/MMRate/Male.csv"
  case decodeByName csvData of
    Left err -> do return []
    Right (_, v) -> return $ V.toList v

loadMortalityFTables :: IO [MortalityTable]
loadMortalityFTables = do
  csvData <- BL.readFile "Data/MMRate/Female.csv"
  case decodeByName csvData of
    Left err -> return []
    Right (_, v) -> return $ V.toList v

instance FromNamedRecord MorbidityTable where
  parseNamedRecord r =
    MorbidityTable
    <$> r .: "Age"
    <*> r .: "Rate"

loadMorbidityMTables :: IO [MorbidityTable]
loadMorbidityMTables = do
  csvData <- BL.readFile "Data/MBRate/Male.csv"
  case decodeByName csvData of
    Left err -> do return []
    Right (_, v) -> return $ V.toList v

loadMorbidityFTables :: IO [MorbidityTable]
loadMorbidityFTables = do
  csvData <- BL.readFile "Data/MBRate/Female.csv"
  case decodeByName csvData of
    Left err -> return []
    Right (_, v) -> return $ V.toList v

instance FromNamedRecord LapseTable where
  parseNamedRecord r =
    LapseTable
    <$> r .: "POLICY_Y"
    <*> r .: "Rate"

loadLapseTable :: IO [LapseTable]
loadLapseTable = do
  csvData <- BL.readFile "Data/Lapse/Lapse.csv"
  case decodeByName csvData of
    Left err -> return []
    Right (_, v) -> return $ V.toList v
