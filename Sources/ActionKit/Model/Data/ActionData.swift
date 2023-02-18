//
//  ActionData.swift
//  ActionKit
//
//  Created by david-swift on 31.01.23.
//

import Foundation

/// Output data of nodes used in ``Function.function(input:completedStep:)``.
struct ActionData {

    /// The output parameter's position.
    var position: ActionDataType
    /// The output value.
    var value: ActionType

    /// The position of the action data
    /// and if the data has been defined manually for an input or it is an output value.
    enum ActionDataType {

        /// The data is an output value.
        case output(node: Int, point: Int)
        /// The data has been defined manually for an input.
        case input(node: Int, point: Int)

    }

    /// ``ActionData`` but with data about the input it belongs to.
    struct ActionInputData {

        /// The input.
        var input: (Int, Int)
        /// The action data.
        var data: ActionData

    }

}
