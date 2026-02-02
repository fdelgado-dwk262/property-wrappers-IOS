//
//  contadorViewModel.swift
//  property-wrappers
//
//  Created by Equipo 9 on 2/2/26.
//

import Observation

// Iniciamos el ejemplop con una clase
@Observable
class ContadorViewModel {
    var count: Int = 0
    var name: String = "Contador App"

    func increment() {
        count += 1
    }
    func decrement() {
        count -= 1
    }
}
