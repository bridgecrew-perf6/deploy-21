pragma solidity ^0.5.0;
pragma experimental ABIEncoderV2;


/**
 * @title Roles
 * @dev Library for managing addresses assigned to a Role.
 */
library Roles {
    struct Role {
        mapping (address => bool) bearer;
    }

    /**
     * @dev Give an account access to this role.
     */
    function add(Role storage role, address account) internal {
        require(!has(role, account), "Roles: account already has role");
        role.bearer[account] = true;
    }

    /**
     * @dev Remove an account's access to this role.
     */
    function remove(Role storage role, address account) internal {
        require(has(role, account), "Roles: account does not have role");
        role.bearer[account] = false;
    }

    /**
     * @dev Check if an account has this role.
     * @return bool
     */
    function has(Role storage role, address account) internal view returns (bool) {
        require(account != address(0), "Roles: account is the zero address");
        return role.bearer[account];
    }
}

contract AdminRole {
    using Roles for Roles.Role;

    event AdminAdded(address indexed account);
    event AdminRemoved(address indexed account);

    Roles.Role private _admins;

    constructor() internal {
        _addAdmin(msg.sender);
    }

    modifier onlyAdmin() {
        require(
            isAdmin(msg.sender),
            "AdminRole: caller does not have the Admin role"
        );
        _;
    }

    function isAdmin() public view returns (bool) {
        return _admins.has(msg.sender);
    }

    function isAdmin(address account) public view returns (bool) {
        return _admins.has(account);
    }

    function addAdmin(address account) public onlyAdmin {
        _addAdmin(account);
    }

    function renounceAdmin() public {
        _removeAdmin(msg.sender);
    }

    function _addAdmin(address account) internal {
        _admins.add(account);
        emit AdminAdded(account);
    }

    function _removeAdmin(address account) internal {
        _admins.remove(account);
        emit AdminRemoved(account);
    }
}

library Helper {

    function toInt(string memory _value) internal pure returns (uint _ret) {
        bytes memory _bytesValue = bytes(_value);
        uint j = 1;

        for(uint i = _bytesValue.length-1; i >= 0 && i < _bytesValue.length; i--) {
            assert(uint8(_bytesValue[i]) >= 48 && uint8(_bytesValue[i]) <= 57);
            _ret += (uint8(_bytesValue[i]) - 48)*j;
            j*=10;
        }
    }

    function compare(string memory org, string memory dst) internal pure returns (bool) {
        return keccak256(abi.encodePacked(org)) == keccak256(abi.encodePacked(dst));
    }

    function toString(uint256 _i) internal pure returns (string memory _uintAsString)
    {
        if (_i == 0) {
            return "0";
        }
        uint256 j = _i;
        uint256 len;
        while (j != 0) {
            len++;
            j /= 10;
        }
        bytes memory bstr = new bytes(len);
        uint256 k = len - 1;
        while (_i != 0) {
            bstr[k--] = bytes1(uint8(48 + (_i % 10)));
            _i /= 10;
        }
        return string(bstr);
    }
}

contract IDistrictInfo is AdminRole {
    function getAttribute(uint256 tokenId, string memory key) public view returns (string memory);
    function getAttribute(uint256 [] memory tokenId, string memory key) public view returns (string [] memory);
    function setAttribute(uint256 tokenId, string memory key, string memory value) public;
    function getTokenIdsByCountry(string memory country) public view returns (uint256 [] memory);
}

contract DistrictInfo is IDistrictInfo
{
    using Helper for string;
    using Helper for uint256;

    // tokenId => key => value
    mapping(uint256 => mapping(string => string)) public attributes;
    
    // country name => tokenId array
    mapping(string => uint256[]) public countryTokenIds;
    
    // tokenId => countryTokenIds index
    mapping(uint256 => uint256) private countryTokenIdIndexes;

    event SetAttribute(uint256 indexed tokenId, string key, string value);

    constructor() public {
    }
    
    function getAttribute(uint256 tokenId, string memory key) public view returns (string memory) {
        require(existAttribute(tokenId, key), "does not exist the key in districtInfo");
        return attributes[tokenId][key];
    }

    function getAttribute(uint256 [] memory tokenIds, string memory key) public view returns (string [] memory) {
        string [] memory result = new string[](tokenIds.length);
        
        for (uint256 i = 0; i < tokenIds.length; i++) {
            result[i] = getAttribute(tokenIds[i], key);
        }

        return result;
    }

    function setAttribute(uint256 tokenId, string memory key, string memory value) public onlyAdmin {
        
        if (key.compare("Country") == true) {
            if (existAttribute(tokenId, key) == true) {
                string memory oldCountry = getAttribute(tokenId, key);
                deleteCountryTokenId(tokenId, oldCountry);
            }

            countryTokenIds[value].push(tokenId);
            countryTokenIdIndexes[tokenId] = countryTokenIds[value].length - 1;
        }

        attributes[tokenId][key] = value;
        
        emit SetAttribute(tokenId, key, value);
    }

    function setAttribute(uint256 tokenId, string [] memory keys, string [] memory values) public onlyAdmin {
        
        require(keys.length == values.length, "keys and values count different");

        for (uint256 i = 0; i < keys.length; i++) {
            setAttribute(tokenId, keys[i], values[i]);
        }

    }

    function getTokenIdsByCountry(string memory country) public view returns (uint256 [] memory) {
        return countryTokenIds[country];
    }

    function existAttribute(uint256 tokenId, string memory key) public view returns (bool) {
        return (keccak256(abi.encodePacked((attributes[tokenId][key]))) != keccak256(abi.encodePacked((""))));
    }

    function deleteCountryTokenId(uint256 tokenId, string memory country) private {
        uint256 [] storage tokenIds = countryTokenIds[country];
        
        uint256 index = countryTokenIdIndexes[tokenId];
        uint256 lastIndex = tokenIds.length - 1;
        
        if (index != lastIndex) {
            uint256 temp = tokenIds[lastIndex];
            countryTokenIdIndexes[temp] = index;
            tokenIds[index] = temp;
        }
       
        tokenIds.length--;
        delete countryTokenIdIndexes[tokenId];
    }
}