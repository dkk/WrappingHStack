import SwiftUI
import WrappingHStack

struct ExampleView: View {
    enum ExampleType: String, CaseIterable {
        case leading, center, trailing, dynamicLeading, dynamicCenter, dynamicTrailing, dynamicIncludingBorders
    }
    
    @State var exampleType: ExampleType
    
    func example(alignment: HorizontalAlignment, spacing: WrappingHStack.Spacing) -> some View {
        WrappingHStack(alignment: alignment, spacing: spacing, lineSpacing: 10) {
            Text("WrappingHStack")
            
            Image(systemName: "scribble")
                .font(.title)
                .frame(width: 20, height: 20)
                .background(Color.purple)
            
            NewLine()
            
            Text("NL")
            
            Image(systemName: "face.dashed")
                .font(.title)
                .border(Color.green)
            
            Text("bcdefghijklmnopqrs")
                .font(.title)
            
            WrappingHStack(1...9, id:\.self, alignment: alignment, spacing: spacing) {
                Text("Item: \($0)")
                    .padding(.all, 12)
                    .background(RoundedRectangle(cornerRadius: 10).stroke())
            }.frame(width: 380)
            
            Text("1234567898")
                .bold()
        }
    }
    
    
    var body: some View {
        switch exampleType {
        case .leading:
            example(alignment: .leading, spacing: .constant(0))

        case .center:
            example(alignment: .center, spacing: .constant(0))

        case .trailing:
            example(alignment: .trailing, spacing: .constant(0))

        case .dynamicLeading:
            example(alignment: .leading, spacing: .dynamic(minSpacing: 0))

        case .dynamicCenter:
            example(alignment: .center, spacing: .dynamic(minSpacing: 0))

        case .dynamicTrailing:
            example(alignment: .trailing, spacing: .dynamic(minSpacing: 0))

        case .dynamicIncludingBorders:
            example(alignment: .leading, spacing: .dynamicIncludingBorders(minSpacing: 0))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ForEach(ExampleView.ExampleType.allCases, id: \.self) {
                ExampleView(exampleType: $0)
                    .previewDisplayName($0.rawValue)
            }

            NavigationView {
                VStack {
                    NavigationLink("To the WrappingHStack") {
                        NavigationView {
                            ExampleView(exampleType: .center)
                        }
                    }
                }
            }
            .previewDisplayName("Link")
        }
        .previewLayout(.fixed(width: 380, height: 250))
    }
}
