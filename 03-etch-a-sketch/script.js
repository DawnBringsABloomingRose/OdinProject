function toggleActive(item) {
    console.log(item.target);
    item.target.classList.toggle('active');
}



const container = document.querySelector('.container');

for (let i = 0; i < 16*16; i++) {
    const gridItem = document.createElement('div');
    gridItem.classList.add('grid-element');
    gridItem.addEventListener('mouseenter', toggleActive);



    container.appendChild(gridItem);
}