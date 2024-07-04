//
//  ParentViewController.swift
//  kidsgoals
//
//  Created by M1 on 04.07.2024.
//

import UIKit

class ParentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private let viewModel: MainViewModel
    private var parentModel: Parent
    
    private var selectedChildIndex: Int? = nil
    
    private let tasksTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TasksTableViewCell.self, forCellReuseIdentifier: TasksTableViewCell.identifier)
        return tableView
    }()
    
    private let childButton = CustomButton(title: "Add Child Account", hasBackground: true, fontSize: .big)
    private let addTaskButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add Task", for: .normal)
        button.isHidden = true
        button.addTarget(self, action: #selector(addTaskButtonTapped), for: .touchUpInside)
        return button
    }()
    private let childNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .label
        return label
    }()
    
    init(viewModel: MainViewModel, parent: Parent) {
        self.viewModel = viewModel
        self.parentModel = parent
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        childButton.addTarget(self, action: #selector(addChildButtonTapped), for: .touchUpInside)
        tasksTableView.delegate = self
        tasksTableView.dataSource = self
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(childButton)
        view.addSubview(childNameLabel)
        view.addSubview(addTaskButton)
        view.addSubview(tasksTableView)
        
        childButton.translatesAutoresizingMaskIntoConstraints = false
        childNameLabel.translatesAutoresizingMaskIntoConstraints = false
        addTaskButton.translatesAutoresizingMaskIntoConstraints = false
        tasksTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            childButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            childButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            childNameLabel.topAnchor.constraint(equalTo: childButton.bottomAnchor, constant: 20),
            childNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            childNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            addTaskButton.topAnchor.constraint(equalTo: childNameLabel.bottomAnchor, constant: 20),
            addTaskButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            tasksTableView.topAnchor.constraint(equalTo: addTaskButton.bottomAnchor, constant: 20),
            tasksTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tasksTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tasksTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc private func addChildButtonTapped() {
        let childAlert = UIAlertController(title: "Add Child Information", message: nil, preferredStyle: .alert)
        childAlert.addTextField { textField in
            textField.placeholder = "Child's Name"
        }
        childAlert.addTextField { textField in
            textField.placeholder = "Child's Username"
        }
        childAlert.addTextField { textField in
            textField.placeholder = "Child's Password"
        }
        childAlert.addTextField { textField in
            textField.placeholder = "Child's Personal ID"
        }
        
        let addChildAction = UIAlertAction(title: "Add", style: .default) { [weak self] _ in
            guard let self = self else { return }
            let name = childAlert.textFields?[0].text ?? ""
            let username = childAlert.textFields?[1].text ?? ""
            let password = childAlert.textFields?[2].text ?? ""
            let personalID = childAlert.textFields?[3].text ?? ""
            
            // Create new child
            let newChild = Child(username: username, password: password, name: name, female: false, personalID: personalID, cardBalance: 0, tasks: [], goals: [])
            
            // Update local model
            self.parentModel.children.append(newChild)
            self.selectedChildIndex = self.parentModel.children.count - 1
            
            // Update UI
            self.updateUIForSelectedChild()
            
            // Push data to database (replace with actual database call)
            self.pushChildToDatabase(child: newChild)
        }
        
        childAlert.addAction(addChildAction)
        childAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(childAlert, animated: true, completion: nil)
    }
    
    private func updateUIForSelectedChild() {
        guard let selectedChildIndex = selectedChildIndex else { return }
        let selectedChild = parentModel.children[selectedChildIndex]
        childNameLabel.text = "Child: \(selectedChild.name)"
        addTaskButton.isHidden = false
        tasksTableView.reloadData()
    }
    
    private func pushChildToDatabase(child: Child) {
        // Replace this with actual database integration code
        print("Pushing child data to database...")
        // Example code: You would implement your database integration logic here
        // For example, using your NetworkService to push data
        // NetworkService().postData(urlString: urlString, data: child) { result in
        //    switch result {
        //    case .success(let response):
        //        print("Data pushed successfully: \(response)")
        //    case .failure(let error):
        //        print("Failed to push data:", error.localizedDescription)
        //    }
        // }
    }
    
    @objc private func addTaskButtonTapped() {
        let taskAlert = UIAlertController(title: "Add Task", message: "Enter task details", preferredStyle: .alert)
        taskAlert.addTextField { textField in
            textField.placeholder = "Task Title"
        }
        taskAlert.addTextField { textField in
            textField.placeholder = "Task Description"
        }
        taskAlert.addTextField { textField in
            textField.placeholder = "Task Comment"
        }
        taskAlert.addTextField { textField in
            textField.placeholder = "Task Cost"
            textField.keyboardType = .numberPad
        }
        
        let addTaskAction = UIAlertAction(title: "Add", style: .default) { [weak self] _ in
            guard let self = self, let selectedChildIndex = self.selectedChildIndex else { return }
            let title = taskAlert.textFields?[0].text ?? ""
            let description = taskAlert.textFields?[1].text ?? ""
            let comment = taskAlert.textFields?[2].text ?? ""
            let cost = Int(taskAlert.textFields?[3].text ?? "0") ?? 0
            
            let newTask = Task(title: title, description: description, comment: comment, cost: cost, done: false)
            
            // Update local model
            self.parentModel.children[selectedChildIndex].tasks.append(newTask)
            self.tasksTableView.reloadData()
            
            // Push data to database (replace with actual database call)
            self.pushTaskToDatabase(task: newTask)
        }
        
        taskAlert.addAction(addTaskAction)
        taskAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(taskAlert, animated: true, completion: nil)
    }
    
    private func pushTaskToDatabase(task: Task) {
        // Replace this with actual database integration code
        print("Pushing task data to database...")
        // Example code: You would implement your database integration logic here
        // For example, using your NetworkService to push data
        // NetworkService().postData(urlString: urlString, data: task) { result in
        //    switch result {
        //    case .success(let response):
        //        print("Data pushed successfully: \(response)")
        //    case .failure(let error):
        //        print("Failed to push data:", error.localizedDescription)
        //    }
        // }
    }
    
    // MARK: - TableView DataSource and Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let selectedChildIndex = selectedChildIndex else { return 0 }
        return parentModel.children[selectedChildIndex].tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TasksTableViewCell.identifier, for: indexPath) as? TasksTableViewCell else {
            return UITableViewCell()
        }
        guard let selectedChildIndex = selectedChildIndex else { return UITableViewCell() }
        let task = parentModel.children[selectedChildIndex].tasks[indexPath.row]
        cell.taskTitle.text = task.title
        cell.taskDescription.text = task.description
        return cell
    }
}
