// migrating the appropriate contracts
const ERC721MintableComplete = artifacts.require('ERC721Mintable');
var SquareVerifier = artifacts.require("./SquareVerifier.sol");
//var SolnSquareVerifier = artifacts.require("./SolnSquareVerifier.sol");

module.exports = function(deployer) {
  deployer.deploy(ERC721MintableComplete)
  deployer.deploy(SquareVerifier);
  // const squareVerifier = await SquareVerifier.deployed();
  // deployer.deploy(SolnSquareVerifier, squareVerifier.address);
};
