//
//  TaskListPresenter.swift
//  TaskManager
//
//  Created by e.shirashiyani on 3/24/23.
//

import Foundation
import Foundation

protocol TaskListPresentationLogic {
    func presentFetchedTasks(response: TaskList.FetchTasks.Response)
    func presentAddedTask(response: TaskList.AddTask.Response)
    func presentEditedTask(response: TaskList.EditTask.Response)
    func presentDeletedTask(response: TaskList.DeleteTask.Response)
}

class TaskListPresenter: TaskListPresentationLogic {
    weak var viewController: TaskListDisplayLogic?

    // MARK: TaskListPresentationLogic

    func presentFetchedTasks(response: TaskList.FetchTasks.Response) {
        let tasks = response.tasks
        let viewModel = TaskList.FetchTasks.ViewModel(tasks: tasks)
        viewController?.displayFetchedTasks(viewModel: viewModel)
    }

    func presentAddedTask(response: TaskList.AddTask.Response) {
        let task = response.task
        let viewModel = TaskList.AddTask.ViewModel(task: task)
        viewController?.displayAddedTask(viewModel: viewModel)
    }

    func presentEditedTask(response: TaskList.EditTask.Response) {
        let task = response.task
        let viewModel = TaskList.EditTask.ViewModel(task: task)
        viewController?.displayEditedTask(viewModel: viewModel)
    }

    func presentDeletedTask(response: TaskList.DeleteTask.Response) {
        let task = response.task
        let viewModel = TaskList.DeleteTask.ViewModel(task: task)
        viewController?.displayDeletedTask(viewModel: viewModel)
    }
}
