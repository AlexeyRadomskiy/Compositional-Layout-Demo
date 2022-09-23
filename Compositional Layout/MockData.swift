//
//  MockData.swift
//  Compositional Layout
//
//  Created by Alexey Radomskiy on 22.09.2022.
//

import Foundation

struct MockData {
    
    static let shared = MockData()
    
    private let sales: ListSection = {
        .sales([
            .init(title: "", image: "salesBurger"),
            .init(title: "", image: "salesPizza"),
            .init(title: "", image: "salesWok")
        ])
    }()
    
    private let category: ListSection = {
        .category([
            .init(title: "", image: "categoryBurger"),
            .init(title: "", image: "categoryChicken"),
            .init(title: "", image: "categoryHotdog"),
            .init(title: "", image: "categoryPizza"),
            .init(title: "", image: "categoryTaco"),
            .init(title: "", image: "categoryWok")
        ])
    }()
    
    private let example: ListSection = {
        .example([
            .init(title: "", image: "burger1"),
            .init(title: "", image: "burger2"),
            .init(title: "", image: "burger3")
        ])
    }()
    
    var pageData: [ListSection] {
        [sales, category, example]
    }
}
