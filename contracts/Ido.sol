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

contract TokenStake is Ownable, Pausable, TokenHelper {
    struct Info {
        address account;
        uint256 amounts;
        uint256 claimed;
        uint256 claimable;
        uint256 claimBlock;
        uint256 lockedUntil;
    }

    address public immutable stakeToken;
    address public immutable interestToken;
    uint256 public interestRate = 10;
    uint256 public unstakeLock = 10;
    string public name;

    mapping(address => Info) public StakeMap;
    mapping(address => uint256) public StakeIndexes;
    address[] public StakeArray;

    event Stake(address indexed staker, uint256 amounts, uint256 total);
    event Unstake(address indexed staker, uint256 amounts, uint256 total);
    event Claim(address indexed account, uint256 amounts, uint256 total);

    constructor(
        string memory _name,
        address _stakeToken,
        address _interestToken
    ) {
        name = _name;
        stakeToken = _stakeToken;
        interestToken = _interestToken;
    }

    function setUnstakeLock(uint256 value) public onlyOwner {
        unstakeLock = value;
    }

    function setInterestRate(uint256 value) public onlyOwner {
        interestRate = value;
    }

    function update(address account) private {
        Info storage info = StakeMap[account];

        // new one
        if (info.account == address(0)) {
            info.claimBlock = block.number;
            info.account = account;
            StakeIndexes[account] = StakeArray.length;
            StakeArray.push(account);
            return;
        }

        if (block.number > info.claimBlock) {
            info.claimable = info.claimable + calcInterest(info.amounts, info.claimBlock);
            info.claimBlock = block.number;
        }
    }

    function _unstake(address account, uint256 amounts) private {
        Info storage info = StakeMap[account];
        require(info.account != address(0), "[Claim] need stake");
        require(info.amounts >= amounts, "[Withdraw] underflow");

        update(account);

        info.amounts -= amounts;
        _transfer(stakeToken, account, amounts);

        if (info.amounts > 0) {
            emit Unstake(account, amounts, info.amounts);
            return;
        }

        _claim(account);

        uint256 index = StakeIndexes[account];
        uint256 lastIndex = StakeArray.length - 1;

        if (index != lastIndex) {
            address temp = StakeArray[lastIndex];
            StakeArray[index] = temp;
            StakeIndexes[temp] = index;
        }

        delete StakeMap[account];
        delete StakeIndexes[account];
        StakeArray.pop();

        emit Unstake(account, amounts, info.amounts);
    }

    function _claim(address account) private {
        Info storage info = StakeMap[account];
        require(info.account != address(0), "[Claim] need stake");

        update(account);

        uint256 amounts = info.claimable;
        info.claimable = 0;
        info.claimed += amounts;
        _transferFrom(interestToken, owner(), account, amounts);

        emit Claim(account, amounts, info.claimed);
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function withdraw(address token) public onlyOwner {
        uint256 amounts = _balanceOf(token, address(this));
        _transfer(token, msg.sender, amounts);
    }

    function transfer(
        address kip7,
        address to,
        uint256 amounts
    ) public onlyOwner {
        _transfer(kip7, to, amounts);
    }

    function stake(uint256 amounts) public whenNotPaused {
        require(amounts >= 1e13, "[Stake] more than 1e13");

        update(msg.sender);

        _transferFrom(stakeToken, msg.sender, address(this), amounts);

        Info storage info = StakeMap[msg.sender];
        info.amounts = info.amounts + amounts;
        info.lockedUntil = block.number + unstakeLock;

        emit Stake(msg.sender, amounts, info.amounts);
    }

    function claim() public {
        _claim(msg.sender);
    }

    function unstake(uint256 amounts) public {
        require(amounts >= 1e13, "[Stake] more than 1e13");
        Info storage info = StakeMap[msg.sender];
        require(info.account != address(0), "[Unstake] zero address");
        require(block.number > info.lockedUntil, "[Unstake] account locked");
        require(info.amounts >= amounts, "[Unstake] underflow");

        info.lockedUntil = block.number + unstakeLock;
        _unstake(msg.sender, amounts);
    }

    function calcInterest(uint256 amounts, uint256 before) private view returns (uint256) {
        if (before >= block.number || amounts == 0) {
            return 0;
        }
        //                       1000000000000000000
        //                                 131536000
        uint256 interest = (amounts / interestRate) / 31536000;
        return (block.number - before) * interest;
    }

    function getInfoByAccount(address account) public view returns (Info memory) {
        Info memory temp = StakeMap[account];
        if (temp.amounts == 0) {
            return temp;
        }
        temp.claimable = temp.claimable + calcInterest(temp.amounts, temp.claimBlock);
        return temp;
    }

    function getInfoByIndex(uint256 index) public view returns (Info memory) {
        require(StakeArray.length > 0, "[getInfoByIndex] empty");
        require(index < StakeArray.length, "[getInfoByIndex] overflow");
        address account = StakeArray[index];
        Info memory temp = StakeMap[account];
        if (temp.amounts == 0) {
            return temp;
        }
        temp.claimable = temp.claimable + calcInterest(temp.amounts, temp.claimBlock);
        return temp;
    }

    function length() public view returns (uint256) {
        return StakeArray.length;
    }

    function balance() public view returns (uint256) {
        (bool check, bytes memory data) = address(stakeToken).staticcall(abi.encodeWithSignature("balanceOf(address)", address(this)));
        require(check == true, "[Balance] failed");
        uint256 amounts = abi.decode(data, (uint256));
        return amounts;
    }

    function cancel(uint256 index) public onlyOwner {
        require(StakeArray.length > 0, "[Cancel] empty");
        require(index < StakeArray.length, "[Cancel] overflow");

        Info memory info = getInfoByIndex(index);
        _unstake(info.account, info.amounts);
    }

    function cancel(address account) public onlyOwner {
        require(account != address(0), "[Cancel] zero address");

        Info memory info = StakeMap[account];
        require(info.account == account, "[Cancel] wrong address");
        _unstake(info.account, info.amounts);
    }
}

contract Ido is Ownable, Pausable, TokenHelper {
    struct Info {
        address account;
        uint256 burned;
        uint256 amounts;
        uint256 claimed;
        uint256 withdraw;
    }

    string public name;
    address public lay;
    address public idoToken;
    TokenStake public orbStake;

    uint256 public price = 1 * 1e14; // per 0.01
    uint256 public beginBlock = 0;
    uint256 public endBlock = 0;

    mapping(address => Info) public IdoMap;
    mapping(address => uint256) public IdoIndexes;
    address[] public IdoArray;

    event Buy(address indexed account, uint256 amounts);
    event Pay(address indexed account, uint256 amounts);
    event Allocate(address indexed account, uint256 amounts);
    event Burn(address indexed account, uint256 orb, uint256 lay);

    constructor(
        string memory _name,
        address _orbStake,
        address _lay,
        address _ido
    ) {
        require(_orbStake != address(0));
        require(_lay != address(0));
        require(_ido != address(0));

        name = _name;
        lay = _lay;
        idoToken = _ido;
        orbStake = TokenStake(_orbStake);
    }

    function set(
        address _token,
        uint256 _begin,
        uint256 _end,
        uint256 _price
    ) public onlyOwner {
        price = _price;
        beginBlock = _begin;
        endBlock = _end;
        idoToken = _token;
    }

    function getInfoByAccount(address account) public view returns (Info memory) {
        return IdoMap[account];
    }

    function getAddressByIndex(uint256 index) public view returns (address) {
        return IdoArray[index];
    }

    function getIndex(address account) public view returns (uint256) {
        return IdoIndexes[account];
    }

    function transfer(
        address kip7,
        address to,
        uint256 amounts
    ) public onlyOwner {
        _transfer(kip7, to, amounts);
    }

    function transferFrom(
        address kip7,
        address from,
        address to,
        uint256 amounts
    ) public onlyOwner {
        _transferFrom(kip7, from, to, amounts);
    }

    function withdraw(address payable to) public onlyOwner {
        to.transfer(address(this).balance);
    }

    // function burn(uint256 amounts) public whenNotPaused {
    //     require(beginBlock < block.number, "[Burn] not yet");
    //     require(endBlock > block.number, "[Burn] ido end");
    //     require(amounts > 0, "[Burn] zero amount");

    //     TokenStake.Info memory stakeInfo = orbStake.getInfoByAccount(msg.sender);
    //     require(stakeInfo.amounts > 0, "[Burn] need stake");
    //     Info storage info = IdoMap[msg.sender];
    //     if (info.account == address(0)) {
    //         IdoArray.push(msg.sender);
    //         info.account = msg.sender;
    //     }

    //     info.account = msg.sender;
    //     _transferFrom(lay, msg.sender, address(this), amounts);

    //     info.burned = info.burned + amounts;
    //     emit Burn(info.account, stakeInfo.amounts, info.burned);
    // }

    function buy(uint256 amounts) public payable whenNotPaused {
        Info storage info = IdoMap[msg.sender];
        require(amounts >= 1e16, "[Buy] can't buy zero");
        require(info.account != address(0), "[Buy] Zero address");
        require(info.amounts >= 1e16, "[Buy] more 1e16 amount");
        require(info.amounts > info.claimed, "[Buy] empty");
        require(info.withdraw == 0, "[Buy] already paid");

        uint256 remain = info.amounts - info.claimed;

        uint256 _price = (amounts / 1e16) * price;
        amounts = (amounts / 1e16) * 1e16;

        require(_price == msg.value, "[Buy] Wrong price");
        require(remain >= amounts, "[Buy] underflow");

        info.claimed = info.claimed + amounts;
        // bool ret = _transfer(idoToken, info.account, amounts);
        // require(ret == true, "[Buy] _transfer fail");
        emit Buy(msg.sender, amounts);
    }

    function allocate(address account, uint256 amounts) public onlyOwner {
        require(account != address(0), "[Allocate] zero address");
        Info storage info = IdoMap[account];

        if (info.account == address(0)) {
            IdoArray.push(account);
            info.account = account;
        }

        info.amounts = amounts;
        emit Allocate(info.account, info.amounts);
    }

    function pay(uint256 index, uint256 rate) public onlyOwner {
        require(index < IdoArray.length, "[Pay] overflow");
        require(rate > 0, "[Pay] rate underflow");
        require(rate <= 100, "[Pay] rate overflow");
        address account = IdoArray[index];

        Info storage info = IdoMap[account];

        require(info.account != address(0), "[Pay] zero address");
        require(info.claimed > 0, "[Pay] need claimed");
        require(info.withdraw < info.claimed, "[Pay] already paid");

        uint256 amounts = (info.claimed * (rate * 100)) / 10000;

        if (info.withdraw + amounts > info.claimed) {
            amounts = info.claimed - info.withdraw;
        }
        info.withdraw += amounts;

        // need approve owner's idoToken
        _transferFrom(idoToken, owner(), info.account, amounts);
        emit Pay(info.account, amounts);
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }
}
