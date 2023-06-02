function add(num1, num2) {
    return parseInt(num1) + parseInt(num2);
}

function subtract(num1, num2) {
    return num1 - num2;
}

function multiply(num1, num2) {
    return num1 * num2;
}

function divide(num1, num2) {
    return num1 / num2;
}

function operate(num1, num2, operand) {
    if (operand == '+') {
        return add(num1, num2);
    }
    if (operand == '-') {
        return subtract(num1, num2);
    }
    if (operand == '*') {
        return multiply(num1, num2);
    }
    if (operand == '/') {
        return divide(num1, num2);
    }
}


function numberClick(item) {
    displayText += item.target.textContent;
    updateDisplay();
    number2 += item.target.textContent;
    currentlyOperating = false;
}

function updateDisplay() {
    displayField.textContent = displayText;
}

function operandClick(item) {
    if(number2=='' && currentlyOperating) {
        currentOperand = item.target.textContent;
        displayText = number1 + currentOperand;
        updateDisplay();
        return;
    }
    else if (!currentlyOperating && number2 == '') {
        
    }
    else {
        currentlyOperating = true;
        if (number1 != '') {
            let tempNum = operate(number1, number2, currentOperand);
            number1 = tempNum;
            number2 = '';
            currentOperand = item.target.textContent;
            displayText = number1 + currentOperand;
            console.log(displayText);
            updateDisplay();
        }
        else {
            currentOperand = item.target.textContent;
            number1 = number2;
            number2 = '';
            displayText = number1 + currentOperand;
            updateDisplay();
        }
    }
}

let displayText = '';
const displayField = document.querySelector('.display');
const numberBtns = document.querySelectorAll('.number');
const operandBtns = document.querySelectorAll('.operand');

let number1='';
let number2='';
let currentOperand, previousOperand;
let currentlyOperating = false;

numberBtns.forEach(btn => btn.addEventListener('click',numberClick));

operandBtns.forEach(btn => btn.addEventListener('click',operandClick));