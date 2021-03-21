import SwiftUI
import WrappingHStack

struct ContentView: View {
    var body: some View {
        VStack(spacing: 0) {
            Text("Above")
                .background(Rectangle().stroke())
            WrappingHStack(alignment: .topLeading, spacing: 10) {
                Text("1234566789")
                    .fixedSize()
                    .background(Rectangle().stroke())
                
                Text("3")
                    .padding(.horizontal, 20)
                    .background(Rectangle().stroke())
                
                Text("8")
                    .padding(.horizontal, 20)
                    .background(Rectangle().stroke())
                
                Image(systemName: "scribble")
                    .font(.title)
                    .background(Rectangle().stroke())
                
                Text("10")
                    .padding(.horizontal, 100)
                    .background(Rectangle().stroke())
                
                
            }.frame(maxWidth: 300).background(Rectangle().stroke(Color.black))
            Text("Bellow")
                .background(Rectangle().stroke())
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
