(()=>{"use strict";const e=class{constructor(e,t,n,o,i){this.title=e,this.description=t,this.dueDate=n,this.priority=o,this.notes=i}makeDOMElement=()=>{console.log(this);const e=document.createElement("div"),t=document.createElement("p"),n=document.createElement("p"),o=document.createElement("p"),i=document.createElement("p");return t.textContent=this.title,document.createElement("p").textContent=this.description,n.textContent=this.dueDate,o.textContent=this.priority,i.textContent=this.notes,e.appendChild(t),e.appendChild(n),e.appendChild(o),e.appendChild(i),e}},t=class{constructor(e){this.name=e,this.todos=[]}addNewToDo(t,n,o,i,s){const c=new e(t,n,o,i,s);this.todos.push(c),console.log(c),console.log(t)}removeToDo(e){this.todos.splice(e,1)}createList(){const e=document.createElement("ul");return this.todos.forEach((t=>{const n=document.createElement("li"),o=t.makeDOMElement();n.appendChild(o),e.appendChild(n)})),e}};new class{constructor(){this.mainArea=document.querySelector(".main"),this.projectsButton=document.querySelector(".view-all"),this.todosButton=document.querySelector(".view-todos"),this.projectsButton.addEventListener("click",this.showProjects),this.newProjectButton=document.querySelector(".new-project"),this.newProjectButton.addEventListener("click",this.newProject),this.dialog=document.querySelector("#newToDoDialog"),this.confirmBtn=this.dialog.querySelector("#confirmBtn"),this.form=document.querySelector("#newToDo"),this.projects=[]}newProject=()=>{const e=prompt("Please Enter a title for the new project"),n=new t(e);this.projects.push(n)};showProjects=()=>{const e=document.createElement("div");this.projects.forEach((t=>{const n=document.createElement("button"),o=document.createElement("p"),i=document.createElement("div");i.className="holder",n.addEventListener("click",(()=>{this.showSingleProject(t)})),o.textContent=t.name,n.textContent="View More",i.appendChild(o),i.appendChild(n),e.appendChild(i)})),this.resetMain(e)};showSingleProject=e=>{const t=document.createElement("div"),n=document.createElement("p"),o=document.createElement("button"),i=e.createList();o.addEventListener("click",(()=>{this.handleDialog(e)})),n.textContent=e.name,o.textContent="Add new ToDo Item",t.appendChild(n),t.appendChild(o),t.appendChild(i),this.resetMain(t)};handleDialog=e=>{this.dialog.showModal(),this.confirmBtn.addEventListener("click",(t=>{t.preventDefault(),this.dialog.close();const n=new FormData(this.form);console.log(n),e.addNewToDo(n.get("title"),n.get("description"),n.get("dueDate"),n.get("priority"),n.get("notes"))}))};resetMain=e=>{this.mainArea.innerHTML="",this.mainArea.appendChild(e)}}})();