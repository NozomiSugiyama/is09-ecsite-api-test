#!/usr/bin/env stack
-- stack script --resolver lts-8.22
{-# LANGUAGE OverloadedStrings #-}

import           Control.Monad
import           Control.Monad.IO.Class
import qualified Data.Aeson             as Aeson
import qualified Data.ByteString.Char8
import qualified Data.Yaml
import qualified Network.HTTP.Simple    as HttpSimple

getResponse :: String -> IO (HttpSimple.Response (Either HttpSimple.JSONException Aeson.Value))
getResponse = HttpSimple.httpJSONEither . HttpSimple.parseRequest_

isSuccess :: (Ord a, Num a) => a -> Bool
isSuccess x
    | x >= 200 && x < 300 = True
    | otherwise           = False

testUrls :: [String]
testUrls = [ "https://is09api.acqq.xyz/api/products"
           , "https://is09api.acqq.xyz/api/products/1"
           , "https://is09api.acqq.xyz/api/products/2"
           , "https://is09api.acqq.xyz/api/products/3"
           , "https://is09api.acqq.xyz/api/products/4"
           , "https://is09api.acqq.xyz/api/products/5"
           , "https://is09api.acqq.xyz/api/products/6"
           , "https://is09api.acqq.xyz/api/products/7"
           , "https://is09api.acqq.xyz/api/products/8"
           , "https://api.ipify.org/?format=json"
           ]

main :: IO ()
main = print =<< mapM (fmap (isSuccess . fromIntegral . HttpSimple.getResponseStatusCode) . getResponse) testUrls
