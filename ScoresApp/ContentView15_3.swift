//
//  ContentView.swift
//  ScoresApp
//
//  Created by Yery Castro on 8/11/23.
//

import SwiftUI

/*:
 Pantalla para iPad en iOS13,iOS14 y iOS15
 */

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
        }
        .onChange(of: selected) {
            print(selected ?? "")
        }
    }
}


#Preview {
    ContentView15_2()
        .environmentObject(ScoresViewModel.preview)
}



