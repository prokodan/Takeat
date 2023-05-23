//
//  DeliveryTimeSlotButton.swift
//  Takeat
//
//  Created by Данил Прокопенко on 23.05.2023.
//

import SwiftUI

struct DeliveryTimeSlotButton: View {
    let time: Date
    let isSelected: Bool
    
    let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "HH:mm"
        return df
    }()
    var body: some View {
        VStack {
            Text(dateFormatter.string(from: time))
                .font(.system(size: 12, weight: .bold, design: .default))
                .foregroundColor(isSelected ? .white : .black)
                .lineLimit(2)
            
        }
        .frame(width: 60, height: 40)
        .background(isSelected ? Color("styleGreen") : Color.gray.opacity(0.4))
        .cornerRadius(16)
    }
}
