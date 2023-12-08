pragma solidity >0.8.0;
pragma experimental ABIEncoderV2;


/*
+---------+--------+-------+
|  Name   |   ID   | Grade |
+---------+--------+-------+
|  John   | ABC123 |   8   |
|  Jane   | DEF456 |   7   |
|   Bob   | GHI789 |   9   |
| Sarah   | JKL012 |   6   |
|  Mike   | MNO345 |   5   |
| Emily   | PQR678 |   8   |
+---------+--------+-------+
*/

contract notas{
    address public profesor;
    
    constructor() public {
        profesor    =   msg.sender;
    }

    mapping(bytes32=>uint) Notas;

    string [] revisiones;

    event alumno_evaluado(bytes32);
    event evento_revision(string); 

    function Evaluar(string memory _idAlumno, uint _nota) public UnicamenteProfesor(msg.sender){
        bytes32 hash_idAlumno = keccak256(abi.encodePacked(_idAlumno));
        Notas[hash_idAlumno]=_nota;
        emit alumno_evaluado(hash_idAlumno);
    }

    modifier UnicamenteProfesor(address _direccion){
        require(_direccion == profesor,"No tienes permisos para ejecutar la funcion");
        _;
    }

    function VerNotas(string memory _idAlumno ) public view returns(uint){
        bytes32 hash_idAlumno= keccak256(abi.encodePacked(_idAlumno));
        uint nota_alumno= Notas[hash_idAlumno];
        return nota_alumno;
    } 

    function Revision(string memory _idAlumno) public{
        revisiones.push(_idAlumno);
        emit evento_revision(_idAlumno);
    }

    function VerRevisiones() public view UnicamenteProfesor(msg.sender) returns (string[]memory){
        return revisiones;
    }  


    
}

