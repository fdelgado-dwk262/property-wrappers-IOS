//
//  App-con-Environment.swift
//  property-wrappers
//
//  Created by Equipo 9 on 2/2/26.
//

import SwiftUI

@Observable
class ThemeManager {
    var isDarkMode: Bool = false
    var accenColor: Color = .blue
}


// @main sirve como punto de entrada a al app
// @main
struct App_con_Environment: App {
    
    @State private var theme = ThemeManager()
    
    var body: some Scene {
        WindowGroup {
            VistaHome()
                // inyectamos el objeto en el entorno environment
                 .environment(theme)
        }
    }
    
}
