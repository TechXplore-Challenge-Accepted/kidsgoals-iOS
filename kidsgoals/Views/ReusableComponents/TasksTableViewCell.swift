//
//  TasksTableViewCell.swift
//  kidsgoals
//
//  Created by M1 on 04.07.2024.
//

import UIKit

class TasksTableViewCell: UITableViewCell {
    static let identifier = "TasksTableViewCell"
    
    var taskTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .blue
        label.numberOfLines = 0
        return label
    }()
    
    var taskDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .blue
        label.numberOfLines = 0
        return label
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 15
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.gray.cgColor
        return view
    }()
    
    let completeButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Complete", for: .normal)
        return button
    }()
    
    var completeButtonTapped: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        completeButton.addTarget(self, action: #selector(didTapCompleteButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        backgroundColor = .clear
        contentView.addSubview(containerView)
        containerView.addSubview(taskTitle)
        containerView.addSubview(taskDescription)
        containerView.addSubview(completeButton)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            taskTitle.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            taskTitle.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            taskTitle.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            taskDescription.topAnchor.constraint(equalTo: taskTitle.bottomAnchor, constant: 8),
            taskDescription.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            taskDescription.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            completeButton.topAnchor.constraint(equalTo: taskDescription.bottomAnchor, constant: 8),
            completeButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            completeButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8)
        ])
    }
    
    @objc func didTapCompleteButton() {
        completeButtonTapped?()
    }
}
