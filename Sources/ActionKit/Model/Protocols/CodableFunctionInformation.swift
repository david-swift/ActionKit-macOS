//
//  CodableFunctionInformation.swift
//  ActionKit
//
//  Created by david-swift on 23.02.23.
//

import ColibriComponents
import Foundation

/// A type containing information for a codable function.
/// Used in ``CodableFunction``.
public protocol CodableFunctionInformation: Codable {

    /// The input parameters of the function.
    @ArrayBuilder<Parameter> static var input: [Parameter] { get }
    /// The output parameters of the function.
    @ArrayBuilder<Parameter> static var output: [Parameter] { get }
    /// The functions available in the function.
    @ArrayBuilder<Folder<Function>> static var functions: [Folder<Function>] { get }
    /// The action type value of the codable function information.
    /// This piece of information has to be encoded and decoded.
    var type: ActionType { get set }
    /// Initialize a piece of information by providing the action type value.
    init(type: ActionType)

}
