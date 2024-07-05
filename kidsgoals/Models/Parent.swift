//
//  Parent.swift
//  kidsgoals
//
//  Created by M1 on 04.07.2024.
//

import Foundation

struct ParentResponse: Codable {
    var parent: Parent
}

struct Parent: Codable {
    var username, password, email, name: String
    var female: Bool
    var personalID: String
    var children: [Child]
}

struct Child: Codable {
    var username, password, name: String
    var female: Bool
    var personalID: String
    var cardBalance: Int
    var tasks: [Task]
    var goals: [Goal]
}

struct Goal: Codable {
    var title: String
    var taskQuantity: Int
    var inProgress, done: Bool
}

struct Task: Codable {
    var title, description, comment: String
    var cost: Int
    var done: Bool
}
