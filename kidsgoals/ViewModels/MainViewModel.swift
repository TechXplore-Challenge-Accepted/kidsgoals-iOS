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
        let urlString = "https://mocki.io/v1/5f5113c1-7506-4208-9f85-be4598468680"
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
    
    func completeTask(at indexPath: IndexPath) {
        guard var child = parents.first?.children.first else { return }
        var task = child.tasks[indexPath.row]
        task.done.toggle()
        child.tasks[indexPath.row] = task
        parents[0].children[0] = child
    }
    
    
//    func login(username: String, password: String) -> (Bool, Bool) {
//        for parent in parents {
//            if parent.username == username && parent.password == password {
//                return (true, true)
//            }
//            for child in parent.children {
//                if child.username == username && child.password == password {
//                    return (true, false)
//                }
//            }
//        }
//        return (false, false)
//    }
//    
//    func registerParent(username: String, password: String, email: String, name: String, female: Bool, personalID: String) {
//        let newParent = Parent(username: username, password: password, email: email, name: name, female: female, personalID: personalID, children: [])
//        parents.append(newParent)
//    }
//    
//    func addChildToParent(parentUsername: String, child: Child) {
//        for parent in parents {
//            if parent.username == parentUsername {
//                parent.children.append(child)
//                break
//            }
//        }
//    }
}
