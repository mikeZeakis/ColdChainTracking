// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.7.0;

contract Album{
    struct musicAlbum{
        string artist;
        string albumTitle;
        uint tracks;
    }

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

}



