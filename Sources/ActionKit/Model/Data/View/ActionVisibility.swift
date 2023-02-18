//
//  ActionVisibility.swift
//  ActionKit
//
//  Created by david-swift on 07.02.23.
//

import Foundation

/// The visibility of the actions to edit a node.
public enum ActionVisibility {

    /// The actions menu is hidden.
    case hidden
    /// The actions menu is visible.
    case menu
    /// The actions menu and the parameters popover are visible.
    case parameters
    /// The actions menu and the definition popover are visible.
    case definition

    /// Toggle the visibility betweem ``hidden`` and ``menu``.
    mutating func toggle() {
        switch self {
        case .hidden:
            self = .menu
        default:
            self = .hidden
        }
    }

}
