//
//  ScoreDetailView.swift
//  ScoresApp
//
//  Created by Yery Castro on 9/11/23.
//

import SwiftUI
/*:
 Cuando lo que quiero es MOSTRAR SOLO la información, le pasamos el dato a la pantalla ScoreDetailView, ésto es LÓGICA DE PANTALLA(Usa los datos para mostrarlos en pantalla), NO implica LÓGICA DE NEGOCIO(Usa los datos para editarlos), porque no voy a editar los datos.
 Como no voy a editar los datos, se pasa el dato(Score) como una constante.
 */
struct ScoreDetailView: View {
    // Esta página va a recibir el Score
    var score: Score
    
    @Environment(\.dismiss) var dismiss
    
    @State var showEdit = false
    
    var body: some View {
        Form {
            Section {
                LabeledContent("Title", value: score.title)
                LabeledContent("Composer", value: score.composer)
                LabeledContent("Year", value: score.yearS)
                LabeledContent("Lenght", value: score.lengthS)
            } header: {
                Text("Score data")
            }
            Section {
                HStack {
                    Image(score.cover)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    Spacer()
                    VStack {
                        Image(score.composer)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100)
                            .clipShape(Circle())
                        Text(score.composer)
                            .font(.caption)
                    }
                }
            } header: {
                Text("Cover and composer")
            }
            
            Section {
                ForEach(score.tracks, id: \.self) { track in
                    Text(track)
                        .font(.callout)
                }
            } header: {
                Text("Tracks")
            }
        }
        .navigationTitle(score.title)
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
        // Button Edit score, que te lleva a la pantalla de ScoreDetailEditView
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button {
                    showEdit.toggle()
                } label: {
                    Text("Edit score")
                }
            }
        }
        .fullScreenCover(isPresented: $showEdit) {
            dismiss()
        } content: {
            NavigationStack {
                ScoreDetailEditView(editVM: ScoreEditVM(score: score))
            }
        }
        // Button personalizado chevron.
//        .navigationBarBackButtonHidden()
//        .toolbar {
//            ToolbarItem(placement: .topBarLeading) {
//                Button {
//                    dismiss()
//                } label: {
//                    Image(systemName: "chevron.left")
//                }
//            }
//        }
    }
}

#Preview {
    NavigationView {
        ScoreDetailView(score: .test)
    }
}
