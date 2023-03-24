//
//  TaskListModels.swift
//  TaskManager
//
//  Created by e.shirashiyani on 3/23/23.
//

import Foundation
//define the models used in the application.
enum TaskList {
    // MARK: Use cases

    enum FetchTasks {
        struct Request {}
        struct Response {
            var tasks: [Task]
        }
        struct ViewModel {
            var tasks: [Task]
        }
    }

    enum AddTask {
        struct Request {
            var title: String
        }
        struct Response {
            var task: Task
        }
        struct ViewModel {
            var task: Task
        }
    }

    enum EditTask {
        struct Request {
            var task: Task
        }
        struct Response {
            var task: Task
        }
        struct ViewModel {
            var task: Task
        }
    }

    enum DeleteTask {
        struct Request {
            var task: Task
        }
        struct Response {}
        struct ViewModel {}
    }
}
