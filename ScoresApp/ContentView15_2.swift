//
//  ContentView.swift
//  ScoresApp
//
//  Created by Yery Castro on 8/11/23.
//

import SwiftUI

struct ContentView15_2: View {
    @EnvironmentObject var vm: ScoresViewModel
    
    @State var selected: Score.ID?
    
    var body: some View {
        NavigationView {
            List(selection: $selected) {
                ForEach (vm.scores) { score in
                    NavigationLink {
                        ScoreDetailView(score: score)
                    } label: {
                        ScoreCell(score: score)
                    }
                }
                .onDelete(perform: vm.deleteScore)
            }
            .navigationTitle("Scores")
            
            // Lo que ponemos en segundo nivel, es lo que aparece en la pantalla, si no está seleccionado el maestro detalle.
            // Para que aparezca el primer detalle.
            if let first = vm.scores.first {
                ScoreDetailView(score: first)
            }
            
//            Text("Choose a score in upper left corner")
//                .font(.largeTitle)
//                .bold()
        }
        .onChange(of: selected) {
            print(selected ?? 0)
        }
    }
}

#Preview {
    ContentView15_2()
        .environmentObject(ScoresViewModel.preview)
}

// UserDefaults: @AppStorage("userColor") var color: Int = 1
// Solo se graba cuando cambias el valor por defecto

