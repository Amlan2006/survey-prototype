// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/Survey.sol";

contract SurveyTest is Test {
    Survey survey;
    address owner = address(this); // default test contract is the deployer
    address alice = address(0x1);
    address bob   = address(0x2);

    function setUp() public {
        survey = new Survey();
    }

    function testOwnerIsDeployer() public {
        assertEq(survey.owner(), owner);
    }

    function testCreateSurveyIncrementsIdAndStoresQuestion() public {
        uint256 id1 = survey.createSurvey("What is your favorite color?");
        uint256 id2 = survey.createSurvey("Do you like Solidity?");

        assertEq(id1, 1);
        assertEq(id2, 2);

        string[] memory allQuestions = survey.getQuestions();
        assertEq(allQuestions.length, 2);
        assertEq(allQuestions[0], "What is your favorite color?");
        assertEq(allQuestions[1], "Do you like Solidity?");
    }

    function testParticipateStoresResponseAndPreventsDuplicates() public {
        // owner creates question
        uint256 qId = survey.createSurvey("What is your favorite color?");

        // prank as Alice
        vm.prank(alice);
        survey.participate("Blue", qId);

        assertEq(survey.hasParticipated(alice), true);
        assertEq(survey.responses(alice), "Blue");
        assertEq(survey.idToResponse(qId), "Blue");
        assertEq(survey.totalParticipants(), 1);

        // duplicate should revert
        vm.prank(alice);
        vm.expectRevert("Already participated");
        survey.participate("Green", qId);
    }

    function testGetParticipantsOnlyOwner() public {
        uint256 qId = survey.createSurvey("Q?");
        vm.prank(alice);
        survey.participate("A", qId);

        // non-owner cannot call
        vm.prank(alice);
        vm.expectRevert("Not the contract owner");
        survey.getParticipants();

        // owner can call
        address[] memory participants = survey.getParticipants();
        assertEq(participants.length, 1);
        assertEq(participants[0], alice);
    }

    function testGetResponseQuestionAnswerOnlyOwner() public {
        uint256 qId = survey.createSurvey("Q?");
        vm.prank(bob);
        survey.participate("Answer from Bob", qId);

        // non-owner revert
        vm.prank(bob);
        vm.expectRevert("Not the contract owner");
        survey.getResponseQuestionAnswer(qId);

        // owner gets response
        string memory resp = survey.getResponseQuestionAnswer(qId);
        assertEq(resp, "Answer from Bob");
    }

    function testGetResponseOfParticipantOnlyOwner() public {
        uint256 qId = survey.createSurvey("Q?");
        vm.prank(alice);
        survey.participate("Alice Answer", qId);

        // non-owner revert
        vm.prank(alice);
        vm.expectRevert("Not the contract owner");
        survey.getResponseOfParticipant(alice);

        // owner gets response
        string memory resp = survey.getResponseOfParticipant(alice);
        assertEq(resp, "Alice Answer");
    }

    function testGetResponseOfNonParticipantReverts() public {
        vm.expectRevert("Participant has not responded");
        survey.getResponseOfParticipant(alice);
    }
}
