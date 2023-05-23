//
//  MapViewController.swift
//  IOSINT
//
//  Created by Эля Корельская on 21.05.2023.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    // cоздание экземпляра CLLocationManager
    let locationManager = CLLocationManager()
    weak var coordinator: MapCoordinator?
    
    // cоздание экземпляра MKMapView
    let mapView = MKMapView()
    // кнопка зума +
    private lazy var zoomInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("+", for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        button.layer.borderColor = UIColor(red: 74/255, green: 218/255, blue: 163/225, alpha: 1).cgColor
        button.layer.borderWidth = 2
        button.contentEdgeInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        button.addTarget(self, action: #selector(zoomIn), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false // Disable autoresizing mask constraints
        return button
    }()
    // кнопка зума -
    private lazy var zoomOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("-", for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        button.layer.borderColor = UIColor(red: 74/255, green: 218/255, blue: 163/225, alpha: 1).cgColor
        button.layer.borderWidth = 2
        button.contentEdgeInsets = UIEdgeInsets(top: 4, left: 9, bottom: 4, right: 10)
        button.addTarget(self, action: #selector(zoomOut), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false // Disable autoresizing mask constraints
        return button
    }()

    @objc func zoomIn() {
        var region = mapView.region
        region.span.latitudeDelta *= 0.8
        region.span.longitudeDelta *= 0.8
        mapView.setRegion(region, animated: true)
    }

    @objc func zoomOut() {
        var region = mapView.region
        region.span.latitudeDelta *= 1.2
        region.span.longitudeDelta *= 1.2
        mapView.setRegion(region, animated: true)
    }

    func setupMapView() {
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.mapType = .standard
        view.backgroundColor = .white
        view.addSubview(mapView)
        view.addSubview(zoomInButton)
        view.addSubview(zoomOutButton)
        NSLayoutConstraint.activate([
           mapView.topAnchor.constraint(equalTo: view.topAnchor),
           mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
           mapView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
           mapView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),

           zoomInButton.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 300),
           zoomInButton.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -16),

           zoomOutButton.topAnchor.constraint(equalTo: zoomInButton.bottomAnchor, constant: 8),
           zoomOutButton.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -16),
       ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // настройка делегата для mapView
        mapView.delegate = self
        setupMapView()
        
        // запрос разрешения на использование местоположения пользователя
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        // включение отслеживания местоположения пользователя
        locationManager.startUpdatingLocation()
        
        // настройка отображения карты
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        
        
        // добавление жеста нажатия на карту
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        mapView.addGestureRecognizer(tapGesture)
    }
    
    // обработчик нажатия на карту
    @objc func handleTap(_ gestureRecognizer: UITapGestureRecognizer) {
        // удаление предыдущих маршрутов и булавок
        mapView.removeOverlays(mapView.overlays)
        mapView.removeAnnotations(mapView.annotations)
        
        // получение координат нажатия на карту
        let touchPoint = gestureRecognizer.location(in: mapView)
        let coordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        
        // создание булавки для отметки выбранной точки
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "Destination"
        
        // добавление булавки на карту
        mapView.addAnnotation(annotation)
        
        // построение маршрута
        if let userLocation = locationManager.location?.coordinate {
            let sourcePlacemark = MKPlacemark(coordinate: userLocation)
            let destinationPlacemark = MKPlacemark(coordinate: coordinate)
            
            let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
            let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
            
            let directionRequest = MKDirections.Request()
            directionRequest.source = sourceMapItem
            directionRequest.destination = destinationMapItem
            directionRequest.transportType = .automobile
            
            let directions = MKDirections(request: directionRequest)
            directions.calculate { (response, error) in
                if let error = error {
                    print("Ошибка при построении маршрута: \(error.localizedDescription)")
                } else if let response = response {
                    // плучение первого маршрута из ответа
                    let route = response.routes[0]
                    
                    // добавление маршрута на карту
                    self.mapView.addOverlay(route.polyline, level: .aboveRoads)
                    
                    // настройка отображения области, чтобы маршрут был виден
                    let routeRect = route.polyline.boundingMapRect
                    self.mapView.setVisibleMapRect(routeRect, edgePadding: UIEdgeInsets(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0), animated: true)
                }
            }
        }
    }
    
    // метод делегата MKMapViewDelegate для отображения маршрута
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolyline {
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = UIColor.black
            renderer.lineWidth = 3.0
            return renderer
        }
        return MKOverlayRenderer()
    }
    
    // метод делегата CLLocationManagerDelegate для обновления местоположения пользователя
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
            mapView.setRegion(region, animated: true)
        }
    }
}
