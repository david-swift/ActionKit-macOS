//
//  ErrorMessage.swift
//  ActionKit
//
//  Created by david-swift on 14.02.23.
//

import SwiftUI

/// An error message in the ``FunctionEditor``.
struct ErrorMessage: View {

    /// The exclamation mark's scale effect for animating the scale.
    @State private var scaleEffect: Double = 1
    /// The displayed message.
    var message: String

    /// The view's body.
    var body: some View {
        HStack {
            Image(systemName: "exclamationmark.circle.fill")
                .accessibilityLabel(
                    .init(
                        "An error occured.",
                        comment: "ErrorMessage (Accessibility label of the exclamation mark icon)"
                    )
                )
                .foregroundColor(.red)
                .font(.system(size: .errorMessageIconFontSize))
                .scaleEffect(scaleEffect)
                .animation(.default.speed(.errorMessageAnimationSpeed).repeatForever(), value: scaleEffect)
                .onAppear {
                    scaleEffect = .errorMessageIconScaleEffect
                }
            Text(message)
                .textSelection(.enabled)
        }
        .padding()
        .background(.bar, in: RoundedRectangle(cornerRadius: .errorMessageCornerRadius))
        .shadow(radius: .shadowRadius)
    }

}

/// Previews for ``ErrorMessage``.
struct ErrorMessage_Previews: PreviewProvider {

    /// The previews.
    static var previews: some View {
        ErrorMessage(message: "Example")
    }

}
