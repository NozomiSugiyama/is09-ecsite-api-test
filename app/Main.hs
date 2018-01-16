#!/usr/bin/env stack
-- stack script --resolver lts-8.22
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE AllowAmbiguousTypes #-}

import           Control.Monad
import           Control.Monad.IO.Class
import           Data.Aeson            (Value)
import qualified Data.ByteString.Char8 as S8
import  Data.Yaml             as Yaml
import           Network.HTTP.Simple

isSuccess :: Integral a => a -> Bool
isSuccess x
    | code >= 200 && code < 300 = True
    | otherwise                 = False
    where
        code = fromIntegral x

getResponseStatusCodeFromURL :: String -> IO Int
getResponseStatusCodeFromURL x = getResponseStatusCode <$> ((httpJSON . parseRequest_) x :: IO (Response Value))

testURLList :: [[Char]]
testURLList = [
        "https://is09api.acqq.xyz/api/products",
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
    x <- isSuccess <$> getResponseStatusCodeFromURL "https://api.ipify.org/?format=json"

    print x
