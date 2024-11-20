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
            List {
                ForEach(groupedNotes.keys.sorted(), id: \.self) { key in
                    if let notes = groupedNotes[key] {
                        Section(header: Text(key)
                            .textCase(nil)
                            .font(.headline)
                            .foregroundColor(Color("primaryText"))
                        ) {
                            ForEach(notes, id: \.id) { note in
                                NavigationLink(value: note) {
                                    NoteRowView(note: .constant(note), onDelete: { viewModel.deleteNote(id: note.id) })
                                        .frame(height: 45)
                                }
                                .tag(note)
                            }
                        }
                    }
                }
                
            }
            //.listRowSpacing(10)
            .background(Color("offWhiteBackground"))
            .scrollContentBackground(.hidden)
            .navigationTitle("Notes")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isNewNote = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .navigationDestination(isPresented: $isNewNote) {
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
            .navigationDestination(for: Note.self) {note in
                NoteEditorView(note: note, isNewNote: false, onUpdate: { note in
                    viewModel.updateNote(note: note)
                })
            }
            .onAppear {
                viewModel.getSavedNotes()
            }
        } detail: {
            Text("Select a note")
        }
        .tint(Color("toolbarColor"))
    }
    
    func groupNotesByDate(notes: [Note]) -> [String: [Note]] {
        var groupedNotes = [String: [Note]]()
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        
        for note in notes {
            guard let noteDate = note.modifiedDate() else { continue } // Skip if date conversion fails
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
        print("Grouped Notes: \(groupedNotes)")
        return groupedNotes
    }
    
}


//#Preview {
//    NoteTableView(viewModel: NoteTableViewModel())
//}
