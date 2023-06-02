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
    if (num2 == 0) {
        clearAll();
        displayText= "you thought you could divide by 0? how cute";
        updateDisplay();
        return 'exit';
    }
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

function printEquals() {
    if (number1 != '' && number2 != '') {
        let tempNum = operate(number1, number2, currentOperand);
        if (tempNum == 'exit') {
            return;
        }
        number1 = tempNum;
        number2 = '';
        displayText = number1;
        updateDisplay();
    }
}

function operandClick(item) {
    if(number2=='' && currentlyOperating) {
        currentOperand = item.target.textContent;
        displayText = number1 + currentOperand;
        updateDisplay();
        return;
    }
    else if (!currentlyOperating && number2 == '') {
        return;
    }
    else {
        currentlyOperating = true;
        if (number1 != '') {
            let tempNum = operate(number1, number2, currentOperand);
            if (tempNum == 'exit') {
                return;
            }
            number1 = tempNum;
            number2 = '';
            currentOperand = item.target.textContent;
            displayText = number1 + currentOperand;
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

function clearAll() {
    number1 = '';
    number2 = '';
    currentOperand = null;
    currentlyOperating = false;
    displayText = '';
    updateDisplay();
}

let displayText = '';
const displayField = document.querySelector('.display');
const equalBtn = document.querySelector('.equals');
const numberBtns = document.querySelectorAll('.number');
const operandBtns = document.querySelectorAll('.operand');
const clearBtn = document.querySelector('.clear');

let number1='';
let number2='';
let currentOperand;
let currentlyOperating = false;

equalBtn.addEventListener('click', printEquals);
numberBtns.forEach(btn => btn.addEventListener('click',numberClick));
operandBtns.forEach(btn => btn.addEventListener('click',operandClick));
clearBtn.addEventListener('click', clearAll);