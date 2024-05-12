//SPD=License-Identifier: MIT

pragma solidity ^0.8.18;

/**
 * @title A sample Raffle Contract
 * @author Todor Klasnakov
 * @notice This contract is for creating a sample raffle
 * @dev Implements Chainlink VRFv2
 */
contract Raffle {
    error Raffle__NotEnouhEtherSent();

    uint256 private immutable i_entranceFee;
    address payable[] private s_players;

    event EnteredRaffle(address indexed player);

    constructor(uint256 entranceFee) {
        i_entranceFee = entranceFee;
    }

    function enterRuffles() external payable {
        if (msg.value < i_entranceFee) {
            revert Raffle__NotEnouhEtherSent();
        }
        s_players.push(payable(msg.sender));
        emit EnteredRaffle({player: msg.sender});
    }

    function pickWinner() public {}

    function getEntranceFee() external view returns (uint256) {
        return i_entranceFee;
    }
}
