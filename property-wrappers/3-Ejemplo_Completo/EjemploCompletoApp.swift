//
//  EjemploCompletoApp.swift
//  property-wrappers
//
//  Created by Equipo 9 on 2/2/26.
//

import SwiftUI

@main
struct EjemploCompletoApp: App {
    
    // nuestra variable global que esta disponible sdesde las subvistas
    @State private var appData = AppData()
    
    
    var body: some Scene {
        WindowGroup {
            VistaEjemploCompleto()
                .environment(appData)
        }
    }
}

