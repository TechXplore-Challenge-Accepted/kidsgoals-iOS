//
//  ChildViewController.swift
//  kidsgoals
//
//  Created by M1 on 04.07.2024.
//

import UIKit

class ChildViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //MARK: - Properties
    private let viewModel: MainViewModel
    
    private let bankCardView: BankCardView = {
        let view = BankCardView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let tasksTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.register(TasksTableViewCell.self, forCellReuseIdentifier: TasksTableViewCell.identifier)
        tableView.contentInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        return tableView
    }()
    
    //MARK: - Lifecycle
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.didLoad()
        setupUI()
        bindViewModel()
    }
    
    //MARK: - Functions
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(bankCardView)
        view.addSubview(tasksTableView)
        
        NSLayoutConstraint.activate([
            bankCardView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            bankCardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            bankCardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            bankCardView.heightAnchor.constraint(equalToConstant: 150),
            
            tasksTableView.topAnchor.constraint(equalTo: bankCardView.bottomAnchor, constant: 20),
            tasksTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tasksTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tasksTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        tasksTableView.delegate = self
        tasksTableView.dataSource = self
    }
    
    private func bindViewModel() {
        viewModel.dataUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.tasksTableView.reloadData()
                if let child = self?.viewModel.parents.first?.children.first {
                    self?.bankCardView.setAmount(child.cardBalance)
                }
            }
        }
    }
    
    // MARK: - TableView Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let child = viewModel.parents.first?.children.first else {
            return 0
        }
        return child.tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TasksTableViewCell.identifier, for: indexPath) as? TasksTableViewCell,
              let task = viewModel.parents.first?.children.first?.tasks[indexPath.row] else {
            return UITableViewCell()
        }
        
        cell.taskTitle.text = task.title
        cell.taskDescription.text = task.description
        cell.taskCost.text = "Cost: \(task.cost) GEL"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
