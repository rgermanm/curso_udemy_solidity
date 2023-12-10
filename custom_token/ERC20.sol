//SPDX-License-Identifier: MIT
pragma solidity >0.8.0;
pragma experimental ABIEncoderV2;
import "./../SafeMath.sol";

//INTERFACE DE TOKEN ERC20
interface IERC20 {
    //Devuelve la cantidad de tokens en existencia
    function TotalSupply() external view returns (uint256);

    //Devuelva la cantidad de tokens para una direccion indicada por parametro
    function balanceOf(address account) external view returns (uint256);

    //Devuelva el nro de tokens que el spender podra gastar en nombre del propietario
    function allowance(address owner, address spender)
        external
        view
        returns (uint256);

    //Devuelve un booleano dependiendo del resultado de la transferencia
    function transfer(address recipient, uint256 amount)
        external
        returns (bool);

    //Devuelve un booleano dependiendo del resultado de la operacion de gasto
    function approve(address spender, uint256 amount) external returns (bool);

    //Devuelve un booleano dependiendo del resultado de la operacion usando allowance
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);

    //Evento cuando una cantidad pase de un origen a un destino
    event Transfer(address indexed from, address indexed to, uint256 amount);
    //Evento cuando se establece una asignacion con el metodo allowance

    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );
}

contract ERC20Basic is IERC20 {
    using SafeMath for uint256;

    //Nombre del token
    string public constant name = "ERC20BlockchainAZ";
    //Abreviacion del nombre del token
    string public constant symbol = "ERCAZ";
    //Numero maximo de decimales
    uint8 public constant decimals = 18;

    mapping(address => uint256) balances;
    mapping(address => mapping(address => uint256)) allowed;
    uint256 totalSupply_;

    constructor(uint256 initialSupply) {
        totalSupply_ = initialSupply;
        balances[msg.sender] = totalSupply_;
    }

    function TotalSupply() public view override returns (uint256) {
        return totalSupply_;
    }

    function increaseTotalSupple(uint256 newTokensAmount) public {
        totalSupply_ += newTokensAmount;
        balances[msg.sender] += newTokensAmount;
    }

    function balanceOf(address tokenOwner)
        public
        view
        override
        returns (uint256)
    {
        return balances[tokenOwner];
    }

    function allowance(address owner, address delegate)
        external
        view
        returns (uint256)
    {
        return allowed[owner][delegate];
    }

    function transfer(address recipient, uint256 numTokens)
        public
        override
        returns (bool)
    {
        require(numTokens<=balances[msg.sender]);
        balances[msg.sender]=balances[msg.sender].sub(numTokens);
        balances[recipient]= balances[recipient].add(numTokens);
        emit Transfer(msg.sender, recipient, numTokens);
        return true;
    }

    function approve(address delegate, uint256 numTokens)
        public
        override
        returns (bool)
    {
        allowed[msg.sender][delegate]=numTokens;
        emit Approval(msg.sender, delegate, numTokens);
        return true;
    }

    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) public override returns (bool) {
        return false;
    }
}
