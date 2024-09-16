import SwiftUI
import MapKit
import UIKit

struct MapMap: View {
    @StateObject var viewModel = ContentViewModel()
    
    @Binding var selectDestination: String
    @Binding var mapSpot: [Double]
    @Binding var isMap: Bool
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            HStack {
                // 場所入力欄
                TextField("", text: $viewModel.location)
                    .padding(5)
                    .cornerRadius(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.primary.opacity(0.6), lineWidth: 0.3))
                    .onChange(of: viewModel.location) { newValue in
                        viewModel.onSearchLocation()
                    }
                
                // 検索ボタン
                Image(systemName: "magnifyingglass")
                    .imageScale(.large)
                    .onTapGesture {
                        viewModel.onSearch()
                    }
            }
            
            ZStack {
                VStack(spacing: 0) {
                    Spacer()
                    PickFromMap_ViewAdaptor(userLocationCoordinate: CLLocationCoordinate2D(latitude: 35.6812, longitude: 139.7671), targetCoordinate: CLLocationCoordinate2D(latitude: Double(viewModel.locationDetail[0])!, longitude: Double(viewModel.locationDetail[1])!), targetTitle: viewModel.locationTitle, isMap: $isMap)
                        .onChange(of: viewModel.locationTitle) {
                            selectDestination = viewModel.locationTitle
                        }
                }
                if viewModel.completions.count > 0 {
                    VStack(spacing: 0) {
                        // 検索候補
                        List(viewModel.completions , id: \.self) { completion in
                            HStack{
                                VStack(alignment: .leading) {
                                    Text(completion.title)
                                    Text(completion.subtitle)
                                        .foregroundColor(Color.primary.opacity(0.5))
                                }
                                Spacer()
                            }
                            .contentShape(Rectangle())
                            .onTapGesture{
                                viewModel.onLocationTap(completion)
                            }
                        }
                        .frame(height: 420)
                        
                        Spacer()
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    MapMap(selectDestination: Binding<String>.constant(""), mapSpot: Binding<[Double]>.constant([35.0, 139.0]), isMap: Binding<Bool>.constant(true))
}


@available(iOS 16, *)
public struct PickFromMap_ViewAdaptor: UIViewRepresentable {
    
    public typealias UIViewType = MKMapView
    
    private var mapView: MKMapView = .init(frame: .zero)
    private var userLocationCoordinate: CLLocationCoordinate2D?
    private var targetCoordinate: CLLocationCoordinate2D?
    private var targetTitle: String
    @Binding var isMap: Bool
    
    public init(userLocationCoordinate: CLLocationCoordinate2D?, targetCoordinate: CLLocationCoordinate2D? = nil, targetTitle: String, isMap: Binding<Bool>) {
        self.userLocationCoordinate = userLocationCoordinate
        self.targetCoordinate = targetCoordinate
        self.targetTitle = targetTitle
        _isMap = isMap
    }
    
    public func makeUIView(context: UIViewRepresentableContext<PickFromMap_ViewAdaptor>) -> MKMapView {
        mapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: "featureAnnotation")
        mapView.showsUserLocation = true
        mapView.delegate = context.coordinator
        
        if let initialCoordinate = targetCoordinate ?? userLocationCoordinate {
            let mapRegion = MKCoordinateRegion(center: initialCoordinate,
                                               latitudinalMeters: 500,
                                               longitudinalMeters: 500)
            mapView.setRegion(mapRegion, animated: true)
        }
        
        return mapView
    }
    
    public func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<PickFromMap_ViewAdaptor>) {
        
        if let newCoordinate = targetCoordinate {
            let mapRegion = MKCoordinateRegion(center: newCoordinate,
                                               latitudinalMeters: 500,
                                               longitudinalMeters: 500)
            uiView.setRegion(mapRegion, animated: true)
            uiView.removeAnnotations(uiView.annotations)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = newCoordinate
            annotation.title = targetTitle
            uiView.addAnnotation(annotation)
        }
    }
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(isMap: $isMap)
    }
    
    public class Coordinator: NSObject, MKMapViewDelegate {
        @Binding var isMap: Bool
        
        init(isMap: Binding<Bool>) {
            _isMap = isMap
        }
        
        public func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            if annotation is MKPointAnnotation {
                let annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "storeAnnotation")
                annotationView.animatesWhenAdded = true
                annotationView.canShowCallout = true
                annotationView.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
                return annotationView
            }
            return nil
        }
        
        public func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            if let annotation = view.annotation {
                print("Tapped on annotation: \(annotation.title ?? "Unknown")")
                // ここで他の処理を実行
                print("success")
                self.isMap = false
            }
        }
    }
}




class ContentViewModel : NSObject, ObservableObject, MKLocalSearchCompleterDelegate{
    /// 位置情報検索クラス
    var completer = MKLocalSearchCompleter()
    /// 場所
    @Published var location = ""
    /// 検索クエリ
    @Published var searchQuery = ""
    /// 位置情報検索結果
    @Published var completions: [MKLocalSearchCompletion] = []
    /// 場所の詳細情報
    @Published var locationDetail = ["35.6812","139.7671"]
    @Published var locationTitle = "Tokyo Station"
    
    
    override init(){
        super.init()
        
        // 検索情報初期化
        completer.delegate = self
        
        // 場所のみ(住所を省く)
        completer.resultTypes = .pointOfInterest
    }
    
    /// 住所変更時
    func onSearchLocation() {
        // マップ表示中の目的地と同じなら何もしない
        if searchQuery == location {
            completions = []
            return
        }
        
        // 検索クエリ設定
        searchQuery = location
        
        // 場所が空の時、候補もクリア
        if searchQuery.isEmpty {
            completions = []
        } else {
            if completer.queryFragment != searchQuery {
                completer.queryFragment = searchQuery
            }
        }
    }
    
    /// 検索結果表示
    /// - Parameter completer: 検索結果の場所一覧
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        DispatchQueue.main.async {
            if self.searchQuery.isEmpty {
                self.completions = .init()
            } else {
                self.completions = completer.results
            }
        }
    }
    
    /// 場所をタップ
    /// - Parameter completion: タップされた場所
    func onLocationTap(_ completion:MKLocalSearchCompletion){
        DispatchQueue.main.async {
            // 場所を選択
            self.location = completion.title
            self.searchQuery = self.location
            
            // 検索
            self.onSearch()
        }
    }
    
    /// 場所の詳細情報を検索
    func onSearch(){
        // 検索結果クリア
        completions = []
        // locationDetail = ["",""]
        
        // 検索条件設定
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = self.location
        
        // 検索実行
        MKLocalSearch(request: request).start { (response, error) in
            if let error = error {
                print("MKLocalSearch Error:\(error)")
                return
            }
            if let mapItem = response?.mapItems.first {
                DispatchQueue.main.async {
                    self.locationDetail[0] = String(mapItem.placemark.coordinate.latitude)
                    self.locationDetail[1] = String(mapItem.placemark.coordinate.longitude)
                    self.locationTitle = mapItem.name ?? "no name"
                }
            }
        }
    }
}

