//SPDX-License-Identifier: MIT
pragma solidity >0.8.0;
pragma experimental ABIEncoderV2;

contract votacion {
    //Direccion del propietario del contrato
    address owner;

    constructor() {
        owner = msg.sender;
    }

    //RELACION nombre - hash
    mapping(string => bytes32) id_candidato;

    //Relacion candidato - votos
    mapping(string => uint256) votos_candidato;

    //Almacenamiento de nombres de candidatos
    string[] candidatos;

    //lista de votantes
    bytes32[] votantes;

    function Representar(
        string memory _nombre,
        uint256 _edad,
        string memory _id_persona
    ) public {
        bytes32 hash_candidato = keccak256(
            abi.encodePacked(_nombre, _edad, _id_persona)
        );
        id_candidato[_nombre] = hash_candidato;
        candidatos.push(_nombre);
    }

    function verCandidatos() public view returns (string[] memory) {
        return candidatos;
    }

    function votar(string memory _candidato) public {
        bytes32 hash_votante = keccak256(abi.encodePacked(msg.sender));
        for (uint256 i = 0; i < votantes.length; i++) {
            require(votantes[i] != hash_votante, "El votante ya ha votado");
        }

        votantes.push(hash_votante);
        votos_candidato[_candidato]++;
    }

    function verVotos(string memory _candidato) public view returns (uint256) {
        return votos_candidato[_candidato];
    }

    function verResultados() public view returns (string memory) {
        string memory resultados = "";
        for (uint256 i = 0; i < candidatos.length; i++) {
            resultados = string(
                abi.encodePacked(
                    resultados,
                    "( ",
                    candidatos[i],
                    ", ",
                    verVotos(candidatos[i]),
                    " ) "
                )
            );
        }

        return resultados;
    }

    function Ganador() public view returns(string memory){
        string memory ganador= candidatos[0];
        for(uint i=1;i<candidatos.length;i++){
  
            if(votos_candidato[ganador]<votos_candidato[candidatos[i]]){
                ganador=candidatos[i];
            }
        }
        return ganador;

    }


}
