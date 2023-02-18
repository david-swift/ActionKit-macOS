//
//  Binding.swift
//  ActionKit
//
//  Created by david-swift on 08.02.23.
//

import SwiftUI

extension Binding where Value == ActionType {

    /// Get the binding with the ``ActionType`` value
    /// as a binding with a value conforming to the ``ActionType`` protocol.
    /// - Parameter defaultValue: This value is taken if the conversion fails.
    /// - Returns: The new binding.
    internal func get<T>(default defaultValue: T) -> Binding<T> where T: ActionType {
        .init {
            wrappedValue as? T ?? defaultValue
        } set: { newValue in
            wrappedValue = newValue
        }
    }

}
