module Main where
import qualified GHC.Utils.Misc as M

parseData :: String -> [[String]]
parseData = let f = M.split in map (f '-') .  f ','

isDouble :: Eq a => [a] -> Bool
isDouble xs = even n && uncurry (==) (splitAt (n `div` 2) xs)
    where n = length xs

partList _ [] = []
partList n xs = a : partList n b
    where (a,b) = splitAt n xs

allEqual (x:xs) = allEqualInternal xs x

allEqualInternal [] _ = True
allEqualInternal (x:xs) c =  x == c && allEqualInternal xs c

isAtleastDouble :: Eq a => [a] -> Bool
isAtleastDouble xs = (divisors n) /= [] &&  any (\t -> allEqual $ partList t xs) (divisors n)
    where n = length xs

divisors n = [x | x <- [1..n-1], n `rem` x == 0]

main :: IO ()
main = do
    c <- getContents >>= return . parseData
    let totalRanges = concatMap (\[x,y] -> [read x..read y]) c :: [Integer]
        s = let m = map (isAtleastDouble . show) totalRanges in sum $ map fst $ filter snd $ zip totalRanges m
        --xs = map (read . fst) $ filter snd (zip c m) :: [Integer]
    print s
