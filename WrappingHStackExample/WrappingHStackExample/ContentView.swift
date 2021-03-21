import SwiftUI
import WrappingHStack

struct ContentView: View {
    var body: some View {
        VStack(spacing: 0) {
            Text("Above")
                .background(Rectangle().stroke())
            HStack(spacing: 0) {
                Text("Left")
                    .background(Rectangle().stroke())
                
                
                
                WrappingHStack(alignment: .topLeading, spacing: 10, data: 1...30, id:\.self, content: {
                    Text("\($0)")
                        .padding(.horizontal, 20)
                }).background(Rectangle().stroke(Color.black))
                
                Text("Right")
                    .background(Rectangle().stroke())
            }
            
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
