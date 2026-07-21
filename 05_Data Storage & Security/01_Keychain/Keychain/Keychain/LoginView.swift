import SwiftUI
import SwiftKeychainWrapper
import Combine

//SwiftUI จะ sync ค่ากับ Keychain อัตโนมัติผ่าน ViewModel นี้
class AuthViewModel: ObservableObject {
    @Published var token: String? {
        didSet {
            if let token = token {
                KeychainWrapper.standard.set(token, forKey: "authToken")
            } else {
                KeychainWrapper.standard.removeObject(forKey: "authToken")
            }
        }
    }
    
    init() {
        self.token = KeychainWrapper.standard.string(forKey: "authToken")
    }
}

struct LoginView: View {
    @StateObject var vm = AuthViewModel()
    
    var body: some View {
        VStack {
            if let token = vm.token {
                Text("✅ Logged in with token: \(token)")
                Button("Logout") { vm.token = nil }
            } else {
                Button("Login") { vm.token = "mySecretToken123" }
            }
        }
        .padding()
    }
}

#Preview {
    LoginView()
}
