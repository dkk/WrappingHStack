import SwiftUI

@main
struct WrappingHStackExampleApp: App {
    var body: some Scene {
        WindowGroup {
            VStack(alignment: .leading) {
                Text("ForEach Example:")
                    .font(.title)
                ForEachExample()
                
                Spacer()
                    .frame(height: 30)
                
                Text("Single Items Example:")
                    .font(.title)
                SingleElementsExample()
            }
            .padding()
        }
    }
}
