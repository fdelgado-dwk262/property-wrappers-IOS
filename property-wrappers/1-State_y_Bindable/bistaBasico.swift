//
//  ContentView.swift
//  property-wrappers
//
//  Created by Equipo 9 on 2/2/26.
//

// importante importar la libreria de observable
import Observation
// importación clasica
import SwiftUI

// Iniciamos el ejemplop con una clase
class ContadorViewModel {
    var count: Int = 0
    var bame: String = "Contador App"

    func increment() {
        count += 1
    }
}

struct bistaBasico: View {

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    bistaBasico()
}
