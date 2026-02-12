// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title VeragentRegistry
 * @author Veragent Protocol Contributors
 * @notice Canonical on-chain registry for Veragent AI agents
 * @dev This contract is the FINAL reference implementation for RFC-0008
 *
 * Design goals:
 * - Minimal on-chain state
 * - Event-driven indexing
 * - Deterministic agent identity anchoring
 * - No business logic, no payments, no reputation
 */
contract VeragentRegistry {
    /*//////////////////////////////////////////////////////////////
                                ERRORS
    //////////////////////////////////////////////////////////////*/

    error AgentAlreadyExists(bytes32 agentId);
    error AgentDoesNotExist(bytes32 agentId);
    error NotAgentOwner(bytes32 agentId, address caller);

    /*//////////////////////////////////////////////////////////////
                                EVENTS
    //////////////////////////////////////////////////////////////*/

    /// @notice Emitted when a new agent is registered
    event AgentRegistered(
        bytes32 indexed agentId,
        address indexed owner,
        string metadataURI
    );

    /// @notice Emitted when agent metadata is updated
    event MetadataUpdated(
        bytes32 indexed agentId,
        string metadataURI
    );

    /// @notice Emitted when an agent is deactivated
    event AgentDeactivated(bytes32 indexed agentId);

    /*//////////////////////////////////////////////////////////////
                                STORAGE
    //////////////////////////////////////////////////////////////*/

    struct Agent {
        address owner;
        string metadataURI;
        uint64 createdAt;
        bool active;
    }

    /// @notice Mapping of agentId => Agent record
    mapping(bytes32 => Agent) private agents;

    /*//////////////////////////////////////////////////////////////
                            VIEW FUNCTIONS
    //////////////////////////////////////////////////////////////*/

    /**
     * @notice Check whether an agent exists
     */
    function exists(bytes32 agentId) external view returns (bool) {
        return agents[agentId].owner != address(0);
    }

    /**
     * @notice Get agent owner
     */
    function ownerOf(bytes32 agentId) external view returns (address) {
        Agent storage agent = agents[agentId];
        if (agent.owner == address(0)) revert AgentDoesNotExist(agentId);
        return agent.owner;
    }

    /**
     * @notice Get agent metadata URI
     */
    function metadataURI(bytes32 agentId) external view returns (string memory) {
        Agent storage agent = agents[agentId];
        if (agent.owner == address(0)) revert AgentDoesNotExist(agentId);
        return agent.metadataURI;
    }

    /**
     * @notice Get full agent record
     */
    function getAgent(bytes32 agentId) external view returns (Agent memory) {
        Agent storage agent = agents[agentId];
        if (agent.owner == address(0)) revert AgentDoesNotExist(agentId);
        return agent;
    }

    /*//////////////////////////////////////////////////////////////
                        REGISTRATION FUNCTIONS
    //////////////////////////////////////////////////////////////*/

    /**
     * @notice Register a new agent
     * @param agentId Deterministic agent identifier
     * @param metadataURI Off-chain metadata URI (RFC-0001 compliant)
     */
    function registerAgent(bytes32 agentId, string calldata metadataURI) external {
        if (agents[agentId].owner != address(0)) {
            revert AgentAlreadyExists(agentId);
        }

        agents[agentId] = Agent({
            owner: msg.sender,
            metadataURI: metadataURI,
            createdAt: uint64(block.timestamp),
            active: true
        });

        emit AgentRegistered(agentId, msg.sender, metadataURI);
    }

    /**
     * @notice Update metadata URI for an existing agent
     */
    function updateMetadata(bytes32 agentId, string calldata newURI) external {
        Agent storage agent = agents[agentId];
        if (agent.owner == address(0)) revert AgentDoesNotExist(agentId);
        if (msg.sender != agent.owner) revert NotAgentOwner(agentId, msg.sender);

        agent.metadataURI = newURI;

        emit MetadataUpdated(agentId, newURI);
    }

    /**
     * @notice Deactivate an agent
     * @dev Deactivation is permanent and does not delete state
     */
    function deactivateAgent(bytes32 agentId) external {
        Agent storage agent = agents[agentId];
        if (agent.owner == address(0)) revert AgentDoesNotExist(agentId);
        if (msg.sender != agent.owner) revert NotAgentOwner(agentId, msg.sender);

        agent.active = false;

        emit AgentDeactivated(agentId);
    }
}
