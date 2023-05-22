//
//  ItemView.swift
//  Takeat
//
//  Created by Данил Прокопенко on 22.05.2023.
//

import SwiftUI

struct ItemView: View {
    @EnvironmentObject var viewModel: ListViewModel
    var item: Item
    
    var body: some View {
        
        ZStack(alignment: .top) {
            VStack {
                Image(item.image)
                    .resizable()
                    .frame(width: 140,height: 140)
                    .scaledToFit()
                    .shadow(radius: 3)
                    .cornerRadius(16)
                    .shadow(radius: 5)
                
                VStack(alignment: .leading, spacing: 4) {
                    
                    HStack(alignment: .top) {
                        Text("\(item.name)")
                            .font(.system(size: 12, weight: .bold, design: .default))
                            .lineLimit(2, reservesSpace: true)
                        
                        Spacer()
                        
                        
                        Text("\(item.price) ₸")
                            .fontWeight(.medium)
                            .foregroundColor(Color.gray.opacity(0.8))
                    }
                    
                    
                    
                }
                    
            }
            .frame(width: 140, height: 140)
            .padding()
            
            
            HStack(alignment: .center) {
                
                Text("\(item.weightScaler.formatted(.number)) \(item.units.rawValue)")
                    .padding(10)
                    .background(Color("styleOrange").opacity(0.8))
                    .foregroundColor(.white)
                    .cornerRadius(16)
                    .font(.system(size: 9, weight: .bold, design: .default))
                    .padding(.leading, 22)
                
                Spacer(minLength: 0)
                
                Button {
                    viewModel.addToCart(item: item)
                } label: {
                    Image(systemName: "plus")
                        .padding(10)
                        .foregroundColor(.white)
                        .background(Color("styleGreen").opacity(0.8))
                        .cornerRadius(50)
                        .padding(.trailing, 22)
                        
                }
            }
            .frame(width: 180)
            
            

        }
    }
}

struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        ItemView(item: itemList[4])
    }
}
