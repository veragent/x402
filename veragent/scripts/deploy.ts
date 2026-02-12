import { ethers } from "hardhat";

async function main() {
  const [deployer] = await ethers.getSigners();

  console.log("Deploying with:", deployer.address);

  const Registry = await ethers.getContractFactory("VeragentRegistry");
  const registry = await Registry.deploy();

  await registry.waitForDeployment();

  const address = await registry.getAddress();

  console.log("VeragentRegistry deployed to:", address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
