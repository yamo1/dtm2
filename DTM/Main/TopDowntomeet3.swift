//
//  TopDowntomeet3.swift
//  DTM
//
//  Created by 水野裕介 on 2024/07/15.
//

import SwiftUI
import MapKit

let oneTwo = ["🍺 Grab a Drink", "🍽️ Grab Dinner", "❤️ Hook up", "🖋️ Write date description"]
let events = ["🎉 House Party", "🎑 Double Dates", "🕺 Go to same club", "🥃 Go to same bar"]


struct PopupView: View {
    @Binding var isPresented: Bool
    @Binding var index: Int
    
    var body: some View {
        GeometryReader { geometry in
            
            ZStack {
                PopupBackgroundView(isPresented: isPresented)
                    .transition(.opacity)
                PopupContentsView(isPresented:$isPresented, cardIndex: $index)
                    .frame(width: 360, height: 350)
                    .background(Color.white)
                    .cornerRadius(30)
                    .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                    .overlay(
                        RoundedRectangle(cornerRadius: 30)
                            .inset(by: 0.5)
                            .stroke(Constants.PlaceholderGrey, lineWidth: Constants.StrokeBorder)
                    )
            }
            
        }
    }
}

struct PopupBackgroundView: View {
    @State var isPresented: Bool
    
    var body: some View {
        Color(red: 1, green: 0.99, blue: 0.99).opacity(0.9)
            .onTapGesture {
                self.isPresented = false
            }
            .edgesIgnoringSafeArea(.all)
    }
}

struct PopupContentsView: View {
    @Binding var isPresented: Bool
    @Binding var cardIndex: Int
    
    @State var select = "Select day & time"
    
    @State var is121 = false
    @State var isEvent = false
    
    @State var selectEvents = ""
    @State var selectMaps = ""
    
    @State private var isTime = false
    @State private var isMap = false
    
    @State var selectDestination = "Select in Maps"
    
    @State var mapSpot = [35.0, 139.0]
    
    var body: some View {
        VStack(spacing:0) {
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    Text("Time:")
                        .font(
                            Font.custom("TTNormsProSerifTrl-Bd", size: 18)
                                .weight(.bold)
                        )
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                        // .frame(width: 49, height: 23, alignment: .center)
                        
                    Spacer()
                    Text(select)
                        .font(
                            Font.custom("Modern Era", size: 18)
                                .weight(.medium)
                        )
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(red: 0.84, green: 0.84, blue: 0.84))
                        .frame(height: 13, alignment: .center)
                        .padding(.trailing, 10)
                    Button {
                        isTime = true
                    } label: {
                        Image(select == "Select day & time" ? "today" : "edit_for_meet_up")
                            .frame(height: 23, alignment: .center)
                    }
                    .sheet(isPresented: $isTime) {
                        DateTime(isTime: $isTime, select: $select)
                    }
                }
                .padding(.top, 36)
                
                Spacer()
                HStack(spacing: 0) {
                    Text("Type:")
                        .font(
                            Font.custom("TTNormsProSerifTrl-Bd", size: 18)
                                .weight(.bold)
                        )
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                        // .frame(width: 49, height: 23, alignment: .center)
                    Spacer()
                    if selectEvents == "" {
                        Button {
                            is121 = true
                        } label: {
                            HStack(alignment: .center, spacing: 0) {
                                Text("1-2-1")
                                    .font(Font.custom("Modern Era", size: 16))
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(Constants.ContentBlack)
                                Image(systemName: "chevron.down")
                                    .font(Font.custom("Modern Era", size:8))
                                    .fontWeight(.bold)
                                    .frame(width: 8, height: 4)
                                    .padding(.leading, 5)
                            }
                            .padding(.horizontal, 10)
                            .padding(.vertical, 12)
                            .frame(width: 68, height: 28, alignment: .center)
                            .background(Constants.GraysWhite)
                            .cornerRadius(8)
                            .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .inset(by: 0.5)
                                    .stroke(Color(red: 0.89, green: 0.17, blue: 0.3), lineWidth: Constants.StrokeBorder)
                            )
                            .padding(.trailing, 10)
                            .popover(isPresented: $is121) {
                                List(oneTwo, id: \.self) { option in
                                    Button(action: {
                                        selectEvents = option
                                        is121 = false
                                    }) {
                                        Text(option)
                                            .font(
                                                Font.custom("Modern Era", size: 14)
                                                    .weight(.medium)
                                            )
                                            .multilineTextAlignment(.center)
                                            .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))
                                    }
                                }
                                .scrollContentBackground(.hidden)
                                .scrollIndicators(.hidden)
                                .listStyle(.plain)
                                .frame(width: 230, height: 180)
                                .cornerRadius(15)
                                .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                                .presentationCompactAdaptation(PresentationAdaptation.popover)
                            }
                        }
                        Button {
                            isEvent = true
                        } label:{
                            HStack(alignment: .center, spacing: 0) {
                                Text("Social Event")
                                    .font(Font.custom("Modern Era", size: 16))
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(Constants.ContentBlack)
                                Image(systemName: "chevron.down")
                                    .font(Font.custom("Modern Era", size:8))
                                    .fontWeight(.bold)
                                    .frame(width: 8, height: 4)
                                    .padding(.leading, 5)
                            }
                            .padding(.horizontal, 5)
                            .padding(.vertical, 12)
                            .frame(width: 120, height: 28, alignment: .center)
                            .background(Constants.GraysWhite)
                            .cornerRadius(8)
                            .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .inset(by: 0.5)
                                    .stroke(Color(red: 0.89, green: 0.17, blue: 0.3), lineWidth: Constants.StrokeBorder)
                            )
                            .padding(.trailing, 10)
                            .popover(isPresented: $isEvent) {
                                List(events, id: \.self) { option in
                                    Button(action: {
                                        selectEvents = option
                                        isEvent = false
                                    }) {
                                        Text(option)
                                            .font(
                                                Font.custom("Modern Era", size: 14)
                                                    .weight(.medium)
                                            )
                                            .multilineTextAlignment(.center)
                                            .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))
                                    }
                                }
                                .scrollContentBackground(.hidden)
                                .scrollIndicators(.hidden)
                                .listStyle(.plain)
                                .frame(width: 230, height: 180)
                                .cornerRadius(15)
                                .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                                .presentationCompactAdaptation(PresentationAdaptation.popover)
                            }
                        }
                    } else {
                        Text(selectEvents)
                            .font(Font.custom("Modern Era", size: 16))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.black)
                            .padding(.trailing, 10)
                    }
                    Button {
                        selectEvents = ""
                    } label: {
                        Image(selectEvents == "" ? "Hear Icon" : "edit_for_meet_up")
                            .frame(height: 23, alignment: .center)
                    }
                    
                }
                .padding(.top, 36)
                Spacer()
                HStack(spacing: 0) {
                    Text("Place:")
                        .font(
                            Font.custom("TTNormsProSerifTrl-Bd", size: 18)
                                .weight(.bold)
                        )
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                        // .frame(width: 52, height: 23, alignment: .center)
                    Spacer()
                    Text(selectDestination)
                        .font(
                            Font.custom("Modern Era", size: 16)
                                .weight(.bold)
                        )
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(red: 0.89, green: 0.17, blue: 0.3))
                        .padding(.trailing, 10)
                    Button {
                        isMap = true
                    } label: {
                        Image(selectDestination == "Select in Maps" ? "map" : "edit_for_meet_up")
                            .frame(height: 23, alignment: .center)
                    }
                    .sheet(isPresented: $isMap) {
                        // DateTime(isTime: $isTime)
                        MapMap(selectDestination: $selectDestination, mapSpot: $mapSpot, isMap: $isMap)
                    }
                    
                }
                .padding(.top, 36)
                Spacer()
                
                Button(action: {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                        isPresented = false
                    }
                    setMatch(to: cards[cardIndex], from: userName, day: select, event:selectEvents, map: [String(mapSpot[0]), String(mapSpot[1])], place:selectDestination)
                }, label: {
                    HStack(alignment: .center, spacing: 8) {
                        Text("Send Invite")
                            .font(
                                Font.custom("Modern Era", size: 16)
                                    .weight(.bold)
                            )
                            .foregroundColor(Constants.GraysWhite)
                    }
                        .padding(12)
                        .background(select == "Select day & time" || selectEvents == "" || selectDestination == "Select in Maps" ? AnyView(Constants.PlaceholderGrey) : AnyView(LinearGradient(
                                    stops: [
                                        Gradient.Stop(color: Color(red: 0.89, green: 0.17, blue: 0.3), location: 0.00),
                                        Gradient.Stop(color: Color(red: 0.91, green: 0.17, blue: 0.3), location: 0.35),
                                        Gradient.Stop(color: Color(red: 0.83, green: 0.13, blue: 0.35), location: 1.00),
                                    ],
                                    startPoint: UnitPoint(x: 0.5, y: 0),
                                    endPoint: UnitPoint(x: 0.5, y: 1)
                                ))
                        )
                        .cornerRadius(10)
                        .shadow(color: .black.opacity(0.15), radius: 2, x: 0, y: 2)
                })
                Spacer()
            }
            .padding(.horizontal, 20)
        }
        
    }
}

func convertToMapItem(from feature: MapFeature) -> MKMapItem {
    // `MKPlacemark`を作成
    let placemark = MKPlacemark(coordinate: feature.coordinate)
    
    // `MKMapItem`を作成し、タイトルを設定
    let mapItem = MKMapItem(placemark: placemark)
    mapItem.name = feature.title
    
    return mapItem
}

struct MapMap2: View {
    @State private var searchText = ""
    @State private var searchResults: [MKMapItem] = []
    @State private var location: CLLocationCoordinate2D = .tokyoStation
    @State private var cameraPosition: MapCameraPosition = .region(MKCoordinateRegion(center: .tokyoStation, span: .init(latitudeDelta: 0.01, longitudeDelta: 0.01)))
    @State private var visibleRegion: MKCoordinateRegion?
    @State private var selectedFeature: MapFeature?
    @State private var selectedItem: MKMapItem?
    
    @Binding var selectDestination: String
    
    var body: some View {
        Map(position: $cameraPosition, selection: $selectedFeature) {
            UserAnnotation(anchor: .top) { userLocation in
                EmptyView()
                    .onAppear {
                        cameraPosition = .region(MKCoordinateRegion(center: userLocation.location?.coordinate ?? .tokyoStation, span: .init(latitudeDelta: 0.01, longitudeDelta: 0.01)))
                        location = userLocation.location?.coordinate ?? .tokyoStation
                        selectedItem = convertToMapItem(from: selectedFeature!)
                    }
            }
            //            ForEach(searchResults, id: \.self) { result in
            //                Marker(item: result)
            //            }
            ForEach(searchResults, id: \.self) { result in
                Annotation("Marker", coordinate: result.placemark.coordinate) {
                    Image(systemName: "mappin.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.red)
                        .onTapGesture {
                            selectedItem = result
                            handleMarkerTap(result)
                        }
                }
            }
        }
        .mapFeatureSelectionContent { feature in
            Annotation("Marker", coordinate: feature.coordinate) {
                Image(systemName: "mappin.circle.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.red)
                    .onAppear {
                        print(feature.title)
                        selectedItem = convertToMapItem(from: feature)
                        handleMarkerTap(selectedItem!)
                    }
            }
        }
        .safeAreaInset(edge: .top) {
            HStack {
                TextField("", text: $searchText)
                Button {
                    Task {
                        searchResults = await searchLocations(searchText: searchText)
                    }
                } label: {
                    Image(systemName: "magnifyingglass")
                }
                Text(selectedItem?.name ?? "non name")
                let _ = selectDestination = selectedItem?.name ?? "Select in Maps"
            }
            .padding(8)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(.white)
            )
            .padding()
            .background(
                .thinMaterial
            )
        }
        .onChange(of: searchResults) {
            cameraPosition = .automatic
        }
        .onMapCameraChange { context in
            visibleRegion = context.region
            visibleRegion?.span = .init(latitudeDelta: 0.0225, longitudeDelta: 0.0225)
        }
    }
    
    private func searchLocations(searchText: String) async -> [MKMapItem] {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText
        request.resultTypes = .pointOfInterest
        request.region = visibleRegion ?? MKCoordinateRegion(
            center: location,
            span: MKCoordinateSpan(latitudeDelta: 0.0125,
                                   longitudeDelta: 0.0125))
        do {
            let search = MKLocalSearch(request: request)
            let response = try await search.start().mapItems
            return response
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    func handleMarkerTap(_ item: MKMapItem) {
        // Handle marker tap, e.g., update state, show details, etc.
        print(item)
    }
    
}

extension CLLocationCoordinate2D {
    static let tokyoStation = CLLocationCoordinate2D(latitude: 35.681271031625556, longitude: 139.76710334029735)
    
    static let shinagawaStation = CLLocationCoordinate2D(latitude: 35.6284756, longitude: 139.7361848)
    
    static let tokyoStationStreet = CLLocationCoordinate2D(latitude: 35.679981237178694, longitude: 139.76897015768628)
    
    static let nagoyaStation = CLLocationCoordinate2D(latitude: 35.171046524929345, longitude: 136.88292091775608)
    
    static let osakaStation = CLLocationCoordinate2D(latitude: 34.70257357671039, longitude: 135.4959720556559)
    
    static let hakataStation = CLLocationCoordinate2D(latitude: 33.590225024456885, longitude: 130.42114956628524)
    
    static let tokyoStationArea = [
        CLLocationCoordinate2D(latitude: 35.681901, longitude: 139.76861968750546),
        CLLocationCoordinate2D(latitude: 35.682405, longitude: 139.76627114508926),
        CLLocationCoordinate2D(latitude: 35.680667, longitude: 139.76587695236373),
        CLLocationCoordinate2D(latitude: 35.680037, longitude: 139.76785865385352)
    ]
    
    static let tokyoStationToNihonbashiStation = [
        CLLocationCoordinate2D(latitude: 35.680360872435834, longitude: 139.76895627465805),
        CLLocationCoordinate2D(latitude: 35.68356491886786, longitude: 139.77095859539386),
        CLLocationCoordinate2D(latitude: 35.68204152197238, longitude: 139.77490316724334)
    ]
}


struct DateTime: View {
    @Binding var isTime : Bool
    @Binding var select : String
    
    @State private var selectedDate: Date? = nil
    @State private var selectedHour = 0
    @State private var selectedMinute = 0
    
    let hours = Array(0..<24)
    let minutes = [0, 15, 30, 45]
    
    let today = Date()
    let calendar = Calendar.current
    let dateFormatter = DateFormatter()
    
    init(isTime: Binding<Bool>, select: Binding<String>) {
        self._isTime = isTime
        self._select = select
        dateFormatter.dateFormat = "dd"
    }
    
    func dayOfWeek(for date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE"
        return dateFormatter.string(from: date).uppercased()
    }
    
    func dayOfWeek2(for date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let dayString = dateFormatter.string(from: date).uppercased()
        return dayString.prefix(1).uppercased() + dayString.dropFirst().lowercased()
    }
    
    func dayOfMonth(for date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM"
        let dayString = dateFormatter.string(from: date)
        return dayString.prefix(1).uppercased() + dayString.dropFirst().lowercased()
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Text("Select day & time")
                .font(
                    Font.custom("Modern Era", size: 20)
                        .weight(.medium)
                )
                .multilineTextAlignment(.center)
                .foregroundColor(Color(red: 0.03, green: 0.03, blue: 0.03))
                .padding(.top, 24)
            Divider()
                .padding(.top, 14)
            Text("Day")
                .font(
                    Font.custom("Modern Era", size: 24)
                        .weight(.bold)
                )
                .multilineTextAlignment(.center)
                .foregroundColor(.black)
                .padding(.top, 36)
            
            // Calendar
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    ForEach(0..<7) { offset in
                        let currentDate = calendar.date(byAdding: .day, value: offset, to: today)!
                        VStack {
                            Text(dayOfWeek(for: currentDate))
                                .font(
                                    Font.custom("Modern Era", size: 13)
                                        .weight(.bold)
                                )
                                .foregroundColor(.black)
                            Button(action: {
                                selectedDate = currentDate
                            }) {
                                if offset == 0 {
                                    Text(dateFormatter.string(from: currentDate))
                                        .font(
                                            Font.custom("Modern Era", size: 18)
                                                .weight(.medium)
                                        )
                                        .frame(width: 40, height: 40)
                                        .background(selectedDate == currentDate ? Color.red : Color.clear)
                                        .foregroundColor(selectedDate == currentDate ? .white : Color(red: 0.3, green: 0.56, blue: 1))
                                        .clipShape(Circle())
                                } else {
                                    Text(dateFormatter.string(from: currentDate))
                                        .font(
                                            Font.custom("Modern Era", size: 18)
                                                .weight(.medium)
                                        )
                                        .frame(width: 40, height: 40)
                                        .background(selectedDate == currentDate ? Color.red : Color.clear)
                                        .foregroundColor(selectedDate == currentDate ? .white : .black)
                                        .clipShape(Circle())
                                }
                            }
                        }
                        Spacer()
                    }
                }
            }
            .frame(width: 330, height: 74)
            .background(Constants.GraysWhite)
            .padding(.top, 43)
            Text("Can meet within a week")
                .font(
                    Font.custom("Modern Era", size: 16)
                        .weight(.medium)
                )
                .multilineTextAlignment(.center)
                .foregroundColor(Color(red: 0.58, green: 0.58, blue: 0.6))
                .padding(.top, 50)
            Divider()
                .padding(.top, 43)
            Text("Time")
                .font(
                    Font.custom("Modern Era", size: 24)
                        .weight(.bold)
                )
                .multilineTextAlignment(.center)
                .foregroundColor(.black)
                .padding(.top, 43)
            
            Spacer()
            
            HStack {
                Picker(selection: $selectedHour, label: Text("")) {
                    ForEach(hours, id: \.self) { hour in
                        Text("\(hour)")
                            .font(
                                Font.custom("Modern Era", size: 24)
                                    .weight(.medium)
                            )
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color(red: 0.89, green: 0.17, blue: 0.3))
                            .frame(width: 60, height: 60)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(width: 100)
                .clipped()
                
                Picker(selection: $selectedMinute, label: Text("")) {
                    ForEach(minutes, id: \.self) { minute in
                        Text(String(format: "%02d", minute))
                            .font(
                                Font.custom("Modern Era", size: 24)
                                    .weight(.medium)
                            )
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color(red: 0.89, green: 0.17, blue: 0.3))
                            .frame(width: 60, height: 60)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(width: 100)
                .clipped()
            }
            Spacer()
            
            Button {
                isTime = false
                if let unwrappedDate = selectedDate {
                    if let ordinal = Int(dateFormatter.string(from: unwrappedDate)) {
                        select = "\(dayOfWeek2(for: unwrappedDate))"+" "+"\(dayOfMonth(for: unwrappedDate))"+" "+"\(ordinalNumber(ordinal))"+" "+" \(selectedHour):\(selectedMinute)"
                    }
                }
            } label: {
                Text("Done")
                    .font(
                        Font.custom("Modern Era", size: 16.96)
                            .weight(.bold)
                    )
                    .multilineTextAlignment(.center)
                    .foregroundColor(Constants.GraysWhite)
                    .padding(.horizontal, 34)
                    .padding(.vertical, 10)
                    .background(
                        LinearGradient(
                            stops: [
                                Gradient.Stop(color: Color(red: 0.89, green: 0.17, blue: 0.3), location: 0.00),
                                Gradient.Stop(color: Color(red: 0.91, green: 0.17, blue: 0.3), location: 0.35),
                                Gradient.Stop(color: Color(red: 0.83, green: 0.13, blue: 0.35), location: 1.00),
                            ],
                            startPoint: UnitPoint(x: 0.5, y: 0),
                            endPoint: UnitPoint(x: 0.5, y: 1)
                        )
                    )
                    .cornerRadius(19.76271)
                    .shadow(color: .black.opacity(0.1), radius: 0.848, x: 0, y: 1.696)
            }
            
            if let unwrappedDate = selectedDate {
                if let ordinal = Int(dateFormatter.string(from: unwrappedDate)) {
                    Text("\(dayOfWeek2(for: unwrappedDate)) \(dayOfMonth(for: unwrappedDate)) \(ordinalNumber(ordinal)) \(selectedHour):\(selectedMinute)")
                        .font(
                            Font.custom("Modern Era", size: 20)
                                .weight(.bold)
                        )
                        .multilineTextAlignment(.center)
                        .ignoresSafeArea(.all)
                        .foregroundColor(.black)
                        .padding(.top, 30)
                        .padding(.bottom, 30)
                }
            } else {
                Text("\(dayOfWeek2(for: today)) \(dayOfMonth(for: today)) \(dateFormatter.string(from: today))th \(selectedHour):\(selectedMinute)")
                    .font(
                        Font.custom("Modern Era", size: 20)
                            .weight(.bold)
                    )
                    .multilineTextAlignment(.center)
                    .ignoresSafeArea(.all)
                    .foregroundColor(.black)
                    .padding(.top, 30)
                    .padding(.bottom, 30)
            }
            
        }
    }
}

struct CustomPickerTime: View {
    @State private var selectedHour = 0
    @State private var selectedMinute = 0
    
    let hours = Array(0..<24)
    let minutes = [0, 15, 30, 45]
    
    var body: some View {
        HStack {
            Picker(selection: $selectedHour, label: Text("")) {
                ForEach(hours, id: \.self) { hour in
                    Text("\(hour)")
                        .font(
                            Font.custom("Modern Era", size: 24)
                                .weight(.medium)
                        )
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(red: 0.89, green: 0.17, blue: 0.3))
                        .frame(width: 60, height: 60)
                }
            }
            .pickerStyle(WheelPickerStyle())
            .frame(width: 100)
            .clipped()
            
            Picker(selection: $selectedMinute, label: Text("")) {
                ForEach(minutes, id: \.self) { minute in
                    Text(String(format: "%02d", minute))
                        .font(
                            Font.custom("Modern Era", size: 24)
                                .weight(.medium)
                        )
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(red: 0.89, green: 0.17, blue: 0.3))
                        .frame(width: 60, height: 60)
                }
            }
            .pickerStyle(WheelPickerStyle())
            .frame(width: 100)
            .clipped()
        }
    }
}


func ordinalSuffix(from number: Int) -> String {
    let suffix: String
    switch number % 100 {
    case 11, 12, 13:
        suffix = "th"
    default:
        switch number % 10 {
        case 1:
            suffix = "st"
        case 2:
            suffix = "nd"
        case 3:
            suffix = "rd"
        default:
            suffix = "th"
        }
    }
    return suffix
}

func ordinalNumber(_ number: Int) -> String {
    return "\(number)\(ordinalSuffix(from: number))"
}
