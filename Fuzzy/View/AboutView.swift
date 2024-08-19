//
//  AboutView.swift
//  Fuzzy
//
//  Created by Carson Clark on 2024-08-18.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        ZStack{
            VStack {
                Text("Lightweight. Effective.")
                    .font(.largeTitle)
                    .padding(.bottom, 20)
                    .padding(.top, 70)
                    .frame(width: 470)
                
                Text("This robust and efficient application is designed to disable your keyboard temporarily, allowing you to easily clean it without the risk of inadvertently turning on your Mac or generating unintended input. Please grant system permissions first. Do not hesitate to reach out if you encounter any difficulties with this software.")
                    .frame(width: 390)
                    .font(.title3)
                    .multilineTextAlignment(.center)
                
                Text("Please consider leaving a rating and some written feedback. We value all feedback, good or bad.")
                    .frame(width: 390)
                    .multilineTextAlignment(.center)
                    .padding(.top, 75)
                
                Spacer()
                HStack {
                    Link("Website", destination: URL(string: "https://carsonclark.dev")!)
                    Link("Youtube", destination: URL(string: "https://www.youtube.com/@CarsonCameronClark")!)
                    Link("Linkedin", destination: URL(string: "https://www.linkedin.com/in/carsoncameronclark/")!)
                }
                Text("Version 1.4.0").font(.footnote).padding(.bottom, 20)
            }
            .navigationTitle("About Fuzzy")
        }
    }
}

#Preview {
    AboutView()
}
