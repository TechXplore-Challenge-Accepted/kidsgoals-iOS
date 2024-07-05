//
//  MainViewModel.swift
//  kidsgoals
//
//  Created by M1 on 04.07.2024.
//

import Foundation

class MainViewModel {
    var parents: [Parent] = [] {
        didSet {
            dataUpdated?()
        }
    }
    
    var dataUpdated: (() -> Void)?
    
    func didLoad() {
        getData()
    }
    
    private func getData() {
        let urlString = "https://mocki.io/v1/88a9ae87-4f4a-4653-94be-5190f8865422"
        NetworkService().getData(urlString: urlString) { [weak self] (result: Result<ParentResponse, Error>) in
            switch result {
            case .success(let parentResponse):
                DispatchQueue.main.async {
                    self?.parents = [parentResponse.parent]
                }
            case .failure(let error):
                print("Failed to fetch data:", error.localizedDescription)
            }
        }
    }
    
    /* ბექის როცა მექნება:
    func completeTask(at indexPath: IndexPath) {
        guard var child = parents.first?.children.first else { return }
        var task = child.tasks[indexPath.row]
        task.done.toggle()
        child.tasks[indexPath.row] = task
        parents[0].children[0] = child
    }
    */
}
