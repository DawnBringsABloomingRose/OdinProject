function toggleActive(item) {
    item.target.classList.toggle('active');
}

function makeGrid(size) {
    for (let i = 0; i < size*size; i++) {
        const gridItem = document.createElement('div');
        gridItem.classList.add('grid-element');
        gridItem.style.width = `${100/size}%`
        gridItem.style.paddingTop = `${100/size}%`
        gridItem.addEventListener('mouseenter', toggleActive);
    
    
    
        container.appendChild(gridItem);
    }
}

function resetGrid() {
    let size = prompt('Please enter the size of the grid, max: 100');
    if (size <= 100) {
        const gridItems = document.querySelectorAll('.grid-element');
        gridItems.forEach((grid) => {
            container.removeChild(grid);
        });
        makeGrid(size);
    }
}

const container = document.querySelector('.container');
const resetButton = document.querySelector('.reset-button');

resetButton.addEventListener('click', resetGrid);
makeGrid(16);