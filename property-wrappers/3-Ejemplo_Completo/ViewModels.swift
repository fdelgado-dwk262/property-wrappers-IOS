//
//  ViewModels.swift
//  property-wrappers
//
//  Created by Equipo 9 on 2/2/26.
//

import SwiftUI

struct Articulo: Identifiable {
    let id = UUID()
    var titulo: String
    var completado = false
}

@Observable
class PerfilUsuario {
    var nombre = "Maria"
    var edad = 45
}

@Observable
class AppData {
    var articulos: [Articulo] = []
    var cargando = false
    var usuario = PerfilUsuario()
    
    // funcion de carga de datos de forma asybncrona o en segundo plano
    func cargarDatos() async {
        cargando = true
        
        // simulamos una espdera de la carga de datos
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        
        // una vez terminada la instrucción anteriro seguimos
        
        await MainActor.run {
            articulos = [
                Articulo(titulo: "aprender SwiftUI es genial"),
                Articulo(titulo: "comprar movil "),
                Articulo(titulo: "comprar casa ", completado: true),
            ]
            cargando = false
        }
    }
    
    func anadirArticulo(titulo: String) {
        articulos.append(Articulo(titulo: titulo))
        
    }
}
