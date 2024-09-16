import SwiftUI

struct ContentView1: View {
    @State private var showPopup = false
    
    var body: some View {
        ZStack {
            VStack {
                Button(action: {
                    withAnimation {
                        showPopup = true
                    }
                }) {
                    Text("Show Popup")
                        .font(.title)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            
            if showPopup {
                // Dimmed background
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation {
                            showPopup = false
                        }
                    }
                
                // Popup content
                VStack {
                    Text("This is a popup")
                        .font(.title)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 20)
                    
                    Button(action: {
                        withAnimation {
                            showPopup = false
                        }
                    }) {
                        Text("Close")
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .frame(maxWidth: 300, maxHeight: 200)
                .background(Color.white)
                .cornerRadius(20)
                .shadow(radius: 20)
                .transition(.scale)
            }
        }
    }
}

struct ContentView1_Previews: PreviewProvider {
    static var previews: some View {
        ContentView1()
    }
}
