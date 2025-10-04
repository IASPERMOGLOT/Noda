//
//  NoteRow.swift
//  Noda
//
//  Created by Александр on 03.10.2025.
//

import SwiftUI

struct NoteRow: View {
    let note: Note
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                // характеристики заголовка из класса Note
                Text(note.title)
                    .font(.system(size: 22, weight: .bold, design: .rounded))
                Spacer()
                // характеристики иконки
                Image(systemName: "text.page")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 42)
                    .foregroundColor(Color.blue)
                    .shadow(color: Color.indigo ,radius: 0.5)
            }
            .padding()
            // характеристики описания из класса Note
            Text(note.content)
                .lineLimit(1)
                .padding(.horizontal)
                .padding(.bottom)
                
        }
        .frame(maxWidth: .infinity)
        // Обводка заметки
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .shadow(radius: 3)
        )
        .padding(.horizontal)
    }
}

#Preview {
    // тестовое представление
    NoteRow(note: Note(title: "test title", description: "test description", createAt: Date()))
}

