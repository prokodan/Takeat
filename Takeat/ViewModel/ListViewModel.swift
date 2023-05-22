//
//  ListViewModel.swift
//  Takeat
//
//  Created by Данил Прокопенко on 22.05.2023.
//

import Foundation

class ListViewModel: ObservableObject {
    @Published private (set) var items: [Item] = []
    @Published private (set) var total: Int = 0
    
    
    func addToCart(item: Item) {
        items.append(item)
        total += item.price
    }
    
    func removeFromCart(item: Item) {
        items = items.filter {$0.id != item.id}
        total -= item.price
    }
    
    func itemsForCategory(_ category: ItemCategory) -> [Item] {
        items.filter { $0.category == category }
    }
    
}
