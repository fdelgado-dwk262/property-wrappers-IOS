//
//  vistaHome.swift
//  property-wrappers
//
//  Created by Equipo 9 on 2/2/26.
//

import SwiftUI

struct VistaHome: View {
    
    // recuperamos el objeto del environmet
    @Environment(ThemeManager.self) var theme
    
    var body: some View {
        ZStack {
            //ncolor de fondo
            
            (theme.isDarkMode ? Color.black : .white)
                .ignoresSafeArea()
            VStack {
                Text("Home")
                    .font(.largeTitle)
                    .foregroundColor(theme.accenColor)
                
                Divider()
                
                VistaEditarTheme()
            }
            
        }
    }
}


struct VistaEditarTheme: View {
    
    // recuperamos el objeto del environmet
    @Environment(ThemeManager.self) var theme
    
    var body: some View {
        
        // ------------------
        // OJO dentro del body se define
        // No se pasa como parametro OJO no es lo mismo que en tros casos
        @Bindable var themeBindeable = theme
        // esto nos permite poder acceder a los bindings de ina variable obtenidoa de @environment
        // ------------------
        
        
        Text("Modo oscurto esta a: \(String(theme.isDarkMode))")
            .foregroundStyle(theme.isDarkMode ? theme.accenColor : .black)
        
        Toggle("Modo oscuro", isOn: $themeBindeable.isDarkMode)
            .foregroundStyle(theme.isDarkMode ? theme.accenColor : .black)
        
        ColorPicker("Color de acento", selection: $themeBindeable.accenColor)
            .foregroundStyle(theme.isDarkMode ? theme.accenColor : .black)

    }
}

#Preview {
    
    @Previewable @State var theme = ThemeManager()
    
    VistaHome()
        .environment(theme)
}
