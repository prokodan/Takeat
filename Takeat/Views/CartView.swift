//
//  CartView.swift
//  Takeat
//
//  Created by Данил Прокопенко on 22.05.2023.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var viewModel: ListViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            
            HStack(spacing: 20) {
                Button {
                    dismiss.callAsFunction()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 26, weight: .heavy))
                        .foregroundColor(Color("styleGreen"))
                }
                
                Text("Корзина")
                    .font(.title)
                    .fontWeight(.heavy)
                    .foregroundColor(Color("styleOrange"))
                Spacer()
            }
            .padding()
            
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(spacing: 0) {
                    ForEach(viewModel.cartItems) { cart in
                        CartItem(viewModel: viewModel, cart: cart)
                    }
                }
            }
            VStack {
                
                HStack {
                    
                    Text("Всего")
                        .fontWeight(.heavy)
                        .foregroundColor(.gray)
                    
                    Spacer()
                    
                    Text(viewModel.calculateTotalPrice())
                        .font(.title)
                        .fontWeight(.heavy)
                        .foregroundColor(.black)
                }
                .padding([.top, .horizontal])
                
                
                NavigationLink {
                    SubscriptionView(viewModel: viewModel)
                } label: {
                    Text("Выбрать подписку")
                        .font(.title2)
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                        .background(
                            viewModel.cartItems.isEmpty
                            ? LinearGradient(gradient: .init(colors: [Color.gray.opacity(0.6), Color.gray]), startPoint: .leading, endPoint: .trailing)
                            : LinearGradient(gradient: .init(colors: [Color("styleGreen"), Color("styleOrange")]), startPoint: .leading, endPoint: .trailing)

                        )
                        .cornerRadius(15)
                }
                .padding(.horizontal, 15)
                .disabled(viewModel.cartItems.isEmpty)
            }
            .background(Color.white)
        }
        .background(Color.white.ignoresSafeArea())
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}


struct CartItem: View {
    @ObservedObject var viewModel: ListViewModel
    var cart: Cart
    
    var body: some View {
        HStack(spacing: 15) {
            Image(cart.item.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100)
                .cornerRadius(15)
            
            VStack(alignment: .leading, spacing: 10) {
                Text(cart.item.name)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                Text(cart.item.description)
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
                    .lineLimit(2)
                
                HStack(spacing: 15) {
                    Text(viewModel.getPrice(value: cart.item.price))
                    
                    Text("\(viewModel.getUnits(value: cart.item.weightScaler * Double(cart.quantity))) \(cart.item.units.rawValue)")
                    
                    Spacer(minLength: 0)
                    
                    Button {
                        if cart.quantity > 1 { viewModel.cartItems[viewModel.getIndex(item: cart.item, isCartIndex: true)].quantity -= 1 }
                    } label: {
                        Image(systemName: "minus")
                            .font(.system(size: 16, weight: .heavy))
                            .foregroundColor(.black)
                    }
                    
                    Text("\(cart.quantity)")
                        .fontWeight(.heavy)
                        .foregroundColor(.black)
                        .padding(.vertical, 5)
                        .padding(.horizontal, 10)
                        .background(Color.black.opacity(0.06))
                    
                    Button {
                        viewModel.cartItems[viewModel.getIndex(item: cart.item, isCartIndex: true)].quantity += 1
                    } label: {
                        Image(systemName: "plus")
                            .font(.system(size: 16, weight: .heavy))
                            .foregroundColor(.black)
                    }
                }
            }
        }
        .padding()
        .contextMenu {

            
            Button {
                let index = viewModel.getIndex(item: cart.item, isCartIndex: true)
                let itemIndex = viewModel.getIndex(item: cart.item, isCartIndex: false)
                
                viewModel.items[itemIndex].isAdded = false
                
                viewModel.cartItems.remove(at: index)
            } label: {
                Text("Удалить товар")
                    .fontWeight(.semibold)
                    .foregroundColor(Color.red)
            }
            
        }
    }
}
