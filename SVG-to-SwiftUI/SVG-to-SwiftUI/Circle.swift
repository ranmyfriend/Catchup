//
//  Circle.swift
//  SVG-to-SwiftUI
//
//  Created by BKS-GGS on 30/09/21.
//

import SwiftUI

struct Circle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.addEllipse(in: CGRect(x: 0.1*width, y: 0.1*height, width: 0.8*width, height: 0.8*height))
        return path
    }
}

struct Circle_Previews: PreviewProvider {
    static var previews: some View {
        Circle()
    }
}
