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
    let price: Int
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


var itemList = [
    
    // Молочные продукты
    Item(id: "1", name: "Молоко Бескольское", description: "Молоко 3,2 % процента 500 мл", price: 480, image: "milk1", category: .milkProducts, weightScaler: 1 , units: .item),
    Item(id: "2", name: "Молоко Lactel", description: "Молоко 1,5 % процента 500 мл", price: 560, image: "milk2", category: .milkProducts, weightScaler: 1 , units: .item),
    Item(id: "3", name: "Молоко Милоко", description: "Молоко 3,2 % процента 450 мл", price: 380, image: "milk3", category: .milkProducts, weightScaler: 1 , units: .item),
    Item(id: "4", name: "Молоко Стандартное", description: "Молоко 3 % процента 500 мл", price: 520, image: "milk4", category: .milkProducts, weightScaler: 1 , units: .item),
    
    // Фрукты
    
    Item(id: "5", name: "Клубника", description: "Клубника ташкент, весовая", price: 800, image: "strawberry", category: .fruits, weightScaler: 0.3, units: .kilos),
    Item(id: "6", name: "Банан", description: "Банан эквадор", price: 450, image: "banana", category: .fruits, weightScaler: 1, units: .item),
    Item(id: "7", name: "Ананас", description: "Ананас Турция", price: 2000, image: "pineapple", category: .fruits, weightScaler: 1, units: .item),
    Item(id: "8", name: "Мандарины", description: "Мандарины, весовые", price: 1400, image: "orange", category: .fruits, weightScaler: 0.5, units: .kilos),
    Item(id: "9", name: "Черешня", description: "Черешня, весовая", price: 900, image: "cherry", category: .fruits, weightScaler: 0.5, units: .kilos),
    
    // Овощи
    
    Item(id: "10", name: "Брокколи", description: "Брокколи, свежий", price: 680, image: "broccoli", category: .vegetables, weightScaler: 0.3, units: .kilos),
    Item(id: "11", name: "Томаты", description: "Томаты, сезонные", price: 545, image: "tomatoes", category: .vegetables, weightScaler: 0.5, units: .kilos),
    Item(id: "12", name: "Болгарский перец", description: "Перец болгарский, весовой", price: 1100, image: "bell_pepper", category: .vegetables, weightScaler: 0.5, units: .kilos),
    Item(id: "13", name: "Томаты черри", description: "Томаты черри, весовые", price: 800, image: "tomatoes_cherry", category: .vegetables, weightScaler: 0.3, units: .kilos),
    Item(id: "14", name: "Лук", description: "Лук репчатый, весовой", price: 250, image: "onion", category: .vegetables, weightScaler: 0.5, units: .kilos),
    
]
