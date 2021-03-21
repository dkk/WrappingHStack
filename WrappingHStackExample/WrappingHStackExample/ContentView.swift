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
                
                WrappingHStack(alignment: .topLeading, spacing: 10) {                    
                    ForEach(1...30, id: \.self) {
                        Text(String($0))
                            .padding(.horizontal, 20)
                    }
                    .background(Rectangle().stroke(Color.red))
                    
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
                    
                    Text("10")
                        .padding(.horizontal, 100)
                        .background(Rectangle().stroke())
                    
                    Group {
                        Text("50")
                            .padding(.horizontal, 10)
                        
                        Text("100")
                            .padding(.horizontal, 20)
                        
                        Image(systemName: "scribble")
                            .font(.title)
                    }
                    .background(Rectangle().stroke(Color.green))
                }.background(Rectangle().stroke(Color.black))
                
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
