// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;


import "@openzeppelin/contracts/utils/Counters.sol";


contract Verification {
    using Counters for Counters.Counter;

    struct File {
        uint ID;
        string uri;
        address sender;
        bool isVerified;
    }

    Counters.Counter public fileIds;

    address public owner;

    constructor() {
        owner = msg.sender;
    }

    mapping(uint => File) public files;

    function uploadFile(string memory _uri) public {
        File memory file;
        fileIds.increment();
        file.ID = fileIds.current();
        file.sender = msg.sender;
        file.uri= _uri;
        files[fileIds.current()] = file;
    }

    function verifyFile(uint _id) public {
        require( files[_id].isVerified == false );
        require(owner == msg.sender);
        files[_id].isVerified = true;
    }

    function viewDocuments() public view returns(File[] memory) {
        uint filesCount = fileIds.current();
        uint currentIndex = 0;

        File[] memory fileArray = new File[](filesCount);
        for(uint i = 0; i < filesCount; i++) {
            uint currentId = files[i+1].ID;
            File storage currentItem = files[currentId];
            fileArray[currentIndex] = currentItem;
            currentIndex += 1;
        }
        return fileArray;
    }


}

