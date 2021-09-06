pragma solidity >=0.5.12;
pragma experimental ABIEncoderV2;

interface TRC20 {
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Burn(address indexed from, uint256 value);

    function _transfer(
        address _from,
        address _to,
        uint256 _value
    ) external;

    function transfer(address _to, uint256 _value) external returns (bool);

    function transferFrom(
        address _from,
        address _to,
        uint256 _value
    ) external returns (bool);

    function approve(address _spender, uint256 _value) external returns (bool);

    function burn(uint256 _value) external returns (bool);

    function burnFrom(address _from, uint256 _value) external returns (bool);

    function mint(address _from, uint256 _amount) external returns (bool);

    function totalSupply() external view returns (uint256);

    function balanceOf(address guy) external view returns (uint256);

    function allowance(address _from, address _to)
        external
        view
        returns (uint256);
}

library SafeMath {
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");
        return c;
    }

    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a - b;
        require(c <= a, "SafeMath: subtraction overflow");
        return c;
    }

    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        if (a == 0) {
            return 0;
        }
        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");
        return c;
    }

    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b > 0, "SafeMath: division by zero");
        uint256 c = a / b;
        return c;
    }
}

library SafeMath8 {
    function add(uint8 a, uint8 b) internal pure returns (uint8) {
        uint8 c = a + b;
        require(c >= a, "SafeMath: addition overflow");
        return c;
    }

    function sub(uint8 a, uint8 b) internal pure returns (uint8) {
        uint8 c = a - b;
        require(c <= a, "SafeMath: subtraction overflow");
        return c;
    }

    function mul(uint8 a, uint8 b) internal pure returns (uint8) {
        if (a == 0) {
            return 0;
        }
        uint8 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");
        return c;
    }

    function div(uint8 a, uint8 b) internal pure returns (uint8) {
        require(b > 0, "SafeMath: division by zero");
        uint8 c = a / b;
        return c;
    }
}

library SafeMath16 {
    function add(uint16 a, uint16 b) internal pure returns (uint16) {
        uint16 c = a + b;
        require(c >= a, "SafeMath: addition overflow");
        return c;
    }

    function sub(uint16 a, uint16 b) internal pure returns (uint16) {
        uint16 c = a - b;
        require(c <= a, "SafeMath: subtraction overflow");
        return c;
    }

    function mul(uint16 a, uint16 b) internal pure returns (uint16) {
        if (a == 0) {
            return 0;
        }
        uint16 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");
        return c;
    }

    function div(uint16 a, uint16 b) internal pure returns (uint16) {
        require(b > 0, "SafeMath: division by zero");
        uint16 c = a / b;
        return c;
    }
}

library SafeMath32 {
    function add(uint32 a, uint32 b) internal pure returns (uint32) {
        uint32 c = a + b;
        require(c >= a, "SafeMath: addition overflow");
        return c;
    }

    function sub(uint32 a, uint32 b) internal pure returns (uint32) {
        uint32 c = a - b;
        require(c <= a, "SafeMath: subtraction overflow");
        return c;
    }

    function mul(uint32 a, uint32 b) internal pure returns (uint32) {
        if (a == 0) {
            return 0;
        }
        uint32 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");
        return c;
    }

    function div(uint32 a, uint32 b) internal pure returns (uint32) {
        require(b > 0, "SafeMath: division by zero");
        uint32 c = a / b;
        return c;
    }
}

library SafeMath64 {
    function add(uint64 a, uint64 b) internal pure returns (uint64) {
        uint64 c = a + b;
        require(c >= a, "SafeMath: addition overflow");
        return c;
    }

    function sub(uint64 a, uint64 b) internal pure returns (uint64) {
        uint64 c = a - b;
        require(c <= a, "SafeMath: subtraction overflow");
        return c;
    }

    function mul(uint64 a, uint64 b) internal pure returns (uint64) {
        if (a == 0) {
            return 0;
        }
        uint64 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");
        return c;
    }

    function div(uint64 a, uint64 b) internal pure returns (uint64) {
        require(b > 0, "SafeMath: division by zero");
        uint64 c = a / b;
        return c;
    }
}


contract Ownable {
    address payable _owner;
    bool public paused = false;

    event OwnershipTransfer(address indexed oldOwner, address indexed newOwner);

    constructor() public {
        _owner = msg.sender;
        emit OwnershipTransfer(address(0), msg.sender);
    }

    function owner() public view returns (address payable) {
        return _owner;
    }

    modifier onlyOwner() {
        require(msg.sender == _owner, "Ownable: caller is not the owner");
        _;
    }
 
    modifier whenNotPaused() {
        require(!paused);
        _;
    }
 
    modifier whenPaused {
        require(paused);
        _;
    }

    function _transferOwnership(address payable newOwner) internal {
        require(
            newOwner != address(0),
            "Ownable: new owner is the zero address"
        );
        emit OwnershipTransfer(_owner, newOwner);
        _owner = newOwner;
    }

    function transfrtOwnership(address payable newOwner) public onlyOwner {
        _transferOwnership(newOwner);
    }

    function pause() external onlyOwner whenNotPaused {
        paused = true;
    }

    function unpause() public onlyOwner whenPaused {
        paused = false;
    }

}

contract MasterController is Ownable {
    using SafeMath for uint256;
    using SafeMath for uint8;
    using SafeMath for uint16;
    using SafeMath for uint32;
    using SafeMath for uint64;
    uint32 public creationTime; 

    TRC20 public Token; 
    TRC20 public PlatformToken; 
    uint16 public constant PERCENTS_DIVIDER = 10**4;
    address public Leader;
    address public CFO; 
    address public CEO; 

    uint256 public totalInvested; 
    uint256 public totalDeposits;

    address[] public userArr; 
    Order[] public orders; 

    uint16 public allowanceCFO = 100; 
    uint16 public allowanceCEO = 500; 
    uint8 public currentChain = 0; 
    uint32 public minTickets = 0; 

   
    uint8[5] public periods = [1, 5, 10, 15, 20];
    uint32[5] public periodsTime = [
        1 minutes,
        5 minutes,
        10 minutes,
        15 minutes,
        20 minutes
    ];

    uint16[5] public basedOutput = [10050, 10500, 11250, 12250, 13500];
  
    uint16[5] public basedOutputRaise = [5, 50, 125, 225, 350];

 
    uint8 public combustion = 100;
 
    uint8 public combustionIncrease = 20;
  
    uint16[5] public inviteYield = [3000, 2000, 1000, 500, 100];
   
    uint16 public inviteYieldCurtail = 9000;

    
    uint32 public witnessTheBasis = 100 * 10**6;

    
    uint16 public subsidyScale = 20000;

  
    uint16 public thawProportion = 1000;
   
    struct Order {
        uint32 createTime; 
        uint32 endTime; 
        uint64 amount; 
        uint64 forecastEarnings; 
        uint8 mold; 
        uint8 chain; 
    }

    struct User {
        address referrer; 
        uint32 birthday; 
        uint64[9] totals; 
        uint64[9] issuedOrders; 
        uint64[9] issuedTributes; 
        uint64[9] paidSubsidy; 
        uint256[] orders;
        mapping(uint8 => uint256[]) tributes;
    }

    mapping(address => User) public users;

  
    event Newbie(address indexed user, address indexed referrer);
 
    event NewDeposit(
        address indexed user,
        uint8 indexed mold,
        uint8 chain,
        uint32 createTime,
        uint32 endTime,
        uint64 amount,
        uint64 forecastEarnings
    );

  
    event Withdrawn(address indexed user, uint64 amount);

    
    event WithdrawnTributes(address indexed user, uint64 amount);

 
    constructor(
        address payable _ceo,
        address payable _cfo,
        address payable _leader,
        TRC20 _token,
        TRC20 _platformToken
    ) public {
        CEO = _ceo;
        CFO = _cfo;
        Token = _token;
        PlatformToken = _platformToken;
        Leader = _leader;
        creationTime = uint32(block.timestamp);
    }

 
    function deposit(
        uint8 mold,
        uint64 amount,
        address referrer
    ) public whenNotPaused {
        require(referrer != address(0), "Master:Referrer can not be 0");
        require(
            referrer != msg.sender,
            "Master:Invite people not for yourself"
        );
        require(amount >= minTickets, "Master:The number of too little");
        if (mold == 0) {
            require(isCan(msg.sender), "Master:Repeat participation");
        }
        uint256 before = Token.balanceOf(address(this));
        Token.transferFrom(address(msg.sender), address(this), amount);
        uint256 received = Token.balanceOf(address(this)).sub(before);

        if (mold != 0) {
            uint256 burnAmoung =
                received
                    .mul(combustion.add(combustionIncrease.mul(currentChain)))
                    .div(PERCENTS_DIVIDER);
            PlatformToken.burnFrom(msg.sender, burnAmoung);
        }

        User storage user = users[msg.sender];
        if (user.referrer == address(0)) {
            user.referrer = !isClansman(msg.sender, referrer)
                ? referrer
                : Leader;
            user.birthday = uint32(block.timestamp);
            userArr.push(msg.sender);
        }

        user.totals[currentChain] = uint64(
            user.totals[currentChain].add(received)
        );
    
        uint256 forecastEarnings =
            received
                .mul(
                uint256(basedOutput[mold]).add(
                    uint256(currentChain).mul(basedOutputRaise[mold])
                )
            )
                .div(PERCENTS_DIVIDER);
        uint256 endTime = now.add(periodsTime[mold]);
        uint256 index =
            orders.push(
                Order(
                    uint32(block.timestamp),
                    uint32(endTime),
                    uint64(received),
                    uint64(forecastEarnings),
                    mold,
                    currentChain
                )
            );
        user.orders.push(index - 1);
        totalInvested = totalInvested.add(received);
        totalDeposits = totalDeposits.add(1);
        _setTribute(msg.sender, index - 1);
        _paying(received);
        emit NewDeposit(
            msg.sender,
            mold,
            currentChain,
            uint32(block.timestamp),
            uint32(endTime),
            uint64(received),
            uint64(forecastEarnings)
        );
    }

  
    function _paying(uint256 amount) internal {
        Token.transfer(CEO, amount.mul(allowanceCEO).div(PERCENTS_DIVIDER));
        if (currentChain != 0) {
            Token.transfer(CFO, amount.mul(allowanceCFO).div(PERCENTS_DIVIDER));
        }
    }

  
    function _setTribute(address userAddress, uint256 index) internal {
        User storage user = users[userAddress];
        for (uint8 i = 0; i < 20; i++) {
          
            user = users[user.referrer];
          
            uint256 turnover =
                user.totals[currentChain].sub(user.issuedOrders[currentChain]);
            uint256 descendant = getOrthologyLength(user.referrer);
            if (
                turnover >= witnessTheBasis.mul(i + 1) && descendant >= (i + 1)
            ) {
                user.tributes[i].push(index);
            }
            if (user.referrer == address(0)) {
                return;
            }
        }
    }


    function withdrawForAmount(uint256 amount) public whenNotPaused {
        uint256 futureValue = getUserFutureValue(msg.sender, currentChain);
        uint256 referralBonus = getUserReferralBonus(msg.sender, currentChain);
        require(
            futureValue.add(referralBonus) >= amount,
            "Master:Insufficient available assets"
        );
        User storage _user = users[msg.sender];
        _safeTransfer(msg.sender, amount);
        if (futureValue >= amount) {
            _user.issuedOrders[currentChain] = uint64(
                _user.issuedOrders[currentChain].add(amount)
            );
        } else {
            _user.issuedOrders[currentChain] = uint64(
                _user.issuedOrders[currentChain].add(futureValue)
            );
            _user.issuedTributes[currentChain] = uint64(
                _user.issuedTributes[currentChain].add(amount.sub(futureValue))
            );
        }
        emit Withdrawn(msg.sender, uint64(amount));
    }


    function drawAllUserSubsidy() public whenNotPaused {
        require(
            currentChain > 0,
            "Master:There are no benefits in the current chain"
        );
        uint256 totalUseableSubsidy;
        User storage _user = users[msg.sender];
        for (uint8 i = 0; i < 9; i++) {
            if (i < currentChain) {
                uint256 useable = getDesirableSubsidy(msg.sender, i);
                totalUseableSubsidy += useable;
                _user.paidSubsidy[i] = uint64(
                    _user.paidSubsidy[i].add(useable)
                );
            } else {
                break;
            }
        }
        _safeTransferToken(msg.sender, totalUseableSubsidy);
    }

    // ------------------------- tool
    function _safeTransfer(address _to, uint256 _amount) internal {
        uint256 tokenBal = Token.balanceOf(address(this));
        if (_amount > tokenBal) {
            Token.transfer(_to, tokenBal);
        } else {
            Token.transfer(_to, _amount);
        }
    }

    function _safeTransferToken(address _to, uint256 _amount) internal {
        uint256 tokenBal = PlatformToken.balanceOf(address(this));
        if (_amount > tokenBal) {
            PlatformToken.transfer(_to, tokenBal);
        } else {
            PlatformToken.transfer(_to, _amount);
        }
    }

    // ------------------------- set
   
    function updateChain() public onlyOwner {
        currentChain += 1;
        if (currentChain > 9) {
            currentChain = 0;
        }
    }

    
    function getSubsidy(address userAddress, uint8 chain)
        public
        view
        returns (uint256)
    {
        uint256 amount = getUserAvailable(userAddress, chain);
        return
            amount.mul(subsidyScale).div(PERCENTS_DIVIDER).sub(
                users[userAddress].paidSubsidy[chain]
            );
    }

  
    function getDesirableSubsidy(address userAddress, uint8 chain)
        public
        view
        returns (uint256)
    {
        if (chain == currentChain || currentChain == 0) {
            return 0;
        }
        uint256 amount = getSubsidy(userAddress, chain);
        uint256 useable =
            users[userAddress].totals[chain + 1]
                .mul(thawProportion)
                .div(PERCENTS_DIVIDER)
                .sub(users[userAddress].paidSubsidy[chain]);
        return useable >= amount ? amount : useable;
    }

  
    function getAllDesirableSubsidy(address userAddress)
        public
        view
        returns (uint256)
    {
        uint256 total;
        for (uint8 i = 0; i < 9; i++) {
            if (i > currentChain) {
                return total;
            }
            uint256 useable = getDesirableSubsidy(userAddress, i);
            total += useable;
        }
        return total;
    }

  
    function isClansman(address userAddress, address referrer)
        public
        view
        returns (bool)
    {
        User storage _user = users[referrer];
        for (uint256 i = 0; i < userArr.length; i++) {
            if (_user.referrer != Leader) {
                // 实例化父级
                _user = users[_user.referrer];
                if (_user.referrer == userAddress) {
                    return true;
                }
            } else {
                return false;
            }
        }
        return false;
    }

  
    function isCan(address user) public view returns (bool) {
        if (users[user].orders.length > 0) {
            return false;
        } else {
            return true;
        }
    }

   
    function getOrthologyLength(address userAddress)
        public
        view
        returns (uint256)
    {
        uint256 sum = 0;
        for (uint256 i = 0; i < userArr.length; i++) {
            if (users[userArr[i]].referrer == address(userAddress)) {
                sum = sum.add(1);
            }
        }
        return sum;
    }

    
    function getUserAvailable(address userAddress, uint8 chain)
        public
        view
        returns (uint256)
    {
        return
            getUserFutureValue(userAddress, chain).add(
                getUserReferralBonus(userAddress, chain)
            );
    }

  
    function getUserFutureValue(address userAddress, uint8 chain)
        public
        view
        returns (uint256)
    {
        User storage user = users[userAddress];
        uint256 total = 0;
        for (uint256 i = 0; i < user.orders.length; i++) {
            if (
                orders[user.orders[i]].chain == chain &&
                orders[user.orders[i]].endTime <= block.timestamp
            ) {
                total = total.add(orders[user.orders[i]].forecastEarnings);
            }
        }
        return
            user.issuedOrders[chain] == 0
                ? total
                : total.sub(user.issuedOrders[chain]);
    }

  
    function getUserReferralBonus(address userAddress, uint8 chain)
        public
        view
        returns (uint256)
    {
        User storage user = users[userAddress];
        uint256 total = 0;
        for (uint8 i = 0; i < 20; i++) {
            if (user.tributes[i].length > 0) {
             
                uint256 invite = 0;
                if (i < 3) {
                    invite = inviteYield[i];
                } else if (i < 11) {
                    invite = inviteYield[3];
                } else {
                    invite = inviteYield[4];
                }
                for (uint256 j = 0; j < user.tributes[i].length; j++) {
                    Order memory order = orders[user.tributes[i][j]];
                    if (
                        order.chain == chain && order.endTime <= block.timestamp
                    ) {
                        total =
                            (total
                                .add(order.forecastEarnings.sub(order.amount))
                                .mul(invite) / PERCENTS_DIVIDER) *
                            (inviteYieldCurtail / PERCENTS_DIVIDER) **
                                currentChain;
                    }
                }
            }
        }
        return total;
    }


    function getPlatformStat()
        public
        view
        returns (
            uint8,
            uint32,
            uint256,
            uint256,
            uint256
        )
    {
        return (
            currentChain,
            creationTime,
            totalInvested,
            totalDeposits,
            userArr.length
        );
    }

  
    function getUserStat(address userAddress)
        public
        view
        returns (
            uint64[9] memory,
            uint64[9] memory,
            uint64[9] memory,
            uint64[9] memory
        )
    {
        return (
            users[userAddress].totals,
            users[userAddress].issuedOrders,
            users[userAddress].issuedTributes,
            users[userAddress].paidSubsidy
        );
    }

  
    function getAllFrinedsNum(address userAddress)
        public
        view
        returns (uint256)
    {
        uint256 total;
        for (uint256 i = 0; i < userArr.length; i++) {
            User memory temp_user = users[userArr[i]];
            for (uint256 j = 0; j < 20; j++) {
                if (temp_user.referrer == userAddress) {
                    total++;
                    break;
                }
                temp_user = users[temp_user.referrer];
            }
        }
        return total;
    }

   
    function getAllFrinedsCurrentNum(address userAddress)
        public
        view
        returns (uint256)
    {
        uint256 total;
        for (uint256 i = 0; i < userArr.length; i++) {
            User memory user = users[userArr[i]];
            for (uint256 j = 0; j < 20; j++) {
                if (user.referrer == userAddress) {
                    total += user.totals[currentChain].sub(
                        user.issuedOrders[currentChain]
                    );
                } else {
                    break;
                }
                user = users[user.referrer];
            }
        }
        return total;
    }

   
    function getSpecificGenerationAddress(
        address userAddress,
        uint256 generation
    ) public view returns (uint256) {
        uint256 num;
        if (generation == 1 || generation == 2 || generation == 3) {
            for (uint256 i = 0; i < userArr.length; i++) {
                User memory temp_user = users[userArr[i]];
                for (uint256 j = 0; j < generation; j++) {
                    if (generation == 1) {
                        if (temp_user.referrer == address(userAddress)) {
                            num++;
                        }
                    } else if (generation == 2 || generation == 3) {
                        if (
                            temp_user.referrer == address(userAddress) &&
                            j > generation - 2
                        ) {
                            num++;
                        }
                    }
                    temp_user = users[temp_user.referrer];
                }
            }
            return num;
        } else if (generation >= 4 && generation <= 10) {
            for (uint256 i = 0; i < userArr.length; i++) {
                User memory temp_user = users[userArr[i]];
                for (uint256 j = 0; j < generation; j++) {
                    if (
                        temp_user.referrer == address(userAddress) &&
                        j >= 4 &&
                        j <= 10
                    ) {
                        num++;
                    }
                    temp_user = users[temp_user.referrer];
                }
            }
            return num;
        } else if (generation >= 10 && generation <= 20) {
            for (uint256 i = 0; i < userArr.length; i++) {
                User memory temp_user = users[userArr[i]];
                for (uint256 j = 0; j < generation; j++) {
                    if (
                        temp_user.referrer == address(userAddress) &&
                        j > 10 &&
                        j <= 20
                    ) {
                        num++;
                    }
                    temp_user = users[temp_user.referrer];
                }
            }
            return num;
        }
        return num;
    }

 
    function getUserTributes(address userAddress, uint8 grade)
        public
        view
        returns (uint256[] memory)
    {
        return users[userAddress].tributes[grade];
    }

 
    function getUserOrders(address userAddress)
        public
        view
        returns (uint256[] memory)
    {
        return users[userAddress].orders;
    }

 
    function getOrders() public view returns (Order[] memory) {
        return orders;
    }
}
