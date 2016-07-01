-- DFA runner!
-- It reads a deterministic finite automaton info from a file and let it run, testing user input
-- The file is organized this way:
-- The starting state (it begins from 1)
-- The acceptance states (separed with blank space)
-- The machine's alphabet (separed with blank space)
-- The transition function, which is:
-- (current state) (destination if it reads the first element from alphabet) (destination if it reads the second element from alphabet) ... 

import System.IO
import Control.Monad
import Data.Char

-- A helper function to parse a Int from a String
toInt :: String -> Int
toInt = read

-- splits a string by a given char, returning a list of Strings
split :: String -> Char -> [String]
split [] delim = [""]
split (c:cs) delim
    | c == delim = "" : rest
    | otherwise = (c : head rest) : tail rest
    where
        rest = split cs delim

-- gets the index of an element inside a list
index :: (Eq a) => a -> [a] -> Int
index _ [] = error "Element not in list"
index element (h:t)
    | element == h = 0
    | otherwise = 1 + (index element t)

-- it repeats forever, getting user input and running its computation
prepare :: [Int] -> [[Int]] -> Int -> [Int] -> IO ()
prepare alphabet transitions start endings = forever $ do
    putStrLn "Ready!"
    input <- getLine
    run input alphabet transitions endings start

-- the computation itself, moving around the DFA
-- when the input ends, it tells the response
run :: String -> [Int] -> [[Int]] -> [Int] -> Int -> IO ()
run [] _ _ endings current 
    | elem current endings = putStrLn "Accepted!"
    | otherwise = putStrLn "Rejected!"
run (h:t) alphabet transitions endings current = (run t alphabet transitions endings $ 
    match (digitToInt h) alphabet transitions current)
    where match _ _ [] _ = error "Incomplete table. Go and fix that!"
          match input a (h:t) c
              | (head h) == c = (tail h)!!(index input a)
              | otherwise = match input a t c

-- it gets file information and passes to the prepare function
main = do
    putStrLn "Oh, hi!"
    putStrLn "I will read the automata.txt file and construct a DFA with its information..."
    handle <- openFile "automata.txt" ReadMode
    putStrLn "..."
    start <- hGetLine handle
    putStrLn "..."
    endings <- hGetLine handle
    putStrLn "..."
    alphabet <- hGetLine handle
    putStrLn "..."
    transitions <- hGetContents handle
    putStrLn "I'm done with that, let's play!"
    putStrLn "It's easy, just insert a input and I'll say if it accepts your word!"
    putStrLn "I think it's a lot of fun. So I'll repeat it forever!"
    putStrLn "If you want to stop, just ctrl+c me."
    (prepare (translate alphabet)
             (map translate $ split transitions '\n')
             (toInt start)
             (translate endings))
    hClose handle
    where translate t = map toInt $ words t