import MapKit
import SwiftUI

struct MapView: View {
    @StateObject private var locationManager = LocationManager()
    
    var body: some View {
        if let location = locationManager.location {
            Map(coordinateRegion: .constant(
                MKCoordinateRegion(
                    center: location.coordinate,
                    span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                )
            ))
            .edgesIgnoringSafeArea(.all)
        } else {
            Text("⏳ กำลังโหลดตำแหน่ง...")
        }
    }
}

#Preview {
    MapView()
}
