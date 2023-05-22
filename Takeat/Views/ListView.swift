//
//  ListView.swift
//  Takeat
//
//  Created by Данил Прокопенко on 22.05.2023.
//

import SwiftUI

struct ListView: View {
    @StateObject var viewModel = ListViewModel()
    
    var body: some View {
        NavigationStack {

            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 140))], spacing: 16) {
                    ForEach(ItemCategory.allCases, id:\.self) { category in
                        Section {
                            ForEach(itemList.filter {$0.category == category}) { item in
                                ItemView(item: item)
                                    .environmentObject(viewModel)
                            }
                        } header: {
                            Text(category.rawValue.capitalized)
                                .bold()
                                .foregroundColor(.gray.opacity(0.6))
                        }


                    }
                }
                
                

            }
            .padding(20)
            .navigationTitle(Text("Все продукты"))
            .navigationBarTitleDisplayMode(NavigationBarItem.TitleDisplayMode.inline)
            
            .toolbar {
                ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                    NavigationLink {
                       CartView()
                    } label: {
                        CartButton(numberOfProducts: viewModel.items.count)
                    }
                }
                
                ToolbarItem(placement: ToolbarItemPlacement.navigationBarLeading) {
                    Image("navLogo")
                        .resizable()
                        .frame(width: 50, height: 50)
                }

            }
            
        }
        
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
