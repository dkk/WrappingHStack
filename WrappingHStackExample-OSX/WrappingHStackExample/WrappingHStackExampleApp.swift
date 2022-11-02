//
//  WrappingHStackExampleApp.swift
//  WrappingHStackExample
//
//  Created by Daniel Kloeck on 02.11.22.
//

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
                }
            }
        }
    }
}
