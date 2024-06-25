// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

contract Main{

    //GLOBAL VARS OF THE CONTRACT
    address public owner;
    string public contractAuthor = 'MGT TEAM';


    //ENUMS
    enum Role {None, Admin, Supplier, DistributionEmployee, Auditor}
      //me thn seira poy ta vlepeis -->
    enum Entity {Producer, Transporter, Warehouse, PackagingCompany, DistributionCompany }


    //STRUCTS
    struct User {
        string name;
        Role role;
    }//as valoume kialla pedia ama xreiastei

    struct transportationInfo{
        uint id;
        string origin;
        string destination;
        //dates are ints cause the are stored in the Unix timestamp format (sto front na tis metatrepsoume)
        uint dateOfDeparture;
        uint estDateOfArrival;
        Entity currentEntity;
    }


    struct Product{
        uint id; 
        string name;
        uint amount;
        string description;
        transportationInfo transInfo;
    }

    //EVENTS 
    //event wrongRole(string message, string role);
    //...


    //MAPPINGS
    //nomizw 8eloume 2 mappings [na to skeftoume ligo auto)
    //ena gia ta products kai ena gia tous users 
    //
    // | 8a mporousame na ftiaksoume kai mia lista apo products     |
    // | kai to index na einai to id kserw gw, as mas pei o daskalos|
    // | poio einai to best practice                                |
    // 
    //products uint -> product (0 -> Beef, 1 -> Tomatoes etc.)
    //mapping(uint => Product) public products;
    //users address -> user (0x987342917237 -> ['GIANNIS , 'ADMIN'],  0x0218376128 -> ['DASKALOS', 'AUDITOR'])
    mapping(address => User) public users;
    address[] public userAddresses;
    

    //MODIFIERS
    modifier onlyOwner{
        // Ensure that the sender of the transaction is the owner
       require(msg.sender == owner, "Only contract owner can call this function"); 
        _; 
    }

    //check if the role of the current user has the required role
    modifier onlyRole (Role _role){
        require(users[msg.sender].role == _role, "Access denied: incorrect role");
        _;
    }



    //CONSTRUCTOR
    constructor(){
        owner = msg.sender; //address of caller of the contract (o 1os logariasmos tou ganache)
        users[owner] = User(contractAuthor,Role.Admin);
        userAddresses.push(owner);
    }


    //FUNCTIONS
    // --- OWNER FUNCTIONS ---

    //address from ganache 
    function changeOwner(address newOwner) public onlyOwner {
        owner = newOwner;
    }

    // --- ADMIN FUNCTIONS ---

    //add user 
    function addUser (address _userAddress, string memory _name, Role _role) public onlyRole(Role.Admin){
        require(_userAddress != address(0), "Invalid address!");
        users[_userAddress] = User(_name,_role);
        userAddresses.push(_userAddress);
    }

    //delete user
    function deleteUser(address _userAddress) public onlyRole(Role.Admin){
        require(_userAddress != address(0), "Invalid address!");
        delete users[_userAddress];
        //userAddresses.pop(_userAddress);
    }

    //change role of a user 
    function setUserRole (address _userAddress, Role _role) public onlyRole(Role.Admin){
        require(_userAddress != address(0), "Invalid address");
        users[_userAddress].role = _role;
    }

    function getAllUsers() public view returns (User[] memory){
        User[] memory allUsers = new User[](userAddresses.length);
        for (uint i = 0; i < userAddresses.length; i++) {
            allUsers[i] = users[userAddresses[i]];
        }
        return allUsers;
    }
}
