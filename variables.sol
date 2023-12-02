pragma solidity >0.8.0;
pragma experimental ABIEncoderV2;
contract variables{
    uint enteroUno=50;

    bytes32 hash = keccak256(abi.encodePacked(enteroUno));
}