//
//  ViewModels.swift
//  property-wrappers
//
//  Created by Equipo 9 on 2/2/26.
//

import SwiftUI

struct DeseoEjercicio: Identifiable {
    let id = UUID()
    var titulo: String
    var completado = false
}

@Observable
class UsuarioEjercicio: Identifiable, Hashable {
    static func == (lhs: UsuarioEjercicio, rhs: UsuarioEjercicio) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
         hasher.combine(id)
    }

    var id = UUID()
    var nombre: String
    var edad: Int
    var deseos: [DeseoEjercicio] = []

    init(nombre: String, edad: Int, deseos: [DeseoEjercicio]) {
        self.nombre = nombre
        self.edad = edad
    }
}

@Observable
class AppDataEjercicio {

    var usuariosEjercicio: [UsuarioEjercicio] = []
    var loading = false

    // para obtener la referencia de memoria a la que se refiere el objeto cunado se instancia
    var instanceId: ObjectIdentifier {
        ObjectIdentifier(self)
    }

    init() {
        print("Se ha creado una instacia del appData: \(instanceId)")
    }

    deinit {
        print("Se ha destruido la instancia de appData: \(instanceId)")
    }

    // funcion de carga de datos de forma asybncrona o en segundo plano
    func cargarDatos() async {
        loading = true

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

            usuariosEjercicio = [
                UsuarioEjercicio(
                    nombre: "Pepe",
                    edad: 24,
                    deseos: [
                        DeseoEjercicio(titulo: "ejercicio 1", completado: false),
                        DeseoEjercicio(titulo: "ejercicio 2", completado: false),
                        DeseoEjercicio(titulo: "ejercicio 3", completado: false)
                    ]
                ),
                UsuarioEjercicio(
                    nombre: "Juanjo",
                    edad: 44,
                    deseos: [
                        DeseoEjercicio(titulo: "ejercicio 4", completado: false),
                        DeseoEjercicio(titulo: "ejercicio 5", completado: false),
                        DeseoEjercicio(titulo: "ejercicio 6", completado: false)
                    ]
                ),
                UsuarioEjercicio(
                    nombre: "Maria",
                    edad: 44,
                    deseos: [
                        DeseoEjercicio(titulo: "ejercicio 7", completado: false),
                        DeseoEjercicio(titulo: "ejercicio 8", completado: false),
                        DeseoEjercicio(titulo: "ejercicio 9", completado: false)
                    ]
                ),
            ]
            loading = false
        }
    }

    func anadirArticulo(titulo: String) {
        usuariosEjercicio.append(UsuarioEjercicio(nombre: titulo, edad: 0, deseos: []))
    }
}
