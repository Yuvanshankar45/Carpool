//
//  ViewController.swift
//  Carpool
//
//  Created by Yuvan Shankar on 16/09/2023.
//

import UIKit

struct Todo: Codable {
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Example GET request
        let networkManager = NetworkManager(baseURL: "https://jsonplaceholder.typicode.com/todos/1")
        networkManager.getRequest(path: "") { (result: Result<Todo, Error>) in
            switch result {
            case .success(let response):
                // Handle successful response
                print(response)
            case .failure(let error):
                // Handle error
                print(error)
            }
        }
    }
}

