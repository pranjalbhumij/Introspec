//
//  SearchView.swift
//  introspec
//
//  Created by Baba Yaga on 27/11/24.
//

import SwiftUI

struct SearchView: View {
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .padding(.leading)
            Text("Search")
            Spacer()
            Image(systemName: "mic")
                .padding(.trailing)
        }
        .foregroundColor(.secondary)
        .padding(.vertical)
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: 40)
        .background( RoundedRectangle(cornerRadius: 10)
            .fill(Color.gray.opacity(0.2)))
        .padding(.horizontal)
    }
}

#Preview {
    SearchView()
}
