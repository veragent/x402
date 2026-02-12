// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../contracts/VeragentRegistry.sol";

contract VeragentRegistryTest is Test {
    VeragentRegistry registry;

    address owner = address(0xABCD);
    bytes32 agentId = keccak256("agent-1");

    function setUp() public {
        registry = new VeragentRegistry();
    }

    function testRegisterAgent() public {
        vm.prank(owner);
        registry.registerAgent(agentId, "ipfs://metadata");

        assertTrue(registry.exists(agentId));
        assertEq(registry.ownerOf(agentId), owner);
    }

    function testUpdateMetadata() public {
        vm.prank(owner);
        registry.registerAgent(agentId, "ipfs://metadata");

        vm.prank(owner);
        registry.updateMetadata(agentId, "ipfs://updated");

        assertEq(registry.metadataURI(agentId), "ipfs://updated");
    }

    function testDeactivateAgent() public {
        vm.prank(owner);
        registry.registerAgent(agentId, "ipfs://metadata");

        vm.prank(owner);
        registry.deactivateAgent(agentId);

        (,, , bool active) = registry.getAgent(agentId);
        assertFalse(active);
    }

    function testCannotUpdateIfNotOwner() public {
        vm.prank(owner);
        registry.registerAgent(agentId, "ipfs://metadata");

        vm.expectRevert();
        registry.updateMetadata(agentId, "ipfs://hack");
    }
}
