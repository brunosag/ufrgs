factorial :: Integer -> Integer
factorial = (map fac [0 ..] !!) . fromIntegral
  where
    fac 0 = 1
    fac n = n * factorial (n - 1)

choose :: Integer -> Integer -> Integer
choose n m = factorial n `div` (factorial (n - m) * factorial m)

maria :: Integer -> Integer
maria n = sum [(n - i) `choose` i | i <- [0 .. (n `div` 2)]]

main :: IO ()
main = interact $ unlines . map (show . maria . read) . takeWhile (/= "0") . lines
