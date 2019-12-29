pragma solidity ^0.5;

contract Election {

    struct Candidate{
        uint id;
        string name;
        string party;
        uint voteCount;

    }

    event votedEvent (
            uint indexed _candidateId
        );

    mapping(uint=>Candidate) public candidates;
    mapping(string=>bool) candidateNames;
    mapping(address=>bool) public voters;
    uint public candidatesCount;

    function addCandidate(string memory _name, string memory _party) private{
        require(!candidateNames[_name], "Candidate with this name already exists");
        candidatesCount++;
        candidates[candidatesCount] = Candidate(candidatesCount,_name,_party,0);
        candidateNames[_name]= true;
    }

    function vote (uint _candidateId) public{
        require(!voters[msg.sender]);
        require(_candidateId>0 && _candidateId< candidatesCount);
        voters[msg.sender]=true;
        candidates[_candidateId].voteCount++;
        emit votedEvent(_candidateId);
    }

    constructor() public {

        addCandidate("Saulius Skvernelis", "Žalieji");
        addCandidate("Alfa vyras", "Kietakai");
        addCandidate("Vytautas Šustauskas", "Kietakai");
        addCandidate("Tadas Samagonas", "Barygos");
        addCandidate("Ingrida Šimonytė", "TS-LKD");
        addCandidate("Arnas Barišauskas", "Kambariokų partija");
        addCandidate("Virūnas Vilčinskas", "Kambariokų partija");

    }


}