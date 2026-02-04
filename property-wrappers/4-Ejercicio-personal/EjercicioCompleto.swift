//
//  EjercicioCompleto.swift
//  property-wrappers
//
//  Created by Equipo 9 on 3/2/26.
//

import SwiftUI

struct EjercicioCompleto: View {

    @Environment(AppDataEjercicio.self) var appDataEjercicio

    var body: some View {

        @Bindable var datosAppBindeable = appDataEjercicio

        NavigationStack {
            VStack {
                List(appDataEjercicio.usuariosEjercicio) { usuario in
                    NavigationLink(value: usuario) {
                        FilaUser(usuario: usuario)
                    }
                }
                .navigationTitle(Text("Listado de Usuarios"))
                .navigationBarTitleDisplayMode(.automatic)

                // TODO ir a una vsta detalle del usuario falla aqui
                .navigationDestination(for: UsuarioEjercicio.self) { usuario in
                    VistaUsuario(usuario: usuario)
                }
                // -----

                // -----

            }
        }
        .task {
            if appDataEjercicio.usuariosEjercicio.isEmpty {
                await appDataEjercicio.cargarDatos()
            }
        }
    }
}

struct FilaUser: View {

    @Bindable var usuario: UsuarioEjercicio

    var body: some View {
        HStack {
            Image(systemName: "person.circle.fill")
            Text(usuario.nombre)
        }
    }
}

struct VistaUsuario: View {

    @Bindable var usuario: UsuarioEjercicio

// proimera parte del ejecicios 
//    var body: some View {
//        HStack {
//            Image(systemName: "person.circle.fill")
//            Text("Vista del usuario")
//            Text(usuario.nombre)
//        }
//        VStack {
//            Text("edad: \(String(usuario.edad))")
//            // TODO .- por que no me llegan los datos ?
//            Text("deseos \(String(usuario.deseos.count))")
//            // es necesario ininicializar el dato en el mdoelo de datos
//            // self.deseos = deseos
//            ForEach(usuario.deseos) { deseo in
//                Text(deseo.titulo)
//            }
//
//        }
//    }
//}
    
    // Estado local para controlar la alerta y el texto del nuevo deseo
        @State private var mostrarAlerta = false
        @State private var nuevoDeseoTitulo = ""

        var body: some View {
            List {
                Section("Datos del Usuario") {
                    TextField("Nombre", text: $usuario.nombre)
                    Stepper("Edad: \(usuario.edad)", value: $usuario.edad)
                }
                
                Section("Mis Deseos") {
                    ForEach(usuario.deseos) { deseo in
                        Text(deseo.titulo)
                    }
                    
                    .onDelete(perform: borrarDeseo) // <--- Aquí la magia
                    
                    // Botón para añadir un nuevo deseo
                    Button(action: { mostrarAlerta = true }) {
                        Label("Añadir deseo", systemImage: "plus")
                    }
                }
            }
            .navigationTitle("Detalle")
            // Alerta con un campo de texto (disponible en iOS 16+)
            .alert("Nuevo Deseo", isPresented: $mostrarAlerta) {
                TextField("¿Qué quieres pedir?", text: $nuevoDeseoTitulo)
                Button("Cancelar", role: .cancel) { nuevoDeseoTitulo = "" }
                Button("Añadir") {
                    agregarDeseo()
                }
            } message: {
                Text("Escribe el nombre de tu nuevo deseo.")
            }
        }

        // Función para actualizar el modelo
        func agregarDeseo() {
            guard !nuevoDeseoTitulo.isEmpty else { return }
            let deseo = DeseoEjercicio(titulo: nuevoDeseoTitulo)
            usuario.deseos.append(deseo)
            nuevoDeseoTitulo = "" // Limpiamos el campo
        }
    
    func borrarDeseo(at offsets: IndexSet) {
            usuario.deseos.remove(atOffsets: offsets)
        }
    }
    
    

//struct MiOtraVista: View {
//
//    @State var ejercicio = UsuarioEjercicio(nombre: "Pepe", edad: 25, deseos: [])
//    @State var activado = false
//
//    var body: some View {
//
//        VStack {
//            Text(ejercicio.nombre)
//            TextField(text: $ejercicio.nombre) {}
//            MiSubVista(ejercicio: $ejercicio, activado: activado)
//        }
//    }
//}
//
//struct MiSubVista: View {
//    @Binding var ejercicio: UsuarioEjercicio
//    var activado: Bool
//
//    var body: some View {
//
//    }
//}

#Preview {
    EjercicioCompleto()
        .environment(AppDataEjercicio())
}
//
//#Preview {
//    MiOtraVista()
//}
