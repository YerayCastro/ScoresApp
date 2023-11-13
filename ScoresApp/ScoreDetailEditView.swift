//
//  ScoreDetailEditView.swift
//  ScoresApp
//
//  Created by Yery Castro on 11/11/23.
//

import SwiftUI
import PhotosUI

struct ScoreDetailEditView: View {
    @EnvironmentObject var vm: ScoresViewModel
    @ObservedObject var editVM: ScoreEditVM
    @Environment(\.dismiss) var dismiss
    
    
    var body: some View {
        Form {
            Section {
                TextFieldX(label: "Title", text: $editVM.title)
                // Para que ponga mayúscula en cada palabra
                    .textInputAutocapitalization(.words)
                // Para que el dispositivo le diga al invidente
                    .accessibilityLabel(Text("The title of the score"))
                Picker("Composer", selection: $editVM.composer) {
                    ForEach(vm.composers, id: \.self) { composer in
                        Text(composer)
                    }
                }
                HStack {
                    VStack(alignment: .leading) {
                        Text("Year")
                            .font(.headline)
                        TextField("Enter the year", value: $editVM.year, format: .number.precision(.integerLength(4)))
                            .accessibilityLabel(Text("Release year of the score"))
                            .keyboardType(.numberPad)
                    }
                    .frame(minWidth: 125)
                    VStack(alignment: .leading) {
                        Text("Length")
                            .font(.headline)
                        TextField("Enter the length", value: $editVM.length, format: .number.precision(.integerAndFractionLength(integer: 2, fraction: 1)))
                            .accessibilityLabel(Text("Release year of the score"))
                            .keyboardType(.numberPad)
                    }
                    .layoutPriority(2)
                }
                .textFieldStyle(.roundedBorder)
            } header: {
                Text("Score data")
            }
            
            Section {
                VStack {
                    if let image = editVM.newCover{
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .frame(maxWidth: .infinity, alignment: .center)
                    } else {
                        Image(editVM.score.cover)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    PhotosPicker("Change Cover",
                                 selection: $editVM.photo,
                                 matching: .images)
                        .buttonStyle(.bordered)
                }
            } header: {
                Text("Cover")
            }
            
            Section {
                // Hacemos el ForEach del @Binding de [ScoreTracks]
                ForEach($editVM.tracks) { $track in
                    TextField("Enter the name of the track", text: $track.tracks)
                }
                .onDelete(perform: editVM.deleteTrack)
            } header: {
                Text("Score tracks")
            }
        }
        .navigationTitle("Edit Score")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button {
                   // Para conectarlos
                    if let score = editVM.validateScore() {
                        vm.updateScore(score: score)
                        dismiss()
                    }
                } label: {
                    Text("Save")
                }
            }
        }
        .alert("Validation error", isPresented: $editVM.showAlert) {} message: {
            Text(editVM.msg)
        }
    }
}

#Preview {
    NavigationStack {
        ScoreDetailEditView(editVM: ScoreEditVM(score: .test))
            .environmentObject(ScoresViewModel.preview)
    }
}

/*:
 TextField("Ponme algo", text: $editVM.title, axis: .vertical)
     .lineLimit(3, reservesSpace: true)
 */
