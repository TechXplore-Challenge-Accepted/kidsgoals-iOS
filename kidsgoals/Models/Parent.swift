//
//  Parent.swift
//  kidsgoals
//
//  Created by M1 on 04.07.2024.
//

import Foundation

struct ParentResponse: Codable {
    let parent: Parent
}

struct Parent: Codable {
    let username, password, email, name: String
    let female: Bool
    let personalID: String
    var children: [Child]
}

struct Child: Codable {
    let username, password, name: String
    let female: Bool
    let personalID: String
    let cardBalance: Int
    var tasks: [Task]
    let goals: [Goal]
}

struct Goal: Codable {
    let title: String
    let taskQuantity: Int
    let inProgress, done: Bool
}

struct Task: Codable {
    let title, description, comment: String
    let cost: Int
    let done: Bool
}
