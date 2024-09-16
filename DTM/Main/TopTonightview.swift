import SwiftUI
import Firebase

var handle: AuthStateDidChangeListenerHandle?
var user: User?


struct TopTonightview: View {
    @State var inputName = ""
    var body: some View {
        VStack(spacing: 0) {
            TextField("名前：", text: $inputName)
                .onSubmit {
                    userName = inputName
            }
            
            VStack {
                if let user = user {
                    Text("Logged in as \(user.email ?? "Unknown")")
                } else {
                    Text("Not logged in")
                }
            }
            .onAppear {
                handle = Auth.auth().addStateDidChangeListener { auth, user1 in
                    user = user1
                }
            }
            .onDisappear {
                if let handle = handle {
                    Auth.auth().removeStateDidChangeListener(handle)
                }
            }
            
            Text(userName)
        }
    }
}


#Preview {
    TopTonightview()
}
