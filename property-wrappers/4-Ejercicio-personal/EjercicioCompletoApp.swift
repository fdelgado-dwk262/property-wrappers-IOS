//
//  EjemploCompletoApp.swift
//  property-wrappers
//
//  Created by Equipo 9 on 2/2/26.
//

import SwiftUI

@main
struct EjercicioCompletoApp: App {
    
    // nuestra variable global que esta disponible sdesde las subvistas
    @State private var appDataEjercicio = AppDataEjercicio()
    
    
    var body: some Scene {
        WindowGroup {
            EjercicioCompleto()
                .environment(appDataEjercicio)
        }
    }
}

