//
//  ContentView.swift
//  ScoresApp
//
//  Created by Yery Castro on 8/11/23.
//

import SwiftUI

/*:
 Pantalla para iPad en iOS13,iOS14 y iOS15. Con el modo de tres paneles.
 */

struct ContentView15_3: View {
    @EnvironmentObject var vm: ScoresViewModel
    
    @State var selected: Score.ID?
    @State var composerSelected: String?
    
    
    var body: some View {
        NavigationView {
            List(selection: $composerSelected) {
                ForEach(vm.composers, id: \.self) { composer in
                    getComposerRow(composer: composer)
                }
            }
            
            if let composerSelected {
                List(selection: $selected) {
                    getComposerList(composer: composerSelected)
                }
                .navigationTitle("Scores")
            } else if let first = vm.composers.first {
                List {
                    getComposerList(composer: first)
                        .onAppear {
                            composerSelected = first
                        }
                }
            }
            
            // Recuperar el primer compositor y la primera partitura
            if let first = vm.composers.first,
               let score = vm.getScoresFormComposer(composer: first).first {
                ScoreDetailView(score: score)
            }
        }
    }
        
        func getComposerList(composer: String) -> some View {
            ForEach(vm.getScoresFormComposer(composer: composer)) { score in
                NavigationLink {
                    ScoreDetailView(score: score)
                } label: {
                    ScoreCell(score: score)
                }
            }
            .onDelete(perform: vm.deleteScore)
        }
        
        func getComposerRow(composer: String) -> some View {
            HStack {
                Text(composer)
                Spacer()
                Image(composer)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50)
                    .clipShape(Circle())
            }
        }
    }
    

    
#Preview {
    ContentView15_3()
        .environmentObject(ScoresViewModel.preview)
}



