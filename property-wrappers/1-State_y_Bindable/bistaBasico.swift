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

// Iniciamos el ejemplop con una clase
@Observable
class ContadorViewModel {
    var count: Int = 0
    var bame: String = "Contador App"

    func increment() {
        count += 1
    }
}

struct bistaBasico: View {

    // instanciamos sobre la clase usando state
    // hace dos cosas
    // inicializamos y poseer el objeto
    // nos sirve para:
    // - para que no se creen nuevas instancias de la clase entre actualizaciones de vistas
    // - para acceder a los bindings ($)
    @State private var viewModel: ContadorViewModel = ContadorViewModel()
    
    var body: some View {

    }
}

#Preview {
    bistaBasico()
}
