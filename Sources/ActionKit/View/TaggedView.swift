//
//  TaggedView.swift
//  ActionKit
//
//  Created by david-swift on 09.06.24.
//

import SwiftUI

/// A view with any hashable type as a tag.
public struct TaggedView<Tag, Body>: View, Identifiable where Tag: Hashable, Body: View {

    /// The identifier.
    public let id: UUID
    /// The tag.
    public var tag: Tag
    /// The view.
    var view: Body

    /// The view body.
    public var body: some View {
        view
    }

    /// The initializer.
    public init(tag: Tag, @ViewBuilder view: () -> Body) {
        id = .init()
        self.tag = tag
        self.view = view()
    }

}

/// The previews for the ``TaggedView``.
struct TaggedView_Previews: PreviewProvider {

    /// The tagged view for the preview.
    static var taggedView: TaggedView<String, Text> {
        TaggedView(tag: "Hello") {
            Text("Hello")
        }
    }

    /// The previews.
    static var previews: some View {
        VStack {
            taggedView
                .font(.body.bold())
            Text("Tag: \(taggedView.tag)")
        }
        .padding()
    }

}
