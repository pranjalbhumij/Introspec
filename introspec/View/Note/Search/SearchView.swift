//
//  SearchView.swift
//  introspec
//
//  Created by Baba Yaga on 29/11/24.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var viewModel: NoteTableViewModel
    @Environment(\.dismiss) var dismiss
    @State private var searchText = ""
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .padding(.leading)
                Text("Search")
                Spacer()
                Image(systemName: "mic")
                    .padding(.trailing)
            }
            .foregroundColor(.secondary)
            .padding(.vertical)
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(height: 40)
            .background( RoundedRectangle(cornerRadius: 10)
                .fill(Color.gray.opacity(0.2)))
            .padding(.leading)
             Button("Cancel") { dismiss() }
            .padding(.horizontal)
        }
        
        List {
            ForEach(searchResults, id: \.self) { note in
                NavigationLink {
                    NoteRowView(note: .constant(note), onDelete: { viewModel.deleteNote(id: note.id) })
                        .frame(height: 45)
                } label: {
                    Text(note.title)
                }
            }
        }
        .navigationTitle("Notes")
    }
    
    var searchResults: [Note] {
        if searchText.isEmpty {
            return viewModel.notes
        } else {
            return viewModel.notes.filter { $0.content.contains(searchText) }
        }
    }
}



//#Preview {
//    SearchView()
//}
