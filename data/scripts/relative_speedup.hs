#!/usr/bin/env stack
-- stack --resolver lts-7.15 --install-ghc runghc --package cassava

{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE OverloadedStrings #-}

import Control.Applicative
import qualified Data.ByteString.Lazy as BL
import qualified Data.ByteString.Lazy.Char8 as BLC
import Data.Csv
import qualified Data.Vector as V
import qualified Data.Map as M
import System.Environment
import Data.List

handlev :: V.Vector (BL.ByteString,BL.ByteString,Int,Int,Double)
        -> V.Vector (BL.ByteString,BL.ByteString,Int,Int,Double)
        -> [(Int,Double)]
handlev v1 v2 =
    let (m1,m2) = (m v1, m v2)
        args = M.keys m1
        m v = M.fromList $ map (\(_na,_va,ar,_it,me) -> (ar,me)) $ V.toList v
        diff = map (\arg -> (arg, (M.findWithDefault 0 arg m1) /
                                  (M.findWithDefault 0 arg m2)))
               args
    in diff

main :: IO ()
main = do
  [arg1,arg2] <- getArgs
  baseline <- BL.readFile arg1
  otherdata <- BL.readFile arg2
  case (decode NoHeader baseline, decode NoHeader otherdata) of
    (Right v1, Right v2) -> BLC.putStrLn $ encode $ handlev v1 v2
    _ -> putStrLn "Error parsing csv"
