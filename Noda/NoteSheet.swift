import SwiftUI
import SwiftData

struct NoteSheet: View {
    @State private var title = ""
    @State private var description = ""
    @FocusState private var isDescriptionFocus: Bool
    @Environment(\.modelContext) var context
    
    var body: some View {
        // текстовые поля
        NavigationStack {
            VStack {
                // заголовок в листе заметки
                TextField("Title", text: $title)
                    .font(.headline)
                    .padding()
                // разделяющая линия
                Divider()
                    .padding(.horizontal)
                
                // создание автозаполнения для описания
                ZStack(alignment: .topLeading) {
                    TextEditor(text: $description)
                    //реагирует на нажание по описанию
                        .focused($isDescriptionFocus)
                        .padding(.horizontal)
                    
                    if !isDescriptionFocus && description.isEmpty {
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
                    Button("Cancel") {}
                    .frame(width: 99)
                    .foregroundColor(Color.white)
                    .background(Color.red)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(color: .gray, radius: 3)
                }
                //кнопка сохранения
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        let newNote = Note(
                            title: title,
                            description: description,
                            createAt: Date.now
                        )
                        context.insert(newNote)
                    }
                    .frame(width: 99)
                    .foregroundColor(Color.white)
                    .background(Color.green)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(color: .gray, radius: 3)
                    .disabled(title.isEmpty) // отключаем если заголовок пустой
                }
            }
        }
    }
}

#Preview {
    NoteSheet()
        .modelContainer(for: Note.self)
}
