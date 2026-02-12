import { BigInt } from "@graphprotocol/graph-ts"
import {
AgentRegistered,
MetadataUpdated,
AgentDeactivated
} from "../generated/VeragentRegistry/VeragentRegistry"
import { Agent } from "../generated/schema"


export function handleAgentRegistered(event: AgentRegistered): void {
let id = event.params.agentId.toHexString()


let agent = new Agent(id)
agent.owner = event.params.owner
agent.metadataURI = event.params.metadataURI
agent.active = true
agent.createdAt = event.block.timestamp
agent.updatedAt = event.block.timestamp


agent.save()
}


export function handleMetadataUpdated(event: MetadataUpdated): void {
let id = event.params.agentId.toHexString()
let agent = Agent.load(id)


if (agent == null) return


agent.metadataURI = event.params.metadataURI
agent.updatedAt = event.block.timestamp


agent.save()
}


export function handleAgentDeactivated(event: AgentDeactivated): void {
let id = event.params.agentId.toHexString()
let agent = Agent.load(id)


if (agent == null) return


agent.active = false
agent.updatedAt = event.block.timestamp


agent.save()
}
