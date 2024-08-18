//
//  SupportView.swift
//  Fuzzy
//
//  Created by Carson Clark on 2024-08-18.
//

import SwiftUI

struct SupportView: View {
    var body: some View {
        HStack {
            Link("Support", destination: URL(string: "https://carsonclark.dev/fuzzy/support.html")!).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            Link("FAQ", destination: URL(string: "https://carsonclark.dev/fuzzy/support.html")!).font(.title)
            Link("Privacy", destination: URL(string: "https://carsonclark.dev/fuzzy/privacy.html")!).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
        }
    }
}

#Preview {
    SupportView()
}
