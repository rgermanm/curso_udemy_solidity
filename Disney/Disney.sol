//SPDX-License-Identifier: MIT
pragma solidity >0.8.0;
pragma experimental ABIEncoderV2;
import "./ERC20.sol";


contract Disney{

    //Instancia al contrato
    ERC20Basic private token;
    //Direccion de Disney (owner) 
    address payable public owner;

    //Constructor
    constructor () {
        token = new ERC20Basic(10000);
        owner = payable(msg.sender);
    }

    //Estructura de almacenamiento de clientes

    struct cliente {
        uint tokens_comprados;
        string [] atracciones_disfrutadas;
    }

    // Mapeo registro de clientes
    mapping (address=>cliente)public Clientes;


    //Funcion que establece el precio de un token
    function PrecioTokens(uint _numTokens) internal pure returns (uint){
        //1 token == 1 eth
        return  _numTokens*(1 ether);
    }

    function CompraTokens(uint _numTokens) public payable{
        uint coste = PrecioTokens(_numTokens);
        //Evaluacion del dinero que el cliente paga por los tokens
        require (msg.value>=coste, "Compra menos Tokens o paga con mas ethers");
        //Diferencia de lo que el cliente paga
        uint returnValue = msg.value - coste;
        //Retorna cantidad de ethers al cliente
        payable(msg.sender).transfer(returnValue);
        //Obtencion de nro de tokens disponibles
        uint Balance = balanceOf();
        require(_numTokens <= Balance, "Compra un numero menor de tokens");
        //Transferencia de tokens al cliente
        token.transfer(msg.sender, _numTokens);
        //Registro de tokens comprados
        Clientes[msg.sender].tokens_comprados += _numTokens;
    }

    //Balance de tokens del contrato disney
    function balanceOf() public view returns(uint){
        return token.balanceOf(address(this));
    }

    //Visualizar el numero de toknes restantes de un cliente
    function MisTokens() public view returns (uint){
        return token.balanceOf(msg.sender);
    }

    //Funcion para generar mas tokens
    function GeneraTokens(uint _numTokens) public Unicamente(msg.sender){
        token.increaseTotalSupple(_numTokens);
    }

    //Modificador para controlar las funciones ejecutables por disney
    modifier Unicamente(address _direccion){
        require(_direccion==owner,"Sin permisos de ejcucion");
        _;
    }


//GESTION

//Eventos
event disfruta_atraccion(string);
event nueva_atraccion(string);
event baja_atraccion(string);

//Estructura de la atraccion
struct atraccion{
    string nombre_atraccion;
    uint precio_atraccion;
    bool estado_atraccion;
}

//Mapping para relacion nombre atraccion con estructura de datos
mapping(string=>atraccion)public MappingAtracciones;

//Array de atracciones
string [] Atracciones;

//Mapping para relacionar una identidad (cliente) consu historial en Disney

mapping(address=>string []) HistorialAtracciones;



}

