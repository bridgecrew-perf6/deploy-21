pragma solidity ^0.5.0;
pragma experimental ABIEncoderV2;


/**
 * @dev Contract module which provides a basic access control mechanism, where
 * there is an account (an owner) that can be granted exclusive access to
 * specific functions.
 *
 * This module is used through inheritance. It will make available the modifier
 * `onlyOwner`, which can be aplied to your functions to restrict their use to
 * the owner.
 */
contract Ownable {
    address payable private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor () internal {
        _owner = msg.sender;
        emit OwnershipTransferred(address(0), _owner);
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view returns (address payable) {
        return _owner;
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        require(isOwner(), "Ownable: caller is not the owner");
        _;
    }

    /**
     * @dev Returns true if the caller is the current owner.
     */
    function isOwner() public view returns (bool) {
        return msg.sender == _owner;
    }

    /**
     * @dev Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions anymore. Can only be called by the current owner.
     *
     * > Note: Renouncing ownership will leave the contract without an owner,
     * thereby removing any functionality that is only available to the owner.
     */
    function renounceOwnership() public onlyOwner {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address payable newOwner) public onlyOwner {
        _transferOwnership(newOwner);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     */
    function _transferOwnership(address payable newOwner) internal {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }
}

/**
 * @dev Wrappers over Solidity's arithmetic operations with added overflow
 * checks.
 *
 * Arithmetic operations in Solidity wrap on overflow. This can easily result
 * in bugs, because programmers usually assume that an overflow raises an
 * error, which is the standard behavior in high level programming languages.
 * `SafeMath` restores this intuition by reverting the transaction when an
 * operation overflows.
 *
 * Using this library instead of the unchecked operations eliminates an entire
 * class of bugs, so it's recommended to use it always.
 */
library SafeMath {
    /**
     * @dev Returns the addition of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `+` operator.
     *
     * Requirements:
     * - Addition cannot overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");

        return c;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return sub(a, b, "SafeMath: subtraction overflow");
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     * - Subtraction cannot overflow.
     *
     * _Available since v2.4.0._
     */
    function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b <= a, errorMessage);
        uint256 c = a - b;

        return c;
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `*` operator.
     *
     * Requirements:
     * - Multiplication cannot overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");

        return c;
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return div(a, b, "SafeMath: division by zero");
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts with custom message on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     *
     * _Available since v2.4.0._
     */
    function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        // Solidity only automatically asserts when dividing by 0
        require(b > 0, errorMessage);
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold

        return c;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return mod(a, b, "SafeMath: modulo by zero");
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts with custom message when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     *
     * _Available since v2.4.0._
     */
    function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b != 0, errorMessage);
        return a % b;
    }
}

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

contract PauserRole {
    using Roles for Roles.Role;

    event PauserAdded(address indexed account);
    event PauserRemoved(address indexed account);

    Roles.Role private _pausers;

    constructor() internal {
        _addPauser(msg.sender);
    }

    modifier onlyPauser() {
        require(
            isPauser(msg.sender),
            "PauserRole: caller does not have the Pauser role"
        );
        _;
    }

    function isPauser(address account) public view returns (bool) {
        return _pausers.has(account);
    }

    function addPauser(address account) public onlyPauser {
        _addPauser(account);
    }

    function renouncePauser() public {
        _removePauser(msg.sender);
    }

    function _addPauser(address account) internal {
        _pausers.add(account);
        emit PauserAdded(account);
    }

    function _removePauser(address account) internal {
        _pausers.remove(account);
        emit PauserRemoved(account);
    }
}

/**
 * @dev Contract module which allows children to implement an emergency stop
 * mechanism that can be triggered by an authorized account.
 *
 * This module is used through inheritance. It will make available the
 * modifiers `whenNotPaused` and `whenPaused`, which can be applied to
 * the functions of your contract. Note that they will not be pausable by
 * simply including this module, only once the modifiers are put in place.
 */
contract Pausable is PauserRole {
    /**
     * @dev Emitted when the pause is triggered by a pauser (`account`).
     */
    event Paused(address account);

    /**
     * @dev Emitted when the pause is lifted by a pauser (`account`).
     */
    event Unpaused(address account);

    bool private _paused;

    /**
     * @dev Initializes the contract in unpaused state. Assigns the Pauser role
     * to the deployer.
     */
    constructor () internal {
        _paused = false;
    }

    /**
     * @dev Returns true if the contract is paused, and false otherwise.
     */
    function paused() public view returns (bool) {
        return _paused;
    }

    /**
     * @dev Modifier to make a function callable only when the contract is not paused.
     */
    modifier whenNotPaused() {
        require(!_paused, "Pausable: paused");
        _;
    }

    /**
     * @dev Modifier to make a function callable only when the contract is paused.
     */
    modifier whenPaused() {
        require(_paused, "Pausable: not paused");
        _;
    }

    /**
     * @dev Called by a pauser to pause, triggers stopped state.
     */
    function pause() public onlyPauser whenNotPaused {
        _paused = true;
        emit Paused(msg.sender);
    }

    /**
     * @dev Called by a pauser to unpause, returns to normal state.
     */
    function unpause() public onlyPauser whenPaused {
        _paused = false;
        emit Unpaused(msg.sender);
    }
}

/**
 * @dev Interface of the KIP-13 standard, as defined in the
 * [KIP-13](http://kips.klaytn.com/KIPs/kip-13-interface_query_standard).
 *
 * Implementers can declare support of contract interfaces, which can then be
 * queried by others.
 *
 * For an implementation, see `KIP13`.
 */
interface IKIP13 {
    /**
     * @dev Returns true if this contract implements the interface defined by
     * `interfaceId`. See the corresponding
     * [KIP-13 section](http://kips.klaytn.com/KIPs/kip-13-interface_query_standard#how-interface-identifiers-are-defined)
     * to learn more about how these ids are created.
     *
     * This function call must use less than 30 000 gas.
     */
    function supportsInterface(bytes4 interfaceId) external view returns (bool);
}

/**
 * @dev Required interface of an KIP17 compliant contract.
 */
contract IKIP17 is IKIP13 {
    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);
    event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId);
    event ApprovalForAll(address indexed owner, address indexed operator, bool approved);

    /**
     * @dev Returns the number of NFTs in `owner`'s account.
     */
    function balanceOf(address owner) public view returns (uint256 balance);

    /**
     * @dev Returns the owner of the NFT specified by `tokenId`.
     */
    function ownerOf(uint256 tokenId) public view returns (address owner);

    /**
     * @dev Transfers a specific NFT (`tokenId`) from one account (`from`) to
     * another (`to`).
     *
     * Requirements:
     * - `from`, `to` cannot be zero.
     * - `tokenId` must be owned by `from`.
     * - If the caller is not `from`, it must be have been allowed to move this
     * NFT by either `approve` or `setApproveForAll`.
     */
    function safeTransferFrom(address from, address to, uint256 tokenId) public;

    /**
     * @dev Transfers a specific NFT (`tokenId`) from one account (`from`) to
     * another (`to`).
     *
     * Requirements:
     * - If the caller is not `from`, it must be approved to move this NFT by
     * either `approve` or `setApproveForAll`.
     */
    function transferFrom(address from, address to, uint256 tokenId) public;
    function approve(address to, uint256 tokenId) public;
    function getApproved(uint256 tokenId) public view returns (address operator);

    function setApprovalForAll(address operator, bool _approved) public;
    function isApprovedForAll(address owner, address operator) public view returns (bool);


    function safeTransferFrom(address from, address to, uint256 tokenId, bytes memory data) public;
}

/**
 * @title KIP-17 Non-Fungible Token Standard, optional enumeration extension
 * @dev See http://kips.klaytn.com/KIPs/kip-17-non_fungible_token
 */
contract IKIP17Enumerable is IKIP17 {
    function totalSupply() public view returns (uint256);
    function tokenOfOwnerByIndex(address owner, uint256 index) public view returns (uint256 tokenId);

    function tokenByIndex(uint256 index) public view returns (uint256);
}

contract ReentrancyGuardByString {
    mapping(string => bool) public entered;

    modifier nonReentrantString(string memory str) {
        require(
            !entered[str],
            'ReentrancyGuardByString: prevent execute function asynchronous'
        );

        entered[str] = true;

        _;

        entered[str] = false;
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

contract IDistrictStaking is AdminRole {
    struct StakingInfo {
        address owner;
        uint256 tokenId;
        string country;
        uint256 stakedBlockNumber;
        uint256 playBlockNumber;
        uint256 accEarned;
    }

    function getStakingInfo(uint256 tokenId) public view returns (StakingInfo memory, bool);
    function dice(uint256 tokenId, uint256 earned) public;
    function getStakingTokenIds(address owner) public view returns (uint256 [] memory);
    function getStakingInfos(address owner) public view returns (StakingInfo [] memory);
    function getStakingInfos(uint256 [] memory tokenIds) public view returns (StakingInfo [] memory);
    function getOwnersByCountry(string memory country) public view returns (address [] memory);
    function setWaitTime(uint256 _waitTime) public;
}

contract DistrictStaking is IDistrictStaking, Ownable, Pausable, ReentrancyGuardByString {
    using SafeMath for uint256;
    using Helper for string;
    using Helper for uint256;

    struct MyStakingInfo {
        uint256 tokenId;
        string city;
        string country;
        uint256 tier;
        uint256 level;
        uint256 stakedBlockNumber;
        uint256 playBlockNumber;
        uint256 remainBlockNumber;
        uint256 accEarned;
    }

    struct CountryStakingTokenIds {
        string country;
        uint256 [] tokenIds;
    }

    IKIP17Enumerable public district;
    IDistrictInfo public districtInfo;
    uint256 private waitTime;
    uint256 public startBlockNumber;

    //StakeInfos
    StakingInfo [] public stakedInfos;
    //tokenId => array index
    mapping(uint256 => uint256) private stakedInfoIndexes;
    //tokenId => bool (exist)
    mapping(uint256 => bool) private existStakedInfos;
    
    //address => tokenId []
    mapping(address => uint256 []) private stakedOwnedTokens;
    //tokenId => array index
    mapping(uint256 => uint256) private stakedOwnedTokensIndexes;
    
    // country name => tokenId []
    mapping(string => uint256 []) private countryStakedTokenIds;
    // tokenId => index
    mapping(uint256 => uint256) private countryStakedTokenIdIndexes;

    event Stake(address indexed staker, uint256 indexed tokenId);
    event UnStake(address indexed staker, uint256 indexed tokenId);
    event UnStakeAll(address indexed user, uint256 workCnt);

    constructor(IKIP17Enumerable _district, IDistrictInfo _districtInfo, uint256 _startBlockNumber) public {
        district = _district;
        districtInfo = _districtInfo;
        startBlockNumber = _startBlockNumber;
    }

    function setContract(IKIP17Enumerable _district, IDistrictInfo _districtInfo) public onlyOwner {
        district = _district;
        districtInfo = _districtInfo;
    }

    function setVariable(uint256 _startBlockNumber) public onlyAdmin {
        startBlockNumber = _startBlockNumber;
    }

    function stake(uint256 tokenId) public payable whenNotPaused {
        
        require(block.number >= startBlockNumber, "start blocknumber");

        require(existStakedInfos[tokenId] == false, "already staked");

        address owner = district.ownerOf(tokenId);

        require(owner == msg.sender, "different owner and msg.sender");

        string memory country = districtInfo.getAttribute(tokenId, "Country");
        
        addStakingInfo(tokenId, country);

        district.transferFrom(msg.sender, address(this), tokenId);

        emit Stake(msg.sender, tokenId);
    }

    function unStake(uint256 tokenId) public payable {
        unStake(msg.sender, tokenId);
    }

    function getAllStakeInfos() public view returns (StakingInfo[] memory) {
        return stakedInfos;
    }

    function getStakingInfo(uint256 tokenId) public view returns (StakingInfo memory, bool) {
        StakingInfo memory result;
        bool exist;

        if (existStakedInfos[tokenId] == true) {
            result = stakedInfos[stakedInfoIndexes[tokenId]];
        } else {
            result = StakingInfo({
                owner : address(0),
                tokenId : 0,
                country : "",
                stakedBlockNumber : 0,
                playBlockNumber : 0,
                accEarned : 0
            });
        }

        exist = existStakedInfos[tokenId];
        return (result, exist);
    }

    function unStakeAll(uint256 count) public payable onlyAdmin {
        uint256 stakedInfoCount = stakedInfos.length;
        uint256 workCnt = stakedInfoCount;

        if (count > 0 && count < stakedInfoCount) {
            workCnt = count;
        }
        
        for (uint256 i = 0; i < workCnt; i++) {
            unStake(stakedInfos[stakedInfoCount - i - 1].owner, stakedInfos[stakedInfoCount - i - 1].tokenId);
        }

        emit UnStakeAll(msg.sender, workCnt);
    }

    function unStakeAdmin(address owner, uint256 tokenId) public payable onlyAdmin {
        unStake(owner, tokenId);
    }

    function dice(uint256 tokenId, uint256 earned) public onlyAdmin {
        
        StakingInfo storage stakingInfo = stakedInfos[stakedInfoIndexes[tokenId]];

        stakingInfo.playBlockNumber = block.number;
        stakingInfo.accEarned = stakingInfo.accEarned.add(earned);
    }

    function setWaitTime(uint256 _waitTime) public onlyAdmin {
        waitTime = _waitTime;
    }

    function getMyStakingInfo() public view returns (MyStakingInfo [] memory) {
        uint256 stakingCount = stakedOwnedTokens[msg.sender].length;
        
        MyStakingInfo [] memory result = new MyStakingInfo[](stakingCount);
        for (uint256 i = 0; i < stakingCount; i++) {
            StakingInfo storage stakingInfo = stakedInfos[stakedInfoIndexes[stakedOwnedTokens[msg.sender][i]]];
            result[i].tokenId = stakingInfo.tokenId;
            
            result[i].city = districtInfo.getAttribute(stakingInfo.tokenId, "City");
            result[i].country = stakingInfo.country;
            result[i].tier = districtInfo.getAttribute(stakingInfo.tokenId, "Tier").toInt();
            result[i].level = districtInfo.getAttribute(stakingInfo.tokenId, "Level").toInt();
            result[i].stakedBlockNumber = stakingInfo.stakedBlockNumber;
            result[i].playBlockNumber = stakingInfo.playBlockNumber;
            
            uint256 lastJobBlockNumber;
            if (stakingInfo.stakedBlockNumber > stakingInfo.playBlockNumber) {
                lastJobBlockNumber = stakingInfo.stakedBlockNumber;
            } else {
                lastJobBlockNumber = stakingInfo.playBlockNumber;
            }
            
            if (block.number >= lastJobBlockNumber + waitTime) {
                result[i].remainBlockNumber = 0;
            } else {
                result[i].remainBlockNumber = lastJobBlockNumber + waitTime - block.number;
            }

            result[i].accEarned = stakingInfo.accEarned;
        }
        return result;
    }

    function getStakingTokenIds(address owner) public view returns (uint256 [] memory) {
        return stakedOwnedTokens[owner];
    }

    function getStakingInfos(address owner) public view returns (StakingInfo [] memory) {
        
        uint256 [] memory tokenIds = stakedOwnedTokens[owner];
        StakingInfo [] memory result = new StakingInfo[](tokenIds.length);

        for (uint256 i = 0; i < tokenIds.length; i++) {
            result[i] = stakedInfos[stakedInfoIndexes[tokenIds[i]]];
        }

        return result;
    }

    function getStakingInfos(uint256 [] memory tokenIds) public view returns (StakingInfo [] memory) {
        
        uint256 resultCount;

        for (uint256 i = 0; i < tokenIds.length; i++) {
            if (existStakedInfos[tokenIds[i]] == true) {
                resultCount++;
            }
        }

        StakingInfo [] memory result = new StakingInfo[](resultCount);

        uint256 index;
        for (uint256 i = 0; i < tokenIds.length; i++) {
            if (existStakedInfos[tokenIds[i]] == true) {
                result[index] = stakedInfos[stakedInfoIndexes[tokenIds[i]]];
                index++;
            }
        }

        return result;
    }

    function getTokenIdsByCountry(string [] memory countries) public view returns (CountryStakingTokenIds [] memory) {
        CountryStakingTokenIds [] memory result = new CountryStakingTokenIds[](countries.length);
        for(uint256 i = 0; i < countries.length; i++) {
            result[i].country = countries[i];
            result[i].tokenIds = countryStakedTokenIds[countries[i]];
        }
        return result;
    }

    function getTokenCountByCountry(string [] memory countries) public view returns (uint256[] memory) {
        uint256 [] memory result = new uint256[](countries.length);
        for(uint256 i = 0; i < countries.length; i++) {
            result[i] = countryStakedTokenIds[countries[i]].length;
        }
        return result;
    }

    function getOwnersByCountry(string memory country) public view returns (address [] memory) {
        uint256 [] storage tokenIds = countryStakedTokenIds[country];
        address [] memory result = new address[](tokenIds.length);
        
        for(uint256 i = 0; i < tokenIds.length; i++) {
            result[i] = stakedInfos[stakedInfoIndexes[tokenIds[i]]].owner;
        }
        return result;
    }

    function unStake(address account, uint256 tokenId) private {
        require(existStakedInfos[tokenId] == true, "not staked");

        uint256 index = stakedInfoIndexes[tokenId];
        StakingInfo storage info = stakedInfos[index];
        string memory country = info.country;
        require(info.owner == account, "different owner and msg.sender");

        deleteStakingInfo(tokenId);
        deleteOwnedToken(account, tokenId);
        deleteCountryToken(country, tokenId);

        district.transferFrom(address(this), account, tokenId);
        
        emit UnStake(account, tokenId);
    }

    function addStakingInfo(uint256 tokenId, string memory country) private {
        
        stakedInfos.push(StakingInfo({
            owner : msg.sender,
            tokenId : tokenId,
            country : country,
            stakedBlockNumber : block.number,
            playBlockNumber : 0,
            accEarned : 0
        }));
        stakedInfoIndexes[tokenId] = stakedInfos.length - 1;
        existStakedInfos[tokenId] = true;

        stakedOwnedTokens[msg.sender].push(tokenId);
        stakedOwnedTokensIndexes[tokenId] = stakedOwnedTokens[msg.sender].length - 1;

        countryStakedTokenIds[country].push(tokenId);
        countryStakedTokenIdIndexes[tokenId] = countryStakedTokenIds[country].length - 1;
    }

    function deleteStakingInfo(uint256 tokenId) private {
        uint256 index = stakedInfoIndexes[tokenId];
        uint256 lastIndex = stakedInfos.length - 1;
        
        if (index != lastIndex) {
            StakingInfo storage temp = stakedInfos[lastIndex];
            stakedInfoIndexes[temp.tokenId] = index;
            stakedInfos[index] = temp;
        }
       
        stakedInfos.length--;
        delete stakedInfoIndexes[tokenId];
        delete existStakedInfos[tokenId];
    }

    function deleteOwnedToken(address account, uint256 tokenId) private {
        uint256 [] storage tokenIds = stakedOwnedTokens[account];
        uint256 index = stakedOwnedTokensIndexes[tokenId];
        uint256 lastIndex = tokenIds.length - 1;
        
        if (index != lastIndex) {
            uint256 temp = tokenIds[lastIndex];
            stakedOwnedTokensIndexes[temp] = index;
            tokenIds[index] = temp;
        }
       
        tokenIds.length--;
        delete stakedOwnedTokensIndexes[tokenId];
    }

    function deleteCountryToken(string memory country, uint256 tokenId) private {
        uint256 [] storage tokenIds = countryStakedTokenIds[country];
        uint256 index = countryStakedTokenIdIndexes[tokenId];
        uint256 lastIndex = tokenIds.length - 1;
        
        if (index != lastIndex) {
            uint256 temp = tokenIds[lastIndex];
            countryStakedTokenIdIndexes[temp] = index;
            tokenIds[index] = temp;
        }
       
        tokenIds.length--;
        delete countryStakedTokenIdIndexes[tokenId];
    }
}