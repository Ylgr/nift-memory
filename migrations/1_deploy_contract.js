const NiftMemoryDust = artifacts.require("./NiftMemoryDust.sol");
const NiftMemoryTreasure = artifacts.require("./NiftMemoryTreasure.sol");

module.exports = function(deployer) {
  deployer.deploy(NiftMemoryDust);
  deployer.deploy(NiftMemoryTreasure);
};
