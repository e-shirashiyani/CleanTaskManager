//
//  TaskListRouter.swift
//  TaskManager
//
//  Created by e.shirashiyani on 3/24/23.
//

import Foundation
import UIKit

protocol TaskListRoutingLogic {
    func routeToAddTask()
    func routeToEditTask(task: Task)
}

protocol TaskListDataPassing {
    var dataStore: TaskListDataStore? { get }
}

class TaskListRouter: NSObject, TaskListRoutingLogic, TaskListDataPassing {
    weak var viewController: TaskListViewController?
    var dataStore: TaskListDataStore?

    // MARK: TaskListRoutingLogic

    func routeToAddTask() {
        guard let viewController = viewController else { return }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "AddTaskViewController") as! AddTaskViewController
        var destinationDS = destinationVC.router!.dataStore!
        passDataToAddTask(source: dataStore!, destination: &destinationDS)
        viewController.show(destinationVC, sender: nil)
    }

    func routeToEditTask(task: Task) {
        guard let viewController = viewController else { return }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "EditTaskViewController") as! EditTaskViewController
        var destinationDS = destinationVC.router!.dataStore!
        passDataToEditTask(task: task, source: dataStore!, destination: &destinationDS)
        viewController.show(destinationVC, sender: nil)
    }
    
    // MARK: Navigation
    
    func passDataToAddTask(source: TaskListDataStore, destination: inout AddTaskDataStore) {
        destination.taskListWorker = source.taskListWorker
        destination.taskListInteractor = source.taskListInteractor
    }
    
    func passDataToEditTask(task: Task, source: TaskListDataStore, destination: inout EditTaskDataStore) {
        destination.taskListWorker = source.taskListWorker
        destination.taskListInteractor = source.taskListInteractor
        destination.task = task
    }
}
