//
//  Combine_MVVM.swift
//  UserDefaults
//
//  Created by tiscomacnb2486 on 1/11/2568 BE.
//

import SwiftUI
import Combine

struct Combine_MVVM: View {
    @StateObject var vm = SettingsViewModel()
    
    var body: some View {
        Toggle("Dark Mode", isOn: $vm.darkMode)
            .padding()
    }
}

class SettingsViewModel: ObservableObject {
    @Published var darkMode: Bool {
        didSet {
            UserDefaults.standard.set(darkMode, forKey: "darkMode")
        }
    }
    
    init() {
        self.darkMode = UserDefaults.standard.bool(forKey: "darkMode")
    }
}



#Preview {
    Combine_MVVM()
}
