//
//  FunctionsGroupView.swift
//  ActionKit
//
//  Created by david-swift on 14.02.23.
//

import SwiftUI

/// The view of a functions group in the expanded ``FunctionsView``.
struct FunctionsGroupView: View {

    /// Information about the dragging of a function.
    @Binding var dragFunction: DragFunction?
    /// Whether the group view is expanded.
    @State private var isExpanded = true
    /// The group.
    var group: Folder<Function>
    /// The function editor's offset.
    var offset: CGSize

    /// The view's body.
    var body: some View {
        DisclosureGroup(
            isExpanded: $isExpanded
        ) {
            ForEach(group.content) { function in
                GroupBox {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(function.name)
                                .bold()
                            Text(function.description)
                        }
                        Spacer()
                    }
                }
                .functionView(dragFunction: $dragFunction, function: function, offset: offset)
            }
        } label: {
            Label {
                Text(group.title)
                    .bold()
            } icon: {
                group.icon
                    .foregroundColor(.accentColor)
            }
            .padding(.functionGroupLabelPadding)
        }
    }
}

/// Previews for the ``FunctionsGroupView``.
struct FunctionsGroupView_Previews: PreviewProvider {

    /// The previews.
    static var previews: some View {
        FunctionsGroupView(
            dragFunction: .constant(nil),
            group:
                .init(
                    "Hello",
                    icon: .init(systemName: "arrow.up"),
                    content: [.init(id: "add", name: "Add", description: "Add two numbers.")]
                ),
            offset: .zero
        )
    }

}
