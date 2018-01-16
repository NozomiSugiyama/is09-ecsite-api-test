#!/usr/bin/env stack
-- stack script --resolver lts-8.22
{-# LANGUAGE OverloadedStrings #-}
import           Control.Monad.IO.Class
import           Data.Aeson            (Value)
import qualified Data.ByteString.Char8 as S8
import qualified Data.Yaml             as Yaml
import           Network.HTTP.Simple

isSuccess :: Integral a => a -> Bool
isSuccess x
    | code >= 200 && code < 300 = True
    | otherwise                 = False
    where
        code = fromIntegral x

getResponseStatusCodeFromURL :: MonadIO m => [Char] -> m Bool
getResponseStatusCodeFromURL = (isSuccess . getResponseStatusCode) <$> (httpJSON . parseRequest_)

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

aa x = "a"

main :: IO ()
main = do
    print $ fmap (aa) testURLList

    -- response <- httpJSON "https://is09api.acqq.xyz/api/products"

    -- putStrLn $ "The status code was: " ++
    --            show (fromIntegral (getResponseStatusCode response) / 200)
    -- print $ getResponseHeader "Content-Type" response
    -- S8.putStrLn $ Yaml.encode (getResponseBody response :: Value)

