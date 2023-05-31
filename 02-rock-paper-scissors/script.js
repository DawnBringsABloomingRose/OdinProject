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

function selectRPS(playerBtn) {
    const playerSelection = playerBtn.target.id;
    const gameState = playRPS(playerSelection, getComputerChoice());

    if (gameState == 1) {
        playerWins++;
        results.textContent = `You win! Currently it is ${playerWins} you to ${computerWins} the computer`
    } 
    else if (gameState==2) {
        computerWins++;
        results.textContent = `You lose! Currently it is ${playerWins} you to ${computerWins} the computer`
    }
    else if (gameState == 3) {
        results.textContent = `Tie Game! Currently it is ${playerWins} you to ${computerWins} the computer`
    }

    if(playerWins >= 5) {
        results.textContent += `! You won the best of 5! Good job. The next round will reset the scores`;
        playerWins = 0;
        computerWins = 0;
    }
    if(computerWins >= 5) {
        results.textContent += `! You lost the best of 5! Better luck next time. The next round will reset the scores`;
        playerWins = 0;
        computerWins = 0;
    }
}

const results = document.querySelector('#results');
const rockBtn = document.querySelector('#rock');
const paperBtn = document.querySelector('#paper');
const scissorsBtn = document.querySelector('#scissors');
let playerWins = 0;
let computerWins = 0;

rockBtn.addEventListener('click',selectRPS);
paperBtn.addEventListener('click',selectRPS);
scissorsBtn.addEventListener('click',selectRPS);
