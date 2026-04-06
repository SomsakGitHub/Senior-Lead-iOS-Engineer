import SwiftUI

struct PromoPopupView: View {
    @State private var currentPage = 0
    @State private var dontShowAgain = false
    
    var body: some View {
        ZStack {
            // Background dim
            Color.black.opacity(0.45)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                
                // MARK: Page View Container
                TabView(selection: $currentPage) {
                    
                    // Page 1 - Pikachu
                    VStack {
                        Image(.picapica)
                            .resizable()
                            .scaledToFit()
                    }
                    .tag(0)
                    
                    // Page 2 - Promotion content
                    VStack(spacing: 0) {
                        // Text content
                        VStack(spacing: 12) {
                            Image(.picapica)
                                .resizable()
                                .scaledToFill()
                        }
                    }
                    .tag(1)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always)) // ซ่อน indicator เดิม
                
                // MARK: Checkbox
                HStack {
                    Toggle(isOn: $dontShowAgain) {
                        Text("ไม่แสดงหน้านี้ 70 วัน")
                            .font(.system(size: 15))
                    }
                    .toggleStyle(CheckboxToggleStyle())
                    
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.top, 4)
                
                // MARK: Red Button
                Button(action: {}) {
                    Text("สมัครเลย!")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(red: 230/255, green: 50/255, blue: 40/255))
                        .cornerRadius(50)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 10)
                
            }
            .frame(width: 320)
            .background(Color.white)
            .cornerRadius(25)
            .shadow(radius: 8)
        }
    }
}

// MARK: - Checkbox Style
struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack(spacing: 12) {
            Image(systemName: configuration.isOn ? "checkmark.square.fill" : "square")
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(.black)
                .onTapGesture {
                    configuration.isOn.toggle()
                }
            
            configuration.label
        }
    }
}

#Preview {
    PromoPopupView()
}
