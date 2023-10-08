import ToDo from "./ToDo";

class Project {
    constructor(name) {
        this.name = name;
        this.todos = [];
    }

    addNewToDo(title, description, dueDate, priority, notes) {
        const todo = new ToDo(title, description, dueDate, priority, notes)
        this.todos.push(todo)
        console.log(todo);
        console.log(title);
    }

    removeToDo(index) {
        this.todos.splice(index, 1);
    }

    createList() {
        const list = document.createElement('ul');

        this.todos.forEach((toDo) => {
            const listEl = document.createElement('li');
            const toDoEl = toDo.makeDOMElement();
            listEl.appendChild(toDoEl);
            list.appendChild(listEl);
        })

        return list;
    }
}

export default Project;