import SwiftUI
import WrappingHStack

struct ExampleView: View {
    var body: some View {
        VStack(spacing: 0) {
            Text("Above")
                .background(Rectangle().stroke())
            HStack(spacing: 0) {
                Text("Left")
                    .background(Rectangle().stroke())
                
                WrappingHStack {
                    Text("WrappingHStack")
                        .padding()
                        .font(.title)
                        .border(Color.black)
                        .padding(.vertical, 10)
                                        
                    Group {
                        Text("can")
                        Text("handle different element")
                    }
                    
                    HStack {
                        RoundedRectangle(cornerRadius: 5)
                            .overlay(Text("types").foregroundColor(.white))
                        
                        
                        Image(systemName: "exclamationmark.circle.fill")
                            .font(.title)
                            .foregroundColor(.purple)
                    }
                    
                    NewLine()
                    
                    Text("and loop items:")
                        .bold()
                        .padding(.bottom, 10)
                    
                    NewLine()
                    
                    WrappingHStack(data: 1...20, id:\.self) {
                        Text("Item: \($0)")
                            .padding(3)
                            .background(Rectangle().stroke())
                            .padding(3)
                    }
                }
                .padding(10)
                .border(Color.black)
                .padding(2)
                
                Text("Right")
                    .background(Rectangle().stroke())
            }
            
            Text("Bellow")
                .background(Rectangle().stroke())
        }
        .padding(2)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ExampleView()
    }
}
