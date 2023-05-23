//
//  ListViewModel.swift
//  Takeat
//
//  Created by Данил Прокопенко on 22.05.2023.
//

import Foundation

class ListViewModel: ObservableObject {
    //views
    @Published var isShowingAdress = false
    
    
    // LocalData
    @Published var items: [Item] = []
    @Published var total: Int = 0
    
    //CartData
    @Published var cartItems: [Cart] = []
    @Published var isOrdered = false
    
    
    //Subscription
    //Date
    @Published var deliveryDates: [Date] = {
        var dates: [Date] = []
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let currentDate = Date()
        
        if calendar.component(.hour, from: currentDate) < 22 {
            dates.append(today)
        }
        
        for day in 1...6 {
            if let date = calendar.date(byAdding: .day, value: day, to: today) {
                dates.append(date)
            }
        }
        
        return dates
    }()
    
    //Subscription
    //user info
    @Published var userName = ""
    @Published var userCommentary = ""
    @Published var userPhoneNumber = ""
    @Published var userFullAdress = ""
    
    @Published var userAdressCity = ""
    @Published var userAdressAdress = ""
    @Published var userAdressHome = ""
    @Published var userAdressFlat = ""
    
    @Published var userCard = ""
    
    
    @Published var selectedDate: Date? = Date()
    @Published var selectedTimeSLot: Date?
    
    func addToCart(item: Item) {
        self.items[getIndex(item: item, isCartIndex: false)].isAdded = !item.isAdded
        
        if item.isAdded {
            //removing
            self.cartItems.remove(at: getIndex(item: item, isCartIndex: true))
            return
        }
        
        self.cartItems.append(Cart(item: item, quantity: 1))
    }
    
    func itemsForCategory(_ category: ItemCategory) -> [Item] {
        items.filter { $0.category == category }
    }
    
    func fetchItems() {
        let itemList = [
            
            // Молочные продукты
            Item(id: "1", name: "Молоко Бескольское", description: "Молоко 3,2 % процента 500 мл", price: 480, image: "milk1", category: .milkProducts, weightScaler: 1 , units: .item),
            Item(id: "2", name: "Молоко Lactel", description: "Молоко 1,5 % процента 500 мл", price: 560, image: "milk2", category: .milkProducts, weightScaler: 1 , units: .item),
            Item(id: "3", name: "Молоко Милоко", description: "Молоко 3,2 % процента 450 мл", price: 380, image: "milk3", category: .milkProducts, weightScaler: 1 , units: .item),
            Item(id: "4", name: "Молоко Стандартное", description: "Молоко 3 % процента 500 мл", price: 520, image: "milk4", category: .milkProducts, weightScaler: 1 , units: .item),
            
            // Фрукты
            
            Item(id: "5", name: "Клубника", description: "Клубника ташкент, весовая", price: 800, image: "strawberry", category: .fruits, weightScaler: 0.3, units: .kilos),
            Item(id: "6", name: "Банан", description: "Банан эквадор", price: 450, image: "banana", category: .fruits, weightScaler: 1, units: .item),
            Item(id: "7", name: "Ананас", description: "Ананас Турция", price: 2000, image: "pineapple", category: .fruits, weightScaler: 1, units: .item),
            Item(id: "8", name: "Мандарины", description: "Мандарины, весовые", price: 1400, image: "orange", category: .fruits, weightScaler: 0.5, units: .kilos),
            Item(id: "9", name: "Черешня", description: "Черешня, весовая", price: 900, image: "cherry", category: .fruits, weightScaler: 0.5, units: .kilos),
            
            // Овощи
            
            Item(id: "10", name: "Брокколи", description: "Брокколи, свежий", price: 680, image: "broccoli", category: .vegetables, weightScaler: 0.3, units: .kilos),
            Item(id: "11", name: "Томаты", description: "Томаты, сезонные", price: 545, image: "tomatoes", category: .vegetables, weightScaler: 0.5, units: .kilos),
            Item(id: "12", name: "Болгарский перец", description: "Перец болгарский, весовой", price: 1100, image: "bell_pepper", category: .vegetables, weightScaler: 0.5, units: .kilos),
            Item(id: "13", name: "Томаты черри", description: "Томаты черри, весовые", price: 800, image: "tomatoes_cherry", category: .vegetables, weightScaler: 0.3, units: .kilos),
            Item(id: "14", name: "Лук", description: "Лук репчатый, весовой", price: 250, image: "onion", category: .vegetables, weightScaler: 0.5, units: .kilos),
            
        ]
        
        
        self.items = itemList
        
    }
    
    func getIndex(item: Item, isCartIndex: Bool) -> Int {
        
        let index = self.items.firstIndex { (item1) -> Bool in
            return item.id == item1.id
        } ?? 0
        
        let cartIndex = self.cartItems.firstIndex { (item1) -> Bool in
            return item.id == item1.item.id
        } ?? 0
        
        return isCartIndex ? cartIndex : index
    }
    
    func calculateTotalPrice() -> String {
        var price: Double = 0
        cartItems.forEach { (item) in
            price += Double(item.quantity) * item.item.price
        }
        return getPrice(value: price)
    }
    
    func calculateTotalSubscriptionPrice() -> String {
        var price: Double = 0
        cartItems.forEach { (item) in
            price += Double(item.quantity) * item.item.price
        }
        
        if price > 5000 {
            
            return getPrice(value: price)
        } else {
            return getPrice(value: price + 1500)
        }
    }
    
    func calculateDeliveryPrice() -> String {
        var price: Double = 0
        cartItems.forEach { (item) in
            price += Double(item.quantity) * item.item.price
        }
        if price > 5000 {
            return getPrice(value: 0)
        } else {
            return getPrice(value: 1500)
        }
        
    }
    
    func getPrice(value: Double) -> String {
        let format = NumberFormatter()
        format.numberStyle = .currency
        format.currencySymbol = "₸"
        format.maximumFractionDigits = 0
        return format.string(from: NSNumber(floatLiteral: value)) ?? ""
    }
    
    func getUnits(value: Double) -> String {
        let format = NumberFormatter()
        format.numberStyle = .decimal
        format.maximumFractionDigits = 1
        
        return format.string(from: NSNumber(floatLiteral: value)) ?? ""
    }
    
    func validatePhoneNumber() -> Bool {
        let phoneNumberRegex = #"^\+7\d{10}$"#
        let predicate = NSPredicate(format: "SELF MATCHES %@", phoneNumberRegex)
        return predicate.evaluate(with: userPhoneNumber)
    }
    
    func validateName() -> Bool {
        let nameRegex = "^[a-zA-Zа-яА-Я]+$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", nameRegex)
        return !userName.isEmpty && predicate.evaluate(with: userName)
    }
    
    func validateAdressCity() -> Bool {
        let nameRegex = "^[a-zA-Zа-яА-Я]+$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", nameRegex)
        return !userAdressCity.isEmpty && predicate.evaluate(with: userAdressCity)
    }
    
    func validateAdressAdress() -> Bool {
        let nameRegex = #"^[A-Za-zА-Яа-яЁё\s./\d]+$"#
        let predicate = NSPredicate(format: "SELF MATCHES %@", nameRegex)
        return !userAdressAdress.isEmpty && predicate.evaluate(with: userAdressAdress)
    }
    
    func validateAdressFlat() -> Bool {
        let nameRegex = #"^\d+$"#
        let predicate = NSPredicate(format: "SELF MATCHES %@", nameRegex)
        return !userAdressFlat.isEmpty && predicate.evaluate(with: userAdressFlat)
    }
    
    func fullAdressValidation() -> Bool {
        return validateAdressCity() && validateAdressAdress() && validateAdressFlat()
    }
    
    func saveAdress() {
        self.userFullAdress = "\(userAdressCity), \(userAdressAdress), \(userAdressFlat)"
    }
    
    //    func uploadOrder() {
    //        
    //    }
    
    func getTimeSlots(for date: Date) -> [Date] {
        let calendar = Calendar.current
        let currentDate = Date()
        
        if calendar.isDate(date, inSameDayAs: currentDate) {
            let currentHour = calendar.component(.hour, from: currentDate)
            
            let startHour = max(6, currentHour)
            let endHour = 22
            
            var timeSlots: [Date] = []
            for hour in startHour...endHour {
                let slotDate = calendar.date(bySettingHour: hour, minute: 0, second: 0, of: currentDate)!
                timeSlots.append(slotDate)
            }
            timeSlots.removeFirst()
            return timeSlots
        } else {
            let startHour = 6
            let endHour = 22
            
            var timeSlots: [Date] = []
            let startOfDay = calendar.startOfDay(for: date)
            for hour in startHour...endHour {
                let slotDate = calendar.date(bySettingHour: hour, minute: 0, second: 0, of: startOfDay)!
                timeSlots.append(slotDate)
            }
            return timeSlots
        }
    }
    
    
    func approveOrder() -> Bool {
        if selectedTimeSLot != nil &&  validatePhoneNumber() && validateName() && fullAdressValidation() { // card validation are requaired in future
            return false
        } else {
            return true
        }
    }
    
}
