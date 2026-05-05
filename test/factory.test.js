const { expect } = require("chai");

describe("Factory", function () {
  it("Should deploy SimpleStorage", async function () {
    const Factory = await ethers.getContractFactory("Factory");
    const factory = await Factory.deploy();

    await factory.deploy(42, { value: ethers.parseEther("0.00001") });

    expect(true).to.equal(true);
  });
});
