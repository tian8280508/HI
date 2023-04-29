pragma solidity >=0.5.0 <0.9.0;

import "./HealthNFT.sol";
import "./Verifier.sol";

contract HealthCenter is HealthNFT {
    mapping(uint => address) nftAddrMap;
    mapping(address => uint) addrNftCountMap;
    mapping(uint => bool) registeredNftMap;
    mapping(uint => uint) nftHashDataMap;
    uint[] nftNumberList;
    PlonkVerifier verifier ;
    HealthNFT healthNFT ;

    constructor (PlonkVerifier _addr1, HealthNFT _addr2) {
        verifier = PlonkVerifier(_addr1);
        healthNFT = HealthNFT(_addr2);
    }

    function VerifyAndMint(address _examinee ,bytes memory proof, uint[] memory pubSignals) public returns(bool, uint) {
        require(verifier.verifyProof(proof, pubSignals), "proof invalid");
        require(!registeredNftMap[pubSignals[0]], "nft already exist");
        uint tokenId = healthNFT.mint(_examinee);
        nftHashDataMap[tokenId] = pubSignals[0];
        registeredNftMap[pubSignals[0]] = true;

        uint count = addrNftCountMap[_examinee];
        addrNftCountMap[_examinee] = count+1;

        nftNumberList.push(tokenId);
        return (true, tokenId);
        //return (true, 1);
    }

    function GetAddrHealthNFTHash(address _owner) public view returns(uint[] memory) {
        uint[] memory result = new uint[](addrNftCountMap[_owner]);
        uint counter = 0;
        for (uint i = 0; i < nftNumberList.length; i++) {
            if (nftAddrMap[i] == _owner) {
                result[counter] = nftHashDataMap[i];
                counter++;
            }
        }
        return result;
    }

    function isRegisteredNft(uint hashData) public view returns(bool) {
        return registeredNftMap[hashData];
    }
}