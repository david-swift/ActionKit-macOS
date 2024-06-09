//
//  FunctionError.swift
//  ActionKit
//
//  Created by david-swift on 14.02.23.
//

import SwiftUI

/// An error that is relevant for the user to see while editing.
enum FunctionError: Equatable {

    /// There is no error.
    case noError
    /// There is a type error. Provide the output and input types.
    case typeError(type1: ActionType.Type, type2: ActionType.Type)
    /// There is an error defined by the developer.
    case devError(message: String)

    /// Show an error and hide it again after five seconds.
    /// - Parameters:
    ///   - error: The error to edit.
    ///   - newError: The error to show.
    static func show(error: Binding<Self>, newError: Self) {
        withAnimation {
            error.wrappedValue = newError
        }
        Task {
            try await Task.sleep(for: .seconds(.displayError))
            withAnimation {
                if error.wrappedValue == newError {
                    error.wrappedValue = .noError
                }
            }
        }
    }

    /// Whether two function errors are the same.
    /// - Parameters:
    ///   - lhs: The first function error.
    ///   - rhs: The second function error.
    /// - Returns: Whether the two function errors are the same.
    static func == (lhs: Self, rhs: Self) -> Bool {
        switch lhs {
        case .noError:
            switch rhs {
            case .noError:
                return true
            default:
                return false
            }
        case let .typeError(type1: type1, type2: type2):
            switch rhs {
            case let .typeError(type1: rhsType1, type2: rhsType2):
                return type1 == rhsType1 && type2 == rhsType2
            default:
                return false
            }
        case let .devError(message: message):
            switch rhs {
            case let .devError(message: rhsMessage):
                return message == rhsMessage
            default:
                return false
            }
        }
    }

}
