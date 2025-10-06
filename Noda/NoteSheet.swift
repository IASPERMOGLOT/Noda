import SwiftUI
import SwiftData

struct NoteSheet: View {
//    @State private var title = ""
//    @State private var description = ""
    @Bindable var note: Note
    @FocusState private var isDescriptionFocus: Bool
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        // текстовые поля
        NavigationStack {
            VStack {
                // заголовок в листе заметки
                TextField("Title", text: $note.title)
                    .font(.headline)
                    .padding()
                // разделяющая линия
                Divider()
                    .padding(.horizontal)
                
                // создание автозаполнения для описания
                ZStack(alignment: .topLeading) {
                    TextEditor(text: $note.content)
                    //реагирует на нажание по описанию
                        .focused($isDescriptionFocus)
                        .padding(.horizontal)
                    
                    if !isDescriptionFocus && note.content.isEmpty {
                        Text("Description")
                            .font(.headline)
                            .foregroundColor(Color.black.opacity(0.219))
                            .padding(.horizontal)
                            .padding(.top, 8)
                    }
                }
            }
            .background(Color.white)
            // панель инструментов
            .toolbar {
                //кнопка отмены
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .frame(width: 99)
                    .foregroundColor(Color.white)
                    .background(Color.red)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(color: .gray, radius: 3)
                }
                //кнопка сохранения
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        context.insert(note)
                        // скрыть лист при создании заметки
                        dismiss()
                    }
                    .frame(width: 99)
                    .foregroundColor(Color.white)
                    .background(Color.green)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(color: .gray, radius: 3)
                    .disabled(note.title.isEmpty) // отключаем если заголовок пустой
                }
            }
        }
    }
}

#Preview {
    NoteSheet(note: Note(title: "", description: "", createAt: Date.now))
        .modelContainer(for: Note.self)
}
