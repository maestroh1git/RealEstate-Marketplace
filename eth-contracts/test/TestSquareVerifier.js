// define a variable to import the <Verifier> or <renamedVerifier> solidity contract generated by Zokrates
const zokratesProof = require("../../zokrates/code/square/proof.json");
const fakeProof = require("../../zokrates/code/square/fakeproof.json");
const squareVerifier = artifacts.require('SquareVerifier');

// Test verification with correct proof
// - use the contents from proof.json generated from zokrates steps

contract('TestSquareVerifier', accounts => {

    describe('proof verification', function() {
        beforeEach(async function(){
            this.contract = await squareVerifier.new();
        });

        it('proof is correct', async function(){
            let result = await this.contract.verifyTx.call(zokratesProof.proof, zokratesProof.inputs);
            assert.equal(result, true, "proof is not correct");
        });

    })

    describe('fake proof verification', function() {
        beforeEach(async function(){
            this.contract = await squareVerifier.new();
        });

        it('proof is not correct', async function(){
            let result = await this.contract.verifyTx.call(zokratesProof.proof, fakeProof.inputs);
            assert.equal(result, false, "proof is not correct");
        });

    })
})

    
// Test verification with incorrect proof
