const playerFactory = (name, symbol, playernum) => {
    return {name, symbol, playernum}
};

const gameBoard = (() => {
    const player1 = playerFactory('one', 'X', 1);
    const player2 = playerFactory('two', 'O', 2);
    const gameState = [0, 0, 0, 0, 0, 0, 0, 0,0];
    const gamePositions = [[0, 0, 0], [0,0,0], [0,0,0]]
    let winner;
    let currentPlayer = player1;

    const start = () => {
        //gameState = [];
        gameState.forEach((value, i) => gameState[i] = 0)
        gamePositions.forEach((value, i) => gamePositions[i] = [0,0,0])
        currentPlayer = player1;
        winner = 0;
        displayDriver.reload();
        displayDriver.printTurn(currentPlayer)
    }

    const makeMove = (cell) => {
        if (gameState[cell] != 0) {
            return
        }
        gameState[cell] = currentPlayer.symbol;
        gamePositions[Math.floor(cell/3)][cell%3] = currentPlayer.playernum;
        displayDriver.reload();
        if (checkWin()) {
            
        } else {
            switchPlayer();
            displayDriver.printTurn(currentPlayer)
        }
    }

    const checkWin = () => {
        let win = 0
        //row
        gamePositions.forEach((value, i) => {
            if (value[0] == 0) {
                return;
            }    
            else {
                if (value[0]==value[1] && value[0] == value[2]){
                    win = value[0];
                }
            }
            
        })

        //column
        for (let i = 0; i < 3; i++) {
            if(gamePositions[0][i] != 0 && gamePositions[0][i] == gamePositions[1][i] && gamePositions[0][i] == gamePositions[2][i]) {
                win = gamePositions[0][i];
            }          
        }

        //diagonal 
        center = gamePositions[1][1];
        if (center == 0) {

        }
        else if (center == gamePositions[0][0] && center == gamePositions[2][2]) {
            win = gamePositions[1][1]
        } 
        else if (center == gamePositions[0][2] && center == gamePositions[2][0]) {
            win = center;
        }

        if (win == 1) {
            winner = player1;
            displayDriver.printWinner(winner);
            return true
        }
        else if (win == 2) {
            winner = player2;
            displayDriver.printWinner(winner)
            return true;
        }
        return false;
        

    }

    const switchPlayer = () => {
        currentPlayer == player1 ? currentPlayer = player2 : currentPlayer = player1;
    }

    return {start, makeMove, gameState}
})();

const displayDriver = (() => {
    const gameArea = document.querySelector('.game')
    const displayArea = document.querySelector('.comms')
    const cells = new Array(9);
    const startButton = document.querySelector('.start')

    const reload = () => {
        gameBoard.gameState.forEach((value, i) => {
            if (value != 0) {
                cells[i].innerText = value;
            }
            else {
                cells[i].innerText = '';
            }
        })
    }

    const initialize = () => {
        for (let i = 0; i < 9; i++) {
            const cell = document.createElement('div');
            cell.className = 'cell' + i;
            cell.addEventListener('click', (e) => {gameBoard.makeMove(i)})
            gameArea.appendChild(cell);
            cells[i] = cell;
        }
        startButton.addEventListener('click', (e) => gameBoard.start())
        gameBoard.start();
    }

    const printWinner = (winner) => {
        displayArea.innerText = 'Congrats ' + winner.name;
        
    }

    const printTurn = (player) => {
        displayArea.innerText = player.name + ' to move'
    }

    return {
        initialize, reload, cells, printWinner, printTurn
    }
})();

displayDriver.initialize();