//
//  Cart.swift
//  Takeat
//
//  Created by Данил Прокопенко on 22.05.2023.
//

import Foundation

struct Cart: Identifiable {
    var id = UUID().uuidString
    var item: Item
    var quantity: Int
}
