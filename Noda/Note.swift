//
//  Note.swift
//  Noda
//
//  Created by Александр on 03.10.2025.
//

import Foundation

class Note: Identifiable {
    var id = UUID()
    var title: String
    var description: String
    var createdAt: Date
    
    init(id: UUID = UUID(), title: String, description: String, createAt:Date) {
        self.id = id
        self.title = title
        self.description = description
        self.createdAt = createAt
    }
}

extension Note {
    static var mockData: [Note] {
        [
            Note(title: "First note", description: "Description for first note", createAt: Date()),
            Note(title: "Second note", description: "Description for second note", createAt: Date()),
            Note(title: "Third note", description: "Description for third note", createAt: Date())
        ]
    }
}
