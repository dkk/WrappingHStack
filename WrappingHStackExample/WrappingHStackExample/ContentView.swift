import SwiftUI
import WrappingHStack

struct ForEachExample: View {
    var body: some View {
        VStack(spacing: 0) {
            Text("Above")
                .background(Rectangle().stroke())
            
            HStack(spacing: 0) {
                Text("Left")
                    .background(Rectangle().stroke())
                
                WrappingHStack(alignment: .topLeading, spacing: 10, data: 1...30, id:\.self, content: {
                    Text("\($0)")
                        .foregroundColor(.red)
                        .padding(.horizontal, 15)
                        .background(Rectangle().stroke(Color.red))
                }).background(Rectangle().stroke(Color.black))
                
                Text("Right")
                    .background(Rectangle().stroke())
            }
            
            Text("Bellow")
                .background(Rectangle().stroke())
        }
        
    }
}

struct SingleElementsExample: View {
    var body: some View {
        VStack(spacing: 0) {
            Text("Above")
                .background(Rectangle().stroke())
            HStack(spacing: 0) {
                Text("Left")
                    .background(Rectangle().stroke())
                
                WrappingHStack(spacing: 0) {
                    Text("One")
                        .frame(width: 100, height: 30)
                        .background(Color.yellow)
                    
                    Image(systemName: "scribble")
                        .font(.title)
                        .background(Color.purple)
                                        
                    Text("Two")
                        .frame(width: 200, height: 30)
                        .background(Color.green)
                    
                    VStack {
                        Text("Three")
                            .padding(.horizontal, 80)
                            .background(Color.gray)
                        Text("Four")
                    }
                    .layoutPriority(1)
                    .background(Rectangle().stroke())
                    
                    VStack {
                        Text("Five")
                        Text("Six")
                    }
                    .background(Rectangle().stroke())
                    
                    HStack {
                        Text("Seven")
                        
                        Image(systemName: "xmark.square")
                            .font(.title)
                            .foregroundColor(Color.red)
                    }
                    .background(Rectangle().stroke())
                }
                .background(Rectangle().stroke(Color.black))
                
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
        ForEachExample()
            .previewLayout(.fixed(width: 300, height: 300))
        
        SingleElementsExample()
            .previewLayout(.fixed(width: 300, height: 300))
        
    }
}
