//
//  test.swift
//  DTM
//
//  Created by 水野裕介 on 2024/08/01.
//

#Preview {
    MapMap()
}

//
//  ContentView.swift
//  GetGeocodeSample
//
//  Created by 春蔵 on 2023/01/14.
//

import SwiftUI
import MapKit

struct MapMap: View {
    /// ViewModel
    @StateObject var viewModel = ContentViewModel()
    
    @Binding var selectDestination: String
    
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
            
            if viewModel.completions.count > 0 {
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
            } else {
                HStack {
                    // 場所の詳細情報
                    // Text(viewModel.locationDetail)
                    Spacer()
                }
            }
            
            Spacer()
        }
        .padding()
    }
}
