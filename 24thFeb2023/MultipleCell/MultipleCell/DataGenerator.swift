//
//  DataGenerator.swift
//  MultipleCell
//
//  Created by BKS-GGS on 25/02/23.
//

import Foundation

struct TableDataSource {
    let redModels: [RedTableModel]
    let blueModels: [BlueTableModel]
    let imageModels: [ImageTableModel]
}

struct RedTableModel {
    let txt: String
}

struct BlueTableModel {
    let txt: String
    let isEnabled: Bool
}

struct ImageTableModel {
    let txt: String
    let imageName: String
}


extension TableDataSource {
    
    static func dataSource() -> TableDataSource {
        var redModels: [RedTableModel] {
            [
                RedTableModel(txt: "Red-1"),
                RedTableModel(txt: "Red-2"),
                RedTableModel(txt: "Red-3"),
                RedTableModel(txt: "Red-4"),
                RedTableModel(txt: "Red-5")
            ]
        }
        
        var blueModels: [BlueTableModel] {
            [
                BlueTableModel(txt: "Blue-1", isEnabled: true),
                BlueTableModel(txt: "Blue-2", isEnabled: true),
                BlueTableModel(txt: "Blue-3", isEnabled: false),
                BlueTableModel(txt: "Blue-4", isEnabled: false),
                BlueTableModel(txt: "Blue-5", isEnabled: false)
            ]
        }
        
        var imageModels: [ImageTableModel] {
            [
                ImageTableModel(txt: "Image-1", imageName: "house"),
                ImageTableModel(txt: "Image-2", imageName: "house"),
                ImageTableModel(txt: "Image-3", imageName: "house"),
                ImageTableModel(txt: "Image-4", imageName: "house"),
                ImageTableModel(txt: "Image-5", imageName: "house"),
            ]
        }
        
        return TableDataSource(
            redModels: redModels,
            blueModels: blueModels,
            imageModels: imageModels
        )
    }
    
    
}
