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
 * @dev Interface of the KIP7 standard as defined in the KIP. Does not include
 * the optional functions; to access them see `KIP7Metadata`.
 * See http://kips.klaytn.com/KIPs/kip-7-fungible_token
 */
contract IKIP7 is IKIP13 {
    /**
     * @dev Returns the amount of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves `amount` tokens from the caller's account to `recipient`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a `Transfer` event.
     */
    function transfer(address recipient, uint256 amount) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through `transferFrom`. This is
     * zero by default.
     *
     * This value changes when `approve` or `transferFrom` are called.
     */
    function allowance(address owner, address spender) external view returns (uint256);

    /**
     * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * > Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an `Approval` event.
     */
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * @dev Moves `amount` tokens from `sender` to `recipient` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a `Transfer` event.
     */
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

    /**
    * @dev Moves `amount` tokens from the caller's account to `recipient`.
    */
    function safeTransfer(address recipient, uint256 amount, bytes memory data) public;

    /**
    * @dev  Moves `amount` tokens from the caller's account to `recipient`.
    */
    function safeTransfer(address recipient, uint256 amount) public;

    /**
    * @dev Moves `amount` tokens from `sender` to `recipient` using the allowance mechanism.
    * `amount` is then deducted from the caller's allowance.
    */
    function safeTransferFrom(address sender, address recipient, uint256 amount, bytes memory data) public;

    /**
    * @dev Moves `amount` tokens from `sender` to `recipient` using the allowance mechanism.
    * `amount` is then deducted from the caller's allowance.
    */
    function safeTransferFrom(address sender, address recipient, uint256 amount) public;

    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to `approve`. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);
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

contract IDistrictInfo is AdminRole {
    function getAttribute(uint256 tokenId, string memory key) public view returns (string memory);
    function getAttribute(uint256 [] memory tokenId, string memory key) public view returns (string [] memory);
    function setAttribute(uint256 tokenId, string memory key, string memory value) public;
    function getTokenIdsByCountry(string memory country) public view returns (uint256 [] memory);
}

contract ICountryVault is AdminRole {
    function addLay(string memory country, uint256 amount) public;
    function addOrb(string memory country, uint256 amount) public;
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

contract ReentrancyGuardByUint256 {
    mapping(uint256 => bool) public entered;

    modifier nonReentrantUint256(uint256 value) {
        require(
            !entered[value],
            'ReentrancyGuardByString: prevent execute function asynchronous'
        );

        entered[value] = true;

        _;

        entered[value] = false;
    }
}

contract DiceGame is Ownable, AdminRole, Pausable, ReentrancyGuardByUint256 {
    using SafeMath for uint256;
    using Helper for string;
    using Helper for uint256;

    struct PlayInfo {
        address user;
        uint256 currentStep;
        bool isStartPos;
    }

    IKIP7 public lay;
    IKIP17Enumerable public district;
    IDistrictInfo public districtInfo;
    ICountryVault public countryVault;
    IDistrictStaking public districtStaking;

    // country name
    string [] public board;
    // country name => array index
    mapping(string => uint256) private boardIndexes;
    // country name => bool
    mapping(string => bool) private existCountryInBoard;

    // tier => reward
    mapping(uint256 => uint256) public tierReward;

    // level => multiply (ex 50%, 100%)
    mapping(uint256 => uint256) public levelMultiply;

    uint256 public maxLevel;
    uint256 public minTier;
    uint256 public randomFrom;
    uint256 public randomTo;

    PlayInfo [] private playInfos;
    mapping(address => uint256) private playInfoIndexes;
    mapping(address => bool) private existPlayInfos;

    uint256 public countryRate;
    uint256 public waitTime;
    uint256 public startBlockNumber;

    event Dice(address indexed user, uint256 indexed tokenId, uint256 pos, uint256 earn, uint256 tax);
    event RemoveAllPlayInfo(address indexed user, uint256 workCnt);

    constructor(IKIP7 _lay, IKIP17Enumerable _district, IDistrictInfo _districtInfo, ICountryVault _countryVault, IDistrictStaking _districtStaking) public {
        
        lay = _lay;
        district = _district;
        districtInfo = _districtInfo;
        countryVault = _countryVault;
        districtStaking = _districtStaking;

        countryRate = 20;
        randomFrom = 1;
        randomTo = 6;
        startBlockNumber = 0;
    }

    function setContract(IKIP7 _lay, IKIP17Enumerable _district, IDistrictInfo _districtInfo, ICountryVault _countryVault, IDistrictStaking _districtStaking) public onlyOwner {
        lay = _lay;
        district = _district;
        districtInfo = _districtInfo;
        countryVault = _countryVault;
        districtStaking = _districtStaking;
    }

    function addCountry(string [] memory names) public onlyAdmin {
        for (uint i = 0; i < names.length; i++) {
            if (existCountryInBoard[names[i]] == false) {
                board.push(names[i]);

                boardIndexes[names[i]] = board.length - 1;

                existCountryInBoard[names[i]] = true;
            }
        }
    }

    function setReward(uint256 [] memory tiers, uint256 [] memory rewards, uint256 [] memory levels, uint256 [] memory multiplies) public onlyAdmin {
        require(tiers.length == rewards.length, "its different tiers and rewards count");
        require(levels.length == multiplies.length, "its different levels and multiplies count");

        // tier => reward
        for (uint256 i = 0; i < tiers.length; i++) {
            tierReward[tiers[i]] = rewards[i];
            if (tiers[i] > minTier) {
                minTier = tiers[i];
            }
        }
        
        // tier => reward
        for (uint256 i = 0; i < levels.length; i++) {
            levelMultiply[levels[i]] = multiplies[i];
            if (levels[i] > maxLevel) {
                maxLevel = levels[i];
            }
        }
    }

    function setCountryRate(uint256 rate) public onlyAdmin { 
        countryRate = rate;
    }

    function setRandomRange(uint256 from, uint256 high) public onlyAdmin {
        randomFrom = from;
        randomTo = high;
    }

    function setWaitTime(uint256 _waitTime) public onlyAdmin {
        waitTime = _waitTime;
        districtStaking.setWaitTime(waitTime);
    }

    function setStartBlockNumber(uint256 _startBlockNumber) public onlyAdmin {
        startBlockNumber = _startBlockNumber;
    }

    function removeAllPlayInfo(uint256 count) public onlyAdmin whenPaused {
        uint256 playInfoCount = playInfos.length;
        uint256 workCnt = playInfoCount;

        if (count > 0 && count < playInfoCount) {
            workCnt = count;
        }
        
        for (uint256 i = 0; i < workCnt; i++) {
            removePlayInfo(playInfos[playInfoCount - 1 - i].user);
        }

        emit RemoveAllPlayInfo(msg.sender, workCnt);
    }

    function dice(uint256 tokenId) public whenNotPaused nonReentrantUint256(tokenId) {
        
        require(block.number >= startBlockNumber, "start blocknumber");

        (IDistrictStaking.StakingInfo memory stakingInfo, bool exist) = districtStaking.getStakingInfo(tokenId);
        
        require(exist == true, "no stakeing info");
        require(stakingInfo.owner == msg.sender, "this is not your district");
        
        require(block.number >= stakingInfo.stakedBlockNumber + waitTime, "need to wait for one day after staking");
        require(block.number >= stakingInfo.playBlockNumber + waitTime, "need to wait for one day after playing");
        
        if (existPlayInfos[msg.sender] == false) {
            playInfos.push(PlayInfo({
                user : msg.sender,
                currentStep : 0,
                isStartPos : true
            }));
            playInfoIndexes[msg.sender] = playInfos.length - 1;
            existPlayInfos[msg.sender] = true;
        }

        PlayInfo storage playInfo = playInfos[playInfoIndexes[msg.sender]];

        uint256 diceNumber = random();

        if (playInfo.isStartPos == true) {
            playInfo.isStartPos = false;
            playInfo.currentStep = (diceNumber - 1) % board.length;            
        } else {
            playInfo.currentStep = (playInfo.currentStep + diceNumber) % board.length;            
        }
        
        string memory nextCountry = board[playInfo.currentStep];

        uint256 level = districtInfo.getAttribute(tokenId, "Level").toInt();

        uint256 tier = districtInfo.getAttribute(tokenId, "Tier").toInt();

        uint256 reward = tierReward[tier].add(tierReward[tier].mul(levelMultiply[level]).div(100));
        
        require(lay.balanceOf(address(this)) >= reward, "not enough lay balance this contract");

        bool haveCountry = haveCountry(msg.sender, nextCountry);

        uint256 userReward = 0;
        uint256 countryReward = 0;
        
        if (haveCountry == true) {
            countryReward = 0;
            userReward = reward;

            lay.transfer(msg.sender, reward);
        } else {
            countryReward = reward.mul(countryRate).div(100);
            userReward = reward.sub(countryReward);
            
            lay.transfer(msg.sender, userReward);
            
            countryVault.addLay(nextCountry, countryReward);
            lay.transfer(address(countryVault), countryReward);
        }

        districtStaking.dice(tokenId, userReward);

        emit Dice(msg.sender, tokenId, playInfo.currentStep, userReward, countryReward);
    }

    function emergencyWithdraw(address guardian) public payable onlyAdmin {
        lay.transfer(guardian, lay.balanceOf(address(this)));
    }

    function renounceAdmin() public onlyAdmin {
        countryVault.renounceAdmin();
        districtStaking.renounceAdmin();
    }

    function getMyPlayInfo() public view returns (PlayInfo memory, bool) {
        if (existPlayInfos[msg.sender] == true) {
            return (playInfos[playInfoIndexes[msg.sender]], existPlayInfos[msg.sender]);
        } else {
            return (PlayInfo ({ 
                user : address(0),
                currentStep: 0,
                isStartPos: false
            }), existPlayInfos[msg.sender]);
        }
        
    }

    function getPlayInfos() public view returns (PlayInfo [] memory) {
        return playInfos;
    }

    // return values (tierReward, levelMultiply)
    function getReward() public view returns(uint256 [] memory, uint256 [] memory) {
        uint256 [] memory resultTierReward = new uint256[](minTier);
        uint256 [] memory resultLevelMultiply = new uint256[](maxLevel);

        for (uint256 i = 1; i <= minTier; i++) {
            resultTierReward[i-1] = tierReward[i];
        }

        for (uint256 i = 1; i <= maxLevel; i++) {
            resultLevelMultiply[i-1] = levelMultiply[i];
        }

        return (resultTierReward, resultLevelMultiply);
    }

    function haveCountry(address sender, string memory country) public view returns (bool) {
        // check staking have country
        uint256 [] memory stakingTokenIds = districtStaking.getStakingTokenIds(sender);
        bool result = false;

        for (uint256 i = 0; i < stakingTokenIds.length; i++) {
            string memory myCountry = districtInfo.getAttribute(stakingTokenIds[i], "Country");
            if (country.compare(myCountry) == true) {
                result = true;
                break;
            }
        }

        return result;
    }

    function getMyStakedCountries() public view returns(string [] memory) {
        
        uint256 [] memory stakingTokenIds = districtStaking.getStakingTokenIds(msg.sender);
        
        string [] memory result = new string[](stakingTokenIds.length);
        uint256 countryCount = 0;

        for(uint256 i = 0;  i < stakingTokenIds.length; i++) {
            string memory myCountry = districtInfo.getAttribute(stakingTokenIds[i], "Country");
            result[countryCount] = myCountry;
            countryCount = countryCount + 1;
        }

        return result;
    }

    function getBoard() public view returns(string [] memory) {
        return board;
    }
    
    function removePlayInfo(address account) private {
        uint256 index = playInfoIndexes[account];
        uint256 lastIndex = playInfos.length - 1;
        
        if (index != lastIndex) {
            PlayInfo storage temp = playInfos[lastIndex];
            playInfoIndexes[temp.user] = index;
            playInfos[index] = temp;
        }
       
        playInfos.length--;
        delete playInfoIndexes[account];
        delete existPlayInfos[account];
    }

    function random() private view returns (uint256) {
        uint256 seed = uint256(keccak256(abi.encodePacked(
            block.difficulty +
            ((uint256(keccak256(abi.encodePacked(block.coinbase)))) / (now)) +
            block.gaslimit + 
            ((uint256(keccak256(abi.encodePacked(msg.sender)))) / (now)) +
            block.number
        )));

        return seed % (randomTo - randomFrom + 1) + randomFrom;
    }
}