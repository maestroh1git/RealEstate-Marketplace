var ERC721MintableComplete = artifacts.require('ERC721Mintable');

contract('TestERC721Mintable', accounts => {

    const account_one = accounts[0];
    const account_two = accounts[1];

    describe('match erc721 spec', function () {
        beforeEach(async function () { 
            this.contract = await ERC721MintableComplete.new({from: account_one});

            await this.contract.mint(account_one, 1, { from: account_one });
            await this.contract.mint(account_one, 2, { from: account_one });
            await this.contract.mint(account_two, 3, { from: account_one });
            await this.contract.mint(account_two, 4, { from: account_one });
        })

        it('should return total supply', async function () { 
            let total = await this.contract.totalSupply.call({from: account_one});
            let expectedTotal = 4;
            assert.equal(total, expectedTotal, "Number of tokens expected have not been minted");
        })

        it('should get token balance', async function () { 
            let account1 = await contract.balanceOf.call(account_one);
            let account2 = await contract.balanceOf.call(account_two);
            assert.equal(
                account1,
                2, 
                "This account does not have the amount it should have");
            assert.equal(
                account2, 
                2, 
                "This account does not have the amount it should have");
        })

        // token uri should be complete i.e: https://s3-us-west-2.amazonaws.com/udacity-blockchain/capstone/1
        it('should return token uri', async function () { 
            let tokenID = 1
            let expectedTokenURI = "https://s3-us-west-2.amazonaws.com/udacity-blockchain/capstone/" + tokenID;
            let tokenURI = await this.contract.tokenURI.call(tokenID, {from: account_one});
            assert.equal(
                tokenURI,
                expectedTokenURI,
                "The token URI does not match");

        })

        it('should transfer token from one owner to another', async function () { 
            await this.contract.transferFrom(account_one, account_two, 2, {from: account_one});
            let newOwner = await this.contract.ownerOf(2);
            assert.equal(account_two, newOwner, "the transfer failed");
            
        })
    });

    describe('have ownership properties', function () {
        beforeEach(async function () { 
            this.contract = await ERC721MintableComplete.new({from: account_two});
        })

        it('should fail when minting when address is not contract owner', async function () { 
            let minted = true;
            try{
                await this.contract.mint(account_one, 5, {from: account_one});
            }
            catch(e){
                minted = false;
            }
            
            assert.equal(minted, false, "An account that's not the owner of the contract called this mint function");
            
        })

        it('should return contract owner', async function () { 
            let Owner = await this.contract.currentOwner.call();
            assert.equal(Owner, account_two, "Wrong contract owner");
            
        })

    });
})