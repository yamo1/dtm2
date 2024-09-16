//
//  RegisterC4.swift
//  DTM
//
//  Created by 水野裕介 on 2024/06/23.
//

import SwiftUI

let musicGenre1 = ["Hip Hop","Rock","Pop","Alternative","Indie"]
let musicGenre2 = ["Jazz","Classical","Country","Metal","Latin"]
let musicGenre3 = ["R & B","Chill","Grime","Reggae","60s-90s"]
let musicGenre4 = ["Techno","Electronic","Deep house","EDM"]
let musicGenre5 = ["Chillwave","Afrobeats","House","Trance"]
let musicGenre6 = ["Dance","DnB","Tropical house","Breakbeat"]

struct RegisterC4: View {
    @State var inputMusic = ""
    @State private var isInput = false
    @State var genre1 = ""
    @State var genre2 = ""
    @State var musicGenre0 = [""]
    
    var now = 6
    public var body: some View {
        VStack(spacing:0) {
            NavigationLink {
                RegisterC5()
                
            } label: {
                Text("Complete later")
                    .font(
                        Font.custom("ModernEra-Medium", size: 12)
                            .weight(.bold)
                    )
                    .foregroundColor(Color(red: 0.1, green: 0.2, blue: 0.45))
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.trailing, 32)
                    .padding(.top, 16)
            }
            
            // Line
            VStack(spacing: 0) {
                ZStack {
                    HStack {
                        ForEach(1...10, id:\.self) { number in
                            Spacer()
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: 25, height: 5)
                                .background(number <= now ? Color(red: 0.89, green: 0.17, blue: 0.3) : Color.clear)
                                .cornerRadius(5)
                        }
                        Spacer()
                    }
                    HStack {
                        ForEach(1...11, id:\.self) { number in
                            Image(systemName: number <= now ? "circle.fill" : "circle")
                                .frame(width: 15, height: 15)
                                .background(Color.white)
                                .foregroundColor(number <= now ? Color(red: 0.89, green: 0.17, blue: 0.3) : Color(red: 0.85, green: 0.85, blue: 0.85))
                            if number != 11 {
                                Spacer()
                            }
                        }
                    }
                }
            }
            .frame(width: 329, height: 15)
            .padding(.top, 48)
            .padding(.trailing, 32)
            .padding(.leading, 32)
            
            // Number
            VStack(alignment: .leading) {
                ScrollView {
                    // What music do you like?
                    HStack(spacing: 0) {
                        Text("2 music genres you like")
                            .font(
                                Font.custom("New York", size: 28)
                                    .weight(.bold)
                            )
                            .foregroundColor(.black)
                            .frame(height: 20, alignment: .topLeading)
                            .padding(.top, 48)
                        
                        Spacer()
                    }
                    // Add Space
                    // Genre List
                
                    VStack(spacing: 0) {
                        HStack(spacing: 0) {
                            ForEach(musicGenre1, id: \.self) { gen in
                                optionGenre(title: gen, genre1: $genre1, genre2: $genre2)
                                if gen != musicGenre1.last {
                                    Spacer()
                                }
                            }
                        }
                        .padding(.top, 15)
                        HStack(spacing: 0) {
                            ForEach(musicGenre2, id: \.self) { gen in
                                optionGenre(title: gen, genre1: $genre1, genre2: $genre2)
                                if gen != musicGenre2.last {
                                    Spacer()
                                }
                            }
                        }
                        .padding(.top, 15)
                        HStack(spacing: 0) {
                            ForEach(musicGenre3, id: \.self) { gen in
                                optionGenre(title: gen, genre1: $genre1, genre2: $genre2)
                                if gen != musicGenre3.last {
                                    Spacer()
                                }
                            }
                        }
                        .padding(.top, 15)
                        HStack(spacing: 0) {
                            ForEach(musicGenre4, id: \.self) { gen in
                                optionGenre(title: gen, genre1: $genre1, genre2: $genre2)
                                if gen != musicGenre4.last {
                                    Spacer()
                                }
                            }
                        }
                        .padding(.top, 36)
                        HStack(spacing: 0) {
                            ForEach(musicGenre5, id: \.self) { gen in
                                optionGenre(title: gen, genre1: $genre1, genre2: $genre2)
                                if gen != musicGenre5.last {
                                    Spacer()
                                }
                            }
                        }
                        .padding(.top, 15)
                        HStack(spacing: 0) {
                            ForEach(musicGenre6, id: \.self) { gen in
                                optionGenre(title: gen, genre1: $genre1, genre2: $genre2)
                                if gen != musicGenre6.last {
                                    Spacer()
                                }
                            }
                        }
                        .padding(.top, 15)
                        HStack(spacing: 0) {
                            ForEach(musicGenre0, id: \.self) { gen in
                                optionGenre(title: gen, genre1: $genre1, genre2: $genre2)
                                if gen != musicGenre6.last {
                                    Spacer()
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 15)
                    }
                    .padding(.top, 60)
                    
                    Text("Type a genre")
                        .font(
                            Font.custom("ModernEra-Medium", size: 16)
                                .weight(.bold)
                        )
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 48)
                    
                    
                    
                    // inputForm
                    
                    VStack(spacing: 0) {
                        HStack(spacing: 0) {
                            HStack(spacing: 0) {
                                CustomTextField3(text: $inputMusic, placeholder: "Type genre", onCommit: {
                                })
                                .frame(width: .infinity, height: 32, alignment: .trailing)
                                .padding(.bottom, 0)
                                
                                Button {
                                    if !inputMusic.isEmpty {
                                        isInput = true
                                        var judge = true
                                        for index in musicGenre0 {
                                            if index == inputMusic {
                                                judge = false
                                            }
                                        }
                                        if judge {
                                            musicGenre0.append(inputMusic)
                                        }
                                    }
                                } label: {
                                    Text("add +")
                                        .font(
                                            Font.custom("ModernEra-Medium", size: 14)
                                                .weight(.medium)
                                        )
                                        .padding(.vertical, 6)
                                        .frame(width: 61, height: 23, alignment: .center)
                                        .foregroundColor(inputMusic == "" ? Color(red: 0.93, green: 0.93, blue: 0.93) : .black)
                                        .background(Color.white)
                                        .cornerRadius(8)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 8)
                                                .inset(by: 0.5)
                                                .stroke(inputMusic == "" ? Color(red: 0.93, green: 0.93, blue: 0.93) : Color(red: 0.89, green: 0.17, blue: 0.3), lineWidth: Constants.StrokeBorder)
                                        )
                                        .shadow(color: .gray.opacity(0.1), radius: 2, x: 0, y: 2)
                                }
                                
                                .padding(.trailing, 5)
                            }
                            .frame(width: 255, alignment: .leading)
                            Spacer()
                        }
                        
                        HStack(spacing: 0) {
                            Rectangle()
                                .padding(.top, 0)
                                .background(.black)
                                .frame(width: 255, height: 1, alignment: .leading)
                            Spacer()
                        }
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 43)
                }
                
                Spacer()
                
                // Next
                NavigationLink {
                    RegisterC5()
                } label: {
                    Text("Next")
                        .font(
                            Font.custom("ModernEra-Medium", size: 16)
                        )
                        .bold()
                        .frame(width: 54, height: 22)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 12)
                        .foregroundColor(Color.white)
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
                        .cornerRadius(33)
                        .shadow(color: .black.opacity(0.1), radius: 1, x: 0, y: 2)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .simultaneousGesture(TapGesture().onEnded {
                    // 実行させたい処理を記載
                    updateProfile(segment: "music1", value: genre1)
                    updateProfile(segment: "music2", value: genre2)
                })
                
                Spacer()
            }
            //.padding(.top, 50)
            .padding(.leading, 20)
            .padding(.trailing, 20)
        }
        .frame(maxWidth: .infinity)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    RegisterC4()
}

struct optionGenre: View {
    var title: String
    @Binding var genre1: String
    @Binding var genre2: String
    
    var body: some View {
        if title != ""{
            HStack(alignment: .center, spacing: 8) {
                Button {
                    if genre1 == "" {
                        genre1 = title
                    } else if genre2 == "" {
                        genre2 = title
                    } else {
                        genre1 = genre2
                        genre2 = title
                    }
                    
                } label: {
                    Text(title)
                        .font(
                            Font.custom("ModernEra-Medium", size: 14)
                                .weight(.medium)
                        )
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                }
            }
            .padding(8)
            .background(genre1 == title || genre2 == title ? Constants.SelectedColour : Constants.BackgoroundGrey)
            .cornerRadius(10)
        }
    }
}
