//
//  CartButton.swift
//  Takeat
//
//  Created by Данил Прокопенко on 22.05.2023.
//

import SwiftUI

struct CartButton: View {
    @EnvironmentObject var viewModel: ListViewModel
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Image(systemName: "cart")
                .foregroundColor(Color("styleGreen"))
                .padding(.top, 5)
            if viewModel.cartItems.count > 0 {
                Text("\(viewModel.cartItems.count)")
                    .font(.caption2)
                    .bold()
                    .foregroundColor(.white)
                    .frame(width: 15, height: 15)
                    .background(Color("styleOrange"))
                    .cornerRadius(50)
            }
        }
    }
}
