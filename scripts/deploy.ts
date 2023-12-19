import hre from "hardhat";
import * as fs from "node:fs/promises";

// Colour codes for terminal prints
const RESET = "\x1b[0m";
const GREEN = "\x1b[32m";

function delay(ms: number) {
  return new Promise((resolve) => setTimeout(resolve, ms));
}

interface DeployedAddresses {
  [key: string]: string;
}

async function main() {
  const constructorArgs = ["Hello, Hardhat!"];
  const contract = await hre.ethers.deployContract("Greeter", constructorArgs);

  await contract.waitForDeployment();
  const contractAddress = await contract.getAddress();

  console.log("Greeter deployed to: " + `${GREEN}${contractAddress}${RESET}\n`);

  if (hre.network.name === "hardhat" || hre.network.name === "localhost") {
    return;
  }

  // Uncomment if you want to enable verify
  // console.log(
  //   "Waiting 30 seconds before beginning the contract verification to allow the block explorer to index the contract...\n",
  // );
  // await delay(30000); // Wait for 30 seconds before verifying the contract

  // await hre.run("verify:verify", {
  //   address: contractAddress,
  //   constructorArguments: constructorArgs,
  // });

  // Uncomment if you want to enable the `tenderly` extension
  // await hre.tenderly.verify({
  //   name: "Greeter",
  //   address: contractAddress,
  // });

  // Export deployed addresses to JSON file in root.
  const deployedAddresses: DeployedAddresses = {
    Greeter: contractAddress,
  };

  await fs.writeFile(
    `./deployed-addresses.${hre.network.name}.json`,
    JSON.stringify(deployedAddresses, null, 2),
  );
  console.log(
    `Deployed addresses written to ./deployed-addresses.${hre.network.name}.json`,
  );
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
