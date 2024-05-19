# Proveable Random Raffle Contracts

## About

This code is to create a proveably random smart contact lottary.

## What we want to do?

1. Users can enter by paying for a ticket
    1. The ticket fees are going to go to the winner during the draw
2. After X period time, the lottary will automatically draw a winner
    1. And this will be done programatically
3. Using Chainlink VRF & Chainlink Automation
    1. Chainlink VRF -> Randomness
    2. Chainlink Automation -> Time based trigger

## Tests

1. Write deploy script
2. Write tests
    1. Work on a local chain
    2. Forked Testned
    3. Forked Mainnet