// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AssetManagement {
    struct Asset {
        address owner;
        string name;
        uint256 value;
        bool exists;
    }
    mapping(uint256 => Asset) public assets;

    event AssetRegistered(uint256 assetId, string name, uint256 value, address owner);

    modifier assetExists(uint256 assetId) {
        require(assets[assetId].exists, "Asset does not exist");
        _;
    }

    function registerAsset(uint256 assetId, string memory name, uint256 value) external {
        require(!assets[assetId].exists, "Asset already exists");
        assets[assetId] = Asset(msg.sender, name, value, true);
        emit AssetRegistered(assetId, name, value, msg.sender);
    }

    function transferAssetOwnership(uint256 assetId, address newOwner) external assetExists(assetId) {
        require(assets[assetId].owner == msg.sender, "You are not the owner of this asset");
        assets[assetId].owner = newOwner;
    }

}
