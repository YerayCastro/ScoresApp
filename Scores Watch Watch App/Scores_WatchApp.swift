//
//  Scores_WatchApp.swift
//  Scores Watch Watch App
//
//  Created by Yery Castro on 11/11/23.
//

import SwiftUI

@main
struct Scores_Watch_Watch_AppApp: App {
    @StateObject var vm = ScoresViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView16_3()
                .environmentObject(vm)
        }
    }
}
