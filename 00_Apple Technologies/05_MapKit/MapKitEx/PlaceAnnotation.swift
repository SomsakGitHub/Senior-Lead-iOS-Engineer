import Foundation
import MapKit

class PlaceAnnotation: NSObject, MKAnnotation, Identifiable {
    let id: UUID
    let title: String?
    let subtitle: String?
    let coordinate: CLLocationCoordinate2D
    let category: Category

    init(
        id: UUID = UUID(),
        title: String? = nil,
        subtitle: String? = nil,
        coordinate: CLLocationCoordinate2D,
        category: Category = .point
    ) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
        self.category = category
    }

    enum Category: String {
        case point, restaurant, hotel, attraction, temple
    }
}
