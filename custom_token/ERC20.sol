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
}

contract ERC20Basic is IERC20 {
    function TotalSupply() public view override returns (uint256) {
        return 0;
    }

    function balanceOf(address account) public view override returns (uint256) {
        return 0;
    }

    function allowance(address owner, address spender)
        external
        view
        returns (uint256)
    {
        return 0;
    }

    function transfer(address recipient, uint256 amount)
        public
        override
        returns (bool)
    {
        return true;
    }

    function approve(address spender, uint256 amount)
        public
        override
        returns (bool)
    {
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
