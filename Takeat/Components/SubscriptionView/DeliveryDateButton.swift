//
//  DeliveryDateButton.swift
//  Takeat
//
//  Created by Данил Прокопенко on 23.05.2023.
//

import SwiftUI

struct DeliveryDateButton: View {
    let date: Date
    let isSelected: Bool
    
    let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "dd MMM"
        return df
    }()
    var body: some View {
        VStack {
            Text(dateFormatter.string(from: date))
                .font(.system(size: 12, weight: .bold, design: .default))
                .foregroundColor(isSelected ? .white : .black)
                .lineLimit(2)
            
        }
        .frame(width: 60, height: 40)
        .background(isSelected ? Color("styleGreen") : Color.gray.opacity(0.4))
        .cornerRadius(16)
    }
}
