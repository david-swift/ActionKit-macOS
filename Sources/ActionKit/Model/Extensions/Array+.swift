//
//  Array+.swift
//  ActionKit
//
//  Created by david-swift on 17.02.23.
//

import ColibriComponents
import Foundation

extension Array where Element == Folder<Function> {

    /// A set of functions for ``ControlFlow`` (Control Flow).
    public static let controlFlowFunctions: Self =
        [
            .init(
                .init(
                    localized: .init(
                        "Convert Control Flow",
                        comment: "Array (The localized name of the conversion set in the control flow functions)"
                    )
                ),
                icon: .init(systemSymbol: .arrowRight)
            ) {
                for function in controlFlowConversionFunctions { function }
            }
        ]

    /// Convert the control flow into other types.
    public static let controlFlowConversionFunctions: [Function] = [
        Function(
            id: .controlFlowToBoolean,
            name: .init(localized: .init(
                "Control Flow to Boolean",
                comment: "Array (Function for converting the control flow into a boolean)"
            )),
            description: .init(localized: .init(
                "Convert the control flow into a boolean.",
                comment: "Array (Description of \"Control Flow to Boolean\")"
            )),
            input: [.init(.controlFlow, type: ControlFlow.self)],
            output: [.init(.boolean, type: Bool.self)]
        ) { input in
            [(input.first as? ControlFlow ?? .noSignal) == .signal]
        }
    ]

    /// The group of the merge flow functions.
    public static let mergeFlowGroup: Self =
        [
            .init(
                .init(
                    localized: .init(
                        "Merge Flow",
                        comment: "Array (The localized name of the functions for merging the flow)"
                    )
                ),
                icon: .init(systemSymbol: .arrowTriangleMerge)
            ) {
                for function in mergeFlowFunctions { function }
            }
        ]

    /// The functions for merging the flow
    /// of ``String`` (Text), ``Double`` (Number), ``Bool`` (Boolean) and ``ControlFlow`` (Control Flow).
    @ArrayBuilder<Function> public static var mergeFlowFunctions: [Function] {
        String.mergeFlowFunction
        Double.mergeFlowFunction
        Bool.mergeFlowFunction
        ControlFlow.mergeFlowFunction
    }

}
