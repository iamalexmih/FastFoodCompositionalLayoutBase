//
//  ListSection.swift
//  CompositionalLayoutBase
//
//  Created by Алексей Попроцкий on 03.02.2023.
//

import Foundation


enum ListSection {
    case sales([ListItem])
    case category([ListItem])
    case example([ListItem])
    
    
    // количество items в каждой секции
//    var items: [ListItem] {
//        switch self {
//        case .sales(let items):
//            return items
//        case .category(let items):
//            return items
//        case .example(let items):
//            return items
//        }
//    }
    
    var items: [ListItem] {
        switch self {
        case .sales(let items),
                .category(let items),
                .example(let items):
                
            return items
        }
    }
    
    // количесвто секций
    var count: Int {
        items.count
    }
    
    // Название секции для хедер
    var title: String {
        switch self {
        case .sales(_):
            return "Sales"
        case .category(_):
            return "Category"
        case .example(_):
            return "Example"
        }
    }
}
