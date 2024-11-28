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
        ZStack {
            Color("editorBackground").ignoresSafeArea()
            VStack {
                Image("emptyIllustration")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .foregroundColor(.gray)

                Text("No notes available")
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
        }
    }
}

#Preview {
    EmptyViewScreen(onAction: {})
}
