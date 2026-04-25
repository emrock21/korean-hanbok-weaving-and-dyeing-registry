// SPDX-License-Identifier: MIT
pragma solidity 0.8.31;

contract HanbokWeavingAndDyeingRegistry {

    struct HanbokTradition {
        string textileName;         // mosi, oksa, nobang, etc.
        string region;              // Hansan, Andong, Jeonju, Jeju
        string materials;           // ramie, silk, natural dyes
        string techniques;          // handloom, natural dyeing, pounding, weaving
        string motifs;              // obangsaek colors, geometric, floral
        string culturalContext;     // ceremonial hanbok, seasonal garments
        string uniqueness;          // UNESCO status, regional identity
        address creator;
        uint256 likes;
        uint256 dislikes;
        uint256 createdAt;
    }

    struct HanbokInput {
        string textileName;
        string region;
        string materials;
        string techniques;
        string motifs;
        string culturalContext;
        string uniqueness;
    }

    HanbokTradition[] public traditions;
    mapping(uint256 => mapping(address => bool)) public hasVoted;

    event HanbokRecorded(uint256 indexed id, string textileName, address indexed creator);
    event HanbokVoted(uint256 indexed id, bool like, uint256 likes, uint256 dislikes);

    constructor() {
        traditions.push(
            HanbokTradition({
                textileName: "Example (replace manually)",
                region: "example",
                materials: "example",
                techniques: "example",
                motifs: "example",
                culturalContext: "example",
                uniqueness: "example",
                creator: address(0),
                likes: 0,
                dislikes: 0,
                createdAt: block.timestamp
            })
        );
    }

    function recordHanbok(HanbokInput calldata h) external {
        traditions.push(
            HanbokTradition({
                textileName: h.textileName,
                region: h.region,
                materials: h.materials,
                techniques: h.techniques,
                motifs: h.motifs,
                culturalContext: h.culturalContext,
                uniqueness: h.uniqueness,
                creator: msg.sender,
                likes: 0,
                dislikes: 0,
                createdAt: block.timestamp
            })
        );

        emit HanbokRecorded(traditions.length - 1, h.textileName, msg.sender);
    }

    function voteHanbok(uint256 id, bool like) external {
        require(id < traditions.length, "Invalid ID");
        require(!hasVoted[id][msg.sender], "Already voted");

        hasVoted[id][msg.sender] = true;
        HanbokTradition storage h = traditions[id];

        if (like) h.likes++;
        else h.dislikes++;

        emit HanbokVoted(id, like, h.likes, h.dislikes);
    }

    function totalHanbok() external view returns (uint256) {
        return traditions.length;
    }
}
