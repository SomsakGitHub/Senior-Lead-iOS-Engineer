import SwiftUI

struct MySwiftUIView: View {
    @State private var currentPage = 0
    @State private var dontShowAgain = false
    
    var body: some View {
        BackgroundDim()
    }
}

#Preview {
    MySwiftUIView()
}

struct BackgroundDim: View {
    var body: some View {
        ZStack {
            // Background dim
            Color.black.opacity(0.45)
                .ignoresSafeArea()
            LightBox()
        }
    }
}

struct LightBox: View {
    @State private var currentPage = 0
    
    let pages: [(image: UIImage, text: String)] = [
        (.picapica, "Hello World"),
        (.picapica,  "Hello World")
    ]
    
    var body: some View {
        VStack(spacing: 12) {
            
            // MARK: - PageView ที่เลื่อนได้เฉพาะตรงรูป
            TabView(selection: $currentPage) {
                ForEach(0..<pages.count, id: \.self) { index in
                    ZStack(alignment: .bottom) {
                        Image(uiImage: pages[index].image)
                            .resizable()
                            .scaledToFit()
                            .contentShape(Rectangle())  // ← gesture จับเฉพาะส่วนนี้เท่านั้น
                        
                        // Custom Indicator
                        HStack(spacing: 8) {
                            ForEach(0..<pages.count, id: \.self) { dot in
                                Circle()
                                    .fill(dot == currentPage ? .red : .gray.opacity(0.3))
                                    .frame(width: 8, height: 8)
                            }
                        }
                        .padding(.bottom, 12)
                    }
                    .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .percentFrame(width: 80, height: 60) // กำหนดความสูงเฉพาะภาพ
            
            // MARK: - ส่วนนี้ห้ามกิน Gesture ของการเลื่อน
            Text("pages[currentPage].text")
                .font(.body)
                .padding(.top, 8)
                .allowsHitTesting(false)   // ← ทำให้ TabView ทำงานเฉพาะตรงรูป
        }
        .background(Color.white)
        .cornerRadius(25)
    }
}


