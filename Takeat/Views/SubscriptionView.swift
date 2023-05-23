//
//  SubscriptionView.swift
//  Takeat
//
//  Created by Данил Прокопенко on 22.05.2023.
//

import SwiftUI

struct SubscriptionView: View {
    @ObservedObject var viewModel: ListViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                VStack {
                    
                    HStack(spacing: 20) {
                        Button {
                            dismiss.callAsFunction()
                        } label: {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 26, weight: .heavy))
                                .foregroundColor(Color("styleGreen"))
                        }
                        
                        Text("Оформление подписки")
                            .font(.title)
                            .fontWeight(.heavy)
                            .foregroundColor(Color("styleOrange"))
                        
                        Spacer()
                        
                    }
                    .padding()
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(alignment: .leading,spacing: 20) {
                            
                            Group {
                                Text("Адрес доставки")
                                    .font(.system(.title3, weight: .bold))
                                
                                HStack {
                                    HStack(spacing: 10) {
                                        Image(systemName: "car")
                                        
                                        
                                        
                                        Button {
                                            viewModel.isShowingAdress.toggle()
                                        } label: {
                                            Text(viewModel.fullAdressValidation() ? viewModel.userFullAdress : "Выбрать адрес")
                                                .foregroundColor(.black)
                                        }
                                        
                                        Spacer()
                                        
                                        Button  {
                                            withAnimation {
                                                viewModel.isShowingAdress.toggle()
                                            }
                                        } label: {
                                            Image(systemName: "chevron.right")
                                                .foregroundColor(.black)
                                        }
                                    }
                                }
                                
                                Divider()
                                
                                Text("Первая дата доставки")
                                    .font(.system(.title3, weight: .bold))
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    LazyHStack(alignment: .center, spacing: 20) {
                                        
                                        ForEach(viewModel.deliveryDates, id: \.self) { date in
                                            Button {
                                                viewModel.selectedDate = date
                                            } label: {
                                                DeliveryDateButton(date: date, isSelected: viewModel.selectedDate == date)
                                            }
                                        }
                                    }
                                }
                                
                                Text("Время доставки")
                                    .font(.system(.title3, weight: .bold))
                            }
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                LazyHStack(alignment: .center, spacing: 20) {
                                    if let selectedDate = viewModel.selectedDate {
                                        ForEach(viewModel.getTimeSlots(for: selectedDate), id: \.self) { time in
                                            Button {
                                                viewModel.selectedTimeSLot = time
                                            } label: {
                                                DeliveryTimeSlotButton(time: time, isSelected: viewModel.selectedTimeSLot == time)
                                            }
                                            
                                            
                                        }
                                        
                                    }
                                }
                            }
                            Text("Ваши данные")
                                .font(.system(.title3, weight: .bold))
                            ZStack(alignment: .trailing) {
                                TextField("Имя", text: $viewModel.userName)
                                    .foregroundColor(viewModel.validateName() ? Color.gray : Color.red)
                                    .padding()
                                    .background(
                                        RoundedRectangle(cornerRadius: 16)
                                            .stroke(Color.gray, style: StrokeStyle(lineWidth: 2))
                                    )
                                    .cornerRadius(16)
                                    .shadow(color: .black.opacity(0.1), radius: 3)
                                if viewModel.validateName() {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(Color.green)
                                        .padding(.trailing, 16)
                                } else {
                                    Image(systemName: "multiply")
                                        .foregroundColor(Color.red)
                                        .padding(.trailing, 16)
                                }
                                
                                
                            }

                            TextField("Комментарий к заказу", text: $viewModel.userCommentary)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(Color.gray, style: StrokeStyle(lineWidth: 2))
                                )
                                .cornerRadius(16)
                                .shadow(color: .black.opacity(0.1), radius: 3)
                            
                            ZStack(alignment: .trailing) {
                                TextField("+7(123)456-78-90", text: $viewModel.userPhoneNumber)
                                    .foregroundColor(viewModel.validatePhoneNumber() ? Color.gray : Color.red)
                                    .padding()
                                    .background(
                                        RoundedRectangle(cornerRadius: 16)
                                            .stroke(Color.gray, style: StrokeStyle(lineWidth: 2))
                                    )
                                    .cornerRadius(16)
                                    .shadow(color: .black.opacity(0.1), radius: 3)
                                
                                if viewModel.validatePhoneNumber() {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(Color.green)
                                        .padding(.trailing, 16)
                                } else {
                                    Image(systemName: "multiply")
                                        .foregroundColor(Color.red)
                                        .padding(.trailing, 16)
                                }
                            }
                            Group {
                                Text("Оплата")
                                    .font(.system(.title3, weight: .bold))
                                
                                HStack {
                                    HStack(spacing: 10) {
                                        Image(systemName: "creditcard.and.123")
                                        
                                        Button {
                                            // same action to card screen
                                        } label: {
                                            Text("Добавьте карту")
                                                .foregroundColor(.black)
                                        }
                                        
                                        Spacer()
                                        
                                        Button  {
                                            // same action to card screen
                                        } label: {
                                            Image(systemName: "chevron.right")
                                                .foregroundColor(.black)
                                        }
                                    }
                                }
                            }
                            
                            Spacer(minLength: 16)
                            
                            VStack {
                                
                                VStack(spacing: 10) {
                                    HStack {
                                        
                                        Text("Доставка")
                                            .font(.system(.callout, weight: .bold))
                                            .foregroundColor(.gray)
                                        
                                        Spacer()
                                        
                                        Text(viewModel.calculateDeliveryPrice())
                                            .font(.callout)
                                            .fontWeight(.heavy)
                                            .foregroundColor(.black)
                                    }
                                    .padding(.horizontal)
                                    
                                    HStack {
                                        
                                        Text("Всего")
                                            .fontWeight(.heavy)
                                            .foregroundColor(.gray)
                                        
                                        Spacer()
                                        
                                        Text(viewModel.calculateTotalSubscriptionPrice())
                                            .font(.title)
                                            .fontWeight(.heavy)
                                            .foregroundColor(.black)
                                    }
                                    .padding([.top, .horizontal])
                                }
                                
                                Button {
                                    print("Заказ сделан")
                                    print("\(viewModel.cartItems.description)")
                                } label: {
                                    Text("Выбрать подписку")
                                        .font(.title2)
                                        .fontWeight(.heavy)
                                        .foregroundColor(.white)
                                        .padding(.vertical)
                                        .frame(maxWidth: .infinity)
                                        .background(
                                            viewModel.approveOrder()
                                            ? LinearGradient(gradient: .init(colors: [Color.gray.opacity(0.6), Color.gray]), startPoint: .leading, endPoint: .trailing)
                                            : LinearGradient(gradient: .init(colors: [Color("styleGreen"), Color("styleOrange")]), startPoint: .leading, endPoint: .trailing)
                                            
                                        )
                                        .cornerRadius(16)
                                }
                                .padding(.horizontal, 15)
                                .disabled(viewModel.approveOrder())
                            }
                        }
                        
                    }
                    .padding(.horizontal, 16)

                }
                .background(Color.white.ignoresSafeArea())
                
                .onAppear {
                    viewModel.selectedTimeSLot = nil
                    viewModel.userPhoneNumber = ""
                    viewModel.userName = ""
                }
                
                AdressView()
                    .environmentObject(viewModel)
                    .frame(width: UIScreen.main.bounds.width, height: 200)
                    .offset(y: viewModel.isShowingAdress ? 0 : UIScreen.main.bounds.height)
                    .transition(.move(edge: .bottom))
                    .animation(.linear(duration: 0.5) , value: viewModel.isShowingAdress)

            }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct SubscriptionView_Previews: PreviewProvider {
    var userName: String?
    static var previews: some View {
        SubscriptionView(viewModel: ListViewModel())
    }
}
