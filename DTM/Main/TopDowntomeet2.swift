//
//  TopDowntomeet2.swift
//  DTM
//
//  Created by 水野裕介 on 2024/07/12.
//

import SwiftUI

//personFix

struct DetailView: View {
    @Binding var showDetailView: Bool
    @Binding var index: Int
    var namespace: Namespace.ID
    
    @State private var currentIndex = 1
    @State var sixImage: [UIImage] = [UIImage(named: "a")!,UIImage(named: "a")!,UIImage(named: "a")!,UIImage(named: "a")!,UIImage(named: "a")!,UIImage(named: "a")!]
    
    @State private var select = 0
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Button {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                        showDetailView = false
                    }
                } label: {
                    HStack(spacing: 0){
                        Image(systemName: "chevron.left")
                            .font(
                                Font.custom("SF Pro", size: 17)
                                    .weight(.bold)
                            )
                            .frame(width: 17, height: 12)
                        Text("Back")
                            .font(Font.custom("SF Pro", size: 17))
                    }
                    .foregroundColor(Constants.InfoGrey)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 8)
                .padding(.top, 46)
                
                Text(personFix[index].name)
                    .font(
                        Font.custom("Modern Era", size: 24)
                            .weight(.bold)
                    )
                    .foregroundColor(.black)
                    .padding(.top, 52)
            }
            .ignoresSafeArea(.all)
            
            VStack(spacing: 0) {
                Rectangle()
                    .foregroundColor(.clear)
                    .background(
                        Image(uiImage: sixImage[select])
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .matchedGeometryEffect(id: "Pic", in: namespace)
                            .frame(width: 360, height: 360)
                            .clipped()
                    )
                    .cornerRadius(10)
                    .frame(width: 360, height: 360)
                    .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                    .padding(.top, 16)
                
                ScrollView(.horizontal,showsIndicators: false) {
                    HStack(spacing: 0) {
                        ForEach(0..<6, id: \.self) { indexV in
                            if sixImage[indexV] != UIImage(named: "a") {
                                Button{
                                    select = indexV
                                } label:{
                                    Rectangle()
                                        .foregroundColor(.clear)
                                        .background(
                                            Image(uiImage: sixImage[indexV])
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 75, height: 72)
                                                .clipped()
                                        )
                                        .cornerRadius(20)
                                        .frame(width: 75, height: 72)
                                        .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                                        .padding(.trailing, index == 6 ? 0 : 30)
                                }
                            } else {
                                VStack(spacing: 0) {
                                    
                                }
                                .frame(height: 72)
                            }
                        }
                    }
                }
                .padding(.top, 16)
            }
            .padding(.horizontal, 20)
            .task {
                if let url = personFix[index].profileImageURL1 {
                    print(url)
                    loadImage(urlString: url) { image in
                        if let image = image {
                            sixImage[0] = image
                        } else {
                            print("didnt get image")
                        }
                    }
                } else {
                    print("didnt get url")
                }
                if let url = personFix[index].profileImageURL2 {
                    print(url)
                    loadImage(urlString: url) { image in
                        if let image = image {
                            sixImage[1] = image
                        } else {
                            print("didnt get image")
                        }
                    }
                } else {
                    print("didnt get url")
                }
                if let url = personFix[index].profileImageURL3 {
                    print(url)
                    loadImage(urlString: url) { image in
                        if let image = image {
                            sixImage[2] = image
                        } else {
                            print("didnt get image")
                        }
                    }
                } else {
                    print("didnt get url")
                }
                if let url = personFix[index].profileImageURL4 {
                    print(url)
                    loadImage(urlString: url) { image in
                        if let image = image {
                            sixImage[3] = image
                        } else {
                            print("didnt get image")
                        }
                    }
                } else {
                    print("didnt get url")
                }
                if let url = personFix[index].profileImageURL5 {
                    print(url)
                    loadImage(urlString: url) { image in
                        if let image = image {
                            sixImage[4] = image
                        } else {
                            print("didnt get image")
                        }
                    }
                } else {
                    print("didnt get url")
                }
                if let url = personFix[index].profileImageURL6 {
                    print(url)
                    loadImage(urlString: url) { image in
                        if let image = image {
                            sixImage[5] = image
                        } else {
                            print("didnt get image")
                        }
                    }
                } else {
                    print("didnt get url")
                }
                
            }
            
            Spacer()
            
            VStack(spacing: 0) {
                if currentIndex == 1 {
                    VStack(spacing: 0) {
                        HStack(spacing: 0) {
                            Text("About")
                                .font(
                                    Font.custom("Modern Era", size: 16)
                                        .weight(.bold)
                                )
                                .foregroundColor(.black)
                                .frame(alignment: .topLeading)
                                .padding(.top, 16)
                            Spacer()
                        }
                        Spacer()
                        
                        HStack(spacing: 0) {
                            Text("🎓 \(personFix[index].year ?? "none")")
                                .font(
                                    Font.custom("Modern Era", size: 16)
                                        .weight(.medium)
                                )
                                .foregroundColor(.black)
                                .frame(alignment: .leading)
                                .padding(.leading, 8)
                            Spacer()
                            Text(personFix[index].faculty ?? "none")
                                .font(
                                    Font.custom("Modern Era", size: 16)
                                        .weight(.bold)
                                )
                                .foregroundColor(.black)
                                .frame(alignment: .topLeading)
                            Spacer()
                            Text(personFix[index].hometown ?? "none")
                                .font(
                                    Font.custom("Modern Era", size: 16)
                                        .weight(.medium)
                                )
                                .foregroundColor(Constants.ContentBlack)
                                .frame(alignment: .leading)
                                .padding(.trailing, 8)
                        }
                        Spacer()
                        
                        HStack(spacing: 0) {
                            Text(personFix[index].height == nil ? "📏 none" : "📏 \(personFix[index].height ?? "none")cm")
                                .font(
                                    Font.custom("Modern Era", size: 16)
                                        .weight(.medium)
                                )
                                .foregroundColor(Constants.ContentBlack)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 8)
                                .background(Color(red: 0.96, green: 0.96, blue: 0.96))
                                .cornerRadius(10)
                            Spacer()
                            Text("\(personFix[index].oftenGo ?? "none")")
                                .font(
                                    Font.custom("Modern Era", size: 16)
                                        .weight(.medium)
                                )
                                .foregroundColor(Constants.ContentBlack)
                                .frame(alignment: .leading)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 8)
                                .background(Color(red: 0.96, green: 0.96, blue: 0.96))
                                .cornerRadius(10)
                            Spacer()
                            Text("🏉 \(personFix[index].hobby1 ?? "none")")
                                .font(
                                    Font.custom("Modern Era", size: 16)
                                        .weight(.medium)
                                )
                                .foregroundColor(Constants.ContentBlack)
                                .frame(alignment: .leading)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 8)
                                .background(Color(red: 0.96, green: 0.96, blue: 0.96))
                                .cornerRadius(10)
                        }
                        Spacer()
                        
                        HStack(spacing: 0) {
                            Text(personFix[index].music1 == nil ? "🎧 None" : "\(personFix[index].music1 ?? "none"), \(personFix[index].music2 ?? "")")
                                .font(
                                    Font.custom("Modern Era", size: 16)
                                        .weight(.medium)
                                )
                                .foregroundColor(Constants.ContentBlack)
                                .frame(alignment: .leading)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 8)
                                .background(Color(red: 0.96, green: 0.96, blue: 0.96))
                                .cornerRadius(10)
                            Spacer()
                            
                            Text("🎹 \(personFix[index].music2 ?? "none")")
                                .font(
                                    Font.custom("Modern Era", size: 16)
                                        .weight(.medium)
                                )
                                .foregroundColor(Constants.ContentBlack)
                                .frame(alignment: .leading)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 8)
                                .background(Color(red: 0.96, green: 0.96, blue: 0.96))
                                .cornerRadius(10)
                        }
                        Spacer()
                        HStack(spacing: 0) {
                            Text("Prompt 1")
                                .frame(width: 56, alignment: .leading)
                            Image(systemName: "chevron.down")
                        }
                        .font(Font.custom("Modern Era", size: 14))
                        .foregroundColor(Constants.InfoGrey)
                        
                        Spacer()
                    }
                    .padding(.horizontal, 16)
                } else if currentIndex == 2 {
                    VStack(spacing: 0) {
                        HStack(spacing: 0) {
                            Text(personFix[index].prompt1Select == nil ? "no Prompt selected" : personFix[index].prompt1Select ?? "")
                                .font(
                                    Font.custom("Modern Era", size: 14)
                                        .weight(.bold)
                                )
                                .foregroundColor(.black)
                                .frame(width: 267, alignment: .topLeading)
                                .padding(.top, 24)
                            Spacer()
                        }
                        Text(personFix[index].prompt1 ?? "none")
                            .font(
                                Font.custom("Test Tiempos Headline", size: 24)
                                    .weight(.bold)
                            )
                            .multilineTextAlignment(.center)
                            .foregroundColor(.black)
                            .frame(width: 358, height: 53, alignment: .top)
                            .padding(.top, 36)
                        Spacer()
                        HStack(spacing: 0) {
                            Text("Prompt 2")
                                .frame(width: 60, alignment: .leading)
                            Image(systemName: "chevron.down")
                        }
                        .font(Font.custom("Modern Era", size: 14))
                        .foregroundColor(Constants.InfoGrey)
                        .padding(.bottom, 28)
                    }
                    .padding(.horizontal, 16)
                    
                } else if currentIndex == 3 {
                    VStack(spacing: 0) {
                        HStack(spacing: 0) {
                            Text(personFix[index].prompt2Select == nil ? "no Prompt selected" : personFix[index].prompt2Select ?? "")
                                .font(
                                    Font.custom("Modern Era", size: 14)
                                        .weight(.bold)
                                )
                                .foregroundColor(.black)
                                .frame(width: 267, alignment: .topLeading)
                                .padding(.top, 24)
                            Spacer()
                        }
                        Text(personFix[index].prompt2 ?? "none")
                            .font(
                                Font.custom("Test Tiempos Headline", size: 24)
                                    .weight(.bold)
                            )
                            .multilineTextAlignment(.center)
                            .foregroundColor(.black)
                            .frame(width: 358, height: 53, alignment: .top)
                            .padding(.top, 36)
                        Spacer()
                        HStack(spacing: 0) {
                            Text("Prompt 3")
                                .frame(width: 60, alignment: .leading)
                            Image(systemName: "chevron.down")
                        }
                        .font(Font.custom("Modern Era", size: 14))
                        .foregroundColor(Constants.InfoGrey)
                        .padding(.bottom, 28)
                    }
                    .padding(.horizontal, 16)
                } else if currentIndex == 4 {
                    VStack(spacing: 0) {
                        HStack(spacing: 0) {
                            Text(personFix[index].prompt3Select == nil ? "no Prompt selected" : personFix[index].prompt3Select ?? "")
                                .font(
                                    Font.custom("Modern Era", size: 14)
                                        .weight(.bold)
                                )
                                .foregroundColor(.black)
                                .frame(width: 267, alignment: .topLeading)
                                .padding(.top, 24)
                            Spacer()
                        }
                        Text(personFix[index].prompt3 ?? "none")
                            .font(
                                Font.custom("Test Tiempos Headline", size: 24)
                                    .weight(.bold)
                            )
                            .multilineTextAlignment(.center)
                            .foregroundColor(.black)
                            .frame(width: 358, height: 53, alignment: .top)
                            .padding(.top, 36)
                        Spacer()
                    }
                    .padding(.horizontal, 16)
                }
            }
            .frame(width: 393, height: 261)
            .background(Color.white)
            .cornerRadius(30)
            .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
            .overlay(
                RoundedRectangle(cornerRadius: 30)
                    .inset(by: 0.5)
                    .stroke(Constants.PlaceholderGrey, lineWidth: Constants.StrokeBorder)
            )
            .padding(.top, 12)
            .gesture(
                DragGesture()
                    .onEnded { value in
                        if value.translation.height < 0 {
                            withAnimation {
                                if currentIndex < 4 {
                                    currentIndex = (currentIndex + 1)
                                }
                            }
                        } else if value.translation.height > 0 {
                            withAnimation {
                                if currentIndex > 1 {
                                    currentIndex = (currentIndex - 1)
                                }
                            }
                        }
                    }
            )
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        Group {
            DetailView(showDetailView: Binding<Bool>.constant(true), index: Binding<Int>.constant(0), namespace: namespace)
        }
    }
}
