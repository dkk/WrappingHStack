import SwiftUI

@main
struct WrappingHStackExampleApp: App {
    var body: some Scene {
        WindowGroup {
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(ExampleView.ExampleType.allCases, id: \.self) {
                        Text($0.rawValue)
                            .font(.title)
                            .padding(.horizontal)
                        
                        ExampleView(exampleType: $0)
                        
                        Divider()
                    }

                    NavigationView {
                        VStack {
                            NavigationLink("To The WrappingHStack") {
                                NavigationView {
                                    ExampleView(exampleType: .center)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
