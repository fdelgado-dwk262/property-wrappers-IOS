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
            }

            .navigationTitle("Lista de  \(appData.usuario.nombre)")
            .toolbar {
                Button {
                    mostrarPerfilUsuario = true
                } label: {
                    Image(systemName: "person.circle")
                }
            }
            // nuevo elemento que despliega una "hoja"
            .sheet(isPresented: $mostrarPerfilUsuario) {
                Text("Datos de usuario \(appData.usuario.nombre)")
            }
            // Task se ejecuta al cargar el Navigatiopns, antes de mostrar la vista
            .task {
                if appData.articulos.isEmpty {
                    await appData.cargarDatos()
                }
            }
        }
    }
}

struct FilaArticulo: View {
    
    @Binding var articulo: Articulo
    
    var body: some View {
        HStack {
            Image(systemName: articulo.completado ? "checkmark.square.fill" : "square")
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
