//
//  ContentView.swift
//  property-wrappers
//
//  Created by Equipo 9 on 2/2/26.
//

// importante importar la libreria de observable es opcional ya que lo implementa el siguiente import
import Observation
// importación clasica
import SwiftUI


//Nos lo llevamnos a otro archivo  .- contadorViewModel
//// Iniciamos el ejemplop con una clase
//@Observable
//class ContadorViewModel {
//    var count: Int = 0
//    var name: String = "Contador App"
//
//    func increment() {
//        count += 1
//    }
//    func decrement() {
//        count -= 1
//    }
//}

struct vistaBasico: View {

    // instanciamos sobre la clase usando state
    // hace dos cosas
    // inicializamos y poseer el objeto
    // nos sirve para:
    // - para que no se creen nuevas instancias de la clase entre actualizaciones de vistas
    // - para acceder a los bindings ($)
    @State private var viewModel = ContadorViewModel()  // siempreeeeeee usar esto para evitar problemas

    var body: some View {
        // ejemplo de uso .-
        Text("hola soy \n \(viewModel.name)")
        Text("Conteo a: \(viewModel.count)")
            .font(.largeTitle)
        TextField("cambiar nbombre", text: $viewModel.name)
        
        HStack {
            
            
            Button {
                if viewModel.count == 0 {
                    return
                }
                viewModel.decrement()
            } label: {
                viewModel.count == 0 ? Text("").font(.largeTitle): Text("➖").font(.largeTitle)
            }
            
            Button {
                viewModel.increment()
            } label: {
                Text("✚").font(.largeTitle)
            }
        }
        

    }
}

#Preview {
    vistaBasico()
}
