//
//  MapViewCell.swift
//  Weather
//
//  Created by MyeongJin Kim on 7/26/24.
//

import UIKit
import MapKit
import SnapKit

class CustomAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String?, subtitle: String?) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
}

class MapViewCell: UITableViewCell, MKMapViewDelegate {
    static var cellId = "MapViewCell"
    var mapView: MKMapView!
    
    var location: CLLocation? {
        didSet {
            guard let location = location else { return }
            centerMap(on: location)
            addAnnotation(at: location.coordinate)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupMapView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupMapView()
    }
    
    private func setupMapView() {
        mapView = MKMapView()
        mapView.delegate = self
        contentView.addSubview(mapView)

        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
            make.height.equalTo(300)
        }
    }
    
    private func centerMap(on location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    private func addAnnotation(at coordinate: CLLocationCoordinate2D) {
        let annotation = CustomAnnotation(coordinate: coordinate, title: "MARK", subtitle: "")
        mapView.removeAnnotations(mapView.annotations) // 기존 어노테이션 제거
        mapView.addAnnotation(annotation)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "CustomAnnotation"
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        } else {
            annotationView?.annotation = annotation
        }
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let center = mapView.centerCoordinate
        print("Map center moved to: \(center.latitude), \(center.longitude)")
    }
}

private extension MKMapView {
    func centerToLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 1000) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)
    }
}
