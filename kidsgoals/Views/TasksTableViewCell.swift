//
//  TasksTableViewCell.swift
//  kidsgoals
//
//  Created by M1 on 04.07.2024.
//

import UIKit

class TasksTableViewCell: UITableViewCell {
    //MARK: Properties:
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
    
    //MARK: Lifecycle:
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: SetupUI:
    
    func setupUI() {
        backgroundColor = .systemBackground
        contentView.addSubview(taskTitle)
        contentView.addSubview(taskDescription)
        contentView.layer.cornerRadius = 15
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.gray.cgColor
        
        NSLayoutConstraint.activate([
            taskTitle.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 8),
            taskTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            taskTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            taskDescription.topAnchor.constraint(equalTo: taskTitle.bottomAnchor, constant: 8),
            taskDescription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            taskDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            taskDescription.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
}
