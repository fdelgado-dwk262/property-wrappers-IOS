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
    
    // para obtener la referencia de memoria a la que se refiere el objeto cunado se instancia
    var instanceId: ObjectIdentifier {
        ObjectIdentifier(self)
    }
    
    init(){
        print("Se ha creado una instacia del appData: \(instanceId)")
    }
    
    deinit {
        print("Se ha destruido la instancia de appData: \(instanceId)")
    }
    
    // funcion de carga de datos de forma asybncrona o en segundo plano
    func cargarDatos() async {
        cargando = true
        
        // simulamos una espdera de la carga de datos yt si hay error tira para adelante
        // try? await Task.sleep(nanoseconds: 1_000_000_000)
        
        // si peta cierra la app y la cierra // forzxar el error
        // try! await Task.sleep(nanoseconds: 1_000_000_000)
         
        // comentamos la linea 45 try?anteriro para probar el try catch
        do {
            try await Task.sleep(nanoseconds: 2_000_000_000)
        } catch is CancellationError {
            print("Se ha cancelada la carga")
        } catch {
            print("error no contolador \(error.localizedDescription)")
        }
        
        
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
