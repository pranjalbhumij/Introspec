//
//  EmptyViewScreen.swift
//  introspec
//
//  Created by Baba Yaga on 26/11/24.
//

import SwiftUI

struct EmptyViewScreen: View {
    var onAction:() -> Void
    var body: some View {
        VStack {
            Image(systemName: "tray")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.gray)

            Text("No items available")
                .font(.headline)
                .foregroundColor(.secondaryText)
            
            Button(action: onAction) {
                            Text("Add a note")
                                .padding()
                                .background(.buttonBackground)
                                .foregroundColor(.buttonText)
                                .cornerRadius(8)
                        }
        }
        .background(.clear)
    }
}

#Preview {
    EmptyViewScreen(onAction: {})
}
