#!/usr/bin/env stack
-- stack script --resolver lts-8.22
{-# LANGUAGE OverloadedStrings #-}
import           Data.Aeson            (Value)
import qualified Data.ByteString.Char8 as S8
import qualified Data.Yaml             as Yaml
import           Network.HTTP.Simple

responseStatusCodeIsSuccess :: Integral p => p -> Bool
responseStatusCodeIsSuccess responseStatusCode
    | code >= 200 && code < 300 = True
    | otherwise                 = False
    where
        code = fromIntegral responseStatusCode

-- -- getResponseStatusCodeFromResponse :: Response ->
getResponseStatusCodeFromURL = ((responseStatusCodeIsSuccess . getResponseStatusCode) <*> httpJSON) . parseRequest_ 

-- testAPIFromURL :: Monad m => [Char] -> m Bool
testAPIFromURL url = getResponseStatusCodeFromURL url

testURLList :: [[Char]]
testURLList = [
        "https://is09api.acqq.xyz/api/products"  ,
        "https://is09api.acqq.xyz/api/products/1",
        "https://is09api.acqq.xyz/api/products/2",
        "https://is09api.acqq.xyz/api/products/3",
        "https://is09api.acqq.xyz/api/products/4",
        "https://is09api.acqq.xyz/api/products/5",
        "https://is09api.acqq.xyz/api/products/6",
        "https://is09api.acqq.xyz/api/products/7",
        "https://is09api.acqq.xyz/api/products/8"
    ]

main :: IO ()
main = do
    print $ map getResponseStatusCodeFromURL testURLList

    -- response <- httpJSON "https://is09api.acqq.xyz/api/products"

    -- putStrLn $ "The status code was: " ++
    --            show (fromIntegral (getResponseStatusCode response) / 200)
    -- print $ getResponseHeader "Content-Type" response
    -- S8.putStrLn $ Yaml.encode (getResponseBody response :: Value)

