//
//  CodableFunction.swift
//  ActionKit
//
//  Created by david-swift on 25.02.23.
//

import ActionKit
import ColibriComponents
import Foundation

extension CodableFunction: ActionRepresentable {

    /// An example action representation for the codable function.
    /// - Parameters:
    ///   - oldValue: The value without the change.
    ///   - newValue: The value with the change.
    /// - Returns: The action representation.
    public static func actionRepresentation(
        oldValue: CodableFunction<Information>,
        newValue: CodableFunction<Information>
    ) -> LocalizedStringResource {
        .init("Editing Function", comment: "CodableFunction (Action Representation Example)")
    }

}
