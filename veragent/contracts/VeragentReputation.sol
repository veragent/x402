// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/**
 * @title VeragentReputation
 * @notice Optional reputation anchoring contract for Veragent Protocol
 *
 * This contract is intentionally minimal.
 * It does NOT enforce scoring logic.
 * It only anchors reputation signals via events.
 *
 * RFC: 0006 — Agent Reputation & Scoring
 *
 * Design Principles:
 * - Registry is canonical identity layer
 * - Reputation is modular and replaceable
 * - No trust assumptions embedded
 * - No execution gating
 */

contract VeragentReputation {
    /*//////////////////////////////////////////////////////////////
                               EVENTS
    //////////////////////////////////////////////////////////////*/

    /**
     * @notice Emitted when reputation is updated for an agent
     * @param agentId The bytes32 identifier of the agent
     * @param score Aggregated reputation score
     * @param totalObservations Number of observations used
     */
    event ReputationUpdated(
        bytes32 indexed agentId,
        uint256 score,
        uint256 totalObservations
    );

    /**
     * @notice Optional granular signal event
     * @param agentId The agent identifier
     * @param reviewer The entity submitting signal
     * @param scoreDelta Signed delta contribution
     */
    event ReputationSignal(
        bytes32 indexed agentId,
        address indexed reviewer,
        int256 scoreDelta
    );

    /*//////////////////////////////////////////////////////////////
                               STORAGE
    //////////////////////////////////////////////////////////////*/

    // Optional lightweight cache (NOT canonical)
    mapping(bytes32 => uint256) public latestScore;
    mapping(bytes32 => uint256) public latestObservations;

    address public owner;

    /*//////////////////////////////////////////////////////////////
                               MODIFIERS
    //////////////////////////////////////////////////////////////*/

    modifier onlyOwner() {
        require(msg.sender == owner, "NOT_AUTHORIZED");
        _;
    }

    /*//////////////////////////////////////////////////////////////
                               CONSTRUCTOR
    //////////////////////////////////////////////////////////////*/

    constructor() {
        owner = msg.sender;
    }

    /*//////////////////////////////////////////////////////////////
                        REPUTATION ANCHORING
    //////////////////////////////////////////////////////////////*/

    /**
     * @notice Anchor aggregated reputation
     * @dev Scoring logic happens OFF-CHAIN
     */
    function updateReputation(
        bytes32 agentId,
        uint256 score,
        uint256 totalObservations
    ) external onlyOwner {
        latestScore[agentId] = score;
        latestObservations[agentId] = totalObservations;

        emit ReputationUpdated(agentId, score, totalObservations);
    }

    /**
     * @notice Optional granular signal event
     * @dev Does not mutate state
     */
    function submitSignal(
        bytes32 agentId,
        int256 scoreDelta
    ) external {
        emit ReputationSignal(agentId, msg.sender, scoreDelta);
    }

    /*//////////////////////////////////////////////////////////////
                             GOVERNANCE
    //////////////////////////////////////////////////////////////*/

    function transferOwnership(address newOwner) external onlyOwner {
        require(newOwner != address(0), "INVALID_OWNER");
        owner = newOwner;
    }
}
