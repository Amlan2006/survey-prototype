// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Survey {

   mapping(address => bool) public hasParticipated;
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
        require(!hasParticipated[msg.sender], "Already participated");
        hasParticipated[msg.sender] = true;
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
        // Logic to create a new survey can be added here
        // For simplicity, this function currently does nothing
        questionId++;
        questions.push(question);
        idToQuestion[questionId] = question;
        return questionId;
    }
    function getQuestions() external view returns (string[] memory) {
        return questions;
    }
    function getResponseOfParticipant(address participant) external view onlyOwner returns (string memory) {
        require(hasParticipated[participant], "Participant has not responded");
        return responses[participant];
    }

    
}