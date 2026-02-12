import { run } from "hardhat";

async function main() {
  const address = process.env.REGISTRY_ADDRESS;

  if (!address) {
    throw new Error("REGISTRY_ADDRESS env var is required");
  }

  console.log("Verifying VeragentRegistry at:", address);

  await run("verify:verify", {
    address,
    constructorArguments: [],
  });

  console.log("Verification complete");
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
