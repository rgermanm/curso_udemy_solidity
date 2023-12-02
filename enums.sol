pragma solidity >0.8.0;
pragma experimental ABIEncoderV2;
contract ejemplos_enums{

 //Enumeracion de interuptor
    enum estado {ON,OFF}

//Variable del tipo enum estado
    estado state;

    function encender() public{
        state = estado.ON;
    }    

    function apagar() public{
        state = estado(1);
    }

    function getEstad() public view returns(estado){
        return state;
    }
    
}