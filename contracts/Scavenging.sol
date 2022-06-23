pragma solidity 0.5.6;
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
    constructor() internal {
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
    function sub(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
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
    function div(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
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
    function mod(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
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
        mapping(address => bool) bearer;
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

contract PauserRole {
    using Roles for Roles.Role;

    event PauserAdded(address indexed account);
    event PauserRemoved(address indexed account);

    Roles.Role private _pausers;

    constructor() internal {
        _addPauser(msg.sender);
    }

    modifier onlyPauser() {
        require(isPauser(msg.sender), "PauserRole: caller does not have the Pauser role");
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
    constructor() internal {
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
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);

    /**
     * @dev Moves `amount` tokens from the caller's account to `recipient`.
     */
    function safeTransfer(
        address recipient,
        uint256 amount,
        bytes memory data
    ) public;

    /**
     * @dev  Moves `amount` tokens from the caller's account to `recipient`.
     */
    function safeTransfer(address recipient, uint256 amount) public;

    /**
     * @dev Moves `amount` tokens from `sender` to `recipient` using the allowance mechanism.
     * `amount` is then deducted from the caller's allowance.
     */
    function safeTransferFrom(
        address sender,
        address recipient,
        uint256 amount,
        bytes memory data
    ) public;

    /**
     * @dev Moves `amount` tokens from `sender` to `recipient` using the allowance mechanism.
     * `amount` is then deducted from the caller's allowance.
     */
    function safeTransferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) public;

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

contract AdminRole {
    using Roles for Roles.Role;

    event AdminAdded(address indexed account);
    event AdminRemoved(address indexed account);

    Roles.Role private _admins;

    constructor() internal {
        _addAdmin(msg.sender);
    }

    modifier onlyAdmin() {
        require(isAdmin(msg.sender), "AdminRole: caller does not have the Admin role");
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

    function getStakingTokenIds(address owner) public view returns (uint256[] memory);

    function getStakingInfos(address owner) public view returns (StakingInfo[] memory);

    function getStakingInfos(uint256[] memory tokenIds) public view returns (StakingInfo[] memory);

    function getOwnersByCountry(string memory country) public view returns (address[] memory);

    function setWaitTime(uint256 _waitTime) public;
}

contract IDistrictInfo is AdminRole {
    function getAttribute(uint256 tokenId, string memory key) public view returns (string memory);

    function getAttribute(uint256[] memory tokenId, string memory key) public view returns (string[] memory);

    function setAttribute(
        uint256 tokenId,
        string memory key,
        string memory value
    ) public;

    function getTokenIdsByCountry(string memory country) public view returns (uint256[] memory);
}

contract ReentrancyGuard {
    bool public entered = false;

    modifier nonReentrant() {
        require(!entered, "ReentrancyGuard: prevent execute function asynchronous");

        entered = true;

        _;

        entered = false;
    }
}

library Helper {
    function toInt(string memory _value) internal pure returns (uint256 _ret) {
        bytes memory _bytesValue = bytes(_value);
        uint256 j = 1;

        for (uint256 i = _bytesValue.length - 1; i >= 0 && i < _bytesValue.length; i--) {
            assert(uint8(_bytesValue[i]) >= 48 && uint8(_bytesValue[i]) <= 57);
            _ret += (uint8(_bytesValue[i]) - 48) * j;
            j *= 10;
        }
    }

    function compare(string memory org, string memory dst) internal pure returns (bool) {
        return keccak256(abi.encodePacked(org)) == keccak256(abi.encodePacked(dst));
    }

    function toString(uint256 _i) internal pure returns (string memory _uintAsString) {
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

contract Scavenging is Ownable, ReentrancyGuard, Pausable, AdminRole {
    using SafeMath for uint256;
    using Helper for string;

    enum PoolType {
        Open,
        Day,
        LPToken
    }

    /* ========== STATE VARIABLES ========== */

    IKIP7 public rewardsToken;
    IKIP7 public stakingToken;
    ICountryVault public countryVault;
    IDistrictStaking public districtStaking;
    IDistrictInfo public districtInfo;

    uint256 public periodFinish = 0;
    uint256 public periodStart = 0;

    uint256 public rewardRate = 0;
    uint256 public rewardsDuration = 120 days;
    uint256 public lastUpdateTime;
    uint256 public rewardPerTokenStored;

    mapping(address => uint256) public userRewardPerTokenPaid;

    mapping(address => uint256) public rewards;

    uint256 private _totalSupply;
    mapping(address => uint256) private _balances;

    mapping(address => uint256) private stakedBlockNumbers;

    address[] private stakers;
    mapping(address => uint256) private stakerIndexes;

    address[] private rewardUsers;
    mapping(address => uint256) private rewardUserIndexes;

    PoolType public poolType;
    uint256 public poolValue;
    string public country;
    uint256 public taxRateExist;
    uint256 public taxRateNonExist;
    uint256 public levelLimit;

    /* ========== CONSTRUCTOR ========== */

    constructor(
        IKIP7 _rewardsToken,
        IKIP7 _stakingToken,
        ICountryVault _countryVault,
        IDistrictStaking _districtStaking,
        IDistrictInfo _districtInfo,
        PoolType _poolType,
        uint256 _poolValue,
        string memory _country,
        uint256 _taxRateExist,
        uint256 _taxRateNonExist,
        uint256 _levelLimit
    ) public {
        rewardsToken = _rewardsToken;
        stakingToken = _stakingToken;
        countryVault = _countryVault;
        districtStaking = _districtStaking;
        districtInfo = _districtInfo;

        poolType = _poolType;
        poolValue = _poolValue;
        country = _country;
        taxRateExist = _taxRateExist;
        taxRateNonExist = _taxRateNonExist;
        levelLimit = _levelLimit;

        periodStart = 9999999999;
    }

    function setContract(
        IKIP7 _rewardsToken,
        IKIP7 _stakingToken,
        ICountryVault _countryVault,
        IDistrictStaking _districtStaking,
        IDistrictInfo _districtInfo
    ) public onlyOwner {
        rewardsToken = _rewardsToken;
        stakingToken = _stakingToken;
        countryVault = _countryVault;
        districtStaking = _districtStaking;
        districtInfo = _districtInfo;
    }

    function setVariable(
        PoolType _poolType,
        uint256 _poolValue,
        string memory _country,
        uint256 _taxRateExist,
        uint256 _taxRateNonExist,
        uint256 _levelLimit
    ) public onlyAdmin {
        poolType = _poolType;
        poolValue = _poolValue;
        country = _country;
        taxRateExist = _taxRateExist;
        taxRateNonExist = _taxRateNonExist;
        levelLimit = _levelLimit;
    }

    /* ========== VIEWS ========== */

    function totalSupply() external view returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address account) external view returns (uint256) {
        return _balances[account];
    }

    function lastTimeRewardApplicable() public view returns (uint256) {
        return block.number < periodFinish ? block.number : periodFinish;
    }

    function rewardPerToken() public view returns (uint256) {
        if (_totalSupply == 0) {
            return rewardPerTokenStored;
        }
        return rewardPerTokenStored.add(lastTimeRewardApplicable().sub(lastUpdateTime).mul(rewardRate).mul(1e18).div(_totalSupply));
    }

    function earned(address account) public view returns (uint256) {
        return _balances[account].mul(rewardPerToken().sub(userRewardPerTokenPaid[account])).div(1e18).add(rewards[account]);
    }

    function getRewardForDuration() external view returns (uint256) {
        return rewardRate.mul(rewardsDuration);
    }

    function getInfo(address account)
        public
        view
        returns (
            string memory,
            uint256,
            uint256,
            uint256,
            uint256,
            uint256,
            uint256
        )
    {
        uint256 remainBlockNumber;
        if (poolType == PoolType.Day && _balances[account] > 0) {
            uint256 timeLapse = block.number - stakedBlockNumbers[account];
            if (timeLapse > poolValue) {
                remainBlockNumber = 0;
            } else {
                remainBlockNumber = poolValue - timeLapse;
            }
        }

        return (country, rewardRate, rewardsDuration, _totalSupply, _balances[account], earned(account), remainBlockNumber);
    }

    function getInfo2(address account)
        public
        view
        returns (
            bool,
            bool,
            uint256,
            uint256,
            uint256,
            uint256,
            uint256
        )
    {
        return (checkStakedDistrictLevel(account), checkStakedDistrictCountry(account), taxRateExist, taxRateNonExist, levelLimit, periodStart, poolValue);
    }

    /* ========== MUTATIVE FUNCTIONS ========== */

    function stake(uint256 amount) external nonReentrant whenNotPaused updateReward(msg.sender) {
        if (poolType == PoolType.Day) {
            require(_balances[msg.sender] < 1, "prevent double stake");
        }

        require(block.number >= periodStart, "block.number must be greater than equal to periodStart");
        require(amount > 0, "Cannot stake 0");

        if (levelLimit > 0) {
            bool checkLevel = checkStakedDistrictLevel(msg.sender);
            require(checkLevel, "level limit");
        }

        if (_balances[msg.sender] == 0) {
            stakers.push(msg.sender);
            stakerIndexes[msg.sender] = stakers.length - 1;
        }

        stakedBlockNumbers[msg.sender] = block.number;

        _totalSupply = _totalSupply.add(amount);
        _balances[msg.sender] = _balances[msg.sender].add(amount);

        if (poolType == PoolType.LPToken) {
            stakingToken.transferFrom(msg.sender, address(0), amount);
        } else {
            stakingToken.transferFrom(msg.sender, address(this), amount);
        }

        emit Staked(msg.sender, block.number, amount);
    }

    function withdraw(uint256 amount) public {
        require(poolType == PoolType.Open, "only can withdraw Open Type");
        withdrawPrivate(msg.sender, amount);
    }

    function getReward() public {
        require(poolType == PoolType.Open || poolType == PoolType.LPToken, "only can getReward Open, LPToken Type");
        getRewardPrivate(msg.sender);
    }

    function exit() external {
        require(poolType == PoolType.Day, "only can exit Day Type");

        require(block.number >= stakedBlockNumbers[msg.sender] + poolValue, "");

        withdrawPrivate(msg.sender, _balances[msg.sender]);
        getRewardPrivate(msg.sender);
    }

    function withdrawAll(uint256 count) external onlyAdmin {
        uint256 stakerCount = stakers.length;
        uint256 workCnt = stakerCount;

        if (count < stakerCount) {
            workCnt = count;
        }

        for (uint256 i = 0; i < workCnt; i++) {
            address staker = stakers[stakerCount - 1 - i];
            withdrawPrivate(staker, _balances[staker]);
        }

        emit WithdrawAll(msg.sender, workCnt);
    }

    function rewardAll(uint256 count) external onlyAdmin {
        uint256 rewardUserCount = rewardUsers.length;
        uint256 workCnt = rewardUserCount;

        if (count < rewardUserCount) {
            workCnt = count;
        }

        for (uint256 i = 0; i < workCnt; i++) {
            address rewardUser = rewardUsers[rewardUserCount - 1 - i];
            getRewardPrivate(rewardUser);
        }

        emit RewardAll(msg.sender, workCnt);
    }

    /* ========== RESTRICTED FUNCTIONS ========== */

    function notifyRewardAmount(uint256 reward) external onlyAdmin updateReward(address(0)) {
        if (block.number >= periodFinish) {
            rewardRate = reward.div(rewardsDuration);
        } else {
            uint256 remaining = periodFinish.sub(block.number);
            uint256 leftover = remaining.mul(rewardRate);
            rewardRate = reward.add(leftover).div(rewardsDuration);
        }

        // Ensure the provided reward amount is not more than the balance in the contract.
        // This keeps the reward rate in the right range, preventing overflows due to
        // very high values of rewardRate in the earned and rewardsPerToken functions;
        // Reward + leftover must be less than 2^256 / 10^18 to avoid overflow.
        uint256 balance = rewardsToken.balanceOf(address(this));
        require(rewardRate <= balance.div(rewardsDuration), "Provided reward too high");

        lastUpdateTime = block.number;
        periodFinish = periodStart.add(rewardsDuration);
        emit RewardAdded(reward);
    }

    // Added to support recovering LP Rewards from other systems such as BAL to be distributed to holders
    function recoverKIP7(address tokenAddress, uint256 tokenAmount) external onlyAdmin {
        require(tokenAddress != address(stakingToken), "Cannot withdraw the staking token");
        IKIP7(tokenAddress).transfer(msg.sender, tokenAmount);
        emit Recovered(tokenAddress, tokenAmount);
    }

    function setRewardsDuration(uint256 _periodStart, uint256 _rewardsDuration) external onlyAdmin {
        rewardsDuration = _rewardsDuration;
        periodStart = _periodStart;

        // Ensure the provided reward amount is not more than the balance in the contract.
        // This keeps the reward rate in the right range, preventing overflows due to
        // very high values of rewardRate in the earned and rewardsPerToken functions;
        // Reward + leftover must be less than 2^256 / 10^18 to avoid overflow.
        uint256 balance = rewardsToken.balanceOf(address(this));
        require(rewardRate <= balance.div(rewardsDuration), "Provided reward too high");

        emit RewardsDurationUpdated(periodStart, rewardsDuration);
    }

    /* ========== PRIVATE FUNCTIONS ========== */
    function withdrawPrivate(address account, uint256 amount) private nonReentrant updateReward(account) {
        require(amount > 0, "Cannot withdraw 0");
        _totalSupply = _totalSupply.sub(amount);
        _balances[account] = _balances[account].sub(amount);

        if (poolType != PoolType.LPToken) {
            stakingToken.transfer(account, amount);
        }

        if (_balances[account] == 0) {
            deleteStaker(account);
        }

        emit Withdrawn(account, block.number, amount);
    }

    function getRewardPrivate(address account) private nonReentrant updateReward(account) {
        uint256 reward = rewards[account];
        if (reward > 0) {
            rewards[account] = 0;

            uint256 vaultAmount = 0;
            bool stakedCountry = checkStakedDistrictCountry(account);
            if (stakedCountry == true) {
                vaultAmount = reward.mul(taxRateExist).div(100);
            } else {
                vaultAmount = reward.mul(taxRateNonExist).div(100);
            }

            rewardsToken.transfer(address(countryVault), vaultAmount);
            countryVault.addOrb(country, vaultAmount);
            uint256 userAmount = reward.sub(vaultAmount);
            rewardsToken.transfer(account, userAmount);

            deleteRewardUser(account);

            emit RewardPaid(account, userAmount, vaultAmount);
        }
    }

    function deleteStaker(address account) private {
        uint256 index = stakerIndexes[account];
        uint256 lastIndex = stakers.length - 1;

        if (index != lastIndex) {
            address temp = stakers[lastIndex];
            stakerIndexes[temp] = index;
            stakers[index] = temp;
        }

        stakers.length--;
        delete stakerIndexes[account];
    }

    function deleteRewardUser(address account) private {
        uint256 index = rewardUserIndexes[account];
        uint256 lastIndex = rewardUsers.length - 1;

        if (index != lastIndex) {
            address temp = rewardUsers[lastIndex];
            rewardUserIndexes[temp] = index;
            rewardUsers[index] = temp;
        }

        rewardUsers.length--;
        delete rewardUserIndexes[account];
    }

    function checkStakedDistrictLevel(address account) private view returns (bool) {
        bool result;
        uint256[] memory tokenIds = districtStaking.getStakingTokenIds(account);
        for (uint256 i = 0; i < tokenIds.length; i++) {
            uint256 level = districtInfo.getAttribute(tokenIds[i], "Level").toInt();
            if (level >= levelLimit) {
                result = true;
                break;
            }
        }

        return result;
    }

    function checkStakedDistrictCountry(address account) private view returns (bool) {
        // check staking have country
        uint256[] memory stakingTokenIds = districtStaking.getStakingTokenIds(account);
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

    /* ========== MODIFIERS ========== */

    modifier updateReward(address account) {
        rewardPerTokenStored = rewardPerToken();
        lastUpdateTime = lastTimeRewardApplicable();
        if (account != address(0)) {
            uint256 oldReward = rewards[account];
            rewards[account] = earned(account);
            userRewardPerTokenPaid[account] = rewardPerTokenStored;

            if (oldReward == 0 && rewards[account] > 0) {
                rewardUsers.push(account);
                rewardUserIndexes[account] = rewardUsers.length - 1;
            }
        }
        _;
    }

    /* ========== EVENTS ========== */

    event RewardAdded(uint256 reward);
    event Staked(address indexed user, uint256 blockNumber, uint256 amount);
    event Withdrawn(address indexed user, uint256 blockNumber, uint256 amount);
    event RewardPaid(address indexed user, uint256 userAmount, uint256 vaultAmount);
    event RewardsDurationUpdated(uint256 periodStart, uint256 newDuration);
    event Recovered(address token, uint256 amount);
    event WithdrawAll(address indexed user, uint256 workCnt);
    event RewardAll(address indexed user, uint256 workCnt);
}
