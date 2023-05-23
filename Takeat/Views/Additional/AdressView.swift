//
//  AdressView.swift
//  Takeat
//
//  Created by Данил Прокопенко on 23.05.2023.
//

import SwiftUI

struct AdressView: View {
    @EnvironmentObject var viewModel: ListViewModel
    @FocusState var isFocused: Bool
    var body: some View {
        
        VStack(alignment: .leading, spacing: 20) {
            
            HStack {
                Text("Введите адрес")
                    .font(.system(.title3, weight: .bold))
                
                Spacer()
                
                Button {
                    isFocused = false
                    viewModel.saveAdress()
                    viewModel.isShowingAdress.toggle()
                    
                } label: {
                    Text("Сохранить")
                        .foregroundColor(.white)
                        .padding(10)
                        .background(Color("styleGreen"))
                        .cornerRadius(16)
                        .padding(.top)
                }
                
            }

            ZStack(alignment: .trailing) {
                TextField("Адрес", text: $viewModel.userAdressAdress)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.gray, style: StrokeStyle(lineWidth: 2))
                    )
                    .cornerRadius(16)
                    .shadow(color: .black.opacity(0.1), radius: 3)
                    .focused($isFocused)
                if viewModel.validateAdressAdress() {
                    Image(systemName: "checkmark")
                        .foregroundColor(Color.green)
                        .padding(.trailing, 16)
                } else {
                    Image(systemName: "multiply")
                        .foregroundColor(Color.red)
                        .padding(.trailing, 16)
                }
            }
            
            HStack {
                ZStack(alignment: .trailing) {
                    TextField("Город", text: $viewModel.userAdressCity)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.gray, style: StrokeStyle(lineWidth: 2))
                        )
                        .cornerRadius(16)
                        .shadow(color: .black.opacity(0.1), radius: 3)
                        .focused($isFocused)
                    
                    if viewModel.validateAdressCity() {
                        Image(systemName: "checkmark")
                            .foregroundColor(Color.green)
                            .padding(.trailing, 16)
                    } else {
                        Image(systemName: "multiply")
                            .foregroundColor(Color.red)
                            .padding(.trailing, 16)
                    }
                }
                
                ZStack(alignment: .trailing) {
                    TextField("Квартира", text: $viewModel.userAdressFlat)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.gray, style: StrokeStyle(lineWidth: 2))
                        )
                        .cornerRadius(16)
                        .shadow(color: .black.opacity(0.1), radius: 3)
                        .focused($isFocused)
                    
                    if viewModel.validateAdressFlat() {
                        Image(systemName: "checkmark")
                            .foregroundColor(Color.green)
                            .padding(.trailing, 16)
                    } else {
                        Image(systemName: "multiply")
                            .foregroundColor(Color.red)
                            .padding(.trailing, 16)
                    }
                }
            }
            .padding(.bottom)
            
        }
        .padding()
        .frame(width: UIScreen.main.bounds.width , height: 200)
        
        .background(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.gray, style: StrokeStyle(lineWidth: 5))
                .background(Color.white)
        )
        .cornerRadius(16)
        .padding()
    }
}

struct AdressView_Previews: PreviewProvider {
    static var previews: some View {
        AdressView()
            .environmentObject(ListViewModel())
    }
}
