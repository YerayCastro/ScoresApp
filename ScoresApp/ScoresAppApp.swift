//
//  ScoresAppApp.swift
//  ScoresApp
//
//  Created by Yery Castro on 8/11/23.
//

import SwiftUI

@main
struct ScoresAppApp: App {
    // Pasamos el @ObservedObject var vm = ScoresViewModel()
    // Y lo converimos en @StateObject para poder difundir los datos por toda la App.
    @StateObject var vm = ScoresViewModel()
    var body: some Scene {
        WindowGroup {
            Group {
                // Si arrancamos con un iPad muestra la pantalla del iPad.
                #if os(iOS)
                if UIDevice.current.userInterfaceIdiom == .pad {
                    ContentView16_3()
                } else {
                    ContentView()
                }
                #else
                    ContentView16_3
                #endif
            }
            // Creamos el .environmentObject, pasandole la variable(vm)
            .environmentObject(vm)
        }
    }
}
