// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

contract Album{


    struct musicAlbum{
        uint id;
        string artist;
        string albumTitle;
        uint tracks;
    }

    mapping (uint => musicAlbum) public album;

    musicAlbum public currentAlbum;
    mapping (address => musicAlbum) public userAlbums;

    string public constant contractAuthor = 'Zeakis Michalis';
    address owner;    

    event albumEvent(string albumEvent_Description,string albumEvent_Artist, string albumEvent_albumTitle, uint albumEvent_tracks);
    event errorEvent(string _Dexcription);


    constructor(){
        // artist = 'Nirvana';
        // albumTitle = 'Nevermind';

        // tracks = 13;
        owner = msg.sender;

        currentAlbum.artist = 'Nirvana';
        currentAlbum.albumTitle = 'NeverMind';
        currentAlbum.tracks = 10;

    }

    modifier onlyOwner{
       // require(msg.sender == owner, "Only contract owner can call this function"); // Ensure that the sender of the transaction is the owner
        //_; 
        if (msg.sender != owner){
            emit errorEvent("only the owner of this contract can perform this action");
        }else{
            _;
        }

    }
    
    function getCurrentAlbum() public view returns (string memory,string memory,uint){
        return(currentAlbum.artist,currentAlbum.albumTitle,currentAlbum.tracks);
    }

    function setAlbum(string memory _artist, string memory _albumTitle, uint _tracks) public {
        currentAlbum.artist = _artist;
        currentAlbum.albumTitle = _albumTitle;
        currentAlbum.tracks = _tracks;

        emit albumEvent("The current album info has been updated", _artist,_albumTitle,_tracks);
    }


    function getUsersFavouriteAlbum() public view returns(string memory, string memory, uint){
        return(userAlbums[msg.sender].artist, userAlbums[msg.sender].albumTitle, userAlbums[msg.sender].tracks);
    }

    function setUsersFavouriteAlbum(string memory _artist, string memory _albumTitle, uint _tracks) public{
        userAlbums[msg.sender].artist = _artist;
        userAlbums[msg.sender].albumTitle = _albumTitle;
        userAlbums[msg.sender].tracks = _tracks;

        emit albumEvent("You have ipdated your favourite album", _artist,_albumTitle,_tracks);
    }
    

    // function myFunction(uint memory _id) public {
    //     musicAlbum storage my_album = album[_id];

    //     uint t = my_album.id;


    // }

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

    // mapping (uint => Product) public products;

    // transInfo = [transinfo1, transinfo2, transinfo3]
    //             [ 0              1              2  ]

    // length = 3

    // 0 -> product1
    // 1 -> product2

    // ksjdnfkjs = product[productId].transInfo[transInfo.length - 1].currentEntity
 

    // function trackShipment(uint productId) public view returns (Entity memory) {
    //     require(_productId < productCount, "Product does not exist");

    //     current_entity = products[_productId].TransportationInfo[TransportationInfo.length - 1].currentEntity
    //     return current_entity;
    // }
    
}



