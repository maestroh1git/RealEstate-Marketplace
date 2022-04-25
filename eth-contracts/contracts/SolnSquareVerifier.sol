pragma solidity >=0.4.21 <0.6.0;
//pragma experimental ABIEncoderV2;

import "./ERC721Mintable.sol";
//import "./SquareVerifier.sol";

contract SquareVerifier {
    function verifyTx(
        uint[2] memory a,
        uint[2][2] memory b,
        uint[2] memory c,
        uint[2] memory input
    )
    public returns(bool result);
}



contract SolnSquareVerifier is ERC721Mintable {
    SquareVerifier private verifier;

    constructor(address verifierAddress) ERC721Mintable() public {
        verifier = SquareVerifier(verifierAddress);
    }


struct Solution {
        uint256 index;
        address solutionSolver;
    }

Solution[] public solutions;

mapping(bytes32 => Solution) solutionsSubmitted;

event solutionAdded(uint256 tokenID, bytes32 key, address solver);


function addSolution(bytes32 _solutionId, uint256 _tokenId, address _solutionAddress) public returns(bool) {
    bool addedSolution;
        solutions.push(Solution({
            index: _tokenId,
            solutionSolver: _solutionAddress
        }));
        solutionsSubmitted[_solutionId] = Solution({
            index: _tokenId,
            solutionSolver: _solutionAddress
        });
        addedSolution = true;
        emit solutionAdded(_tokenId, _solutionId, msg.sender);
        return addedSolution;
    }
    //for Tests

    function getSolutionKey(uint[2] memory a, uint[2][2] memory b, uint[2] memory c, uint[2] memory input) public returns(bytes32){
        bytes32 solutionKey = keccak256(abi.encodePacked(a, b, c, input));
        return solutionKey;
    }

  function mintIt(address to, uint256 tokenId, uint[2] memory a, uint[2][2] memory b, uint[2] memory c, uint[2] memory input) public returns(bool) {
      bytes32 solutionKey = keccak256(abi.encodePacked(a, b, c, input));

      require(solutionsSubmitted[solutionKey].solutionSolver == address(0), "Solution has been solved already.");
      require(verifier.verifyTx(a, b, c, input), 'The solution is not valid');

      addSolution(solutionKey, tokenId, to);
      return mint(to, tokenId);
  }


}























