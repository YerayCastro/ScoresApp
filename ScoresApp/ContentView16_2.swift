//
//  ContentView.swift
//  ScoresApp
//
//  Created by Yery Castro on 8/11/23.
//

import SwiftUI

/*:
 Pantalla para iPad en iOS16
 */

struct ContentView16_2: View {
    @EnvironmentObject var vm: ScoresViewModel
    
    @State var selected: Score.ID?
    
    @State var visibility: NavigationSplitViewVisibility = .all
    
    var body: some View {
        NavigationSplitView(columnVisibility: $visibility) {
            // Aquí esta la parte de sidebar
            List(selection: $selected) {
                ForEach (vm.scores) { score in
                    ScoreCell(score: score)
                }
            }
            .navigationTitle("Scores")
//            .navigationSplitViewColumnWidth(350)
            // Aquí está la parte del detalle
        } detail: {
            // Si hay alguno seleccionado lo muestra
            if let selected,
               let score = vm.getScoreByID(id: selected) {
                ScoreDetailView(score: score)
                // Si no hay ninguno seleccionado muestra el primero
            } else if let first = vm.scores.first {
                ScoreDetailView(score: first)
                    .onAppear {
                        selected = first.id
                    }
            }
        }
        .navigationSplitViewStyle(.prominentDetail)
    }
}


#Preview {
    ContentView16_2()
        .environmentObject(ScoresViewModel.preview)
}



