//
//  ControlFlow.swift
//  ActionKit
//
//  Created by david-swift on 07.02.23.
//

import SwiftUI

/// A type used as a parameter for representing the control flow.
public enum ControlFlow: ActionType, CaseIterable, Identifiable {

    /// There is a signal at the node.
    case signal
    /// There is no signal at the node.
    case noSignal

    /// The name of the control flow type.
    public static var name: String {
        .init(localized: .init("Control Flow", comment: "ControlFlow (Name of the control flow type)") )
    }
    /// The color of the control flow type.
    public static var color: Color { Color.gray }

    /// The identifier.
    public var id: Int { hashValue }

    /// The localized name of each case of ``ControlFlow``.
    var localized: LocalizedStringResource {
        switch self {
        case .signal:
            return .init("Signal", comment: "ControlFlow (Name of the \"signal\" case)")
        case .noSignal:
            return .init("No Signal", comment: "ControlFlow (Name of the \"noSignal\" case)")
        }
    }

    /// The standard value.
    public init() {
        self = .signal
    }

    /// A picker for choosing a control flow value.
    /// - Parameter value: The value.
    /// - Returns: The view containing the picker.
    public static func picker(value: Binding<ActionType>) -> any View {
        let value = value.get(default: Self.signal)
        Picker("Control Flow", selection: value) {
            ForEach(Self.allCases) { flowValue in
                Text(flowValue.localized)
                    .tag(flowValue)
            }
        }
        if value.wrappedValue == .noSignal {
            Button {
                value.wrappedValue = .signal
            } label: {
                Text("This node will never be executed.")
                    .font(.caption)
                    .foregroundColor(.red)
            }
        }
    }

}
