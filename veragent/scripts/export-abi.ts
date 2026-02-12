import fs from "fs";
import path from "path";

/**
 * Export VeragentRegistry ABI from Hardhat artifacts
 * Output path matches subgraph expected location
 */

const CONTRACT_NAME = "VeragentRegistry";

function main() {
  const artifactPath = path.join(
    __dirname,
    `../artifacts/contracts/${CONTRACT_NAME}.sol/${CONTRACT_NAME}.json`
  );

  const outputDir = path.join(__dirname, "../subgraph/abis");
  const outputPath = path.join(outputDir, `${CONTRACT_NAME}.json`);

  if (!fs.existsSync(artifactPath)) {
    throw new Error("Contract artifact not found. Run `npx hardhat compile` first.");
  }

  if (!fs.existsSync(outputDir)) {
    fs.mkdirSync(outputDir, { recursive: true });
  }

  const artifact = JSON.parse(fs.readFileSync(artifactPath, "utf8"));

  const abiOnly = {
    contractName: CONTRACT_NAME,
    abi: artifact.abi
  };

  fs.writeFileSync(outputPath, JSON.stringify(abiOnly, null, 2));

  console.log("ABI exported to:", outputPath);
}

main();
