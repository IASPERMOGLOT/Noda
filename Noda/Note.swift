import Foundation
import SwiftData

@Model
class Note: Identifiable {
    var id: UUID
    var title: String
    var content: String
    var createdAt: Date
    
    init(id: UUID = UUID(), title: String, description: String, createAt: Date = Date()) {
        self.id = id
        self.title = title
        self.content = description
        self.createdAt = createAt
    }
}


// FIXME: удалить после тестов
extension Note {
    static var emptyList: [Note] { [] }
    
    static var mockData: [Note] {
        [
            Note(title: "First note", description: "Description for first note", createAt: Date()),
            Note(title: "Second note", description: "Description for second note", createAt: Date()),
            Note(title: "Third note", description: "Description for third note", createAt: Date())
        ]
    }
}
