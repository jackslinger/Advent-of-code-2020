# Advent of Code Day 1

## What is Advent of code

Advent of code is an advent calendar of programming puzzles, with 2 puzzles released each day from Dec 1st to Dec 25th. Each puzzle is designed to be solved by writing some code to process the input and the instructions and produce an answer.

This will be the first year I've attempted Advent of code as the puzzles are released. Given my attempts at the 2019 puzzles I susspect that I won't be able to complete all of them, but hopefully I'll be able to complete a few and maybe learn something along the way.

## Part 1

The first puzzle is a simple one that will allow me to make sure I've got my environment setup and ready to go. I'm going to be solving each of these puzzles in Ruby as it's the language I'm most familliar and it's nicely suited to these kinds of challenges.

For the first part all we need to do is read a file of numbers, find the pair of numbers that sum to give 2020, and then multiply them together to get our answer. Luckily Ruby has a method called `permutation` that can give us all possible combinations of pairs of numbers. From there it's fairly simple to select the pair that sum to 2020 and then work out their product. This gives us our answer and our first star!

## Part 2

Part two asks us to find the **3** numbers that sum together to give 2020 and return their product. Looks like we where on the right track, all I need to do is change the input to the `permutation` method from 2 to 3, and we're good. There we go 2 star coins, tropical vacation here we come!