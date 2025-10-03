//
//  ContentView.swift
//  Noda
//
//  Created by Александр on 03.10.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var notes = Note.mockData
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    RoundedRectangle(cornerRadius: 30)
                        .fill(
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
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .fill(Color.white.opacity(0.3))
                                .frame(width: .infinity, height: 188)
                                .overlay(
                                    HStack {
                                        VStack(alignment: .leading) {
                                            Text("Welcome to Noda")
                                                .font(.system(size: 30, weight: .bold, design: .rounded))
                                            Text("Давай, запиши свои дела, на которые тебе станет похуй через неделю...")
                                                .font(.subheadline)
                                            
                                        }
                                        Spacer()
                                        Image(systemName: "scribble.variable")
                                            .imageScale(.large)
                                            .font(.system(size: 52))
                                    }
                                        .padding()
                                )
                                .padding()
                                .foregroundColor(.white)
                        )
                    ForEach(notes) {note in
                        NoteRow(note: note)
                    }
                }
            }
            .background(Color.gray.opacity(0.2))
        }
        .edgesIgnoringSafeArea(.top)
    }
}

#Preview {
    ContentView()
}
