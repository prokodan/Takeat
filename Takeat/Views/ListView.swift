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
                    ForEach(ItemCategory.allCases, id:\.self) { (category) in
                        Section {
                            ForEach(viewModel.items.filter {$0.category == category}) { (item) in
                                
                                ItemView(viewModel: viewModel, item: item)
                                
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
                            .environmentObject(viewModel)
                        
                    } label: {
                        CartButton()
                            .environmentObject(viewModel)
                    }
                }
                
                ToolbarItem(placement: ToolbarItemPlacement.navigationBarLeading) {
                    Image("navLogo")
                        .resizable()
                        .frame(width: 50, height: 50)
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                viewModel.fetchItems()
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}


struct SectionView<Content:View>: View {
    let category: ItemCategory
    let content: () -> Content
    var body: some View {
        Text(category.rawValue.capitalized)
            .bold()
            .foregroundColor(.gray.opacity(0.6))
        content()
        
    }
}
