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

    uint256 private constant REQUEST_CONFRIMATIONS = 3;
    uint256 private constant NUMBER_OF_WORDS = 1;

    uint256 private immutable i_entranceFee;
    uint256 private immutable i_interval;
    uint64 private immutable i_subscriptionId;
    address private immutable i_vrfCoordinator;
    bytes32 private immutable i_gasLine;
    uint32 private immutable i_callbackGasLimit;

    uint256 private s_lastTimstamp;
    address payable[] private s_players;

    event EnteredRaffle(address indexed player);

    constructor(
        uint256 entranceFee,
        uint256 interval,
        address vrfCoordinator,
        bytes32 gasLine /** keyHash */,
        uint64 subscriptionId,
        uint32 callbackGasLimit
    ) {
        i_entranceFee = entranceFee;
        i_interval = interval;
        i_vrfCoordinator = vrfCoordinator;
        i_gasLine = gasLine;
        i_subscriptionId = subscriptionId;
        i_callbackGasLimit = callbackGasLimit;
        s_lastTimstamp = block.timestamp;
    }

    function enterRuffles() external payable {
        if (msg.value < i_entranceFee) {
            revert Raffle__NotEnouhEtherSent();
        }
        s_players.push(payable(msg.sender));
        emit EnteredRaffle({player: msg.sender});
    }

    function pickWinner() public {
        if ((block.timestamp - s_lastTimstamp) < i_interval) {
            revert();
        }

        uint256 requestId = i_vrfCoordinator.requestRandomWords(
            i_gasLine,
            i_subscriptionId,
            REQUEST_CONFRIMATIONS,
            i_callbackGasLimit,
            NUMBER_OF_WORDS
        );
    }

    function getEntranceFee() external view returns (uint256) {
        return i_entranceFee;
    }
}
