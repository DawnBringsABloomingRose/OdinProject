function getComputerChoice() {
    let computerChoice;
    let randomNumber = Math.floor(Math.random()*3);

    if (randomNumber == 0) {
        computerChoice = "scissors";
    }
    else if (randomNumber == 1) {
        computerChoice = "rock";
    }
    else {
        computerChoice = "paper";
    }

    return computerChoice;
}

console.log(getComputerChoice());