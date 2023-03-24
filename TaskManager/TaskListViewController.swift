//
//  TaskListViewController.swift
//  TaskManager
//
//  Created by e.shirashiyani on 3/24/23.
//

import Foundation
import UIKit
protocol TaskListDisplayLogic: AnyObject {
    func displayFetchedTasks(viewModel: TaskList.FetchTasks.ViewModel)
    func displayAddedTask(viewModel: TaskList.AddTask.ViewModel)
    func displayEditedTask(viewModel: TaskList.EditTask.ViewModel)
    func displayDeletedTask(viewModel: TaskList.DeleteTask.ViewModel)
}
class TaskListViewController: UIViewController, TaskListDisplayLogic {
    var interactor: TaskListBusinessLogic?
    var router: (NSObjectProtocol & TaskListRoutingLogic)?

    // MARK: IBOutlets

    @IBOutlet weak var tableView: UITableView!

    // MARK: Properties

    var tasks: [Task] = []

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupTableView()
        fetchTasks()
    }
    
    // MARK: Private methods
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TaskCell")
    }
    
    private func fetchTasks() {
        let request = TaskList.FetchTasks.Request()
        interactor?.fetchTasks(request: request)
    }
    
    // MARK: TaskListDisplayLogic
    
    func displayFetchedTasks(viewModel: TaskList.FetchTasks.ViewModel) {
        tasks = viewModel.tasks
        tableView.reloadData()
    }
    
    func displayAddedTask(viewModel: TaskList.AddTask.ViewModel) {
        tasks.append(viewModel.task)
        tableView.reloadData()
    }
    
    func displayEditedTask(viewModel: TaskList.EditTask.ViewModel) {
        if let index = tasks.firstIndex(where: { $0.id == viewModel.task.id }) {
            tasks[index] = viewModel.task
            tableView.reloadData()
        }
    }
    
    func displayDeletedTask(viewModel: TaskList.DeleteTask.ViewModel) {
        if let index = tasks.firstIndex(where: { $0.id == viewModel.task.id }) {
            tasks.remove(at: index)
            tableView.reloadData()
        }
    }
}

// MARK: UITableViewDataSource

extension TaskListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return tasks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath)
        let task = tasks[indexPath.row]
        cell.textLabel?.text = task.title
        return cell
    }
}

// MARK: UITableViewDelegate

extension TaskListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let task = tasks[indexPath.row]
        router?.routeToEditTask(task: task)
    }
}
