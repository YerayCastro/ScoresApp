//
//  ContentView.swift
//  ScoresApp
//
//  Created by Yery Castro on 8/11/23.
//

import SwiftUI

/*:
 Cuarta capa: La view
 */

struct ContentView: View {
    /*
     Creamos la variable "vm" como @ObservedObject, instanciando el ViewModel(scoresViewModel)
     */
    //@ObservedObject var vm = ScoresViewModel()
    // Despues de haber pasado el @ObservedObject var vm = ScoresViewModel() al ScoresApp este objeto para crear el .environmentObject. creamos el environtmentObject aquí. -> @EnvironmentObject var vm: ScoresViewModel
    @EnvironmentObject var vm: ScoresViewModel
    var body: some View {
        NavigationStack {
            List {
                ForEach (vm.scores) { score in
                    // Navegación en iOS15. (NavigationLink: Destination, Label) No se puede hacer navegación en cadena.
                    NavigationLink(value: score) {
                        ScoreCell(score: score)
                    }
                }
                // Solo se puede usar el modificador delete, en el forEach
                .onDelete(perform: vm.deleteScore)
            }
            .navigationTitle("Scores")
            .navigationDestination(for: Score.self) { score in
                ScoreDetailEditView(editVM: ScoreEditVM(score: score))
            }
        }
        // Para iPad -> Se muestra igual que en el iPhone con el siguiente modificador.
        #if os(iOS)
        .navigationViewStyle(.stack)
        #endif
    }
}

// Pasamos el modelo de los datos de prueba -> vm: ScoresViewModel(interactor: TestInteractor())
#Preview {
    // Esto cuando NO esta creado el environmentObject
    //ContentView(vm: ScoresViewModel(interactor: TestInteractor()))
    
    // Esto una vez creado el environmentObject
    ContentView()
    // Pasando los datos de prueba para la preview con TestInteractor
    // -> ScoresViewModel(interactor: TestInteractor()) se pasa a una extensión.Con una variable static llamada preview
        .environmentObject(ScoresViewModel.preview)
}

// UserDefaults: @AppStorage("userColor") var color: Int = 1
// Solo se graba cuando cambias el valor por defeceto.
// Solo usarlo cuando vas a guardar información irrelevante del usuario.



