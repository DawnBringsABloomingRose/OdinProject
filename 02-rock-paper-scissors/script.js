//a function to let the CPU choose rock paper or scissors randomly
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


//a function to play a single round of Rock, paper, scissors
function playRPS(playerSelection, computerSelection){
    if (playerSelection == computerSelection) {
        return `It was a tie! You both chose ${playerSelection}`
    }
    else if (playerSelection == "rock" && computerSelection == "paper") {
        return "You lose! Paper beats rock";
    }
    else if (playerSelection == "rock" && computerSelection == "scissors") {
        return "You win! Rock beats paper";
    }
    else if (playerSelection == "scissors" && computerSelection == "paper") {
        return "You win! Scissors beats paper";
    }
    else if (playerSelection == "scissors" && computerSelection == "rock") {
        return "You lose! Rock beats scissors";
    }
    else if (playerSelection == "paper" && computerSelection == "scissors") {
        return "You lose! Scissors beats paper";
    }
    else if (playerSelection == "paper" && computerSelection == "rock") {
        return "You win! Paper beats rock";
    }
    return "error";

}

let playerSelection = prompt("Please enter rock, paper or scissors").toLowerCase();

console.log(playRPS(playerSelection, getComputerChoice()));
