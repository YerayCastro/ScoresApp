//
//  ContentView.swift
//  ScoresApp
//
//  Created by Yery Castro on 8/11/23.
//

import SwiftUI

/*:
 Pantalla para iPad en iOS16. Con el modo de tres paneles.
 */

struct ContentView16_3: View {
    @EnvironmentObject var vm: ScoresViewModel
    @State var visibility: NavigationSplitViewVisibility = .all
    
    var body: some View {
        NavigationSplitView(columnVisibility: $visibility) {
            List(vm.composers, id: \.self) { composer in
                NavigationLink(value: composer) {
                    getComposerRow(composer: composer)
                }
                
            }
            .navigationTitle("Composer")
            .navigationDestination(for: String.self) { composer in
                getComposerList(composer: composer)
            }
            //.navigationSplitViewColumnWidth(min: 300, ideal: 400, max: 400)
        } content: {
            Group {
                if let first = vm.composers.first {
                    getComposerList(composer: first)
                }
            }
            //.navigationSplitViewColumnWidth(min: 300, ideal: 325, max: 350)
        } detail: {
            // Recuperar el primer compositor y la primera partitura
            if let first = vm.composers.first,
               let score = vm.getScoresFormComposer(composer: first).first {
                ScoreDetailView(score: score)
            }
        }
        .navigationSplitViewStyle(.balanced)
    }
    
    func getComposerList(composer: String) -> some View {
        List {
            ForEach(vm.getScoresFormComposer(composer: composer)) { score in
                NavigationLink(value: score) {
                    ScoreCell(score: score)
                    
                }
            }
        }
        .navigationTitle(composer)
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
        .navigationDestination(for: Score.self) { score in
            ScoreDetailView(score: score)
        }
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
    ContentView16_3()
        .environmentObject(ScoresViewModel.preview)
}



