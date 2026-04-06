import SwiftUI
import CoreLocation

struct LocationView: View {
    @StateObject private var locationManager = LocationManager()
    
    var body: some View {
        VStack(spacing: 16) {
            Text("📍 Location Manager Demo")
                .font(.headline)
            
            switch locationManager.authorizationStatus {
            case .notDetermined:
                Text("กำลังขออนุญาตเข้าถึงตำแหน่ง...")
            case .restricted, .denied:
                Text("❌ ไม่สามารถเข้าถึงตำแหน่งได้ กรุณาเปิดใน Settings")
                    .foregroundColor(.red)
            case .authorizedWhenInUse, .authorizedAlways:
                if let location = locationManager.location {
                    Text("Latitude: \(location.coordinate.latitude)")
                    Text("Longitude: \(location.coordinate.longitude)")
                } else {
                    Text("⏳ กำลังดึงตำแหน่ง...")
                }
            default:
                Text("สถานะไม่ทราบ")
            }
        }
        .padding()
    }
}
#Preview {
    LocationView()
}
