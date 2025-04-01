import json

TASKS_FILE = "tasks.json"

def load_tasks():
    try:
        with open(TASKS_FILE, "r") as file:
            return json.load(file)
    except (FileNotFoundError, json.JSONDecodeError):
        return []

def save_tasks(tasks):
    with open(TASKS_FILE, "w") as file:
        json.dump(tasks, file, indent=4)

def add_task(task):
    tasks = load_tasks()
    tasks.append({"task": task, "done": False})
    save_tasks(tasks)
    print("Task added successfully!\n")

def view_tasks():
    tasks = load_tasks()
    if not tasks:
        print("No tasks found!\n")
        return
    for idx, task in enumerate(tasks, start=1):
        status = "[✓]" if task["done"] else "[ ]"
        print(f"{idx}. {status} {task['task']}")
    print()

def mark_complete(task_number):
    tasks = load_tasks()
    if 1 <= task_number <= len(tasks):
        tasks[task_number - 1]["done"] = True
        save_tasks(tasks)
        print("Task marked as complete!\n")
    else:
        print("Invalid task number!\n")

def remove_task(task_number):
    tasks = load_tasks()
    if 1 <= task_number <= len(tasks):
        removed = tasks.pop(task_number - 1)
        save_tasks(tasks)
        print(f"Removed task: {removed['task']}\n")
    else:
        print("Invalid task number!\n")

def main():
    while True:
        print("--- To-Do List ---")
        print("1. View Tasks")
        print("2. Add Task")
        print("3. Mark Task as Complete")
        print("4. Remove Task")
        print("5. Exit")
        choice = input("Enter your choice: ")
        
        if choice == "1":
            view_tasks()
        elif choice == "2":
            task = input("Enter new task: ")
            add_task(task)
        elif choice == "3":
            view_tasks()
            try:
                num = int(input("Enter task number to mark complete: "))
                mark_complete(num)
            except ValueError:
                print("Invalid input!\n")
        elif choice == "4":
            view_tasks()
            try:
                num = int(input("Enter task number to remove: "))
                remove_task(num)
            except ValueError:
                print("Invalid input!\n")
        elif choice == "5":
            print("Goodbye!")
            break
        else:
            print("Invalid choice, try again!\n")

if __name__ == "__main__":
    main()
