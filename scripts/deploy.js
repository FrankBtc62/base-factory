async function main() {
  const Factory = await ethers.getContractFactory("Factory");

  console.log("Deploy ediliyor...");

  const factory = await Factory.deploy();

  await factory.waitForDeployment();

  console.log("Factory adresi:", await factory.getAddress());
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
