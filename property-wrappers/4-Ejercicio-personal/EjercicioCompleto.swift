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
            Text(usuario.nombre)
        }
    }
}

struct VistaUsuario: View {

    @Bindable var usuario: UsuarioEjercicio

    var body: some View {
        HStack {
            Text("Vista del usuario")
            Text(usuario.nombre)
        }
    }
}

struct MiOtraVista: View {
    
    @State var ejercicio = UsuarioEjercicio(nombre: "Pepe", edad: 25, deseos: [])
    @State var activado = false
    
    var body: some View {
        
        VStack {
            Text(ejercicio.nombre)
            TextField(text: $ejercicio.nombre) {}
            MiSubVista(ejercicio: $ejercicio, activado: activado)
        }
    }
}

struct MiSubVista: View {
    @Binding var ejercicio: UsuarioEjercicio
    var activado: Bool
    
    var body: some View {
        
    }
}

#Preview {
    EjercicioCompleto()
        .environment(AppDataEjercicio())
}

#Preview {
    MiOtraVista()
}
