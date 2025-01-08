import Data.Bits (shiftR, testBit)
import Text.Printf (printf)

modExp :: Integer -> Integer -> Integer -> Integer
modExp _ 0 _ = 1
modExp b e m = (if testBit e 0 then b else 1) * modExp (b * b `mod` m) (e `shiftR` 1) m `mod` m

hanoiMod24h :: Integer -> Integer
hanoiMod24h n = (modExp 2 n 86400 - 1) `mod` 86400

formatTime :: Integer -> String
formatTime seconds = printf "%02d:%02d:%02d" hh mm ss
  where
    hh = seconds `div` 3600
    mm = seconds `div` 60 `mod` 60
    ss = seconds `mod` 60

main :: IO ()
main = getLine >>= putStrLn . formatTime . hanoiMod24h . read
