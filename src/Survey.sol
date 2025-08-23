// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Survey {

//    mapping(address => bool) public hasParticipated;
   mapping(uint256 => mapping (address => bool)) public idToParticipant;
   mapping(address => string) public responses;
   address[] public participants;
   string[] public questions;
   mapping(string questions => string response) public questionResponses;
   uint256 questionId =0;
   uint256 public totalParticipants=0;
    address public owner;
    mapping(uint256 => string) public idToQuestion;
    mapping(uint256 => string) public idToResponse;
    

    constructor() {
        owner = msg.sender; // The deployer becomes the owner
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the contract owner");
        _;
    }
    function participate(string memory response,uint256 _questionId) external {
        require(!idToParticipant[_questionId] [msg.sender], "Already participated");
        idToParticipant[_questionId][msg.sender] = true;
        // hasParticipated[msg.sender] = true;
        responses[msg.sender] = response;
        questionResponses[idToQuestion[_questionId]] = response;
        idToResponse[_questionId] = response;
        participants.push(msg.sender);
        totalParticipants++;
    }
    function getParticipants() external view onlyOwner returns (address[] memory) {
        return participants;
    }
    function getResponseQuestionAnswer(uint256 _questionId) external view onlyOwner returns (string memory) {
        return questionResponses[idToQuestion[_questionId]];
    }
    function createSurvey(string memory question) external returns (uint256) {

        questionId = random(10000);
        questions.push(question);
        idToQuestion[questionId] = question;
        return questionId;
    }
    function getQuestions() external view returns (string[] memory) {
        return questions;
    }
    function getResponseOfParticipant(address participant,uint256 _questionId) external view onlyOwner returns (string memory) {
        require(idToParticipant[_questionId][participant], "Participant has not responded");
        return responses[participant];
    }
  function random(uint256 max) internal view returns (uint256) {
        uint256 nonce = totalParticipants; // Use totalParticipants as a nonce
        // This is pseudo-random, not secure!
        return uint256(
            keccak256(
                abi.encodePacked(
                    block.timestamp,
                    block.prevrandao, // replaces block.difficulty after merge
                    msg.sender,
                    nonce
                )
            )
        ) % max;
    }
    
}