module Main where


rot :: (Char, Int) -> Int -> Int
rot (dir, s) curr = let t = (curr `op` s)  `mod` 100 in if t < 0 then t + 100 else t
    where op = if dir == 'L' then (-) else (+)

allSteps :: (Char, Int) -> Int -> [Int]
allSteps (dir, s) curr = take s $ iterate (rot (dir, 1)) curr

parse :: String -> [(Char, Int)]
parse s = map (\w -> (head w, read $ tail w)) $ lines s
 
main :: IO ()
main = do
    c <- getContents 
    let parsed = parse c
    --print $ sum $ map (\x -> if x == 0 then 1 else 0) $ scanl (flip rot) 50 parsed
    print . sum . map (fromEnum . (==0)) $ concatMap (uncurry allSteps) (zip parsed (scanl (flip rot) 50 parsed))
