primeWheel :: [Int]
primeWheel = [6 * k + r | k <- [1 ..], r <- [-1, 1]]

isPrime :: Int -> Bool
isPrime n
    | n < 2 = False
    | n == 2 = True
    | n == 3 = True
    | even n = False
    | n `mod` 3 == 0 = False
    | otherwise = not $ any (divides n) candidates
  where
    sqrtN = floor . sqrt . fromIntegral $ n
    candidates = takeWhile (<= sqrtN) primeWheel
    divides n x = n `mod` x == 0

primesUnder2500 :: [Int]
primesUnder2500 = 2 : 3 : filter isPrime [5, 7 .. 2500]

isPrimeUnder2500 :: Int -> Bool
isPrimeUnder2500 n
    | n < 2 || n > 2500 = False
    | otherwise = n `elem` primesUnder2500

choose :: Int -> Int -> Int
choose n k
    | k > n = 0
    | k == 0 = 1
    | k > n `div` 2 = n `choose` (n - k)
    | otherwise = product [n - k + 1 .. n] `div` product [1 .. k]

loteria :: Int -> Int -> Int -> Int
loteria n m k = sum $ map (\list -> countNonPrimes list `choose` k) list
  where
    countNonPrimes = length . filter (not . isPrimeUnder2500)
    list
        | k == 1 = rows
        | n >= k && m >= k = rows ++ cols
        | n >= k = rows
        | m >= k = cols
        | otherwise = []
    rows = [[i * m + j | j <- [0 .. m - 1]] | i <- [0 .. n - 1]]
    cols = [[i * m + j | i <- [0 .. n - 1]] | j <- [0 .. m - 1]]

processLine :: String -> IO ()
processLine line = print (loteria n m k)
  where
    [n, m, k] = map read (words line)

main :: IO ()
main = do
    input <- getContents
    mapM_ processLine $ takeWhile (/= "0 0 0") (lines input)
