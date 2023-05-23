//
//  Item.swift
//  Takeat
//
//  Created by Данил Прокопенко on 22.05.2023.
//

import Foundation

struct Item: Identifiable {
    let id:  String
    let name: String
    let description: String
    let price: Double
    let image: String
    let category: ItemCategory
    let weightScaler: Double // For defining how much of the weight for 1 item
    let units: ItemUnits
    
    var isAdded: Bool = false
}


enum ItemUnits: String {
    case item = "шт"
    case kilos = "кг"
    case gram = "гр"
    
}

enum ItemCategory: String, CaseIterable {
    case milkProducts = "Молочные продукты"
    case fruits = "Фрукты"
    case vegetables = "Овощи"
}



