import SwiftUI

struct SupportView: View {
    var body: some View {
        
        let instructions = [
            "Step 1: Download from the App Store",
            "Step 2: Open Fuzzy for the First time",
            "Step 3: Click 'Open System Preferences'",
            "Step 4: Click '+' icon",
            "Step 5: Enter password",
            "Step 6: Locate 'Fuzzy' within your list of Applications",
            "Step 7: Click 'Fuzzy' and then select 'Open'",
            "Step 8: Ensure permissions are toggled on",
        ]

        VStack {
            VStack(alignment: .leading, spacing: 10) {
                ForEach(instructions, id: \.self) { instruction in
                    Text(instruction)
                        .padding(.top, 7)
                }
            }
            .padding(.top, 10)
            
            VStack {
                Link("Watch Instructional Video", destination: URL(string: "https://www.youtube.com/watch?v=LR598lOSgYE&t=4s")!)
                                .foregroundColor(.blue)
                                .font(.title2)
                                .padding(.bottom, 5)
                
                Text("Please consider rating this app in the App store!")
                    .multilineTextAlignment(.center)
                    .font(.footnote)
                HStack {
                    Link("Support", destination: URL(string: "https://carsonclark.dev/fuzzy/support.html")!)
                    Link("Privacy", destination: URL(string: "https://carsonclark.dev/fuzzy/privacy.html")!)
                }
            }
            .padding(.top, 42)
        }
        .navigationTitle("How to Install Fuzzy")
        .background(Color.clear)
    }
}

#Preview {
    SupportView()
}

