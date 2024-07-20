// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

//creating a smart contract where student can study as well as enjoy using degen application
contract DegenToken is ERC20, Ownable, ERC20Burnable {

    // Events that are perform further by which students will earn points
    event TokensMinted(address indexed to, uint256 amount);
    event TokensRedeemed(address indexed from, uint256 amount, uint256 mathCredit, uint256 scienceCredit, uint256 historyCredit, uint256 literatureCredit, uint256 extraCurricularPoints);
    event EventCreated(uint256 eventId, string eventName, uint256 tokensRewarded, uint256 extraCurricularPointsRewarded);
    event EventAttended(address indexed student, uint256 eventId, uint256 tokensEarned);
    event StudyCompleted(address indexed student, uint256 tokensEarned);
    event GamePlayed(address indexed student, uint256 tokensEarned, uint256 extraCurricularPointsEarned);
    event StudentRegistered(address indexed student);
    event BonusCreditsGranted(address indexed student, uint256 mathCredit, uint256 scienceCredit, uint256 historyCredit, uint256 literatureCredit, uint256 extraCurricularPoints);

    struct StudentCredits {
        uint256 math;
        uint256 science;
        uint256 history;
        uint256 literature;
        uint256 extraCurricularPoints;
    }

    struct Event {
        string name;
        uint256 tokensRewarded;
        uint256 extraCurricularPointsRewarded;
    }

    mapping(address => StudentCredits) public studentCredits;
    mapping(address => bool) public registeredStudents;
    mapping(uint256 => Event) public events;
    mapping(address => mapping(uint256 => bool)) public eventAttendance;
    uint256 public nextEventId;

//check if the student is registered or not
    modifier onlyRegistered() {
        require(registeredStudents[msg.sender], "You must be a registered student to perform this action");
        _;
    }

    // Constructor to set token name, symbol and initial owner
    constructor() ERC20("DegenToken", "DGN") Ownable(msg.sender) {}

    // to check Registered student address provided is right or wrong
    function registerStudent(address student) public onlyOwner {
        require(student != address(0), "Invalid student address");
        registeredStudents[student] = true;
        emit StudentRegistered(student);
    }
// here i have added  function so that we got to know at what point student is there
     function StudentPosition(uint256 marks) public pure {
          if (marks <= 30) {
            revert("e grade");
        }
        else if (marks <= 50 || marks >30 )
        {
            revert("d grade");
        }
        else if (marks <= 70 || marks >50 )
        {
            revert("c grade");
        }
         else if (marks <= 80 || marks >70 )
        {
            revert("b grade");
        }
         else  
        {
            revert("a grade");
        }
     }

    // Mint the tokens only owner can call the function
    function mint(address to, uint256 amount) external onlyOwner {
        //add tokens to mint 
        _mint(to, amount);
        emit TokensMinted(to, amount);
    }

    // Redeem tokens for extra credits in different subjects and extracurricular points
    function redeemTokens(uint256 amount, uint256 mathCredit, uint256 scienceCredit, uint256 historyCredit, uint256 literatureCredit, uint256 extraCurricularPoints) public onlyRegistered {
        require(balanceOf(msg.sender) >= amount, "Insufficient tokens to redeem");

        burn(amount);

        studentCredits[msg.sender].math += mathCredit;
        studentCredits[msg.sender].science += scienceCredit;
        studentCredits[msg.sender].history += historyCredit;
        studentCredits[msg.sender].literature += literatureCredit;
        studentCredits[msg.sender].extraCurricularPoints += extraCurricularPoints;

        emit TokensRedeemed(msg.sender, amount, mathCredit, scienceCredit, historyCredit, literatureCredit, extraCurricularPoints);
    }

    // Create an event , we can create by ourselves
    function createEvent(string memory name, uint256 tokensRewarded, uint256 extraCurricularPointsRewarded) public onlyOwner {
        //creating new event &  add new address
        events[nextEventId] = Event(name, tokensRewarded, extraCurricularPointsRewarded);
        emit EventCreated(nextEventId, name, tokensRewarded, extraCurricularPointsRewarded);
        nextEventId++;
    }

    //we can check is he pass or fail so that we can get added by degen he should get credit or not
     uint public x = 95; //subject1 marks
    uint public y = 33; // subject2 marks
      function passOrfail() public view returns (uint, string memory) {
        uint add = x + y; // adding all grade marks
        assert(add >= 0);
        if (add >= 50) {
            return (add, "student is passed with good marks");
        } else {
            return (add, "student is failed");
        }
    }
    // Function to attend event and earn tokens
    function attendEvent(uint256 eventId) public onlyRegistered {
        require(events[eventId].tokensRewarded > 0, "Event does not exist");
        require(!eventAttendance[msg.sender][eventId], "You have already attended this event");
        //enhancing student performance by adding their tokens
        eventAttendance[msg.sender][eventId] = true;
        _mint(msg.sender, events[eventId].tokensRewarded);
        studentCredits[msg.sender].extraCurricularPoints += events[eventId].extraCurricularPointsRewarded;

        emit EventAttended(msg.sender, eventId, events[eventId].tokensRewarded);
    }

    // Function to complete study and earn tokens
    function completeStudy(address student, uint256 tokensEarned) public onlyOwner {
        require(student != address(0), "Invalid student address");
        require(registeredStudents[student], "Student must be registered");
        _mint(student, tokensEarned);
        emit StudyCompleted(student, tokensEarned);
    }

    // Function to play games and earn extracurricular points and tokens
    function playGame(address student, uint256 tokensEarned, uint256 extraCurricularPointsEarned) public onlyOwner {
        require(student != address(0), "Invalid student address");
        require(registeredStudents[student], "Student must be registered");
        _mint(student, tokensEarned);
        studentCredits[student].extraCurricularPoints += extraCurricularPointsEarned;
        emit GamePlayed(student, tokensEarned, extraCurricularPointsEarned);
    }

    // Grant bonus credits
    function grantBonusCredits(address student, uint256 mathCredit, uint256 scienceCredit, uint256 historyCredit, uint256 literatureCredit, uint256 extraCurricularPoints) public onlyOwner {
        require(student != address(0), "Invalid student address");
        require(registeredStudents[student], "Student must be registered");

        studentCredits[student].math += mathCredit;
        studentCredits[student].science += scienceCredit;
        studentCredits[student].history += historyCredit;
        studentCredits[student].literature += literatureCredit;
        studentCredits[student].extraCurricularPoints += extraCurricularPoints;

        emit BonusCreditsGranted(student, mathCredit, scienceCredit, historyCredit, literatureCredit, extraCurricularPoints);
    }

    // Override transfer function to ensure proper transfer
    function transfer(address to, uint256 amount) public virtual override returns (bool) {
        _transfer(_msgSender(), to, amount);
        return true;
    }

    // Override transferFrom function to ensure proper transfer from an address
    function transferFrom(address sender, address recipient, uint256 amount) public virtual override returns (bool) {
        _transfer(sender, recipient, amount);
        _approve(sender, _msgSender(), allowance(sender, _msgSender()) - amount);
        return true;
    }

    // Override approve function to ensure proper approval
    function approve(address spender, uint256 amount) public virtual override returns (bool) {
        _approve(_msgSender(), spender, amount);
        return true;
    }
}
