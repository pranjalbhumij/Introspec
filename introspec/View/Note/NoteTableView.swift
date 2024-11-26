//
//  NoteTableView.swift
//  introspec
//
//  Created by Pranjal Bhumij on 30/10/24.
//

import SwiftUI

struct NoteTableView: View {
    @StateObject var viewModel: NoteTableViewModel
    @State private var isNewNote = false
    
    public init(viewModel: NoteTableViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var groupedNotes: [String: [Note]] {
        groupNotesByDate(notes: viewModel.notes)
    }
    
    var body: some View {
        NavigationSplitView {
            VStack {
                if groupedNotes.isEmpty {
                    showEmptyScreen
                }
                else
                {
                    showList
                }
            }
            .navigationTitle("Notes")
            .navigationDestination(isPresented: $isNewNote) {
                newNote
            }
            .navigationDestination(for: Note.self) { note in
                editNote(note)
            }
            .onAppear {
                viewModel.getSavedNotes()
            }
        } detail: {
            Text("Select a note")
        }
        .tint(Color("toolbarColor"))
    }
    
    private var showEmptyScreen: some View {
        EmptyViewScreen(onAction: {
            self.isNewNote = true
         })
    }
    
    private var showList: some View {
        List() {
            ForEach(groupedNotes.keys.sorted { key1, key2 in
                let order = ["Today", "Yesterday", "Previous 7 Days", "Previous 30 Days", "Older"]
                let index1 = order.firstIndex(of: key1) ?? order.count
                let index2 = order.firstIndex(of: key2) ?? order.count
                return index1 < index2
            }, id: \.self) { key in
                if let notes = groupedNotes[key] {
                    Section(header: Text(key)
                        .textCase(nil)
                        .font(.title2)
                        .bold()
                        .foregroundColor(Color("primaryText"))
                    ) {
                        ForEach(notes, id: \.id) { note in
                            NavigationLink(value: note) {
                                NoteRowView(note: .constant(note), onDelete: { viewModel.deleteNote(id: note.id) })
                                    .frame(height: 45)
                            }
                        }
                    }
                }
            }
        }
        .background(Color("offWhiteBackground"))
        .scrollContentBackground(.hidden)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    isNewNote = true
                }) {
                    Image(systemName: "plus")
                }
            }
        }
    }
    
    private var newNote: some View {
        NoteEditorView(
            note: Note(
                id: UUID().uuidString,
                title: "",
                content: "",
                dateCreation: Date().toString(),
                dateModified: Date().toString()
            ),
            isNewNote: true,
            onSave: { note in
                viewModel.saveNote(note: note)
            }
        )
    }
    
    private func editNote(_ note: Note) -> some View {
       return NoteEditorView(note: note, isNewNote: false, onUpdate: { note in
            viewModel.updateNote(note: note)
        })
    }
    
    func groupNotesByDate(notes: [Note]) -> [String: [Note]] {
        var groupedNotes = [String: [Note]]()
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        
        for note in notes {
            guard let noteDate = note.modifiedDate() else { continue }
            let noteDay = calendar.startOfDay(for: noteDate)
            
            if calendar.isDateInToday(noteDay) {
                groupedNotes["Today", default: []].append(note)
            } else if calendar.isDateInYesterday(noteDay) {
                groupedNotes["Yesterday", default: []].append(note)
            } else if let daysDifference = calendar.dateComponents([.day], from: noteDay, to: today).day {
                if daysDifference <= 7 {
                    groupedNotes["Previous 7 Days", default: []].append(note)
                } else if daysDifference <= 30 {
                    groupedNotes["Previous 30 Days", default: []].append(note)
                } else {
                    groupedNotes["Older", default: []].append(note)
                }
            }
        }

        // Sort notes within each group by date and time (descending)
        for key in groupedNotes.keys {
            groupedNotes[key]?.sort { note1, note2 in
                guard let date1 = note1.modifiedDate(), let date2 = note2.modifiedDate() else {
                    return false
                }
                return date1 > date2 // Descending order
            }
        }
        
        // Maintain the desired order of groups
        var orderedGroupedNotes = [String: [Note]]()
        let sortedOrder = ["Today", "Yesterday", "Previous 7 Days", "Previous 30 Days", "Older"]
        for key in sortedOrder {
            if let notesForKey = groupedNotes[key] {
                orderedGroupedNotes[key] = notesForKey
            }
        }
        
        return orderedGroupedNotes
    }
    
}


//#Preview {
//    NoteTableView(viewModel: NoteTableViewModel())
//}
