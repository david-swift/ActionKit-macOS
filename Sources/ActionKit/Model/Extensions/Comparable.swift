//
//  Comparable.swift
//  ActionKit
//
//  Created by david-swift on 09.06.24.
//

import Foundation

extension Comparable {

    /// Check if the value is in a certain range and, if not, change it to be in the range.
    /// - Parameter range: The closed range.
    ///
    /// Change a comparable type so it is in a certain range:
    /// ```swift
    /// var value = 10
    /// value.map(in: 0...5)
    /// ```
    public mutating func map(in range: ClosedRange<Self>) {
        if self > range.upperBound {
            self = range.upperBound
        } else if self < range.lowerBound {
            self = range.lowerBound
        }
    }

    /// Check if the value is in a certain range and, if not, change it to be in the range.
    /// - Parameter range: The range.
    public mutating func map(in range: Range<Self>) {
        if self > range.upperBound {
            self = range.upperBound
        } else if self < range.lowerBound {
            self = range.lowerBound
        }
    }

}
