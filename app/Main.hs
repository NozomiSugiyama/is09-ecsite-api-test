#!/usr/bin/env stack
-- stack script --resolver lts-8.22
{-# LANGUAGE OverloadedStrings #-}
import           Data.Aeson            (Value)
import qualified Data.ByteString.Char8 as S8
import qualified Data.Yaml             as Yaml
import           Network.HTTP.Simple

main :: IO ()
main = do
    response <- httpJSON "https://is09api.acqq.xyz/api/products"

    putStrLn $ "The status code was: " ++
               show (fromIntegral (getResponseStatusCode response) / 200)
    print $ getResponseHeader "Content-Type" response
    S8.putStrLn $ Yaml.encode (getResponseBody response :: Value)
