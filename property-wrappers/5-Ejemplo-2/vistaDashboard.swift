//
//  vistaDashboard.swift
//  property-wrappers
//
//  Created by Equipo 9 on 4/2/26.
//

import SwiftUI

@Observable
class UserContext {
    var username: String = "usuario Iphone"
    var esPremiun: Bool = false
}

@Observable
class CardDesigner {
    var colorTarjeta: Color = .blue.opacity(0.2) {
        // nos pèrmite usar codigo por ejemplo oldvalue es interno de swift
        didSet {
            print("el color ha cambiado de \(oldValue) a \(colorTarjeta)")
            // Ejemplo de control en el caso que el color sea igual al del icono en teoria
            if colorTarjeta == .gray {
                colorTarjeta = oldValue
            } else if colorTarjeta == .yellow {
                colorTarjeta = oldValue
            }
        }
    }
    var mostrarBorde: Bool = true
}

struct vistaDashboard: View {

    // global y de clase
    @Environment(UserContext.self) private var user

    // solo de estado no globlales
    @State private var designer = CardDesigner()

    @State private var mostrarEditor: Bool = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Spacer()

                // Tarjeta
                VStack {
                    Image(
                        systemName: user.esPremiun
                            ? "crown.fill" : "person.fill"
                    )
                    .font(.largeTitle)
                    .foregroundStyle(user.esPremiun ? .yellow : .blue)
                    Text(user.username)
                        .font(.title2.bold())
                        .padding(10)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 200)
                .background(designer.colorTarjeta)
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(
                            .black,
                            lineWidth: designer.mostrarBorde ? 2 : 0
                        )
                )

                .padding(20)

                Spacer()
                Button("Editar Tarjeta y usuario") {
                    mostrarEditor = true
                }
                .buttonStyle(.borderedProminent)
                

            }
            .navigationTitle("Dashboard")
            .sheet(isPresented: $mostrarEditor) {
                VistaEditor(designer: designer)
            }
        }
        
        
    }
}

struct VistaEditor: View {
    // como CardDesigner es una class y es obserblable se usa el @Bindable
    @Bindable var designer: CardDesigner
    
    //notacion
    @Environment(UserContext.self) private var user
    
    // notación especifica de swift
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        // siempre dentro del body .- y tira de la variabla del enviroment
        @Bindable var bindableUser  = user
        
        NavigationStack {
            Form {
                Section("Diseño de Tarjeta"){
                    ColorPicker("Color del fondo", selection: $designer.colorTarjeta)
                    Toggle("Mostrar borde", isOn: $designer.mostrarBorde)
                }
                Section("Modificar datos de usuario"){
                    TextField("Nombre", text: $bindableUser.username)
                    Toggle("Es preminun", isOn: $bindableUser.esPremiun)
                }
                if bindableUser.esPremiun {
                    Text("otros datos ,....")
                    
                }
            }
            .navigationTitle("Configuración")
            .toolbar{
                // boton de carrar
                Button("close") {
                    dismiss()
                }
            }
        }
        
       
        
    }
}

#Preview {
    vistaDashboard()
        .environment(UserContext())
}
