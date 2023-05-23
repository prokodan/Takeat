//
//  View + extension.swift
//  Takeat
//
//  Created by Данил Прокопенко on 22.05.2023.
//

import SwiftUI

extension View {
    
    func onViewDidLoad(perform action: (() -> Void)? = nil) -> some View {
        self.modifier(ViewDidLoadModifier(action: action))
    }
    
}
