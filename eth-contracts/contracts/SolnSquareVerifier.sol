pragma solidity >=0.4.21 <0.6.0;
pragma experimental ABIEncoderV2;

import "./ERC721Mintable.sol";
import "./SquareVerifier.sol";

// contract SquareVerifier {
//     function verifyTx(
//         uint[2] memory a,
//         uint[2][2] memory b,
//         uint[2] memory c,
//         uint[2] memory input
//     )
//     public returns(bool result);
// }
interface ISquareVerifier {
    struct Proof {
        Pairing.G1Point a;
        Pairing.G2Point b;
        Pairing.G1Point c;
    }
    function verifyTx(Proof calldata proof, uint256[2] calldata input)
        external
        view
        returns (bool r);
}
//IZokratesVerifier.Proof memory proof,


contract SolnSquareVerifier is ERC721Mintable {
    ISquareVerifier verifier;

    constructor(address verifierAddress) ERC721Mintable() public {
        verifier = ISquareVerifier(verifierAddress);
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

  function mintIt(address to, uint256 tokenId, ISquareVerifier.Proof memory proof, uint[2] memory a, uint[2][2] memory b, uint[2] memory c, uint[2] memory input) public returns(bool) {
      bytes32 solutionKey = keccak256(abi.encodePacked(a, b, c, input));

      require(solutionsSubmitted[solutionKey].solutionSolver == address(0), "Solution has been solved already.");
      require(verifier.verifyTx(proof, input), 'The solution is not valid');

      addSolution(solutionKey, tokenId, to);
      return mint(to, tokenId);
  }


}























