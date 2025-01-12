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

    event OwnershipTransferred(
        address indexed previousOwner,
        address indexed newOwner
    );

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
        require(
            newOwner != address(0),
            "Ownable: new owner is the zero address"
        );
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
    function has(Role storage role, address account)
        internal
        view
        returns (bool)
    {
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
    function transfer(address recipient, uint256 amount)
        external
        returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through `transferFrom`. This is
     * zero by default.
     *
     * This value changes when `approve` or `transferFrom` are called.
     */
    function allowance(address owner, address spender)
        external
        view
        returns (uint256);

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
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );
}

/**
 * @dev Required interface of an KIP17 compliant contract.
 */
contract IKIP17 is IKIP13 {
    event Transfer(
        address indexed from,
        address indexed to,
        uint256 indexed tokenId
    );
    event Approval(
        address indexed owner,
        address indexed approved,
        uint256 indexed tokenId
    );
    event ApprovalForAll(
        address indexed owner,
        address indexed operator,
        bool approved
    );

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
    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId
    ) public;

    /**
     * @dev Transfers a specific NFT (`tokenId`) from one account (`from`) to
     * another (`to`).
     *
     * Requirements:
     * - If the caller is not `from`, it must be approved to move this NFT by
     * either `approve` or `setApproveForAll`.
     */
    function transferFrom(
        address from,
        address to,
        uint256 tokenId
    ) public;

    function approve(address to, uint256 tokenId) public;

    function getApproved(uint256 tokenId)
        public
        view
        returns (address operator);

    function setApprovalForAll(address operator, bool _approved) public;

    function isApprovedForAll(address owner, address operator)
        public
        view
        returns (bool);

    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId,
        bytes memory data
    ) public;
}

/**
 * @title KIP-17 Non-Fungible Token Standard, optional enumeration extension
 * @dev See http://kips.klaytn.com/KIPs/kip-17-non_fungible_token
 */
contract IKIP17Enumerable is IKIP17 {
    function totalSupply() public view returns (uint256);

    function tokenOfOwnerByIndex(address owner, uint256 index)
        public
        view
        returns (uint256 tokenId);

    function tokenByIndex(uint256 index) public view returns (uint256);
}

library Helper {
    function toInt(string memory _value) internal pure returns (uint256 _ret) {
        bytes memory _bytesValue = bytes(_value);
        uint256 j = 1;

        for (
            uint256 i = _bytesValue.length - 1;
            i >= 0 && i < _bytesValue.length;
            i--
        ) {
            assert(uint8(_bytesValue[i]) >= 48 && uint8(_bytesValue[i]) <= 57);
            _ret += (uint8(_bytesValue[i]) - 48) * j;
            j *= 10;
        }
    }

    function compare(string memory org, string memory dst)
        internal
        pure
        returns (bool)
    {
        return
            keccak256(abi.encodePacked(org)) ==
            keccak256(abi.encodePacked(dst));
    }

    function toString(uint256 _i)
        internal
        pure
        returns (string memory _uintAsString)
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

/**
 * @title ERC721 token receiver interface
 * @dev Interface for any contract that wants to support safeTransfers
 * from ERC721 asset contracts.
 */
contract IERC721Receiver {
    /**
     * @notice Handle the receipt of an NFT
     * @dev The ERC721 smart contract calls this function on the recipient
     * after a `safeTransfer`. This function MUST return the function selector,
     * otherwise the caller will revert the transaction. The selector to be
     * returned can be obtained as `this.onERC721Received.selector`. This
     * function MAY throw to revert and reject the transfer.
     * Note: the ERC721 contract address is always the message sender.
     * @param operator The address which called `safeTransferFrom` function
     * @param from The address which previously owned the token
     * @param tokenId The NFT identifier which is being transferred
     * @param data Additional data with no specified format
     * @return bytes4 `bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"))`
     */
    function onERC721Received(
        address operator,
        address from,
        uint256 tokenId,
        bytes memory data
    ) public returns (bytes4);
}

/**
 * @title KIP17 token receiver interface
 * @dev Interface for any contract that wants to support safeTransfers
 * from KIP17 asset contracts.
 * @dev see http://kips.klaytn.com/KIPs/kip-17-non_fungible_token
 */
contract IKIP17Receiver {
    /**
     * @notice Handle the receipt of an NFT
     * @dev The KIP17 smart contract calls this function on the recipient
     * after a `safeTransfer`. This function MUST return the function selector,
     * otherwise the caller will revert the transaction. The selector to be
     * returned can be obtained as `this.onKIP17Received.selector`. This
     * function MAY throw to revert and reject the transfer.
     * Note: the KIP17 contract address is always the message sender.
     * @param operator The address which called `safeTransferFrom` function
     * @param from The address which previously owned the token
     * @param tokenId The NFT identifier which is being transferred
     * @param data Additional data with no specified format
     * @return bytes4 `bytes4(keccak256("onKIP17Received(address,address,uint256,bytes)"))`
     */
    function onKIP17Received(
        address operator,
        address from,
        uint256 tokenId,
        bytes memory data
    ) public returns (bytes4);
}

/**
 * @dev Collection of functions related to the address type,
 */
library Address {
    /**
     * @dev Returns true if `account` is a contract.
     *
     * This test is non-exhaustive, and there may be false-negatives: during the
     * execution of a contract's constructor, its address will be reported as
     * not containing a contract.
     *
     * > It is unsafe to assume that an address for which this function returns
     * false is an externally-owned account (EOA) and not a contract.
     */
    function isContract(address account) internal view returns (bool) {
        // This method relies in extcodesize, which returns 0 for contracts in
        // construction, since the code is only stored at the end of the
        // constructor execution.

        uint256 size;
        // solhint-disable-next-line no-inline-assembly
        assembly {
            size := extcodesize(account)
        }
        return size > 0;
    }
}

/**
 * @title Counters
 * @author Matt Condon (@shrugs)
 * @dev Provides counters that can only be incremented or decremented by one. This can be used e.g. to track the number
 * of elements in a mapping, issuing ERC721 ids, or counting request ids.
 *
 * Include with `using Counters for Counters.Counter;`
 * Since it is not possible to overflow a 256 bit integer with increments of one, `increment` can skip the SafeMath
 * overflow check, thereby saving gas. This does assume however correct usage, in that the underlying `_value` is never
 * directly accessed.
 */
library Counters {
    using SafeMath for uint256;

    struct Counter {
        // This variable should never be directly accessed by users of the library: interactions must be restricted to
        // the library's function. As of Solidity v0.5.2, this cannot be enforced, though there is a proposal to add
        // this feature: see https://github.com/ethereum/solidity/issues/4637
        uint256 _value; // default: 0
    }

    function current(Counter storage counter) internal view returns (uint256) {
        return counter._value;
    }

    function increment(Counter storage counter) internal {
        counter._value += 1;
    }

    function decrement(Counter storage counter) internal {
        counter._value = counter._value.sub(1);
    }
}

/**
 * @dev Implementation of the `IKIP13` interface.
 *
 * Contracts may inherit from this and call `_registerInterface` to declare
 * their support of an interface.
 */
contract KIP13 is IKIP13 {
    /*
     * bytes4(keccak256('supportsInterface(bytes4)')) == 0x01ffc9a7
     */
    bytes4 private constant _INTERFACE_ID_KIP13 = 0x01ffc9a7;

    /**
     * @dev Mapping of interface ids to whether or not it's supported.
     */
    mapping(bytes4 => bool) private _supportedInterfaces;

    constructor() internal {
        // Derived contracts need only register support for their own interfaces,
        // we register support for KIP13 itself here
        _registerInterface(_INTERFACE_ID_KIP13);
    }

    /**
     * @dev See `IKIP13.supportsInterface`.
     *
     * Time complexity O(1), guaranteed to always use less than 30 000 gas.
     */
    function supportsInterface(bytes4 interfaceId)
        external
        view
        returns (bool)
    {
        return _supportedInterfaces[interfaceId];
    }

    /**
     * @dev Registers the contract as an implementer of the interface defined by
     * `interfaceId`. Support of the actual KIP13 interface is automatic and
     * registering its interface id is not required.
     *
     * See `IKIP13.supportsInterface`.
     *
     * Requirements:
     *
     * - `interfaceId` cannot be the KIP13 invalid interface (`0xffffffff`).
     */
    function _registerInterface(bytes4 interfaceId) internal {
        require(interfaceId != 0xffffffff, "KIP13: invalid interface id");
        _supportedInterfaces[interfaceId] = true;
    }
}

/**
 * @title KIP17 Non-Fungible Token Standard basic implementation
 * @dev see http://kips.klaytn.com/KIPs/kip-17-non_fungible_token
 */
contract KIP17 is KIP13, IKIP17 {
    using SafeMath for uint256;
    using Address for address;
    using Counters for Counters.Counter;

    // Equals to `bytes4(keccak256("onKIP17Received(address,address,uint256,bytes)"))`
    // which can be also obtained as `IKIP17Receiver(0).onKIP17Received.selector`
    bytes4 private constant _KIP17_RECEIVED = 0x6745782b;

    // Equals to `bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"))`
    // which can be also obtained as `IERC721Receiver(0).onERC721Received.selector`
    bytes4 private constant _ERC721_RECEIVED = 0x150b7a02;

    // Mapping from token ID to owner
    mapping(uint256 => address) private _tokenOwner;

    // Mapping from token ID to approved address
    mapping(uint256 => address) private _tokenApprovals;

    // Mapping from owner to number of owned token
    mapping(address => Counters.Counter) private _ownedTokensCount;

    // Mapping from owner to operator approvals
    mapping(address => mapping(address => bool)) private _operatorApprovals;

    /*
     *     bytes4(keccak256('balanceOf(address)')) == 0x70a08231
     *     bytes4(keccak256('ownerOf(uint256)')) == 0x6352211e
     *     bytes4(keccak256('approve(address,uint256)')) == 0x095ea7b3
     *     bytes4(keccak256('getApproved(uint256)')) == 0x081812fc
     *     bytes4(keccak256('setApprovalForAll(address,bool)')) == 0xa22cb465
     *     bytes4(keccak256('isApprovedForAll(address,address)')) == 0xe985e9c
     *     bytes4(keccak256('transferFrom(address,address,uint256)')) == 0x23b872dd
     *     bytes4(keccak256('safeTransferFrom(address,address,uint256)')) == 0x42842e0e
     *     bytes4(keccak256('safeTransferFrom(address,address,uint256,bytes)')) == 0xb88d4fde
     *
     *     => 0x70a08231 ^ 0x6352211e ^ 0x095ea7b3 ^ 0x081812fc ^
     *        0xa22cb465 ^ 0xe985e9c ^ 0x23b872dd ^ 0x42842e0e ^ 0xb88d4fde == 0x80ac58cd
     */
    bytes4 private constant _INTERFACE_ID_KIP17 = 0x80ac58cd;

    constructor() public {
        // register the supported interfaces to conform to KIP17 via KIP13
        _registerInterface(_INTERFACE_ID_KIP17);
    }

    /**
     * @dev Gets the balance of the specified address.
     * @param owner address to query the balance of
     * @return uint256 representing the amount owned by the passed address
     */
    function balanceOf(address owner) public view returns (uint256) {
        require(
            owner != address(0),
            "KIP17: balance query for the zero address"
        );

        return _ownedTokensCount[owner].current();
    }

    /**
     * @dev Gets the owner of the specified token ID.
     * @param tokenId uint256 ID of the token to query the owner of
     * @return address currently marked as the owner of the given token ID
     */
    function ownerOf(uint256 tokenId) public view returns (address) {
        address owner = _tokenOwner[tokenId];
        require(
            owner != address(0),
            "KIP17: owner query for nonexistent token"
        );

        return owner;
    }

    /**
     * @dev Approves another address to transfer the given token ID
     * The zero address indicates there is no approved address.
     * There can only be one approved address per token at a given time.
     * Can only be called by the token owner or an approved operator.
     * @param to address to be approved for the given token ID
     * @param tokenId uint256 ID of the token to be approved
     */
    function approve(address to, uint256 tokenId) public {
        address owner = ownerOf(tokenId);
        require(to != owner, "KIP17: approval to current owner");

        require(
            msg.sender == owner || isApprovedForAll(owner, msg.sender),
            "KIP17: approve caller is not owner nor approved for all"
        );

        _tokenApprovals[tokenId] = to;
        emit Approval(owner, to, tokenId);
    }

    /**
     * @dev Gets the approved address for a token ID, or zero if no address set
     * Reverts if the token ID does not exist.
     * @param tokenId uint256 ID of the token to query the approval of
     * @return address currently approved for the given token ID
     */
    function getApproved(uint256 tokenId) public view returns (address) {
        require(
            _exists(tokenId),
            "KIP17: approved query for nonexistent token"
        );

        return _tokenApprovals[tokenId];
    }

    /**
     * @dev Sets or unsets the approval of a given operator
     * An operator is allowed to transfer all tokens of the sender on their behalf.
     * @param to operator address to set the approval
     * @param approved representing the status of the approval to be set
     */
    function setApprovalForAll(address to, bool approved) public {
        require(to != msg.sender, "KIP17: approve to caller");

        _operatorApprovals[msg.sender][to] = approved;
        emit ApprovalForAll(msg.sender, to, approved);
    }

    /**
     * @dev Tells whether an operator is approved by a given owner.
     * @param owner owner address which you want to query the approval of
     * @param operator operator address which you want to query the approval of
     * @return bool whether the given operator is approved by the given owner
     */
    function isApprovedForAll(address owner, address operator)
        public
        view
        returns (bool)
    {
        return _operatorApprovals[owner][operator];
    }

    /**
     * @dev Transfers the ownership of a given token ID to another address.
     * Usage of this method is discouraged, use `safeTransferFrom` whenever possible.
     * Requires the msg.sender to be the owner, approved, or operator.
     * @param from current owner of the token
     * @param to address to receive the ownership of the given token ID
     * @param tokenId uint256 ID of the token to be transferred
     */
    function transferFrom(
        address from,
        address to,
        uint256 tokenId
    ) public {
        //solhint-disable-next-line max-line-length
        require(
            _isApprovedOrOwner(msg.sender, tokenId),
            "KIP17: transfer caller is not owner nor approved"
        );

        _transferFrom(from, to, tokenId);
    }

    /**
     * @dev Safely transfers the ownership of a given token ID to another address
     * If the target address is a contract, it must implement `onKIP17Received`,
     * which is called upon a safe transfer, and return the magic value
     * `bytes4(keccak256("onKIP17Received(address,address,uint256,bytes)"))`; otherwise,
     * the transfer is reverted.
     * Requires the msg.sender to be the owner, approved, or operator
     * @param from current owner of the token
     * @param to address to receive the ownership of the given token ID
     * @param tokenId uint256 ID of the token to be transferred
     */
    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId
    ) public {
        safeTransferFrom(from, to, tokenId, "");
    }

    /**
     * @dev Safely transfers the ownership of a given token ID to another address
     * If the target address is a contract, it must implement `onKIP17Received`,
     * which is called upon a safe transfer, and return the magic value
     * `bytes4(keccak256("onKIP17Received(address,address,uint256,bytes)"))`; otherwise,
     * the transfer is reverted.
     * Requires the msg.sender to be the owner, approved, or operator
     * @param from current owner of the token
     * @param to address to receive the ownership of the given token ID
     * @param tokenId uint256 ID of the token to be transferred
     * @param _data bytes data to send along with a safe transfer check
     */
    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId,
        bytes memory _data
    ) public {
        transferFrom(from, to, tokenId);
        require(
            _checkOnKIP17Received(from, to, tokenId, _data),
            "KIP17: transfer to non KIP17Receiver implementer"
        );
    }

    /**
     * @dev Returns whether the specified token exists.
     * @param tokenId uint256 ID of the token to query the existence of
     * @return bool whether the token exists
     */
    function _exists(uint256 tokenId) internal view returns (bool) {
        address owner = _tokenOwner[tokenId];
        return owner != address(0);
    }

    /**
     * @dev Returns whether the given spender can transfer a given token ID.
     * @param spender address of the spender to query
     * @param tokenId uint256 ID of the token to be transferred
     * @return bool whether the msg.sender is approved for the given token ID,
     * is an operator of the owner, or is the owner of the token
     */
    function _isApprovedOrOwner(address spender, uint256 tokenId)
        internal
        view
        returns (bool)
    {
        require(
            _exists(tokenId),
            "KIP17: operator query for nonexistent token"
        );
        address owner = ownerOf(tokenId);
        return (spender == owner ||
            getApproved(tokenId) == spender ||
            isApprovedForAll(owner, spender));
    }

    /**
     * @dev Internal function to mint a new token.
     * Reverts if the given token ID already exists.
     * @param to The address that will own the minted token
     * @param tokenId uint256 ID of the token to be minted
     */
    function _mint(address to, uint256 tokenId) internal {
        require(to != address(0), "KIP17: mint to the zero address");
        require(!_exists(tokenId), "KIP17: token already minted");

        _tokenOwner[tokenId] = to;
        _ownedTokensCount[to].increment();

        emit Transfer(address(0), to, tokenId);
    }

    /**
     * @dev Internal function to burn a specific token.
     * Reverts if the token does not exist.
     * Deprecated, use _burn(uint256) instead.
     * @param owner owner of the token to burn
     * @param tokenId uint256 ID of the token being burned
     */
    function _burn(address owner, uint256 tokenId) internal {
        require(
            ownerOf(tokenId) == owner,
            "KIP17: burn of token that is not own"
        );

        _clearApproval(tokenId);

        _ownedTokensCount[owner].decrement();
        _tokenOwner[tokenId] = address(0);

        emit Transfer(owner, address(0), tokenId);
    }

    /**
     * @dev Internal function to burn a specific token.
     * Reverts if the token does not exist.
     * @param tokenId uint256 ID of the token being burned
     */
    function _burn(uint256 tokenId) internal {
        _burn(ownerOf(tokenId), tokenId);
    }

    /**
     * @dev Internal function to transfer ownership of a given token ID to another address.
     * As opposed to transferFrom, this imposes no restrictions on msg.sender.
     * @param from current owner of the token
     * @param to address to receive the ownership of the given token ID
     * @param tokenId uint256 ID of the token to be transferred
     */
    function _transferFrom(
        address from,
        address to,
        uint256 tokenId
    ) internal {
        require(
            ownerOf(tokenId) == from,
            "KIP17: transfer of token that is not own"
        );
        require(to != address(0), "KIP17: transfer to the zero address");

        _clearApproval(tokenId);

        _ownedTokensCount[from].decrement();
        _ownedTokensCount[to].increment();

        _tokenOwner[tokenId] = to;

        emit Transfer(from, to, tokenId);
    }

    /**
     * @dev Internal function to invoke `onKIP17Received` on a target address.
     * The call is not executed if the target address is not a contract.
     *
     * This function is deprecated.
     * @param from address representing the previous owner of the given token ID
     * @param to target address that will receive the tokens
     * @param tokenId uint256 ID of the token to be transferred
     * @param _data bytes optional data to send along with the call
     * @return bool whether the call correctly returned the expected magic value
     */
    function _checkOnKIP17Received(
        address from,
        address to,
        uint256 tokenId,
        bytes memory _data
    ) internal returns (bool) {
        bool success;
        bytes memory returndata;

        if (!to.isContract()) {
            return true;
        }

        // Logic for compatibility with ERC721.
        (success, returndata) = to.call(
            abi.encodeWithSelector(
                _ERC721_RECEIVED,
                msg.sender,
                from,
                tokenId,
                _data
            )
        );
        if (
            returndata.length != 0 &&
            abi.decode(returndata, (bytes4)) == _ERC721_RECEIVED
        ) {
            return true;
        }

        (success, returndata) = to.call(
            abi.encodeWithSelector(
                _KIP17_RECEIVED,
                msg.sender,
                from,
                tokenId,
                _data
            )
        );
        if (
            returndata.length != 0 &&
            abi.decode(returndata, (bytes4)) == _KIP17_RECEIVED
        ) {
            return true;
        }

        return false;
    }

    /**
     * @dev Private function to clear current approval of a given token ID.
     * @param tokenId uint256 ID of the token to be transferred
     */
    function _clearApproval(uint256 tokenId) private {
        if (_tokenApprovals[tokenId] != address(0)) {
            _tokenApprovals[tokenId] = address(0);
        }
    }
}

/**
 * @title KIP-17 Non-Fungible Token with optional enumeration extension logic
 * @dev See http://kips.klaytn.com/KIPs/kip-17-non_fungible_token
 */
contract KIP17Enumerable is KIP13, KIP17, IKIP17Enumerable {
    // Mapping from owner to list of owned token IDs
    mapping(address => uint256[]) private _ownedTokens;

    // Mapping from token ID to index of the owner tokens list
    mapping(uint256 => uint256) private _ownedTokensIndex;

    // Array with all token ids, used for enumeration
    uint256[] private _allTokens;

    // Mapping from token id to position in the allTokens array
    mapping(uint256 => uint256) private _allTokensIndex;

    /*
     *     bytes4(keccak256('totalSupply()')) == 0x18160ddd
     *     bytes4(keccak256('tokenOfOwnerByIndex(address,uint256)')) == 0x2f745c59
     *     bytes4(keccak256('tokenByIndex(uint256)')) == 0x4f6ccce7
     *
     *     => 0x18160ddd ^ 0x2f745c59 ^ 0x4f6ccce7 == 0x780e9d63
     */
    bytes4 private constant _INTERFACE_ID_KIP17_ENUMERABLE = 0x780e9d63;

    /**
     * @dev Constructor function.
     */
    constructor() public {
        // register the supported interface to conform to KIP17Enumerable via KIP13
        _registerInterface(_INTERFACE_ID_KIP17_ENUMERABLE);
    }

    /**
     * @dev Gets the token ID at a given index of the tokens list of the requested owner.
     * @param owner address owning the tokens list to be accessed
     * @param index uint256 representing the index to be accessed of the requested tokens list
     * @return uint256 token ID at the given index of the tokens list owned by the requested address
     */
    function tokenOfOwnerByIndex(address owner, uint256 index)
        public
        view
        returns (uint256)
    {
        require(
            index < balanceOf(owner),
            "KIP17Enumerable: owner index out of bounds"
        );
        return _ownedTokens[owner][index];
    }

    /**
     * @dev Gets the total amount of tokens stored by the contract.
     * @return uint256 representing the total amount of tokens
     */
    function totalSupply() public view returns (uint256) {
        return _allTokens.length;
    }

    /**
     * @dev Gets the token ID at a given index of all the tokens in this contract
     * Reverts if the index is greater or equal to the total number of tokens.
     * @param index uint256 representing the index to be accessed of the tokens list
     * @return uint256 token ID at the given index of the tokens list
     */
    function tokenByIndex(uint256 index) public view returns (uint256) {
        require(
            index < totalSupply(),
            "KIP17Enumerable: global index out of bounds"
        );
        return _allTokens[index];
    }

    /**
     * @dev Internal function to transfer ownership of a given token ID to another address.
     * As opposed to transferFrom, this imposes no restrictions on msg.sender.
     * @param from current owner of the token
     * @param to address to receive the ownership of the given token ID
     * @param tokenId uint256 ID of the token to be transferred
     */
    function _transferFrom(
        address from,
        address to,
        uint256 tokenId
    ) internal {
        super._transferFrom(from, to, tokenId);

        _removeTokenFromOwnerEnumeration(from, tokenId);

        _addTokenToOwnerEnumeration(to, tokenId);
    }

    /**
     * @dev Internal function to mint a new token.
     * Reverts if the given token ID already exists.
     * @param to address the beneficiary that will own the minted token
     * @param tokenId uint256 ID of the token to be minted
     */
    function _mint(address to, uint256 tokenId) internal {
        super._mint(to, tokenId);

        _addTokenToOwnerEnumeration(to, tokenId);

        _addTokenToAllTokensEnumeration(tokenId);
    }

    /**
     * @dev Internal function to burn a specific token.
     * Reverts if the token does not exist.
     * Deprecated, use _burn(uint256) instead.
     * @param owner owner of the token to burn
     * @param tokenId uint256 ID of the token being burned
     */
    function _burn(address owner, uint256 tokenId) internal {
        super._burn(owner, tokenId);

        _removeTokenFromOwnerEnumeration(owner, tokenId);
        // Since tokenId will be deleted, we can clear its slot in _ownedTokensIndex to trigger a gas refund
        _ownedTokensIndex[tokenId] = 0;

        _removeTokenFromAllTokensEnumeration(tokenId);
    }

    /**
     * @dev Gets the list of token IDs of the requested owner.
     * @param owner address owning the tokens
     * @return uint256[] List of token IDs owned by the requested address
     */
    function _tokensOfOwner(address owner)
        internal
        view
        returns (uint256[] storage)
    {
        return _ownedTokens[owner];
    }

    /**
     * @dev Private function to add a token to this extension's ownership-tracking data structures.
     * @param to address representing the new owner of the given token ID
     * @param tokenId uint256 ID of the token to be added to the tokens list of the given address
     */
    function _addTokenToOwnerEnumeration(address to, uint256 tokenId) private {
        _ownedTokensIndex[tokenId] = _ownedTokens[to].length;
        _ownedTokens[to].push(tokenId);
    }

    /**
     * @dev Private function to add a token to this extension's token tracking data structures.
     * @param tokenId uint256 ID of the token to be added to the tokens list
     */
    function _addTokenToAllTokensEnumeration(uint256 tokenId) private {
        _allTokensIndex[tokenId] = _allTokens.length;
        _allTokens.push(tokenId);
    }

    /**
     * @dev Private function to remove a token from this extension's ownership-tracking data structures. Note that
     * while the token is not assigned a new owner, the _ownedTokensIndex mapping is _not_ updated: this allows for
     * gas optimizations e.g. when performing a transfer operation (avoiding double writes).
     * This has O(1) time complexity, but alters the order of the _ownedTokens array.
     * @param from address representing the previous owner of the given token ID
     * @param tokenId uint256 ID of the token to be removed from the tokens list of the given address
     */
    function _removeTokenFromOwnerEnumeration(address from, uint256 tokenId)
        private
    {
        // To prevent a gap in from's tokens array, we store the last token in the index of the token to delete, and
        // then delete the last slot (swap and pop).

        uint256 lastTokenIndex = _ownedTokens[from].length.sub(1);
        uint256 tokenIndex = _ownedTokensIndex[tokenId];

        // When the token to delete is the last token, the swap operation is unnecessary
        if (tokenIndex != lastTokenIndex) {
            uint256 lastTokenId = _ownedTokens[from][lastTokenIndex];

            _ownedTokens[from][tokenIndex] = lastTokenId; // Move the last token to the slot of the to-delete token
            _ownedTokensIndex[lastTokenId] = tokenIndex; // Update the moved token's index
        }

        // This also deletes the contents at the last position of the array
        _ownedTokens[from].length--;

        // Note that _ownedTokensIndex[tokenId] hasn't been cleared: it still points to the old slot (now occupied by
        // lastTokenId, or just over the end of the array if the token was the last one).
    }

    /**
     * @dev Private function to remove a token from this extension's token tracking data structures.
     * This has O(1) time complexity, but alters the order of the _allTokens array.
     * @param tokenId uint256 ID of the token to be removed from the tokens list
     */
    function _removeTokenFromAllTokensEnumeration(uint256 tokenId) private {
        // To prevent a gap in the tokens array, we store the last token in the index of the token to delete, and
        // then delete the last slot (swap and pop).

        uint256 lastTokenIndex = _allTokens.length.sub(1);
        uint256 tokenIndex = _allTokensIndex[tokenId];

        // When the token to delete is the last token, the swap operation is unnecessary. However, since this occurs so
        // rarely (when the last minted token is burnt) that we still do the swap here to avoid the gas cost of adding
        // an 'if' statement (like in _removeTokenFromOwnerEnumeration)
        uint256 lastTokenId = _allTokens[lastTokenIndex];

        _allTokens[tokenIndex] = lastTokenId; // Move the last token to the slot of the to-delete token
        _allTokensIndex[lastTokenId] = tokenIndex; // Update the moved token's index

        // This also deletes the contents at the last position of the array
        _allTokens.length--;
        _allTokensIndex[tokenId] = 0;
    }
}

/**
 * @title KIP-17 Non-Fungible Token Standard, optional metadata extension
 * @dev See http://kips.klaytn.com/KIPs/kip-17-non_fungible_token
 */
contract IKIP17Metadata is IKIP17 {
    function name() external view returns (string memory);

    function symbol() external view returns (string memory);

    function tokenURI(uint256 tokenId) external view returns (string memory);
}

contract KIP17Metadata is KIP13, KIP17, IKIP17Metadata {
    // Token name
    string private _name;

    // Token symbol
    string private _symbol;

    // Optional mapping for token URIs
    mapping(uint256 => string) private _tokenURIs;

    /*
     *     bytes4(keccak256('name()')) == 0x06fdde03
     *     bytes4(keccak256('symbol()')) == 0x95d89b41
     *     bytes4(keccak256('tokenURI(uint256)')) == 0xc87b56dd
     *
     *     => 0x06fdde03 ^ 0x95d89b41 ^ 0xc87b56dd == 0x5b5e139f
     */
    bytes4 private constant _INTERFACE_ID_KIP17_METADATA = 0x5b5e139f;

    /**
     * @dev Constructor function
     */
    constructor(string memory name, string memory symbol) public {
        _name = name;
        _symbol = symbol;

        // register the supported interfaces to conform to KIP17 via KIP13
        _registerInterface(_INTERFACE_ID_KIP17_METADATA);
    }

    /**
     * @dev Gets the token name.
     * @return string representing the token name
     */
    function name() external view returns (string memory) {
        return _name;
    }

    /**
     * @dev Gets the token symbol.
     * @return string representing the token symbol
     */
    function symbol() external view returns (string memory) {
        return _symbol;
    }

    /**
     * @dev Returns an URI for a given token ID.
     * Throws if the token ID does not exist. May return an empty string.
     * @param tokenId uint256 ID of the token to query
     */
    function tokenURI(uint256 tokenId) external view returns (string memory) {
        require(
            _exists(tokenId),
            "KIP17Metadata: URI query for nonexistent token"
        );
        return _tokenURIs[tokenId];
    }

    /**
     * @dev Internal function to set the token URI for a given token.
     * Reverts if the token ID does not exist.
     * @param tokenId uint256 ID of the token to set its URI
     * @param uri string URI to assign
     */
    function _setTokenURI(uint256 tokenId, string memory uri) internal {
        require(
            _exists(tokenId),
            "KIP17Metadata: URI set of nonexistent token"
        );
        _tokenURIs[tokenId] = uri;
    }

    /**
     * @dev Internal function to burn a specific token.
     * Reverts if the token does not exist.
     * Deprecated, use _burn(uint256) instead.
     * @param owner owner of the token to burn
     * @param tokenId uint256 ID of the token being burned by the msg.sender
     */
    function _burn(address owner, uint256 tokenId) internal {
        super._burn(owner, tokenId);

        // Clear metadata (if any)
        if (bytes(_tokenURIs[tokenId]).length != 0) {
            delete _tokenURIs[tokenId];
        }
    }
}

/**
 * @title Full KIP-17 Token
 * This implementation includes all the required and some optional functionality of the KIP-17 standard
 * Moreover, it includes approve all functionality using operator terminology
 * @dev see http://kips.klaytn.com/KIPs/kip-17-non_fungible_token
 */
contract KIP17Full is KIP17, KIP17Enumerable, KIP17Metadata {
    constructor(string memory name, string memory symbol)
        public
        KIP17Metadata(name, symbol)
    {
        // solhint-disable-previous-line no-empty-blocks
    }
}

/**
 * @title KIP17 Burnable Token
 * @dev KIP17 Token that can be irreversibly burned (destroyed).
 * See http://kips.klaytn.com/KIPs/kip-17-non_fungible_token
 */
contract KIP17Burnable is KIP13, KIP17 {
    /*
     *     bytes4(keccak256('burn(uint256)')) == 0x42966c68
     *
     *     => 0x42966c68 == 0x42966c68
     */
    bytes4 private constant _INTERFACE_ID_KIP17_BURNABLE = 0x42966c68;

    /**
     * @dev Constructor function.
     */
    constructor() public {
        // register the supported interface to conform to KIP17Burnable via KIP13
        _registerInterface(_INTERFACE_ID_KIP17_BURNABLE);
    }

    /**
     * @dev Burns a specific KIP17 token.
     * @param tokenId uint256 id of the KIP17 token to be burned.
     */
    function burn(uint256 tokenId) public {
        //solhint-disable-next-line max-line-length
        require(
            _isApprovedOrOwner(msg.sender, tokenId),
            "KIP17Burnable: caller is not owner nor approved"
        );
        _burn(tokenId);
    }
}

/**
 * @title KIP17 Non-Fungible Pausable token
 * @dev KIP17 modified with pausable transfers.
 */
contract KIP17Pausable is KIP13, KIP17, Pausable {
    /*
     *     bytes4(keccak256('paused()')) == 0x5c975abb
     *     bytes4(keccak256('pause()')) == 0x8456cb59
     *     bytes4(keccak256('unpause()')) == 0x3f4ba83a
     *     bytes4(keccak256('isPauser(address)')) == 0x46fbf68e
     *     bytes4(keccak256('addPauser(address)')) == 0x82dc1ec4
     *     bytes4(keccak256('renouncePauser()')) == 0x6ef8d66d
     *
     *     => 0x5c975abb ^ 0x8456cb59 ^ 0x3f4ba83a ^ 0x46fbf68e ^ 0x82dc1ec4 ^ 0x6ef8d66d == 0x4d5507ff
     */
    bytes4 private constant _INTERFACE_ID_KIP17_PAUSABLE = 0x4d5507ff;

    /**
     * @dev Constructor function.
     */
    constructor() public {
        // register the supported interface to conform to KIP17Pausable via KIP13
        _registerInterface(_INTERFACE_ID_KIP17_PAUSABLE);
    }

    function approve(address to, uint256 tokenId) public whenNotPaused {
        super.approve(to, tokenId);
    }

    function setApprovalForAll(address to, bool approved) public whenNotPaused {
        super.setApprovalForAll(to, approved);
    }

    function transferFrom(
        address from,
        address to,
        uint256 tokenId
    ) public whenNotPaused {
        super.transferFrom(from, to, tokenId);
    }
}

contract MinterRole {
    using Roles for Roles.Role;

    event MinterAdded(address indexed account);
    event MinterRemoved(address indexed account);

    Roles.Role private _minters;

    constructor() internal {
        _addMinter(msg.sender);
    }

    modifier onlyMinter() {
        require(
            isMinter(msg.sender),
            "MinterRole: caller does not have the Minter role"
        );
        _;
    }

    function isMinter(address account) public view returns (bool) {
        return _minters.has(account);
    }

    function addMinter(address account) public onlyMinter {
        if (isMinter(account) == true) {
            return;
        }
        _addMinter(account);
    }

    function renounceMinter() public {
        _removeMinter(msg.sender);
    }

    function _addMinter(address account) internal {
        _minters.add(account);
        emit MinterAdded(account);
    }

    function _removeMinter(address account) internal {
        _minters.remove(account);
        emit MinterRemoved(account);
    }
}

/**
 * @title KIP17MetadataMintable
 * @dev KIP17 minting logic with metadata.
 */
contract KIP17MetadataMintable is KIP13, KIP17, KIP17Metadata, MinterRole {
    /*
     *     bytes4(keccak256('mintWithTokenURI(address,uint256,string)')) == 0x50bb4e7f
     *     bytes4(keccak256('isMinter(address)')) == 0xaa271e1a
     *     bytes4(keccak256('addMinter(address)')) == 0x983b2d56
     *     bytes4(keccak256('renounceMinter()')) == 0x98650275
     *
     *     => 0x50bb4e7f ^ 0xaa271e1a ^ 0x983b2d56 ^ 0x98650275 == 0xfac27f46
     */
    bytes4 private constant _INTERFACE_ID_KIP17_METADATA_MINTABLE = 0xfac27f46;

    /**
     * @dev Constructor function.
     */
    constructor() public {
        // register the supported interface to conform to KIP17Mintable via KIP13
        _registerInterface(_INTERFACE_ID_KIP17_METADATA_MINTABLE);
    }

    /**
     * @dev Function to mint tokens.
     * @param to The address that will receive the minted tokens.
     * @param tokenId The token id to mint.
     * @param tokenURI The token URI of the minted token.
     * @return A boolean that indicates if the operation was successful.
     */
    function mintWithTokenURI(
        address to,
        uint256 tokenId,
        string memory tokenURI
    ) public onlyMinter returns (bool) {
        _mint(to, tokenId);
        _setTokenURI(tokenId, tokenURI);
        return true;
    }
}

/**
 * @title KIP17Mintable
 * @dev KIP17 minting logic.
 */
contract KIP17Mintable is KIP17, MinterRole {
    /*
     *     bytes4(keccak256('isMinter(address)')) == 0xaa271e1a
     *     bytes4(keccak256('addMinter(address)')) == 0x983b2d56
     *     bytes4(keccak256('renounceMinter()')) == 0x98650275
     *     bytes4(keccak256('mint(address,uint256)')) == 0x40c10f19
     *
     *     => 0xaa271e1a ^ 0x983b2d56 ^ 0x98650275 ^ 0x40c10f19 == 0xeab83e20
     */
    bytes4 private constant _INTERFACE_ID_KIP17_MINTABLE = 0xeab83e20;

    /**
     * @dev Constructor function.
     */
    constructor() public {
        // register the supported interface to conform to KIP17Mintable via KIP13
        _registerInterface(_INTERFACE_ID_KIP17_MINTABLE);
    }

    /**
     * @dev Function to mint tokens.
     * @param to The address that will receive the minted tokens.
     * @param tokenId The token id to mint.
     * @return A boolean that indicates if the operation was successful.
     */
    function mint(address to, uint256 tokenId)
        public
        onlyMinter
        returns (bool)
    {
        _mint(to, tokenId);
        return true;
    }
}

contract KIP17TokenIdGenerator is KIP17Mintable {
    using SafeMath for uint256;
    uint256 private _currentTokenId = 0;

    function _getNextTokenId() internal view returns (uint256) {
        return _currentTokenId.add(1);
    }

    /**
     * @dev increments the value of _currentTokenId
     */
    function _incrementTokenId() internal {
        _currentTokenId++;
    }

    function getNextTokenId() internal view onlyMinter returns (uint256) {
        return _currentTokenId.add(1);
    }

    function incrementTokenId() public onlyMinter returns (uint256) {
        _incrementTokenId();
        return _currentTokenId;
    }
}

contract IKIP2981 is IKIP13 {
    /// ERC165 bytes to add to interface array - set in parent contract
    /// implementing this standard
    ///
    /// bytes4(keccak256("royaltyInfo(uint256,uint256)")) == 0x2a55205a
    /// bytes4 private constant _INTERFACE_ID_ERC2981 = 0x2a55205a;
    /// _registerInterface(_INTERFACE_ID_ERC2981);

    /// @notice Called with the sale price to determine how much royalty
    //          is owed and to whom.
    /// @param _tokenId - the NFT asset queried for royalty information
    /// @param _salePrice - the sale price of the NFT asset specified by _tokenId
    /// @return receiver - address of who should be sent the royalty payment
    /// @return royaltyAmount - the royalty payment amount for _salePrice
    function royaltyInfo(uint256 _tokenId, uint256 _salePrice)
        external
        view
        returns (address receiver, uint256 royaltyAmount);
}

contract KIP2981 is IKIP2981, KIP13 {
    bytes4 private constant _INTERFACE_ID_ERC2981 = 0x2a55205a;

    struct Royalty {
        address payable recipient;
        uint256 value;
    }

    mapping(uint256 => Royalty) internal _royalties;

    event SetTokenRoyalty(uint256 tokenId, address recipient, uint256 value);

    constructor() public {
        // register the supported interfaces to conform to KIP17 via KIP13
        _registerInterface(_INTERFACE_ID_ERC2981);
    }

    function _setTokenRoyalty(
        uint256 tokenId,
        address payable recipient,
        uint256 value
    ) internal {
        require(value <= 10000, "KIP2981: Too high");
        _royalties[tokenId] = Royalty(recipient, value);
        emit SetTokenRoyalty(tokenId, recipient, value);
    }

    function royaltyInfo(uint256 _tokenId, uint256 _salePrice)
        external
        view
        returns (address receiver, uint256 royaltyAmount)
    {
        Royalty memory royalty = _royalties[_tokenId];
        return (royalty.recipient, (_salePrice * royalty.value) / 10000);
    }
}

contract MeetUpTicketNormal is
    KIP17Full,
    KIP17Pausable,
    KIP17MetadataMintable,
    KIP17TokenIdGenerator,
    KIP2981,
    Ownable,
    AdminRole
{
    constructor(string memory _name, string memory _symbol)
        public
        KIP17Full(_name, _symbol)
    {}

    function uint2str(uint256 _i)
        public
        pure
        returns (string memory _uintAsString)
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

    function mintTo(address to, string memory uri)
        public
        onlyMinter
        returns (uint256)
    {
        uint256 tokenId = _getNextTokenId();
        mintWithTokenURI(
            to,
            tokenId,
            string(abi.encodePacked(uri, uint2str(tokenId)))
        );
        _incrementTokenId();
        return tokenId;
    }
}

contract MeetUpTicketVIP is
    KIP17Full,
    KIP17Pausable,
    KIP17MetadataMintable,
    KIP17TokenIdGenerator,
    KIP2981,
    Ownable,
    AdminRole
{
    constructor(string memory _name, string memory _symbol)
        public
        KIP17Full(_name, _symbol)
    {}

    function uint2str(uint256 _i)
        public
        pure
        returns (string memory _uintAsString)
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

    function mintTo(address to, string memory uri)
        public
        onlyMinter
        returns (uint256)
    {
        uint256 tokenId = _getNextTokenId();
        mintWithTokenURI(
            to,
            tokenId,
            string(abi.encodePacked(uri, uint2str(tokenId)))
        );
        _incrementTokenId();
        return tokenId;
    }
}

contract District is
    KIP17Full,
    KIP17Mintable,
    KIP17Pausable,
    KIP17MetadataMintable,
    KIP17TokenIdGenerator,
    KIP2981,
    Ownable,
    AdminRole
{
    constructor(string memory name, string memory symbol)
        public
        KIP17Full(name, symbol)
    {}

    function uint2str(uint256 _i)
        public
        pure
        returns (string memory _uintAsString)
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

    function tokensOfOwner(address owner)
        public
        view
        returns (uint256[] memory)
    {
        return _tokensOfOwner(owner);
    }

    function nextTokenIsVatican() public view onlyMinter returns (bool) {
        return _getNextTokenId() == 639;
    }

    function mintTo(address to, string memory uri)
        public
        onlyMinter
        returns (uint256)
    {
        uint256 tokenId = _getNextTokenId();
        mintWithTokenURI(
            to,
            tokenId,
            string(abi.encodePacked(uri, uint2str(tokenId)))
        );
        _incrementTokenId();
        return tokenId;
    }

    function setTokenUri(uint256 tokenId, string memory uri) public onlyMinter {
        _setTokenURI(tokenId, uri);
    }

    function setTokenRoyalty(
        uint256 tokenId,
        address payable recipient,
        uint256 value
    ) public {
        require(isAdmin() || isOwner(), "Need Admin role or Owner");
        _setTokenRoyalty(tokenId, recipient, value);
    }
}

contract IDistrictInfo is AdminRole {
    function getAttribute(uint256 tokenId, string memory key)
        public
        view
        returns (string memory);

    function getAttribute(uint256[] memory tokenId, string memory key)
        public
        view
        returns (string[] memory);

    function setAttribute(
        uint256 tokenId,
        string memory key,
        string memory value
    ) public;

    function getTokenIdsByCountry(string memory country)
        public
        view
        returns (uint256[] memory);
}

contract DistrictInfo is IDistrictInfo {
    using Helper for string;
    using Helper for uint256;

    // tokenId => key => value
    mapping(uint256 => mapping(string => string)) public attributes;

    // country name => tokenId array
    mapping(string => uint256[]) public countryTokenIds;

    // tokenId => countryTokenIds index
    mapping(uint256 => uint256) private countryTokenIdIndexes;

    event SetAttribute(uint256 indexed tokenId, string key, string value);

    constructor() public {}

    function getAttribute(uint256 tokenId, string memory key)
        public
        view
        returns (string memory)
    {
        require(
            existAttribute(tokenId, key),
            "does not exist the key in districtInfo"
        );
        return attributes[tokenId][key];
    }

    function getAttribute(uint256[] memory tokenIds, string memory key)
        public
        view
        returns (string[] memory)
    {
        string[] memory result = new string[](tokenIds.length);

        for (uint256 i = 0; i < tokenIds.length; i++) {
            result[i] = getAttribute(tokenIds[i], key);
        }

        return result;
    }

    function setAttribute(
        uint256 tokenId,
        string memory key,
        string memory value
    ) public onlyAdmin {
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

    function setAttribute(
        uint256 tokenId,
        string[] memory keys,
        string[] memory values
    ) public onlyAdmin {
        require(
            keys.length == values.length,
            "keys and values count different"
        );

        for (uint256 i = 0; i < keys.length; i++) {
            setAttribute(tokenId, keys[i], values[i]);
        }
    }

    function getTokenIdsByCountry(string memory country)
        public
        view
        returns (uint256[] memory)
    {
        return countryTokenIds[country];
    }

    function existAttribute(uint256 tokenId, string memory key)
        public
        view
        returns (bool)
    {
        return (keccak256(abi.encodePacked((attributes[tokenId][key]))) !=
            keccak256(abi.encodePacked((""))));
    }

    function deleteCountryTokenId(uint256 tokenId, string memory country)
        private
    {
        uint256[] storage tokenIds = countryTokenIds[country];

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

contract ReentrancyGuardByString {
    mapping(string => bool) public entered;

    modifier nonReentrantString(string memory str) {
        require(
            !entered[str],
            "ReentrancyGuardByString: prevent execute function asynchronous"
        );

        entered[str] = true;

        _;

        entered[str] = false;
    }
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

    function getStakingInfo(uint256 tokenId)
        public
        view
        returns (StakingInfo memory, bool);

    function dice(uint256 tokenId, uint256 earned) public;

    function getStakingTokenIds(address owner)
        public
        view
        returns (uint256[] memory);

    function getStakingInfos(address owner)
        public
        view
        returns (StakingInfo[] memory);

    function getStakingInfos(uint256[] memory tokenIds)
        public
        view
        returns (StakingInfo[] memory);

    function getOwnersByCountry(string memory country)
        public
        view
        returns (address[] memory);

    function setWaitTime(uint256 _waitTime) public;
}

contract DistrictStaking is
    IDistrictStaking,
    Ownable,
    Pausable,
    ReentrancyGuardByString
{
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
        uint256[] tokenIds;
    }

    IKIP17Enumerable public district;
    IDistrictInfo public districtInfo;
    uint256 private waitTime;
    uint256 public startBlockNumber;

    //StakeInfos
    StakingInfo[] public stakedInfos;
    //tokenId => array index
    mapping(uint256 => uint256) private stakedInfoIndexes;
    //tokenId => bool (exist)
    mapping(uint256 => bool) private existStakedInfos;

    //address => tokenId []
    mapping(address => uint256[]) private stakedOwnedTokens;
    //tokenId => array index
    mapping(uint256 => uint256) private stakedOwnedTokensIndexes;

    // country name => tokenId []
    mapping(string => uint256[]) private countryStakedTokenIds;
    // tokenId => index
    mapping(uint256 => uint256) private countryStakedTokenIdIndexes;

    event Stake(address indexed staker, uint256 indexed tokenId);
    event UnStake(address indexed staker, uint256 indexed tokenId);
    event UnStakeAll(address indexed user, uint256 workCnt);

    constructor(
        IKIP17Enumerable _district,
        IDistrictInfo _districtInfo,
        uint256 _startBlockNumber
    ) public {
        district = _district;
        districtInfo = _districtInfo;
        startBlockNumber = _startBlockNumber;
    }

    function setContract(
        IKIP17Enumerable _district,
        IDistrictInfo _districtInfo
    ) public onlyOwner {
        district = _district;
        districtInfo = _districtInfo;
    }

    function setVariable(uint256 _startBlockNumber) public onlyAdmin {
        startBlockNumber = _startBlockNumber;
    }

    function stake(uint256 tokenId) public whenNotPaused {
        require(block.number >= startBlockNumber, "start blocknumber");

        require(existStakedInfos[tokenId] == false, "already staked");

        address owner = district.ownerOf(tokenId);

        require(owner == msg.sender, "different owner and msg.sender");

        string memory country = districtInfo.getAttribute(tokenId, "Country");

        addStakingInfo(tokenId, country);

        district.transferFrom(msg.sender, address(this), tokenId);

        emit Stake(msg.sender, tokenId);
    }

    function unStake(uint256 tokenId) public {
        unStake(msg.sender, tokenId);
    }

    function getAllStakeInfos() public view returns (StakingInfo[] memory) {
        return stakedInfos;
    }

    function getStakingInfo(uint256 tokenId)
        public
        view
        returns (StakingInfo memory, bool)
    {
        StakingInfo memory result;
        bool exist;

        if (existStakedInfos[tokenId] == true) {
            result = stakedInfos[stakedInfoIndexes[tokenId]];
        } else {
            result = StakingInfo({
                owner: address(0),
                tokenId: 0,
                country: "",
                stakedBlockNumber: 0,
                playBlockNumber: 0,
                accEarned: 0
            });
        }

        exist = existStakedInfos[tokenId];
        return (result, exist);
    }

    function unStakeAll(uint256 count) public onlyAdmin {
        uint256 stakedInfoCount = stakedInfos.length;
        uint256 workCnt = stakedInfoCount;

        if (count > 0 && count < stakedInfoCount) {
            workCnt = count;
        }

        for (uint256 i = 0; i < workCnt; i++) {
            unStake(
                stakedInfos[stakedInfoCount - i - 1].owner,
                stakedInfos[stakedInfoCount - i - 1].tokenId
            );
        }

        emit UnStakeAll(msg.sender, workCnt);
    }

    function unStakeAdmin(address owner, uint256 tokenId) public onlyAdmin {
        unStake(owner, tokenId);
    }

    function dice(uint256 tokenId, uint256 earned) public onlyAdmin {
        StakingInfo storage stakingInfo = stakedInfos[
            stakedInfoIndexes[tokenId]
        ];

        stakingInfo.playBlockNumber = block.number;
        stakingInfo.accEarned = stakingInfo.accEarned.add(earned);
    }

    function setWaitTime(uint256 _waitTime) public onlyAdmin {
        waitTime = _waitTime;
    }

    function getMyStakingInfo() public view returns (MyStakingInfo[] memory) {
        uint256 stakingCount = stakedOwnedTokens[msg.sender].length;

        MyStakingInfo[] memory result = new MyStakingInfo[](stakingCount);
        for (uint256 i = 0; i < stakingCount; i++) {
            StakingInfo storage stakingInfo = stakedInfos[
                stakedInfoIndexes[stakedOwnedTokens[msg.sender][i]]
            ];
            result[i].tokenId = stakingInfo.tokenId;

            result[i].city = districtInfo.getAttribute(
                stakingInfo.tokenId,
                "City"
            );
            result[i].country = stakingInfo.country;
            result[i].tier = districtInfo
                .getAttribute(stakingInfo.tokenId, "Tier")
                .toInt();
            result[i].level = districtInfo
                .getAttribute(stakingInfo.tokenId, "Level")
                .toInt();
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
                result[i].remainBlockNumber =
                    lastJobBlockNumber +
                    waitTime -
                    block.number;
            }

            result[i].accEarned = stakingInfo.accEarned;
        }
        return result;
    }

    function getStakingTokenIds(address owner)
        public
        view
        returns (uint256[] memory)
    {
        return stakedOwnedTokens[owner];
    }

    function getStakingInfos(address owner)
        public
        view
        returns (StakingInfo[] memory)
    {
        uint256[] memory tokenIds = stakedOwnedTokens[owner];
        StakingInfo[] memory result = new StakingInfo[](tokenIds.length);

        for (uint256 i = 0; i < tokenIds.length; i++) {
            result[i] = stakedInfos[stakedInfoIndexes[tokenIds[i]]];
        }

        return result;
    }

    function getStakingInfos(uint256[] memory tokenIds)
        public
        view
        returns (StakingInfo[] memory)
    {
        uint256 resultCount;

        for (uint256 i = 0; i < tokenIds.length; i++) {
            if (existStakedInfos[tokenIds[i]] == true) {
                resultCount++;
            }
        }

        StakingInfo[] memory result = new StakingInfo[](resultCount);

        uint256 index;
        for (uint256 i = 0; i < tokenIds.length; i++) {
            if (existStakedInfos[tokenIds[i]] == true) {
                result[index] = stakedInfos[stakedInfoIndexes[tokenIds[i]]];
                index++;
            }
        }

        return result;
    }

    function getTokenIdsByCountry(string[] memory countries)
        public
        view
        returns (CountryStakingTokenIds[] memory)
    {
        CountryStakingTokenIds[] memory result = new CountryStakingTokenIds[](
            countries.length
        );
        for (uint256 i = 0; i < countries.length; i++) {
            result[i].country = countries[i];
            result[i].tokenIds = countryStakedTokenIds[countries[i]];
        }
        return result;
    }

    function getTokenCountByCountry(string[] memory countries)
        public
        view
        returns (uint256[] memory)
    {
        uint256[] memory result = new uint256[](countries.length);
        for (uint256 i = 0; i < countries.length; i++) {
            result[i] = countryStakedTokenIds[countries[i]].length;
        }
        return result;
    }

    function getOwnersByCountry(string memory country)
        public
        view
        returns (address[] memory)
    {
        uint256[] storage tokenIds = countryStakedTokenIds[country];
        address[] memory result = new address[](tokenIds.length);

        for (uint256 i = 0; i < tokenIds.length; i++) {
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
        stakedInfos.push(
            StakingInfo({
                owner: msg.sender,
                tokenId: tokenId,
                country: country,
                stakedBlockNumber: block.number,
                playBlockNumber: 0,
                accEarned: 0
            })
        );
        stakedInfoIndexes[tokenId] = stakedInfos.length - 1;
        existStakedInfos[tokenId] = true;

        stakedOwnedTokens[msg.sender].push(tokenId);
        stakedOwnedTokensIndexes[tokenId] =
            stakedOwnedTokens[msg.sender].length -
            1;

        countryStakedTokenIds[country].push(tokenId);
        countryStakedTokenIdIndexes[tokenId] =
            countryStakedTokenIds[country].length -
            1;
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
        uint256[] storage tokenIds = stakedOwnedTokens[account];
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

    function deleteCountryToken(string memory country, uint256 tokenId)
        private
    {
        uint256[] storage tokenIds = countryStakedTokenIds[country];
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

contract MeetUpTicketShop is Ownable, AdminRole, Pausable {
    using SafeMath for uint256;
    using Helper for string;
    using Helper for uint256;

    struct UserInfo {
        address user;
        string name;
        string birthDay;
        string ticketName;
    }

    MeetUpTicketNormal public meetUpTicketNormal;
    MeetUpTicketVIP public meetUpTicketVIP;
    District public district;
    DistrictInfo public districtInfo;
    DistrictStaking public districtStaking;

    address payable public devAddress;

    uint256 public startNormal1Tier;
    uint256 public startNormal2Tier;
    uint256 public startNormal3Tier;
    uint256 public startVIP;

    uint256 public normalPrice;
    uint256 public vipPrice;

    uint256 public totalNormalTicketCount;
    uint256 public totalVIPTicketCount;

    uint256 public remainNormalTicketCount;
    uint256 public remainVIPTicketCount;

    mapping(address => UserInfo) public userInfos;
    address[] public userAddresses;

    string public meetUpTicketNormalUri;
    string public meetUpTicketVIPUri;

    event BuyNormal(address indexed user, uint256 tokenId, uint256 price);
    event BuyVIP(address indexed user, uint256 tokenId, uint256 price);

    event UpdateUserInfo(address indexed user, string name, string birthDay);

    constructor(
        MeetUpTicketNormal _meetUpTicketNormal,
        MeetUpTicketVIP _meetUpTicketVIP,
        District _district,
        DistrictInfo _districtInfo,
        DistrictStaking _districtStaking,
        address payable _devAddress
    ) public {
        meetUpTicketNormal = _meetUpTicketNormal;
        meetUpTicketVIP = _meetUpTicketVIP;
        district = _district;
        districtInfo = _districtInfo;
        districtStaking = _districtStaking;
        devAddress = _devAddress;
    }

    // admin functions
    function setConstructParam(
        MeetUpTicketNormal _meetUpTicketNormal,
        MeetUpTicketVIP _meetUpTicketVIP,
        District _district,
        DistrictInfo _districtInfo,
        DistrictStaking _districtStaking,
        address payable _devAddress
    ) public onlyOwner {
        meetUpTicketNormal = _meetUpTicketNormal;
        meetUpTicketVIP = _meetUpTicketVIP;
        district = _district;
        districtInfo = _districtInfo;
        districtStaking = _districtStaking;
        devAddress = _devAddress;
    }

    function setTicketCount(
        uint256 _totalNormalTicketCount,
        uint256 _totalVIPTicketCount
    ) public onlyOwner {
        totalNormalTicketCount = _totalNormalTicketCount;
        totalVIPTicketCount = _totalVIPTicketCount;

        remainNormalTicketCount = totalNormalTicketCount;
        remainVIPTicketCount = totalVIPTicketCount;
    }

    function setTime(
        uint256 _startNormal1Tier,
        uint256 _startNormal2Tier,
        uint256 _startNormal3Tier,
        uint256 _startVIP
    ) public onlyOwner {
        startVIP = _startVIP;
        startNormal1Tier = _startNormal1Tier;
        startNormal2Tier = _startNormal2Tier;
        startNormal3Tier = _startNormal3Tier;
    }

    function setPrice(uint256 _normalPrice, uint256 _vipPrice)
        public
        onlyOwner
    {
        vipPrice = _vipPrice;
        normalPrice = _normalPrice;
    }

    function setNFTUri(
        string memory _meetUpTicketNormalUri,
        string memory _meetUpTicketVIPUri
    ) public onlyOwner {
        meetUpTicketNormalUri = _meetUpTicketNormalUri;
        meetUpTicketVIPUri = _meetUpTicketVIPUri;
    }

    // public functions
    function buyNormal(string memory name, string memory birthDay)
        public
        payable
    {
        // 가격이 맞아야 한다.
        require(msg.value == normalPrice, "different price");

        // 남은 수량이 있어야 한다. 먼저 가감시켜주기
        require(remainNormalTicketCount > 0, "sold out");
        remainNormalTicketCount = remainNormalTicketCount - 1;

        UserInfo storage userInfo = userInfos[msg.sender];
        // 두번 살수 없다.
        require(userInfo.user == address(0), "prevent twice buy");

        userInfos[msg.sender] = UserInfo({
            user: msg.sender,
            name: name,
            birthDay: birthDay,
            ticketName: "Normal"
        });
        userAddresses.push(msg.sender);

        uint256[] memory stakingTokenIds = districtStaking.getStakingTokenIds(
            msg.sender
        );
        uint256[] memory ownTokenIds = district.tokensOfOwner(msg.sender);
        // 땅이 있어야 한다.
        require(
            stakingTokenIds.length != 0 || ownTokenIds.length != 0,
            "must have district"
        );

        uint256 highTier = getHighTier(stakingTokenIds, ownTokenIds);
        uint256 startTime;
        if (highTier == 1) {
            startTime = startNormal1Tier;
        } else if (highTier == 2) {
            startTime = startNormal2Tier;
        } else if (highTier == 3) {
            startTime = startNormal3Tier;
        }

        // 정해진 시간을 지켜야 한다.
        require(now >= startTime, "not ready");

        //nft mint
        uint256 tokenId = meetUpTicketNormal.mintTo(
            msg.sender,
            meetUpTicketNormalUri
        );

        //receive price
        devAddress.transfer(msg.value);

        emit BuyNormal(msg.sender, tokenId, msg.value);
    }

    function buyVIP(string memory name, string memory birthDay) public payable {
        // 가격이 맞아야 한다.
        require(msg.value == vipPrice, "different price");

        // 남은 수량이 있어야 한다. 먼저 가감시켜주기
        require(remainVIPTicketCount > 0, "sold out");
        remainVIPTicketCount = remainVIPTicketCount - 1;

        UserInfo storage userInfo = userInfos[msg.sender];
        // 두번 살수 없다.
        require(userInfo.user == address(0), "prevent twice buy");

        userInfos[msg.sender] = UserInfo({
            user: msg.sender,
            name: name,
            birthDay: birthDay,
            ticketName: "VIP"
        });
        userAddresses.push(msg.sender);

        uint256[] memory stakingTokenIds = districtStaking.getStakingTokenIds(
            msg.sender
        );
        uint256[] memory ownTokenIds = district.tokensOfOwner(msg.sender);
        // 땅이 있어야 한다.
        require(
            stakingTokenIds.length != 0 || ownTokenIds.length != 0,
            "must have district"
        );

        // 정해진 시간을 지켜야 한다.
        require(now >= startVIP, "not ready");

        //nft mint
        uint256 tokenId = meetUpTicketVIP.mintTo(
            msg.sender,
            meetUpTicketVIPUri
        );

        //receive price
        devAddress.transfer(msg.value);

        emit BuyVIP(msg.sender, tokenId, msg.value);
    }

    function removeUserInfoForTest(address user) public onlyAdmin {
        for (uint256 i; i < userAddresses.length; i++) {
            if (userAddresses[i] == user) {
                address temp = userAddresses[userAddresses.length - 1];
                userAddresses[userAddresses.length - 1] = userAddresses[i];
                userAddresses[i] = temp;
                userAddresses.length--;
                delete userInfos[user];
                break;
            }
        }
    }

    function updateUserInfo(string memory name, string memory birthDay) public {
        UserInfo storage userInfo = userInfos[msg.sender];
        require(userInfo.user != address(0), "no user info");
        userInfo.name = name;
        userInfo.birthDay = birthDay;

        emit UpdateUserInfo(msg.sender, name, birthDay);
    }

    // public view functions
    function getMyTicketCount()
        public
        view
        returns (uint256 normalTicketCount, uint256 vipTicketCount)
    {
        normalTicketCount = meetUpTicketNormal.balanceOf(msg.sender);
        vipTicketCount = meetUpTicketVIP.balanceOf(msg.sender);
    }

    function getNow() public view returns (uint256) {
        return now;
    }

    function getInfo()
        public
        view
        returns (
            uint256 _startNormal1Tier,
            uint256 _startNormal2Tier,
            uint256 _startNormal3Tier,
            uint256 _startVIP,
            uint256 _normalPrice,
            uint256 _vipPrice,
            uint256 _totalNormalTicketCount,
            uint256 _totalVIPTicketCount,
            uint256 _remainNormalTicketCount,
            uint256 _remainVIPTicketCount
        )
    {
        _startNormal1Tier = startNormal1Tier;
        _startNormal2Tier = startNormal2Tier;
        _startNormal3Tier = startNormal3Tier;
        _startVIP = startVIP;
        _normalPrice = normalPrice;
        _vipPrice = vipPrice;
        _totalNormalTicketCount = totalNormalTicketCount;
        _totalVIPTicketCount = totalVIPTicketCount;
        _remainNormalTicketCount = remainNormalTicketCount;
        _remainVIPTicketCount = remainVIPTicketCount;
    }

    function getUserAddressLength() public view returns (uint256) {
        return userAddresses.length;
    }

    function getUserHighTier(address user) public view returns (uint256) {
        uint256[] memory stakingTokenIds = districtStaking.getStakingTokenIds(
            user
        );
        uint256[] memory ownTokenIds = district.tokensOfOwner(user);

        return getHighTier(stakingTokenIds, ownTokenIds);
    }

    //private view functions
    function getHighTier(
        uint256[] memory stakingTokenIds,
        uint256[] memory ownTokenIds
    ) private view returns (uint256) {
        uint256 highTier = 999;

        for (uint256 i = 0; i < stakingTokenIds.length; i++) {
            uint256 tier = districtInfo
                .getAttribute(stakingTokenIds[i], "Tier")
                .toInt();

            if (tier < highTier) {
                highTier = tier;
            }
        }

        for (uint256 i = 0; i < ownTokenIds.length; i++) {
            uint256 tier = districtInfo
                .getAttribute(ownTokenIds[i], "Tier")
                .toInt();

            if (tier < highTier) {
                highTier = tier;
            }
        }

        return highTier;
    }
}
