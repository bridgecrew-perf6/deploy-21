// SPDX-License-Identifier: MIT
pragma solidity 0.8.6;

// OpenZeppelin Contracts v4.4.1 (utils/Context.sol)
/**
 * @dev Provides information about the current execution context, including the
 * sender of the transaction and its data. While these are generally available
 * via msg.sender and msg.data, they should not be accessed in such a direct
 * manner, since when dealing with meta-transactions the account sending and
 * paying for execution may not be the actual sender (as far as an application
 * is concerned).
 *
 * This contract is only required for intermediate, library-like contracts.
 */
abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes calldata) {
        return msg.data;
    }
}

// OpenZeppelin Contracts v4.4.1 (access/Ownable.sol)
/**
 * @dev Contract module which provides a basic access control mechanism, where
 * there is an account (an owner) that can be granted exclusive access to
 * specific functions.
 *
 * By default, the owner account will be the one that deploys the contract. This
 * can later be changed with {transferOwnership}.
 *
 * This module is used through inheritance. It will make available the modifier
 * `onlyOwner`, which can be applied to your functions to restrict their use to
 * the owner.
 */
abstract contract Ownable is Context {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor() {
        _transferOwnership(_msgSender());
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view virtual returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        require(owner() == _msgSender(), "Ownable: caller is not the owner");
        _;
    }

    /**
     * @dev Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions anymore. Can only be called by the current owner.
     *
     * NOTE: Renouncing ownership will leave the contract without an owner,
     * thereby removing any functionality that is only available to the owner.
     */
    function renounceOwnership() public virtual onlyOwner {
        _transferOwnership(address(0));
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        _transferOwnership(newOwner);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Internal function without access restriction.
     */
    function _transferOwnership(address newOwner) internal virtual {
        address oldOwner = _owner;
        _owner = newOwner;
        emit OwnershipTransferred(oldOwner, newOwner);
    }
}

// OpenZeppelin Contracts v4.4.1 (security/Pausable.sol)
/**
 * @dev Contract module which allows children to implement an emergency stop
 * mechanism that can be triggered by an authorized account.
 *
 * This module is used through inheritance. It will make available the
 * modifiers `whenNotPaused` and `whenPaused`, which can be applied to
 * the functions of your contract. Note that they will not be pausable by
 * simply including this module, only once the modifiers are put in place.
 */
abstract contract Pausable is Context {
    /**
     * @dev Emitted when the pause is triggered by `account`.
     */
    event Paused(address account);

    /**
     * @dev Emitted when the pause is lifted by `account`.
     */
    event Unpaused(address account);

    bool private _paused;

    /**
     * @dev Initializes the contract in unpaused state.
     */
    constructor() {
        _paused = false;
    }

    /**
     * @dev Returns true if the contract is paused, and false otherwise.
     */
    function paused() public view virtual returns (bool) {
        return _paused;
    }

    /**
     * @dev Modifier to make a function callable only when the contract is not paused.
     *
     * Requirements:
     *
     * - The contract must not be paused.
     */
    modifier whenNotPaused() {
        require(!paused(), "Pausable: paused");
        _;
    }

    /**
     * @dev Modifier to make a function callable only when the contract is paused.
     *
     * Requirements:
     *
     * - The contract must be paused.
     */
    modifier whenPaused() {
        require(paused(), "Pausable: not paused");
        _;
    }

    /**
     * @dev Triggers stopped state.
     *
     * Requirements:
     *
     * - The contract must not be paused.
     */
    function _pause() internal virtual whenNotPaused {
        _paused = true;
        emit Paused(_msgSender());
    }

    /**
     * @dev Returns to normal state.
     *
     * Requirements:
     *
     * - The contract must be paused.
     */
    function _unpause() internal virtual whenPaused {
        _paused = false;
        emit Unpaused(_msgSender());
    }
}

// OpenZeppelin Contracts v4.4.1 (security/ReentrancyGuard.sol)
/**
 * @dev Contract module that helps prevent reentrant calls to a function.
 *
 * Inheriting from `ReentrancyGuard` will make the {nonReentrant} modifier
 * available, which can be applied to functions to make sure there are no nested
 * (reentrant) calls to them.
 *
 * Note that because there is a single `nonReentrant` guard, functions marked as
 * `nonReentrant` may not call one another. This can be worked around by making
 * those functions `private`, and then adding `external` `nonReentrant` entry
 * points to them.
 *
 * TIP: If you would like to learn more about reentrancy and alternative ways
 * to protect against it, check out our blog post
 * https://blog.openzeppelin.com/reentrancy-after-istanbul/[Reentrancy After Istanbul].
 */
abstract contract ReentrancyGuard {
    // Booleans are more expensive than uint256 or any type that takes up a full
    // word because each write operation emits an extra SLOAD to first read the
    // slot's contents, replace the bits taken up by the boolean, and then write
    // back. This is the compiler's defense against contract upgrades and
    // pointer aliasing, and it cannot be disabled.

    // The values being non-zero value makes deployment a bit more expensive,
    // but in exchange the refund on every call to nonReentrant will be lower in
    // amount. Since refunds are capped to a percentage of the total
    // transaction's gas, it is best to keep them low in cases like this one, to
    // increase the likelihood of the full refund coming into effect.
    uint256 private constant _NOT_ENTERED = 1;
    uint256 private constant _ENTERED = 2;

    uint256 private _status;

    constructor() {
        _status = _NOT_ENTERED;
    }

    /**
     * @dev Prevents a contract from calling itself, directly or indirectly.
     * Calling a `nonReentrant` function from another `nonReentrant`
     * function is not supported. It is possible to prevent this from happening
     * by making the `nonReentrant` function external, and making it call a
     * `private` function that does the actual work.
     */
    modifier nonReentrant() {
        // On the first call to nonReentrant, _notEntered will be true
        require(_status != _ENTERED, "ReentrancyGuard: reentrant call");

        // Any calls to nonReentrant after this point will fail
        _status = _ENTERED;

        _;

        // By storing the original value once again, a refund is triggered (see
        // https://eips.ethereum.org/EIPS/eip-2200)
        _status = _NOT_ENTERED;
    }
}

contract TokenHelper {
    function _balanceOf(address token, address account) internal view returns (uint256) {
        if (token == address(this)) {
            return account.balance;
        }

        (bool check, bytes memory data) = address(token).staticcall(abi.encodeWithSignature("balanceOf(address)", account));
        require(check == true, "[TokenHelper] _balanceOf");
        uint256 balance = abi.decode(data, (uint256));
        return balance;
    }

    function _transfer(
        address token,
        address to,
        uint256 amounts
    ) internal {
        /*bytes memory data*/

        if (token == address(this)) {
            payable(to).transfer(amounts);
            return;
        }

        (bool ret, ) = address(token).call(abi.encodeWithSignature("transfer(address,uint256)", to, amounts));
        require(ret == true, "[TokenHelper] transfer");
    }

    function _transferFrom(
        address token,
        address from,
        address to,
        uint256 amounts
    ) internal {
        /*bytes memory data*/
        (bool ret, ) = address(token).call(abi.encodeWithSignature("transferFrom(address,address,uint256)", from, to, amounts));
        require(ret == true, "[TokenHelper] transferFrom");
    }

    function _burnFrom(
        address token,
        address account,
        uint256 amounts
    ) internal {
        (bool ret, ) = address(token).call(abi.encodeWithSignature("burnFrom(address,uint256)", account, amounts));
        require(ret == true, "[TokenHelper] brunFrom");
    }
}

contract TokenVestingPool is Ownable, ReentrancyGuard, Pausable, TokenHelper {
    enum PoolType {
        Open,
        Burn
    }

    struct Period {
        uint256 begin;
        uint256 end;
        uint256 amounts;
    }

    Period[] public periods;

    /* ========== STATE VARIABLES ========== */

    address internal rewardsToken;
    address internal immutable stakingToken;

    uint256 public periodFinish = 0;
    uint256 public periodStart = 0;

    uint256 public rewardRate = 0;
    uint256 public rewardsDuration = 90 days;
    uint256 public lastUpdateTime;
    uint256 public rewardPerTokenStored;

    mapping(address => uint256) public userRewardPerTokenPaid;

    mapping(address => uint256) public rewards;

    uint256 public totalSupply;
    mapping(address => uint256) private _balances;

    mapping(address => uint256) private stakedBlockNumbers;

    address[] public stakers;
    mapping(address => uint256) private stakerIndexes;

    address[] public rewardUsers;
    mapping(address => uint256) private rewardUserIndexes;

    PoolType public immutable poolType;
    uint256 public poolValue;

    constructor(
        address _rewardsToken,
        address _stakingToken,
        PoolType _poolType,
        uint256 _poolValue
    ) {
        if (_rewardsToken == address(0)) {
            rewardsToken = address(this);
        } else {
            rewardsToken = _rewardsToken;
        }

        require(_stakingToken != address(0));
        stakingToken = _stakingToken;
        poolType = _poolType;
        poolValue = _poolValue;
        periodStart = 9999999999;
    }

    function deposit() public payable {
        require(msg.value != 0);
        require(rewardsToken == address(this), "[Deposit] rewardToken is not coin");
    }

    function withdraw(address token) public onlyOwner {
        uint256 amounts = _balanceOf(token, address(this));
        _transfer(token, msg.sender, amounts);
    }

    function setVariable(uint256 _poolValue) public onlyOwner {
        poolValue = _poolValue;
    }

    function balanceOf(address account) external view returns (uint256) {
        return _balances[account];
    }

    function lastTimeRewardApplicable() public view returns (uint256) {
        return block.number < periodFinish ? block.number : periodFinish;
    }

    function rewardPerToken() public view returns (uint256) {
        // no more reward
        if (totalSupply == 0 || lastUpdateTime == 0) {
            return rewardPerTokenStored;
        }

        // not yet
        if (periodStart > block.number) {
            return rewardPerTokenStored;
        }

        return rewardPerTokenStored + ((((lastTimeRewardApplicable() - lastUpdateTime) * rewardRate) * 1e18) / totalSupply);
    }

    function earned(address account) public view returns (uint256) {
        return (((_balances[account] * (rewardPerToken() - userRewardPerTokenPaid[account])) / 1e18) + rewards[account]);
    }

    function getRewardForDuration() external view returns (uint256) {
        return rewardRate * rewardsDuration;
    }

    function getInfo(address account)
        public
        view
        returns (
            PoolType,
            uint256,
            uint256,
            uint256,
            uint256,
            uint256,
            uint256,
            uint256,
            uint256,
            uint256
        )
    {
        uint256 remainBlockNumber = 0;
        if (_balances[account] > 0) {
            uint256 timeLapse = block.number - stakedBlockNumbers[account];
            if (timeLapse < poolValue) {
                remainBlockNumber = poolValue - timeLapse;
            }
        }

        uint256 balance = _balances[account];
        uint256 _earned = earned(account);
        return (poolType, periodStart, periodFinish, rewardRate, rewardsDuration, totalSupply, balance, _earned, poolValue, remainBlockNumber);
    }

    /* ========== MUTATIVE FUNCTIONS ========== */

    function stake(uint256 amount) external nonReentrant whenNotPaused updateReward(msg.sender) {
        require(block.number >= periodStart, "[Stake] blocknumber must be greater than equal to periodStart");
        require(amount > 0, "[Stake] Cannot stake zero");

        if (_balances[msg.sender] == 0) {
            stakers.push(msg.sender);
            stakerIndexes[msg.sender] = stakers.length - 1;
        }

        stakedBlockNumbers[msg.sender] = block.number;

        totalSupply = totalSupply + amount;
        _balances[msg.sender] = _balances[msg.sender] + amount;

        if (poolType == PoolType.Burn) {
            _burnFrom(stakingToken, msg.sender, amount);
        } else {
            _transferFrom(stakingToken, msg.sender, address(this), amount);
        }

        emit Stake(msg.sender, block.number, amount);
    }

    function unstake(uint256 amount) public whenNotPaused {
        require(poolType != PoolType.Burn, "[Unstake] Burn pool can't unstake");
        require(amount > 0, "[Unstake] Cannot stake zero");
        require(_balances[msg.sender] >= amount, "[Unstake] underflow");

        uint256 timeLapse = block.number - stakedBlockNumbers[msg.sender];
        require(timeLapse > poolValue, "[Unstake] locked");
        _unstake(msg.sender, amount);
    }

    function claim() public whenNotPaused {
        _claim(msg.sender);
    }

    function exit() external whenNotPaused {
        require(poolType != PoolType.Burn, "[Exit] Burn pool can't exit");

        require(block.number >= stakedBlockNumbers[msg.sender] + poolValue, "[Exit] you locked");

        _claim(msg.sender);
        _unstake(msg.sender, _balances[msg.sender]);
    }

    function unstakeByIndex(uint256 index) external onlyOwner {
        require(poolType != PoolType.Burn, "[unstakeByIndex] Burn pool can't withdraw");
        require(stakers.length > index, "[unstakeByIndex] overflow");
        address account = stakers[index];
        _claim(account);
        _unstake(account, _balances[account]);
    }

    function rewardByIndex(uint256 index) external onlyOwner {
        require(stakers.length > index, "[rewardByIndex] overflow");

        address account = stakers[index];
        _claim(account);
    }

    function notifyRewardAmount(uint256 reward) external onlyOwner updateReward(address(0)) {
        require(reward > 1e16, "[NotifyRewardAmount] reward more than 1e16");
        if (block.number >= periodFinish) {
            rewardRate = reward / rewardsDuration;
        } else {
            uint256 remaining = periodFinish - block.number;
            uint256 leftover = remaining * rewardRate;
            rewardRate = (reward + leftover) / rewardsDuration;
        }

        // Ensure the provided reward amount is not more than the balance in the contract.
        // This keeps the reward rate in the right range, preventing overflows due to
        // very high values of rewardRate in the earned and rewardsPerToken functions;
        // Reward + leftover must be less than 2^256 / 10^18 to avoid overflow.

        uint256 balance = _balanceOf(rewardsToken, address(this));
        require(rewardRate <= (balance / rewardsDuration), "[NotifyRewardAmount] Provided reward too high");

        lastUpdateTime = block.number;
        periodFinish = periodStart + rewardsDuration;
        emit RewardAdded(reward);
    }

    function setRewardsDuration(uint256 _periodStart, uint256 _rewardsDuration) external onlyOwner updateReward(address(0)) {
        require(_rewardsDuration > 0, "[SetRewardsDuration] _rewardsDuration zero");
        rewardsDuration = _rewardsDuration;
        periodStart = _periodStart;

        lastUpdateTime = block.number;
        periodFinish = periodStart + rewardsDuration;

        uint256 remaining = periodFinish - block.number;
        uint256 leftover = remaining * rewardRate;
        rewardRate = leftover / rewardsDuration;

        if (periods.length > 0) {
            periods.pop();
        }

        // Ensure the provided reward amount is not more than the balance in the contract.
        // This keeps the reward rate in the right range, preventing overflows due to
        // very high values of rewardRate in the earned and rewardsPerToken functions;
        // Reward + leftover must be less than 2^256 / 10^18 to avoid overflow.
        //
        uint256 balance = _balanceOf(rewardsToken, address(this));
        require(rewardRate <= (balance / rewardsDuration), "Provided reward too high");

        emit RewardsDurationUpdated(periodStart, rewardsDuration);
    }

    function setNextReward(uint256 _rewardsDuration, uint256 amounts) external onlyOwner {
        require(_rewardsDuration > 0, "[SetRewardsDuration] _rewardsDuration zero");
        require(amounts > 1e16, "[SetRewardsDuration] amounts more than 1e16");
        if (periods.length > 0) {
            periods.pop();
        }

        _updateReward(address(0));

        if (periodFinish > block.number) {
            periods.push(Period({begin: periodFinish, end: periodFinish + _rewardsDuration, amounts: amounts}));
        } else {
            periods.push(Period({begin: block.number, end: block.number + _rewardsDuration, amounts: amounts}));
            lastUpdateTime = block.number;
        }
    }

    /* ========== PRIVATE FUNCTIONS ========== */
    function _unstake(address account, uint256 amount) private nonReentrant updateReward(account) {
        require(amount > 0, "[Unstake] Cannot unstake zero");
        require(poolType != PoolType.Burn, "[Unstake] Burn pool can't unstake");
        require(_balances[account] >= amount, "[Unstake] underflow");

        totalSupply = totalSupply - amount;
        _balances[account] = _balances[account] - amount;

        _transfer(stakingToken, account, amount);

        if (_balances[account] == 0) {
            deleteStaker(account);
        }

        emit Unstake(account, block.number, amount);
    }

    function _claim(address account) private nonReentrant updateReward(account) {
        require(account != address(0), "[_claim] zero account");
        uint256 reward = rewards[account];
        if (reward == 0) {
            return;
        }

        rewards[account] = 0;

        _transfer(rewardsToken, account, reward);
        deleteRewardUser(account);

        emit Claim(account, reward);
    }

    function deleteStaker(address account) private {
        require(account != address(0), "[deleteStaker] zero account");
        uint256 index = stakerIndexes[account];
        uint256 lastIndex = stakers.length - 1;

        if (index != lastIndex) {
            address temp = stakers[lastIndex];
            stakerIndexes[temp] = index;
            stakers[index] = temp;
        }

        stakers.pop();
        delete stakerIndexes[account];
    }

    function length() public view returns (uint256) {
        return stakers.length;
    }

    function deleteRewardUser(address account) private {
        require(account != address(0), "[deleteRewardUser] zero account");
        uint256 index = rewardUserIndexes[account];
        uint256 lastIndex = rewardUsers.length - 1;

        if (index != lastIndex) {
            address temp = rewardUsers[lastIndex];
            rewardUserIndexes[temp] = index;
            rewardUsers[index] = temp;
        }

        rewardUsers.pop();
        delete rewardUserIndexes[account];
    }

    /* ========== MODIFIERS ========== */

    function _updateReward(address account) private {
        rewardPerTokenStored = rewardPerToken();
        lastUpdateTime = lastTimeRewardApplicable();

        if (account == address(0)) {
            return;
        }

        uint256 oldReward = rewards[account];
        rewards[account] = earned(account);
        userRewardPerTokenPaid[account] = rewardPerTokenStored;

        if (oldReward == 0 && rewards[account] > 0) {
            rewardUsers.push(account);
            rewardUserIndexes[account] = rewardUsers.length - 1;
        }
    }

    modifier updateReward(address account) {
        _updateReward(account);

        if (lastUpdateTime >= periodFinish && periods.length > 0) {
            periodStart = periods[0].begin;
            periodFinish = periods[0].end;
            rewardsDuration = periodFinish - periodStart;
            rewardRate = periods[0].amounts / rewardsDuration;

            periods.pop();
            _updateReward(account);
        }
        _;
    }

    /* ========== EVENTS ========== */

    event RewardAdded(uint256 reward);
    event Stake(address indexed user, uint256 blockNumber, uint256 amount);
    event Unstake(address indexed user, uint256 blockNumber, uint256 amount);
    event Claim(address indexed user, uint256 amounts);
    event RewardsDurationUpdated(uint256 periodStart, uint256 newDuration);
}
