const table = document.querySelector("table.main");
const showButton = document.querySelector("#showdialog");
const dialog = document.querySelector("#newBookDialog");
const titleInput = dialog.querySelector("#titleinput");
const authorInput = dialog.querySelector("#authorinput");
const pagesInput = dialog.querySelector("#pagesinput");
const readInput = dialog.querySelector("#readinput");
const confirmBtn = dialog.querySelector("#confirmBtn");

function Book(title, author, pages, read) {
    this.title = title;
    this.author = author;
    this.pages = pages;
    this.read = read;

    this.info = function() {
        return this.title + " by " + this.author + ", " + this.pages + " pages, " + (this.read ? "read" : "not read yet");
    }
}

const myLibrary = []
function addBookToLibrary(title, author, pages, read) {
    myLibrary.push(new Book(title, author, pages, read));
    addLibraryToTable();
}

function swapStatus(index) {
  myLibrary[index].read = !myLibrary[index].read;
  addLibraryToTable();
}

function addBookToTable(book, index) {
    const row = document.createElement("tr");
    row.classList.add('row-' + index);
    for (var x in book) {
        const col = document.createElement("td");
        if (x == 'info') {
            continue;
        }

        
        col.textContent = book[x];
        if (x == 'read') {
          const swapBtn = document.createElement('button');
          swapBtn.textContent = 'Change status';
          swapBtn.addEventListener('click', () => {
            swapStatus(index);
          });
          col.appendChild(swapBtn);
        }
        row.appendChild(col);
    }
    const delBtn = document.createElement('button');
    delBtn.textContent = 'Delete book';
    delBtn.addEventListener('click', () => {
      deleteAtIndex(index);
    });

    row.appendChild(delBtn);
    table.appendChild(row);
}

function deleteAtIndex(index) {
  myLibrary.splice(index, 1);
  addLibraryToTable();
}

function addLibraryToTable() {
  while (table.firstChild) {
    table.removeChild(table.firstChild);
  }

  const headers = ['Title', 'Author', 'Pages', 'Read?', 'Delete']
  var row = document.createElement('tr'); 

  for (var x of headers) {
    var th = document.createElement('th')
    th.textContent = x;
    row.appendChild(th);
  }
  table.appendChild(row);

  for (var [i,book] of myLibrary.entries()) {
        addBookToTable(book, i);
  }
}

addBookToLibrary("The Hobbit", "JRR Tolkien", 345, false);
addLibraryToTable();


showButton.addEventListener("click", () => {
    dialog.showModal();
    confirmBtn.value = {title: "test", author: null, pages: null, read: false };
  });


titleInput.addEventListener("change", (e) => {
    confirmBtn.value.title = titleInput.value;
  });

  authorInput.addEventListener("change", (e) => {
    confirmBtn.value.author = authorInput.value;
  });

  pagesInput.addEventListener("change", (e) => {
    confirmBtn.value.pages = pagesInput.value;
  });

  readInput.addEventListener("change", (e) => {
    confirmBtn.value.read = readInput.value;
  });

  dialog.addEventListener("close", (e) => {
    addBookToLibrary(titleInput.value, authorInput.value, pagesInput.value, readInput.checked);
  });
  
  confirmBtn.addEventListener("click", (e) =>{
    e.preventDefault();
    dialog.close(confirmBtn.value);
  })