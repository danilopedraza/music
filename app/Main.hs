module Main (main) where

import Config (getConfig)
import System.Directory (canonicalizePath, doesFileExist)
import System.Environment (getArgs)
import System.FilePath (isValid)

main :: IO ()
main = do
  args <- getArgs
  case args of
    (arg : _) -> do
      res <- handleFilePath arg
      case res of
        Left err -> putStrLn $ "Error: " ++ err
        Right path -> do
            config <- getConfig path
            print config
    [] -> putStrLn "Please, pass the path of the config file as a command line argument."

handleFilePath :: String -> IO (Either String FilePath)
handleFilePath path
  | not (isValid path) = return $ Left "The config file path is not valid."
  | otherwise = do
      canonicalPath <- canonicalizePath path
      exists <- doesFileExist canonicalPath
      if exists
        then return $ Right canonicalPath
        else return $ Left "The config file path does not exist."
