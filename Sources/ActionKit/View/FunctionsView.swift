//
//  FunctionsView.swift
//  ActionKit
//
//  Created by david-swift on 14.02.23.
//

import SwiftUI

/// The view at the bottom of a ``FunctionEditor`` for showing the available functions.
struct FunctionsView: View {

    /// Whether the functions view is expanded.
    @Binding var expand: Bool
    /// Information about dragging a function into the editor.
    @Binding var dragFunction: DragFunction?
    /// The expanded functions editor's width.
    @State private var height: CGFloat = 100
    /// A correction of the function editor's offset in the global coordinate space.
    @State private var offset: CGSize = .zero
    /// The functions displayed in the functions view.
    var functions: [Folder<Function>]
    /// Actions added by the developer.
    var extraActions: [FunctionEditor.ExtraAction]

    /// The view's body.
    var body: some View {
        Spacer()
            .geometry { geometry in
                height = geometry.size.height
                let origin = geometry.frame(in: .global).origin
                offset = .init(width: origin.x, height: origin.y)
            }
            .overlay(alignment: .bottom) {
                Group {
                    VStack(alignment: .trailing) {
                        HStack {
                            ForEach(extraActions, id: \.tag) { extraAction in
                                extraAction
                                    .actionButton()
                            }
                            expandButton
                        }
                        .buttonStyle(.plain)
                        .padding(.horizontal)
                        functionsView
                    }
                }
            }
    }

    /// A button for expanding the functions view.
    private var expandButton: some View {
        Button {
            expand.toggle()
        } label: {
            Label(
                "Expand",
                systemImage: expand ? "arrow.down" : "arrow.up"
            )
            .actionButton()
            .labelStyle(.iconOnly)
        }
    }

    /// The view showing the functions.
    private var functionsView: some View {
        Group {
            if expand {
                expandedView
            } else {
                compactView
            }
        }
        .background(.regularMaterial)
    }

    /// The expanded functions view with descriptions.
    private var expandedView: some View {
        ScrollView(.vertical) {
            LazyVStack {
                ForEach(functions) { group in
                    GroupBox {
                        FunctionsGroupView(dragFunction: $dragFunction, group: group, offset: offset)
                    }
                }
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
        .frame(height: height * .expandedFunctionsViewHeight)
    }

    /// The compact functions view without the descriptions.
    private var compactView: some View {
        ScrollView(.horizontal) {
            LazyHStack {
                ForEach(functions) { group in
                    ForEach(group.content) { function in
                        GroupBox {
                            Text(function.name)
                                .padding(.compactViewInnerPadding)
                        }
                        .functionView(dragFunction: $dragFunction, function: function, offset: offset)
                    }
                    if let last = functions.last, group.id != last.id {
                        Divider()
                            .padding(.functionsViewDividerPadding)
                    }
                }
            }
            .padding(.compactViewPadding)
        }
        .frame(height: .compactViewHeight)
        .fixedSize(horizontal: false, vertical: true)
    }

}

/// Previews for the ``FunctionsView``.
struct FunctionsView_Previews: PreviewProvider {

    /// The previews.
    static var previews: some View {
        Color.clear
            .overlay {
                FunctionsView(
                    expand: .constant(false),
                    dragFunction: .constant(nil),
                    functions: [
                        .init(
                            "Hello",
                            icon: .init(systemName: "hand.wave"),
                            content: [.init(id: "test", name: "Test", description: "A description.")]
                        )
                    ],
                    extraActions: []
                )
            }
    }

}
