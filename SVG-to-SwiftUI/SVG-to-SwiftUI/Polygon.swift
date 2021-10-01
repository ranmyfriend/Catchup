//
//  Polygon.swift
//  SVG-to-SwiftUI
//
//  Created by BKS-GGS on 30/09/21.
//

import SwiftUI

struct Polygon: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.addRect(CGRect(x: 0, y: 0, width: 0.81818*width, height: 0.81818*height))
        return path
    }
}

struct Polygon_Previews: PreviewProvider {
    static var previews: some View {
        Polygon()
    }
}
