import SwiftUI
import MapKit

enum MapStyleOption: String, CaseIterable {
    case standard
    case hybrid
    case imagery

    var style: MapStyle {
        switch self {
        case .standard: return .standard
        case .hybrid:   return .hybrid
        case .imagery:  return .imagery
        }
    }
}

struct ContentView: View {
    @State private var position: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 13.7563, longitude: 100.5018),
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        )
    )
    @State private var searchText = ""
    @State private var selectedPlace: PlaceAnnotation?
    @State private var selectedMapStyle: MapStyleOption = .standard

    private let landmarks: [PlaceAnnotation] = [
        PlaceAnnotation(
            title: "พระบรมมหาราชวัง",
            subtitle: "กรุงเทพมหานคร",
            coordinate: CLLocationCoordinate2D(latitude: 13.7510, longitude: 100.4913),
            category: .temple
        ),
        PlaceAnnotation(
            title: "วัดพระศรีรัตนศาสดาราม",
            subtitle: "วัดพระแก้ว",
            coordinate: CLLocationCoordinate2D(latitude: 13.7517, longitude: 100.4927),
            category: .temple
        ),
        PlaceAnnotation(
            title: "สนามกีฬาแห่งชาติ",
            subtitle: "สนามศุภชลาศัย",
            coordinate: CLLocationCoordinate2D(latitude: 13.7466, longitude: 100.5291),
            category: .attraction
        ),
        PlaceAnnotation(
            title: "สยามพารากอน",
            subtitle: "ศูนย์การค้า",
            coordinate: CLLocationCoordinate2D(latitude: 13.7463, longitude: 100.5348),
            category: .restaurant
        ),
        PlaceAnnotation(
            title: "โรงแรมมณเฑียร",
            subtitle: "ริมแม่น้ำเจ้าพระยา",
            coordinate: CLLocationCoordinate2D(latitude: 13.7234, longitude: 100.5167),
            category: .hotel
        ),
        PlaceAnnotation(
            title: "ท่าอากาศยานสุวรรณภูมิ",
            subtitle: "สนามบินนานาชาติ",
            coordinate: CLLocationCoordinate2D(latitude: 13.6900, longitude: 100.7501),
            category: .point
        ),
        PlaceAnnotation(
            title: "ตลาดนัดจตุจักร",
            subtitle: "ตลาดนัดชื่อดัง",
            coordinate: CLLocationCoordinate2D(latitude: 13.8000, longitude: 100.5506),
            category: .restaurant
        ),
        PlaceAnnotation(
            title: "วัดอรุณราชวราราม",
            subtitle: "วัดแจ้ง",
            coordinate: CLLocationCoordinate2D(latitude: 13.7437, longitude: 100.4888),
            category: .temple
        ),
    ]

    var body: some View {
        ZStack(alignment: .top) {
            mapView
            VStack(spacing: 0) {
                searchBar
                stylePicker
            }
        }
    }

    private var mapView: some View {
        Map(position: $position, selection: $selectedPlace) {
            ForEach(landmarks) { place in
                Annotation(place.title ?? "", coordinate: place.coordinate) {
                    annotationView(for: place)
                }
                .tag(place)
            }
        }
        .mapStyle(selectedMapStyle.style)
        .mapControls {
            MapUserLocationButton()
            MapCompass()
            MapScaleView()
            MapPitchToggle()
        }
    }

    @ViewBuilder
    private func annotationView(for place: PlaceAnnotation) -> some View {
        VStack(spacing: 2) {
            Image(systemName: glyphName(for: place.category))
                .font(.title2)
                .foregroundStyle(.white)
                .padding(8)
                .background(color(for: place.category))
                .clipShape(Circle())
                .shadow(radius: 3)
            Text(place.title ?? "")
                .font(.caption2)
                .fontWeight(.semibold)
                .foregroundStyle(.primary)
        }
    }

    private var searchBar: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.secondary)
            TextField("ค้นหาสถานที่...", text: $searchText)
                .textFieldStyle(.plain)
            if !searchText.isEmpty {
                Button {
                    searchText = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(.secondary)
                }
            }
        }
        .padding(12)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .padding(.horizontal, 16)
        .padding(.top, 8)
    }

    private var stylePicker: some View {
        HStack(spacing: 12) {
            styleButton("มาตรฐาน", icon: "map", option: .standard)
            styleButton("ภาพถ่าย", icon: "photo", option: .hybrid)
            styleButton("ดาวเทียม", icon: "globe", option: .imagery)
        }
        .padding(.top, 4)
    }

    private func styleButton(_ title: String, icon: String, option: MapStyleOption) -> some View {
        Button {
            selectedMapStyle = option
        } label: {
            Label(title, systemImage: icon)
                .font(.caption)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(selectedMapStyle == option ? Color.accentColor : Color(.systemGray5))
                .foregroundStyle(selectedMapStyle == option ? .white : .primary)
                .clipShape(Capsule())
        }
    }

    private func color(for category: PlaceAnnotation.Category) -> Color {
        switch category {
        case .point:      return .blue
        case .restaurant: return .red
        case .hotel:      return .purple
        case .attraction: return .orange
        case .temple:     return .green
        }
    }

    private func glyphName(for category: PlaceAnnotation.Category) -> String {
        switch category {
        case .point:      return "mappin"
        case .restaurant: return "fork.knife"
        case .hotel:      return "bed.double"
        case .attraction: return "star.fill"
        case .temple:     return "building.columns"
        }
    }
}

#Preview {
    ContentView()
}
