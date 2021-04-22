import SwiftUI
import WrappingHStack

struct ExampleView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Leading:")
                .font(.headline)
            WrappingHStack(1...7, id:\.self, alignment: .leading, spacing: .constant(0)) {
                Text("Item: \($0)")
                    .padding(.all, 12)
                    .background(RoundedRectangle(cornerRadius: 10).stroke())
            }
            
            Text("Center:")
                .font(.headline)
            WrappingHStack(1...7, id:\.self, alignment: .center, spacing: .constant(0)) {
                Text("Item: \($0)")
                    .padding(.all, 12)
                    .background(RoundedRectangle(cornerRadius: 10).stroke())
            }
            
            Text("Trailing:")
                .font(.headline)
            WrappingHStack(1...7, id:\.self, alignment: .trailing, spacing: .constant(0)) {
                Text("Item: \($0)")
                    .padding(.all, 12)
                    .background(RoundedRectangle(cornerRadius: 10).stroke())
            }
            
            Text("Dynamic:")
                .font(.headline)
            WrappingHStack(1...7, id:\.self, alignment: .leading, spacing: .dynamic(minSpacing: 0)) {
                Text("Item: \($0)")
                    .padding(.all, 12)
                    .background(RoundedRectangle(cornerRadius: 10).stroke())
            }
            
            Text("Dynamic Including Borders:")
                .font(.headline)
            WrappingHStack(1...7, id:\.self, alignment: .leading, spacing: .dynamicIncludingBorders(minSpacing: 0)) {
                Text("Item: \($0)")
                    .padding(.all, 12)
                    .background(RoundedRectangle(cornerRadius: 10).stroke())
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ExampleView()
    }
}
