//
//  vistaConBindable.swift
//  property-wrappers
//
//  Created by Equipo 9 on 2/2/26.
//

import SwiftUI

struct VistaConBindable: View {
    @State private var viewModel = ContadorViewModel()

    var body: some View {
        VStack {
            Text("VistaConBindable \n es la vista PAdre")
                .font(.title)
            Text("Nombre del contador \(viewModel.name)")
            Text("Conteo \(viewModel.count)")

            Divider()

            // pasamos por el viewModel por referencia, no por valor
            VistaEdicion(viewModel: viewModel)

            VistaLectura(viewModel: viewModel)
        }
    }
}

struct VistaEdicion: View {
    // aqui se debe de uaser el typo Bindable no binding
    // por que el ContadorViewModel es una clase
    @Bindable var viewModel: ContadorViewModel

    var body: some View {
        Form {
            Section("Configuración") {
                // GRacias al @Bindable generamos el binding<String>
                TextField("Numero de contador", text: $viewModel.name)
                Stepper("Contador: \(viewModel.count)") {
                    viewModel.increment()
                } onDecrement: {
                    // controld eno pasar a negativos
                    if viewModel.count == 0 {
                        return
                    }
                    viewModel.decrement()
                }

            }
        }
    }
}

struct VistaLectura: View {

    // si solo leemos los datos no necesitamos un bindeable
    // y usaremos un let
    let viewModel : ContadorViewModel

    var body: some View {
        VStack{
            Text("Vista de lectura").font(.title2)
            Text("Nombre: \(viewModel.name)")
            Text("Contador: \(viewModel.count)").font(.largeTitle)
        }.background(.yellow.opacity(0.3))
       
    }
}

#Preview {
    VistaConBindable()
}
