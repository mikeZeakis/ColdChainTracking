// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

contract Main{

    //GLOBAL VARS OF THE CONTRACT
    address public owner;
    string public contractAuthor = 'MGT TEAM';


    //ENUMS
    enum Role {None, Admin, Supplier, DistributionEmployee, Auditor}
      //me thn seira poy ta vlepeis -->
    enum EntityType {Producer, Transporter, Warehouse, PackagingCompany, DistributionCompany}

    //STRUCTS

    struct Entity{
        string name;// Paragwgos A 
        EntityType entityType;// Producer
    }

    struct User {
        string name;
        Role role;

    }//as valoume kialla pedia ama xreiastei

    // struct transportationInfo{
    //     uint id;
    //     string origin; //
    //     string destination; //
    //     //dates are ints cause the are stored in the Unix timestamp format (sto front na tis metatrepsoume)
    //     uint dateOfDeparture;
    //     uint estDateOfArrival;
    //     Entity currentEntity;
    // }

    // struct Product{
    //     uint id; 
    //     string name;
    //     uint amount;
    //     string description;
    //     transportationInfo[] transInfo;
    // }


//START EVENTS
    //User events
    event UserAdded(string description, address indexed userAddress, string name, string role);
    event UserDeleted(string description,address indexed userAddress, string name, string role);
    //entity events    
    event EntityAdded(string description, uint id, string name, EntityType entityType);
    event EntityDeleted(string description, uint id, string name, EntityType entityType);
    //owner event
    event OwnerChanged(string description, address currentOwner,address  newOwner);
//END EVENTS

//START MAPPINGS
    // mapping(uint=> Product) public products;
    // uint productCount;

    //users address -> user (0x987342917237 -> ['GIANNIS , 'ADMIN'],  0x0218376128 -> ['DASKALOS', 'AUDITOR'])
    mapping(address => User) public users;
    address[] public userAddresses;

    // Mapping to store entities by ID
    mapping(uint => Entity) public entities;
    // Mapping to store entity IDs by name
    mapping(string => uint) private nameToId;
    // Mapping to store entity IDs by type
    mapping(EntityType => uint[]) private entitiesByType;

//END MAPPINGS
    
//START MODIFIERS
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
//END MODIFIERS

    constructor(){
        owner = msg.sender; //address of caller of the contract (o 1os logariasmos tou ganache) will be owner and admin
        users[owner] = User(contractAuthor,Role.Admin);
        userAddresses.push(owner);
        //productCount = 0;
    }

//**FUNCTIONS**

//START TO STRING FUNCTIONS
    function roleToString(Role _role) internal pure returns (string memory) {
        if (_role == Role.None) return "None";
        if (_role == Role.Admin) return "Admin";
        if (_role == Role.Supplier) return "Supplier";
        if (_role == Role.DistributionEmployee) return "DistributionEmployee";
        if (_role == Role.Auditor) return "Auditor";
        revert("Invalid Role");
    }

    function entityTypeToString(EntityType _type) internal pure returns (string memory) {
        if (_type == EntityType.Producer) return "Producer";
        if (_type == EntityType.Transporter) return "Transporter";
        if (_type == EntityType.Warehouse) return "Warehouse";
        if (_type == EntityType.PackagingCompany) return "PackagingCompany";
        if (_type == EntityType.DistributionCompany) return "DistributionCompany";
        revert("Invalid Type");
    }
//END TO STRING FUNCTIONS

//START OWNER 
    //address from ganache 
    function changeOwner(address newOwner) public onlyOwner {
        require(newOwner != address(0), "Invalid address!");
        owner = newOwner;
        emit OwnerChanged("Owner changed successfully!", msg.sender, newOwner);
    }
//END OWNER 

//START ADMIN FUNCTIONS
//START USER
    function addUser (address _userAddress, string memory _name, Role _role) public onlyRole(Role.Admin){
        require(_userAddress != address(0), "Invalid address!");
        users[_userAddress] = User(_name,_role);
        userAddresses.push(_userAddress);
        string memory current_role = roleToString(_role);

        emit UserAdded("User added successfully!", _userAddress, _name, current_role);
    }

    //delete user
    function deleteUser(address _userAddress) public onlyRole(Role.Admin){
        require(_userAddress != address(0), "Invalid address!");
        string memory name = users[_userAddress].name;
        string memory current_role = roleToString(users[_userAddress].role);

        //delete user from mapping
        delete users[_userAddress];

        //delete user address from list with addresses
        for (uint i = 0; i < userAddresses.length; i++) {
            if (userAddresses[i] == _userAddress) {
                userAddresses[i] = userAddresses[userAddresses.length - 1];
                userAddresses.pop();
                break;
            }
        }

        emit UserDeleted("User deleted successfully!", _userAddress, name, current_role);
    }

    //change role of a user 
    function setUserRole (address _userAddress, Role _role) public onlyRole(Role.Admin){
        //TODO: handle _role value to be valid 
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

    function getUserByAddress(address _userAddress) public view returns (User memory) {
        require(_userAddress != address(0), "Invalid address");
        return users[_userAddress];
    }
//END USER

//START ENTITIES
   function addEntity(uint entityId, string memory name, EntityType entityType) public onlyRole(Role.Admin){
        // Check if the entity ID already exists
        require(bytes(entities[entityId].name).length == 0, "Entity ID already exists");
        // Check if the entity name already exists
        require(nameToId[name] == 0, "Entity name already exists");

        // Add the entity to the mappings
        entities[entityId] = Entity(name, entityType);
        nameToId[name] = entityId;
        entitiesByType[entityType].push(entityId);

        
        // Emit the EntityAdded event
        emit EntityAdded("New entity added!", entityId, name, entityType);
    }


    // Function to delete an entity
    function deleteEntity(uint entityId) public onlyRole(Role.Admin) {
        // Check if the entity exists
        require(bytes(entities[entityId].name).length != 0, "Entity does not exist");
        
        // Delete the entity from the mappings
        string memory entityName = entities[entityId].name;
        EntityType entityType = entities[entityId].entityType;

        delete entities[entityId];
        delete nameToId[entityName];

        // Remove the entity ID from the entitiesByType array
        uint[] storage ids = entitiesByType[entityType];
        for (uint i = 0; i < ids.length; i++) {
            if (ids[i] == entityId) {
                ids[i] = ids[ids.length - 1];
                ids.pop();
                break;
            }
        }
        
        // Emit the EntityDeleted event
        emit EntityDeleted("Entity deleted successfully!", entityId, entityName, entities[entityId].entityType);
    }

    // Function to get an entity by ID
    function getEntityById(uint entityId) public view returns (string memory name, EntityType entityType) {
        // Check if the entity exists
        require(bytes(entities[entityId].name).length != 0, "Entity does not exist");
        
        // Return the entity's details
        Entity storage entity = entities[entityId];
        return (entity.name, entity.entityType);
    }

     // Function to get an entity by name
    function getEntityByName(string memory name) public view returns (uint entityId, EntityType entityType) {
        // Check if the entity exists
        require(nameToId[name] != 0, "Entity does not exist");

        // Get the entity ID
        entityId = nameToId[name];
        Entity storage entity = entities[entityId];
        return (entityId, entity.entityType);
    }

    // Function to get all ids entities of a specific type
    function getEntitiesByType(EntityType entityType) public view returns (uint[] memory) {
        return entitiesByType[entityType];
    }






//END ENTITIES

//END ADMIN FUNCTIONS 
}

