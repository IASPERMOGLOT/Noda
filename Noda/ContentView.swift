import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var isShowingSheet = false
    @State private var selectedNote: Note = Note(title: "", description: "")
    @Environment(\.modelContext) var context
    @Query(sort: \Note.createdAt) var swiftDataNotes: [Note] // сортировка по дате создания
    
    var body: some View {
        GeometryReader { geometry in
            // скролинг
            ScrollView {
                VStack {
                    RoundedRectangle(cornerRadius: 30)
                        .fill(
                            // задание градиента
                            LinearGradient(gradient:
                                            Gradient(colors: [Color.indigo,
                                                              Color.blue,
                                                              Color.blue,
                                                              Color.mint,
                                                              Color.mint]),
                                           startPoint: .topLeading,
                                           endPoint: .trailing)
                        )
                        .frame(height: geometry.size.height/2.3)
                        // Основной прямоугольник (градиент)
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .fill(Color.white.opacity(0.3))
                                .frame(width: .infinity, height: 188) // исправлено на maxWidth
                                // Внутренний прямоугольник (+текст)
                                .overlay(
                                    HStack {
                                        VStack(alignment: .leading) {
                                            //заголовок
                                            Text("Welcome to Noda")
                                                .font(.system(size: 30, weight: .bold, design: .rounded))
                                            // описание
                                            Text("Давай, запиши свои дела, на которые тебе станет похуй через час...")
                                                .font(.subheadline)
                                            
                                        }
                                        Spacer()
                                        // иконка note
                                        Image(systemName: "scribble.variable")
                                            .imageScale(.large)
                                            .font(.system(size: 52))
                                    }
                                    .padding()
                                )
                                .padding()
                                .foregroundColor(.white)
                        )
                    
                    // заполнение заметками - показываем только если они есть
                    if !swiftDataNotes.isEmpty {
                        ForEach(swiftDataNotes) { note in
                            NoteRow(note: note)
                                .onTapGesture {
                                    selectedNote = note
                                    isShowingSheet = true
                                }
                            // контекстное меню для удаления заметки
                                .contextMenu {
                                    Button(action: {
                                        context.delete(note)
                                    }) {
                                        Text("Delete")
                                        Image(systemName: "trash")
                                    }
                                }
                        }
                    }
                }
            }
            .background(Color.gray.opacity(0.15))
            //нажание на кнопку => показ листа
            .sheet(isPresented: $isShowingSheet) {
                NoteSheet(note: selectedNote)
                    .presentationDetents([.fraction(0.7), .large])
            }
            
            //Иконка отсутствия заметок - показываем только если нет заметок
            .overlay{
                if swiftDataNotes.isEmpty {
                    ContentUnavailableView(
                        label: {
                            // характеристики текста остуствия заметок
                            Label {
                                Text("No Notes")
                                    .font(.system(size: 22, weight: .bold, design: .rounded))
                            }
                            // характеристики иконки note
                            icon: {
                                Image(systemName: "text.page")
                                    .frame(width: 30, height: 40)
                                    .foregroundColor(Color.blue)
                                    .shadow(color: Color.indigo ,radius: 0.5)
                            }
                        }
                    )
                    // размещение No Notes
                    .offset(y:144)
                }
            }
            
            .overlay(
                HStack {
                    Spacer()
                    // кнопка создания заметок
                    Button(action:{isShowingSheet = true}) {
                        Image(systemName: "plus")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                    }
                }.padding(),
                alignment: .bottom
            )
        }
        .edgesIgnoringSafeArea(.top)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Note.self)
}
