const NiftMemoryDust = artifacts.require("./NiftMemoryDust.sol");
const NiftMemoryTreasure = artifacts.require("./NiftMemoryTreasure.sol");
const NiftMemoryHeart = artifacts.require("./NiftMemoryHeart.sol");

module.exports = function(deployer) {
  deployer.deploy(NiftMemoryDust);
  deployer.deploy(NiftMemoryTreasure);
  deployer.deploy(NiftMemoryHeart);
};
