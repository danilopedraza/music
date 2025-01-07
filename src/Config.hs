{-# LANGUAGE DeriveGeneric #-}

module Config
  ( getConfig,
  )
where

import Data.Yaml (decodeFileEither, ParseException)
import GHC.Generics (Generic)
import qualified Data.Yaml as Y

newtype Config = Config
  { 
    musicDirPath :: FilePath
  }
  deriving (Show, Generic)

instance Y.FromJSON Config

getConfig :: FilePath -> IO (Either String Config)
getConfig path = do
  result <- decodeFileEither path
  case result of
    Left err -> return $ Left $ show err
    Right conf -> return $ Right conf
