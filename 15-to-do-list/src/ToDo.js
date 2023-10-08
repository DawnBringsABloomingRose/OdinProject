class ToDo {
    constructor(title, description, dueDate, priority, notes) {
        this.title = title;
        this.description = description;
        this.dueDate = dueDate;
        this.priority = priority;
        this.notes = notes;
    }

    makeDOMElement = () => {
        console.log(this);
        const todo = document.createElement('div');
        const title = document.createElement('p');
        const dueDate = document.createElement('p');
        const priority = document.createElement('p');
        const notes = document.createElement('p');
        title.textContent = this.title;
        const description = document.createElement('p');
        description.textContent = this.description;
        dueDate.textContent = this.dueDate;
        priority.textContent = this.priority;
        notes.textContent = this.notes

        todo.appendChild(title);
        todo.appendChild(dueDate);
        todo.appendChild(priority);
        todo.appendChild(notes);

        return todo;
    }
};

export default ToDo;