//
//  WaitMatchView.swift
//  DTM
//
//  Created by 水野裕介 on 2024/08/09.
//

import SwiftUI
import MapKit
import Foundation

struct WaitMatchView: View {
    
    @Binding var data: [String: Any]
    @Binding var withWho: String
    
    @State private var isRevise = false
    @State private var isSearch = false
    @State private var sectionData = ["","","","","",""]
    
    @State var targetDate = Date()
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Text("What if they don’t show?")
                    .font(
                        Font.custom("Modern Era", size: 12)
                            .weight(.bold)
                    )
                    .foregroundColor(Color(red: 0.46, green: 0.47, blue: 0.47))
                    .frame(width: 140, alignment: .topLeading)
                    .padding(.leading, 16)
                    .padding(.top, 8)
                Spacer()
                HStack(spacing: 0) {
                    Button {
                        // revise your profile
                        isRevise = true
                    }label: {
                        HStack(alignment: .bottom, spacing: 0) {
                            Text("Your Profile")
                                .font(Font.custom("Modern Era", size: 14))
                                .multilineTextAlignment(.center)
                                .foregroundColor(.black)
                                .frame(width: 86, height: 22, alignment: .top)
                        }
                        .padding(.leading, 0)
                        .padding(.trailing, 10)
                        .padding(.top, 5)
                        .padding(.bottom, 4.44444)
                        .frame(width: 126, height: 40, alignment: .bottomLeading)
                        .background(Constants.GraysWhite)
                        .cornerRadius(15)
                        .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
                        .padding(.top, 12)
                        .padding(.trailing, 20)
                    }
                    .fullScreenCover(isPresented: $isRevise) {
                        ProfileReviseView()
                    }
                }
            }
            
            Text("You’re Meeting \(withWho)!")
                .font(
                    Font.custom("Modern Era", size: 24)
                        .weight(.bold)
                )
                .multilineTextAlignment(.center)
                .foregroundColor(.black)
                .frame(height: 17)
                .padding(.top, 36)
            
            ZStack {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 181, height: 168)
                    .background(
                        Image("testImage")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 181, height: 168)
                            .clipped()
                    )
                    .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
            }
                .frame(width: 168, height: 168)
                .background(Constants.GraysWhite)
                .cornerRadius(100)
                .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                .padding(.top, 36)
            
            CountDownView(targetDate: targetDate)
                .padding(.top, 56)
            
            Text("\(sectionData[0])\n\(sectionData[4])  \(sectionData[1])")
                .font(
                    Font.custom("Modern Era", size: 20)
                        .weight(.bold)
                )
                .multilineTextAlignment(.center)
                .foregroundColor(.black)
                .frame(width: 361, alignment: .top)
                .padding(.top, 56)
            
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 159, height: 119)
                .background(
                    Group {
                        if let lati = Double(sectionData[2]), let long = Double(sectionData[3]) {
                            PickFromMap_ViewAdaptor(
                                userLocationCoordinate: CLLocationCoordinate2D(latitude: lati, longitude: long),
                                targetCoordinate: CLLocationCoordinate2D(latitude: lati, longitude: long),
                                targetTitle: sectionData[4],
                                isMap: Binding<Bool>.constant(true)
                            )
                        } else {
                            Color.white
                        }
                    }
                )

                .cornerRadius(30)
                .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                .padding(.top, 26)
            
            Spacer()
            
            Divider()
                .padding(.bottom, 8)
        }
        .background(Color(red:255, green:252, blue:253))
        .task {
            print("Binding to data: \(data)")
            // purse data
            for fieldName in Array(data.keys) {
                if let fromArray = data[fieldName] as? [String] {
                    sectionData = fromArray
                }
            }
        }
        .onChange(of: sectionData[0]) {
            func removeDateSuffix(from dateString: String) -> String {
                let weeks = ["Sunday ", "Monday ", "Tuesday ", "Wednesday ", "Thursday ", "Friday ", "Saturday "]
                let suffixes = ["st", "nd", "rd", "th"]
                var cleanedString = dateString
                for we in weeks {
                    cleanedString = cleanedString.replacingOccurrences(of: we, with: "")
                }
                for suffix in suffixes {
                    cleanedString = cleanedString.replacingOccurrences(of: suffix, with: "")
                }
                return cleanedString
            }
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM d HH:mm"
            
            let dateString = sectionData[0]
            let cleanedDateString = removeDateSuffix(from: dateString as! String)
            print(cleanedDateString)
            
            if let date = dateFormatter.date(from: cleanedDateString) {
                print("Parsed Date: \(date)")
            } else {
                print("Failed to parse date.")
            }
            
            
            // print(sectionData[0])
            // let dateString = sectionData[0]
            print(sectionData)
            targetDate = dateFormatter.date(from: cleanedDateString) ?? Date()
            print("targetDate1:\(targetDate)")
            
            // 現在の年を取得
            let currentYear = Calendar.current.component(.year, from: Date())
            
            if let dateWithoutYear = dateFormatter.date(from: cleanedDateString) {
                // カレンダーを使用して年を現在の年に設定
                var calendar = Calendar.current
                calendar.timeZone = TimeZone.current
                var dateComponents = calendar.dateComponents([.month, .day, .hour, .minute], from: dateWithoutYear)
                dateComponents.year = currentYear // 現在の年を設定
                targetDate = calendar.date(from: dateComponents) ?? Date()
                print("targetDate2:\(targetDate)")
            } else {
                targetDate = Date()
                print("targetDate3:\(targetDate)")
            }
        }
    }
}

#Preview {
    WaitMatchView(data: Binding<[String: Any]>.constant(["Test2": ["Friday Aug 13th  8:0","🕺 Go to same club","35.0","139.0","Ramen Jiro",""]]), withWho: Binding<String>.constant(""))
}

struct CountDownView: View {
    @State private var timeRemaining: TimeInterval = 0
    @State private var timer: Timer?
    
    let targetDate: Date
    
    var body: some View {
        ZStack {
            HStack(spacing: 0) {
                VStack(spacing: 0) {
                    Text(timeFormatted(Int(timeRemaining) / 3600))
                        .font(
                            Font.custom("Plus Jakarta Sans", size: 28)
                                .weight(.bold)
                        )
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(red: 1, green: 0.99, blue: 0.99))
                    Text("Hours")
                        .font(
                            Font.custom("Modern Era", size: 10)
                                .weight(.medium)
                        )
                        .multilineTextAlignment(.center)
                        .foregroundColor(Constants.GraysWhite)
                }
                Text(":")
                    .font(
                        Font.custom("Playfair Display SC", size: 28)
                            .weight(.bold)
                    )
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(red: 1, green: 0.99, blue: 0.99))
                    .padding(.leading, 25)
                VStack(spacing: 0) {
                    Text(timeFormatted((Int(timeRemaining) % 3600) / 60))
                        .font(
                            Font.custom("Plus Jakarta Sans", size: 28)
                                .weight(.bold)
                        )
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(red: 1, green: 0.99, blue: 0.99))
                    Text("Minutes")
                        .font(
                            Font.custom("Modern Era", size: 10)
                                .weight(.medium)
                        )
                        .multilineTextAlignment(.center)
                        .foregroundColor(Constants.GraysWhite)
                }
                .padding(.leading, 25)
                Text(":")
                    .font(
                        Font.custom("Playfair Display SC", size: 28)
                            .weight(.bold)
                    )
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(red: 1, green: 0.99, blue: 0.99))
                    .padding(.leading, 25)
                VStack(spacing: 0) {
                    Text(timeFormatted(Int(timeRemaining) % 60))
                        .font(
                            Font.custom("Plus Jakarta Sans", size: 28)
                                .weight(.bold)
                        )
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(red: 1, green: 0.99, blue: 0.99))
                    Text("Seconds")
                        .font(
                            Font.custom("Modern Era", size: 10)
                                .weight(.medium)
                        )
                        .multilineTextAlignment(.center)
                        .foregroundColor(Constants.GraysWhite)
                }
                .padding(.leading, 25)
            }
            .onAppear {
                updateTimeRemaining()
                startTimer()
                print(timeRemaining)
                print("targetDate: \(targetDate)")
                print("timeRemaining: \(timeRemaining)")
            }
            .onDisappear {
                timer?.invalidate()
            }
        }
        .padding(.leading, 21)
        .padding(.trailing, 28)
        .padding(.top, 2)
        .padding(.bottom, 6)
        .frame(width: 290)
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
        .cornerRadius(15)
        .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            updateTimeRemaining()
        }
    }
    
    private func updateTimeRemaining() {
        let currentTime = Date()
        timeRemaining = targetDate.timeIntervalSince(currentTime)
        
        if timeRemaining <= 0 {
            timer?.invalidate()
            timeRemaining = 0
        }
    }
    
    private func timeFormatted(_ value: Int) -> String {
        return String(format: "%02d", value)
    }
}
