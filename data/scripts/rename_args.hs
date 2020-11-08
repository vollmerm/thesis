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

handlev :: V.Vector (BL.ByteString,BL.ByteString,BL.ByteString,Int,Double)
        -> [(BL.ByteString,BL.ByteString,Int,Int,Double)]
handlev v = V.toList $ V.map (\(a1,a2,arg,it,me) -> (a1,a2,f arg,it,me)) v
    where f a = case a of
                  " mega_100.sexp" -> 38801988
                  " mega_10.sexp" -> 10352315
                  " mega_1.sexp" -> 1428807
                  " mega_4456.sexp" -> 102825384
                  " mega_500.sexp" -> 72522369
                  " mega_50.sexp" -> 28623064
                  " mega_5.sexp" -> 5538243
                  " mega1_50.gpkd" -> 71440252
                  " mega1_5.gpkd" -> 7144027
                  " mega1_10.gpkd" -> 14288052
                  " mega1_1.gpkd" -> 1428807
                  " ./share/pkgs/typed-racket-lib/typed-racket/base-env/base-env.rkt.out.gpkd" -> 799391
                  " ./share/pkgs/redex-examples/redex/examples/racket-machine/verification.rkt.out.gpkd" -> 361148
                  " ./share/pkgs/redex-lib/redex/private/pat-unify.rkt.out.gpkd" -> 181828
                  " ./collects/racket/match/legacy-match.rkt.out.gpkd" -> 91001
                  " ./share/pkgs/drracket/drracket/private/app.rkt.out.gpkd" -> 45085
                  " ./share/pkgs/redex-benchmark/redex/benchmark/models/rvm/util.rkt.out.gpkd" -> 22466
                  " ./share/pkgs/games/tally-maze/state.rkt.out.gpkd" -> 11277
                  " ./share/pkgs/data-enumerate-lib/data/enumerate/private/unfair.rkt.out.gpkd" -> 5761
                  " ./share/pkgs/drracket/browser/private/sig.rkt.out.gpkd" -> 2830
                  " ./share/pkgs/htdp-lib/htdp/color-structs.rkt.out.gpkd" -> 1408
                  " ./share/pkgs/web-server-lib/web-server/default-web-root/htdocs/servlets/examples/template-compat0.rkt.out.gpkd" -> 705
                  " ./share/pkgs/htdp-lib/stepper/private/xml-sig.rkt.out.gpkd" -> 350
                  " ./share/pkgs/racket-doc/scribblings/foreign/com-common.rkt.out.gpkd" -> 175
                  " ./share/pkgs/dynext-lib/dynext/private/dirs.rkt.out.gpkd" -> 86
                  " ./share/pkgs/web-server-lib/web-server/web-server-sig.rkt.out.gpkd" -> 44

main :: IO ()
main = do
  [arg1] <- getArgs
  csvd <- BL.readFile arg1
  case decode HasHeader csvd of
    Right v -> BLC.putStrLn $ encode $ handlev v
    _ -> putStrLn "Error parsing csv"
