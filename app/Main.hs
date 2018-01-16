#!/usr/bin/env stack
-- stack script --resolver lts-8.22
{-# LANGUAGE OverloadedStrings #-}

import           Control.Monad
import           Control.Monad.IO.Class
import qualified Data.Aeson             as Aeson
import qualified Data.ByteString.Char8
import qualified Data.Yaml
import qualified Network.HTTP.Simple    as HttpSimple

get :: String -> IO (HttpSimple.Response Aeson.Value)
get = HttpSimple.httpJSON . HttpSimple.parseRequest_

responseStatusCode = HttpSimple.getResponseStatusCode

isSuccess :: Integral a => a -> Bool
isSuccess x
    | code >= 200 && code < 300 = True
    | otherwise                 = False
    where
        code = fromIntegral x

testUrls :: [String]
testUrls = [
        "https://is09api.acqq.xyz/api/products",
        "https://is09api.acqq.xyz/api/products/1",
        "https://is09api.acqq.xyz/api/products/2",
        "https://is09api.acqq.xyz/api/products/3",
        "https://is09api.acqq.xyz/api/products/4",
        "https://is09api.acqq.xyz/api/products/5",
        "https://is09api.acqq.xyz/api/products/6",
        "https://is09api.acqq.xyz/api/products/7",
        "https://is09api.acqq.xyz/api/products/8",
        "https://api.ipify.org/?format=json"
    ]

main :: IO ()
main = do
     results <- mapM get testUrls

     print $ (isSuccess . responseStatusCode) <$> results
