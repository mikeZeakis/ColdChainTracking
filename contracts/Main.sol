// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

//TODO: require se ola na ta ksana dw view history/update status
//TODO: date of depart < date of arrival
//TODO: merge location code 
//TODO: merge new update product
//TODO: 

contract Main{

    //GLOBAL VARS OF THE CONTRACT
    address public owner;
    string public contractAuthor = 'MGT TEAM';


    //ENUMS
    enum Role {None, Admin, Supplier, DistributionEmployee, Auditor}
      //me thn seira poy ta vlepeis -->
    enum EntityType {None, Producer, Transporter, Warehouse, PackagingCompany, DistributionCompany, Delivered}

    //STRUCTS

    struct Entity{
        string name;// Paragwgos A 
        EntityType entityType;// Producer
    }

    struct User {
        string name;
        Role role;

    }//as valoume kialla pedia ama xreiastei

    struct TransportationInfo {
        string origin;
        string destination;
        uint dateOfDeparture;
        uint estDateOfArrival;
        Entity currentEntity;
    }

    struct Product {
        uint id;
        string name;
        uint amount;
        string description;
    }

//START EVENTS
    //User events
    event UserAdded(string description, address indexed userAddress, string name, string role);
    event UserDeleted(string description,address indexed userAddress, string name, string role);
    //entity events    
    event EntityAdded(string description, string name, EntityType entityType);
    event EntityDeleted(string description, string name, EntityType entityType);
    //owner event
    event OwnerChanged(string description, address currentOwner, address newOwner);

    event ProductAdded(uint indexed productId, string name);
    event ProductUpdated(string name);
    event ProductDeleted(string name);
//END EVENTS

//START MAPPINGS
    // mapping(uint=> Product) public products;
    // uint productCount;

    //users address -> user (0x987342917237 -> ['GIANNIS , 'ADMIN'],  0x0218376128 -> ['DASKALOS', 'AUDITOR'])
    mapping(address => User) public users;
    address[] public userAddresses;

    // Mapping to store entities by ID
    mapping(string => Entity) public entities;
    // Mapping to store entity IDs by name
    //mapping(string => uint) private nameToId;
    // Mapping to store entity IDs by type
    mapping(EntityType => string[]) private entitiesByType;

    // Mapping to associate products with Transportation Info
    mapping(uint => TransportationInfo[]) public ProdToTransInfo;

    // Mapping to associate product names with product IDs
    mapping(uint => Product) public products;
    mapping(string => Product) private nameToProducts;
    uint public productCount;

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
        if (_type == EntityType.Delivered) return "Delivered";
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
        require(_userAddress != address(0), "Invalid address!"); // non-0 address value 
        require(bytes(users[_userAddress].name).length == 0 , "User already exists!"); // ensure user doesn't already exists
        require(uint(_role) >= uint(Role.None) && uint(_role) <= uint(Role.Auditor), "Invalid role!");


        users[_userAddress] = User(_name,_role);
        userAddresses.push(_userAddress);
        string memory current_role = roleToString(_role);

        emit UserAdded("User added successfully!", _userAddress, _name, current_role);
    }

    //delete user
    function deleteUser(address _userAddress) public onlyRole(Role.Admin){
        require(_userAddress != address(0), "Invalid address!");
        require(bytes(users[_userAddress].name).length != 0, "User doesn't exist!");

        //require(users[_userAddress].role != Role.None, "hmm"); nomizw den xreiazetai auto...

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
        require( uint(_role) >= uint(Role.None) && uint(_role) <= uint(Role.Auditor), "Role is not valid"); //role must be valid 
        require(_userAddress != address(0), "Invalid address");
        require(users[_userAddress].role != _role, "Already has this role");

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
   function addEntity(string memory _name, EntityType entityType) public onlyRole(Role.Admin){
        // Check if the entity name already exists
        require(bytes(entities[_name].name).length == 0, "Entity already exists");
        //require(uint(entityType) >= uint(EntityType.None) && uint(entityType) <= uint(EntityType.DistributionCompany), "Invalid Entity");
   
        // Add the entity to the mappings
        entities[_name] = Entity(_name, entityType);
        entitiesByType[entityType].push(_name);

        // Emit the EntityAdded event
        emit EntityAdded("New entity added!", _name, entityType);
    }

    // Function to delete an entity
    function deleteEntity(string memory _name) public onlyRole(Role.Admin) {
        // Check if the entity exists
        require(bytes(entities[_name].name).length != 0, "Entity does not exist");
        
        // Delete the entity from the mappings
        string memory entityName = entities[_name].name;
        EntityType entityType = entities[_name].entityType;

        delete entities[_name];

        // Remove the entity ID from the entitiesByType array
        string[] storage names = entitiesByType[entityType];
        for (uint i = 0; i < names.length; i++) {
            if (keccak256(bytes(names[i])) == keccak256(bytes(entityName))) {
                names[i] = names[names.length - 1];
                names.pop();
                break;
            }
        }
        
        // Emit the EntityDeleted event
        emit EntityDeleted("Entity deleted successfully!", entityName, entityType);
    }


     // Function to get an entity by name
    function getEntityByName(string memory name) public view returns (Entity memory entity) {
       // Check if the entity exists
        require(bytes(entities[name].name).length != 0, "Entity does not exist");

        // Get the entity ID
        Entity storage _entity = entities[name];

        return (_entity);
    }

    // Function to get all names of the entities of a specific type
    function getEntitiesByType(EntityType entityType) public view returns (string[] memory) {
        // Check if the entity type exists in the entitiesByType array
        require(entitiesByType[entityType].length != 0, "Entity type does not exist");

        return entitiesByType[entityType];//list of names
    }

//END ENTITIES

//END ADMIN FUNCTIONS 

//#region PRODUCT FUNCTIONS

    function addProduct(string memory _name, uint _amount, string memory _description) public {
        require(bytes(nameToProducts[_name].name).length == 0, "Product already exists!");
        require(_amount > 0, "Give a non-zero value for amount!");

        Entity memory currentEntity= Entity("", EntityType.None); //create an empty Entity for the inital transportation info 

        TransportationInfo memory initialTransInfo= TransportationInfo(" ", " ", 0, 0, currentEntity); //initialize an empty transportation info
        
        products[productCount] = Product(productCount, _name, _amount, _description);
        Product memory newproduct=products[productCount];
        
        nameToProducts[_name] = newproduct;
        ProdToTransInfo[newproduct.id].push(initialTransInfo);

        emit ProductAdded(productCount, _name);
        productCount++;
    }

    function deleteProduct(string memory ProductName) public {
        require(bytes(nameToProducts[ProductName].name).length != 0, "Product doesn't exist");
        Product memory prod = nameToProducts[ProductName];
        delete products[prod.id]; 
        delete nameToProducts[ProductName];
        productCount--; 

        emit ProductDeleted(ProductName); 
    }

    function updateProduct(string memory name, string memory newName, uint newAmount, string memory newDescription) public{
        require(bytes(nameToProducts[name].name).length != 0, "Product does not exist"); // product[name] has to exist to be updated

        if (keccak256(bytes(name)) != keccak256(bytes(newName))) { //new name must be different than the current name
            require(bytes(nameToProducts[newName].name).length == 0, "New product name already exists"); // new name should not already exist 
        }

        require(newAmount > 0, "Give a non zero amount!");

        // amount and description how ?

        Product memory product = nameToProducts[name];
        
        product.name= newName;
        product.amount = newAmount;
        product.description= newDescription;

        products[product.id] = product;
        nameToProducts[name] = product;

        emit ProductUpdated(name);
    }

    function getProduct(string memory productName) public view returns (Product memory){
        require(bytes(nameToProducts[productName].name).length != 0, "Product doesn't exist");

        return nameToProducts[productName];
    }

    function UpdateStatus(string memory ProductName, string memory origin, string memory destination, uint dateOfDeparture, uint estDateOfArrival, string memory EntityName, EntityType entityType) public {     
        Product memory product = nameToProducts[ProductName];

        Entity memory entity= Entity(EntityName, entityType);
        TransportationInfo memory transInfo= TransportationInfo(origin, destination, dateOfDeparture, estDateOfArrival, entity);
        ProdToTransInfo[product.id].push(transInfo);
    }


    function ViewProductHistory(string memory productName) public view returns(TransportationInfo[] memory, string memory){
        Product memory product = nameToProducts[productName];       

        TransportationInfo[] memory transInfo= ProdToTransInfo[product.id];

        string memory message= "";

        if(transInfo[transInfo.length -1].currentEntity.entityType==EntityType.None){
            message="Product is just initialized";
        }
        else if(transInfo[transInfo.length -1].currentEntity.entityType==EntityType.Producer){
            message="Product is in the state of Production";
        }
        else if(transInfo[transInfo.length -1].currentEntity.entityType==EntityType.Transporter){
            message="Product is in the state of Transportation";
        }
        else if(transInfo[transInfo.length -1].currentEntity.entityType==EntityType.Warehouse){
            message="Product is in the state of Warehouse";
        }
        else if(transInfo[transInfo.length -1].currentEntity.entityType==EntityType.PackagingCompany){
           message="Product is in the state of Packaging";
        }
        else{
            message="Sou rxetai";
        }
        
        return (transInfo,message);
    }

    function getAmount(uint _productId) public view returns (uint){
        require(_productId < productCount, "Product does not exist");
        Product memory product = products[_productId];
        return product.amount;
    }
   
//#endregion


}

