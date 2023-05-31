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
//arguments: playerSelection is a string, computerSelection is a string
//return: 1 for player win, 2 for CPU win, 3 for a tie
function playRPS(playerSelection, computerSelection){
    if (playerSelection == computerSelection) {
        return 3;
    }
    else if (playerSelection == "rock" && computerSelection == "paper") {
        return 2;
    }
    else if (playerSelection == "rock" && computerSelection == "scissors") {
        return 1;
    }
    else if (playerSelection == "scissors" && computerSelection == "paper") {
        return 1;
    }
    else if (playerSelection == "scissors" && computerSelection == "rock") {
        return 2;
    }
    else if (playerSelection == "paper" && computerSelection == "scissors") {
        return 2;
    }
    else if (playerSelection == "paper" && computerSelection == "rock") {
        return 1;
    }
    return "error";

}


//a function to play through 5 rounds of RPS
function game() {
    console.log("Welcome to Rock paper scissors xd");
    let playerSelection= "";
    let computerSelection = "";
    let playerWins = 0;
    let computerWins = 0;
    let currentWinner;
    for (let i = 0; i < 5; i++) {
        console.log(`Game ${i+1}`)
        playerSelection = prompt("Please enter rock, paper or scissors").toLowerCase();
        computerSelection = getComputerChoice();
        currentWinner = playRPS(playerSelection, computerSelection);
        if (currentWinner == 1) {
            console.log(`You win! ${playerSelection} beats ${computerSelection}`);
            playerWins++;
        }
        else if (currentWinner == 2) {
            console.log(`You lose! ${computerSelection} beats ${playerSelection}`);
            computerWins++;
        }
        else if (currentWinner == 3) {
            console.log(`It was a draw! You both chose ${playerSelection}`);
        }

    }

    if (computerWins > playerWins) {
        console.log(`The computer won ${computerWins} to your ${playerWins}. Better Luck next time!`);
    }
    else if (playerWins > computerWins) {
        console.log(`The computer won ${computerWins} to your ${playerWins}. Good job!`);
    }
    else {
        console.log(`The computer won ${computerWins} to your ${playerWins}. It was a draw!`);
    }
}

game();
