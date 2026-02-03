//
//  EjemploVistaCompleta.swift
//  property-wrappers
//
//  Created by Equipo 9 on 2/2/26.
//

import SwiftUI

struct VistaEjemploCompleto: View {

    @Environment(AppData.self) var appData

    @State private var ocultarCompletados = false
    @State private var mostrarPerfilUsuario = false
    @State private var nuevoArticulo = ""

    var body: some View {

        @Bindable var datosBindeable = appData

        NavigationStack {

            VStack {
                // definimos la lista
                Toggle("ocultar los completado", isOn: $ocultarCompletados)

                // debe de hacer dos cosas si esta cargando los datos nos muestre la lista de progreso o un spiner
                // si no, que nos muestre la listra con los datos

                // -

                if appData.cargando {
                    ProgressView("")  // spiner
                } else {
                    List {
                        ForEach($datosBindeable.articulos) { $articulo in

                            // loca que oculta los completados
                            if !ocultarCompletados || !articulo.completado {

                                FilaArticulo(articulo: $articulo)
                            }

                        }
                        // geneera la opcion de la hacer el swipe poder borrar
                        .onDelete {
                            appData.articulos.remove(atOffsets: $0)
                        }

                    }
                }
                HStack {
                    TextField("Nuevo deseo ...", text: $nuevoArticulo)
                        .textFieldStyle(.roundedBorder)
                    Button("Añadir") {
                        guard !nuevoArticulo.isEmpty else { return }
                        appData.anadirArticulo(titulo: nuevoArticulo)
                        nuevoArticulo = ""
                    }
                }
                .padding(10)
            }

            .navigationTitle(
                "Lista de  \(appData.usuario.nombre) \(appData.usuario.edad)"
            )
            .toolbar {
                Button {
                    mostrarPerfilUsuario = true
                } label: {
                    Image(systemName: "person.circle")
                }
            }
            // nuevo elemento que despliega una "hoja"
            .sheet(isPresented: $mostrarPerfilUsuario) {
                //                Text("Datos de usuario \(appData.usuario.nombre)")
                VistaEditarPerfil(perfil: appData.usuario)
            }
            // Task se ejecuta al cargar el Navigatiopns, antes de mostrar la vista
            .task {
                if appData.articulos.isEmpty {
                    await appData.cargarDatos()
                }
            }
        }
        // cuando la vista se va a dibujar
        .onAppear {
            print("Entrando en la vista")
            print(appData.instanceId)
        }
    }
}

struct VistaEditarPerfil: View {

    // variable global de swiftUI y creamos una variable que la invoca como funcion
    @Environment(\.dismiss) var dismiss
    
    @Environment(AppData.self) var appData
    
    @Bindable var perfil: PerfilUsuario

    var body: some View {
        NavigationStack {
            Form {
                Section("Editar perfil") {
                    TextField("Nombre", text: $perfil.nombre)
                    Stepper("Edad: \(perfil.edad)", value: $perfil.edad)
                }
                
                VistaEstadisticas()
            }
            .navigationTitle(Text("Editar perfil"))
            .toolbar {
                Button("realizado") {
                    dismiss()
                }
            }
        }
    }
}

struct VistaEstadisticas: View {

    @Environment(AppData.self) var appData

    var body: some View {

        HStack {
            Text("Total: \(appData.articulos.count) deseos")
            Spacer()
            Text("Completados : \(appData.articulos.filter(\.completado).count)")
        }
        .font(.footnote)
        .padding()
        .background(Color(.secondarySystemBackground))
        .clipShape(Capsule())
        
        
    }
}

struct FilaArticulo: View {

    @Binding var articulo: Articulo

    var body: some View {
        HStack {
            Image(
                systemName: articulo.completado
                    ? "checkmark.square.fill" : "square"
            )
            .foregroundStyle(articulo.completado ? .green : .gray)
            .onTapGesture {
                articulo.completado.toggle()
            }
            Text(articulo.titulo)
                .strikethrough(articulo.completado)
                .foregroundStyle(articulo.completado ? .gray : .black)
        }
    }
}

#Preview {
    VistaEjemploCompleto()
        .environment(AppData())
}
