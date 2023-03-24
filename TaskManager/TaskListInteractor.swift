//
//  TaskListInteractor.swift
//  TaskManager
//
//  Created by e.shirashiyani on 3/24/23.
//

import Foundation
import Foundation

protocol TaskListBusinessLogic {
    func fetchTasks(request: TaskList.FetchTasks.Request)
    func addTask(request: TaskList.AddTask.Request)
    func editTask(request: TaskList.EditTask.Request)
    func deleteTask(request: TaskList.DeleteTask.Request)
}

protocol TaskListDataStore {
    var tasks: [Task] { get set }
}

class TaskListInteractor: TaskListBusinessLogic, TaskListDataStore {
    var presenter: TaskListPresentationLogic?
    var worker: TaskListWorkerProtocol = TaskListWorker()

    // MARK: TaskListDataStore

    var tasks: [Task] = []

    // MARK: TaskListBusinessLogic

    func fetchTasks(request: TaskList.FetchTasks.Request) {
        worker.fetchTasks { [weak self] result in
            switch result {
            case .success(let tasks):
                self?.tasks = tasks
                let response = TaskList.FetchTasks.Response(tasks: tasks)
                self?.presenter?.presentFetchedTasks(response: response)
            case .failure(let error):
                print(error)
            }
        }
    }

    func addTask(request: TaskList.AddTask.Request) {
        let task = Task(id: tasks.count + 1, title: request.title, completed: false)
        tasks.append(task)
        let response = TaskList.AddTask.Response(task: task)
        presenter?.presentAddedTask(response: response)
    }

    func editTask(request: TaskList.EditTask.Request) {
        let task = Task(id: request.task.id, title: request.title, completed: request.task.completed)
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index] = task
            let response = TaskList.EditTask.Response(task: task)
            presenter?.presentEditedTask(response: response)
        }
    }

    func deleteTask(request: TaskList.DeleteTask.Request) {
        if let index = tasks.firstIndex(where: { $0.id == request.task.id }) {
            let task = tasks[index]
            tasks.remove(at: index)
            let response = TaskList.DeleteTask.Response(task: task)
            presenter?.presentDeletedTask(response: response)
        }
    }
}

// MARK: TaskListWorker

protocol TaskListWorkerProtocol {
    func fetchTasks(completion: @escaping (Result<[Task], Error>) -> Void)
}

class TaskListWorker: TaskListWorkerProtocol {
    func fetchTasks(completion: @escaping (Result<[Task], Error>) -> Void) {
        // Simulate a network request with a delay.
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let tasks = [Task(id: 1, title: "Task 1", completed: false),
                         Task(id: 2, title: "Task 2", completed: false),
                         Task(id: 3, title: "Task 3", completed: true),
                         Task(id: 4, title: "Task 4", completed: false),
                         Task(id: 5, title: "Task 5", completed: true)]
            completion(.success(tasks))
        }
    }
}
