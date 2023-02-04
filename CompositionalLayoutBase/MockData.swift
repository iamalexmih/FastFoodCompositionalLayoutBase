//
//  MocData.swift
//  CompositionalLayoutBase
//
//  Created by Алексей Попроцкий on 03.02.2023.
//

import Foundation


struct MockData {
    
    static let shared = MockData()
    private init() { }
    
    private let sales: ListSection = {
        .sales([
            .init(title: "", image: "salesBurger"),
            .init(title: "", image: "salesPizza"),
            .init(title: "", image: "salesWok")
        ])
    }()
    
    private let category: ListSection = {
        .category([
            .init(title: "Burger", image: "categoryBurger"),
            .init(title: "Chicken", image: "categoryChicken"),
            .init(title: "Hot-Dog", image: "categoryHotDog"),
            .init(title: "Pizza", image: "categoryPizza"),
            .init(title: "Taco", image: "categoryTaco"),
            .init(title: "Wok", image: "categoryWok")
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
