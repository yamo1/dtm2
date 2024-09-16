//
//  TopDoubleDatesView.swift
//  DTM
//
//  Created by 水野裕介 on 2024/07/12.
//

import SwiftUI
import MapKit

//struct MapFeature {
//    let id: UUID
//    let title: String
//    let coordinate: CLLocationCoordinate2D
//}


struct TopDoubleDatesView: View {
    @Binding var data: [String: Any]
    @Binding var withWho: String
    
    @State private var sectionData = ["","","","","",""]
    @State private var inputSign = false
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    Text("McGill Double Dates ")
                        .font(
                            Font.custom("ModernEra-Medium", size: 24)
                                .weight(.bold)
                        )
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                    Spacer()
                }
                .padding(.top, 60)
                HStack(spacing: 0) {
                    Text("Next event:")
                        .font(
                            Font.custom("ModernEra-Medium", size: 14)
                                .weight(.bold)
                        )
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(red: 0.03, green: 0.23, blue: 0.17))
                    Spacer()
                }
                .padding(.top, 48)
                VStack(alignment: .center, spacing: 20) {
                    Text("🎉 \(sectionData[0]) 🎉")
                        .font(
                            Font.custom("ModernEra-Medium", size: 20)
                                .weight(.semibold)
                        )
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                        .frame(width: 358, alignment: .top)
                    Text("Spaces: 27 / 170")
                        .font(Font.custom("SF Pro", size: 14))
                        .foregroundColor(.black)
                        .frame(width: 110, alignment: .topLeading)
                    Button {
                        
                    } label: {
                        HStack(spacing: 0) {
                            Text("How it works")
                                .font(
                                    Font.custom("Modern Era", size: 14)
                                        .weight(.bold)
                                )
                            Image(systemName: "info.circle")
                                .frame(width: 15, height: 15)
                                .padding(.leading, 6)
                        }
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(red: 0.89, green: 0.17, blue: 0.3))
                    }
                }
                    .padding(20)
                    .frame(width: 358, alignment: .center)
                    .background(.white)
                    .cornerRadius(25)
                    .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .inset(by: 0.5)
                            .stroke(Color(red: 0.96, green: 0.96, blue: 0.96), lineWidth: 1)
                    )
                    .padding(.top, 16)
                
                Spacer()
                
                if sectionData[5] == "none" {
                    Button {
                        inputSign = true
                    } label: {
                        HStack(alignment: .center, spacing: 0) {
                            // Small text
                            Text("Sign Up")
                                .font(
                                    Font.custom("ModernEra-Medium", size: 16)
                                        .weight(.medium)
                                )
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)
                                .frame(width: 76, alignment: .top)
                        }
                            .padding(.leading, 52)
                            .padding(.trailing, 51)
                            .padding(.vertical, 12)
                            .frame(width: 179, height: 48, alignment: .center)
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
                            .cornerRadius(30)
                    }
                    .fullScreenCover(isPresented: $inputSign) {
                        signUpBro(data: $data, withWho: $withWho)
                    }
                } else {
                    Text("\(sectionData[5]) must click the link sent to their email to confirm your place")
                        .font(
                            Font.custom("SF Pro", size: 16)
                                .weight(.medium)
                        )
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                        .frame(width: 318, alignment: .top)
                    Spacer()
                    Image("dots")
                        .frame(width: 37, height: 5)
                }
                Spacer()
            }
            
            .padding(.horizontal, 18)
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 393, height: 194)
                .background(
                    Image("sitt")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 393, height: 194)
                        .clipped()
                )
            
            Divider()
                .padding(.horizontal, 15)
                .padding(.bottom, 8)
                .padding(.top, 20)
        }
        .task {
            print("Binding to data: \(data)")
            // purse data
            for fieldName in Array(data.keys) {
                if let fromArray = data[fieldName] as? [String] {
                    sectionData = fromArray
                }
            }
        }
    }
    
}

#Preview {
    TopDoubleDatesView(data: Binding<[String: Any]>.constant(["Test2": ["Friday Aug 13th  8:0","🕺 Go to same club","35.0","139.0","Ramen Jiro", ""]]), withWho: Binding<String>.constant("Test2"))
}
