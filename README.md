# DFA-Runner
A DFA runner! It reads a deterministic finite automaton info from a file and let it run, testing user input.

## Input
It reads a file that follows with it ("automata.txt"). This file is a structured input which contains the automaton data. Its structure follows:
* The starting state (it begins from 1)
* The acceptance states (separed with blank space)
* The machine's alphabet (separed with blank space)
* The transition function, which is:
* (current state) (destination if it reads the first element from alphabet) (destination if it reads the second element from alphabet)

## Execution
It just needs to run its main function, inside dfa.hs file. It's easy as running inside GHCI or:
```
runhaskell dfa.hs
```
