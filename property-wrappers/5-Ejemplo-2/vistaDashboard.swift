//
//  vistaDashboard.swift
//  property-wrappers
//
//  Created by Equipo 9 on 4/2/26.
//

import SwiftUI

@Observable
class UserContext {
    var username: String = "usuario Iphone"
    var esPremiun: Bool = false
}

@Observable
class CardDesigner {
    var colorTarjeta: Color = .blue.opacity(0.2)
    var mostrarBorde: Bool = true
}

struct vistaDashboard: View {
    
    // global y de clase
    @Environment(UserContext.self) private var user
    
    // solo de estado no globlales
    @State private var designer = CardDesigner()
    
    @State private var mostrarEditor : Bool = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing:20){
                Spacer()
                
                // Tarjeta
                VStack{
                    Image(systemName: user.esPremiun ? "crow.fill" : "person.fill")
                }
                
                Spacer()
                
                
            }
        }
    }
}

#Preview {
    vistaDashboard()
        .environment(UserContext())
}
