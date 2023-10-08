import Project from "./Project";

class Display {
    constructor() {
        this.mainArea = document.querySelector('.main');
        this.projectsButton = document.querySelector('.view-all');
        this.todosButton = document.querySelector('.view-todos');
        this.projectsButton.addEventListener('click',this.showProjects)
        this.newProjectButton = document.querySelector('.new-project');
        this.newProjectButton.addEventListener('click', this.newProject);
        this.dialog = document.querySelector('#newToDoDialog');
        this.confirmBtn = this.dialog.querySelector('#confirmBtn');
        this.form = document.querySelector('#newToDo');
        this.projects = [];
    }

    newProject = () => {
        const title = prompt('Please Enter a title for the new project');
        const newProj = new Project(title);
        this.projects.push(newProj)
    }

    showProjects = () => {
        const all = document.createElement('div');
        this.projects.forEach((project) => {
            const viewFurther = document.createElement('button')
            const title = document.createElement('p');
            const holder = document.createElement('div');
            holder.className = 'holder';

            viewFurther.addEventListener('click', () => {
                this.showSingleProject(project);
            });
            title.textContent = project.name;
            viewFurther.textContent = 'View More';

            holder.appendChild(title);
            holder.appendChild(viewFurther);
            all.appendChild(holder);
        })

        this.resetMain(all);
    }

    showSingleProject = (project) => {
        const div = document.createElement('div');
        const title = document.createElement('p');
        const newToDo = document.createElement('button');
        const list = project.createList();

        newToDo.addEventListener('click', () => {this.handleDialog(project)})
        title.textContent = project.name;
        newToDo.textContent = 'Add new ToDo Item';

        div.appendChild(title);
        div.appendChild(newToDo);
        div.appendChild(list);

        this.resetMain(div);
    }

    handleDialog = (project) => {
        this.dialog.showModal();
        this.confirmBtn.addEventListener('click', (e) => {
            e.preventDefault();
            this.dialog.close();
            const formData = new FormData(this.form);
            console.log(formData);
            project.addNewToDo(formData.get('title'), formData.get('description'), formData.get('dueDate'), formData.get('priority'),formData.get('notes'));
        });
        
    }

    resetMain = (newMain) => {
        this.mainArea.innerHTML = '';
        this.mainArea.appendChild(newMain);
    }
}

export default Display;