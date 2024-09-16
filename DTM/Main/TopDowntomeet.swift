//
//  TopDowntomeet.swift
//  DTM
//
//  Created by 水野裕介 on 2024/07/12.
//

import SwiftUI
import UIKit
import Firebase

let cards = ["Test1", "Test2", "Test3", "Test4", "Test5"]
var personFix: [UserProfile] = [UserProfile(name: cards[0]),UserProfile(name: cards[1]),UserProfile(name: cards[2]),UserProfile(name: cards[3]),UserProfile(name: cards[4])]

struct TopDowntomeet: View {
    @State private var showDetailView = false
    @Namespace var namespace
    @State private var isFirstPresented = false
    @State private var cardIndex = 0
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    Button {
                        
                    } label: {
                        Text("Previous meet ups")
                            .font(
                                Font.custom("Modern Era", size: 14)
                                    .weight(.bold)
                            )
                            .foregroundColor(Constants.Secondary)
                            .frame(alignment: .topLeading)
                    }
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    
                    Button {
                        
                    } label: {
                        Image("search")
                            .frame(width: 20, height: 20)
                            .foregroundColor(.black)
                    }
                    .padding(.leading, 172)
                }
                .padding(.top, 22)
                .padding(.horizontal, 37)
                
                Text("Down To Meet")
                    .font(
                        Font.custom("Modern Era", size: 24)
                            .weight(.bold)
                    )
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    .padding(.top, 12)
                    .padding(.leading, 37)
                
                CardSwipeView(showDetailView: $showDetailView, namespace: namespace, cardIndex: $cardIndex)
                    .padding(.top, 44)
                    .padding(.bottom, 0)
                
                HStack(alignment: .center, spacing: 10) {
                    Button {
                        withAnimation(.spring(response: 0.6, dampingFraction: 0.6)) {
                            isFirstPresented = true
                        }
                    } label: {
                        Text("Meet Up")
                            .font(
                                Font.custom("Modern Era", size: 18)
                                    .weight(.bold)
                            )
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                    }
                }
                .padding(.horizontal, 39)
                .padding(.vertical, 13)
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
                .shadow(color: .black.opacity(0.15), radius: 0, x: 0, y: 4)
                .padding(.top, 48)
                
                Spacer()
                
                Divider()
                    .padding(.horizontal, 15)
                    .padding(.bottom, 8)
            }
            
            .background(Color(red: 1, green: 0.99, blue: 0.99))
            
            if isFirstPresented {
                PopupView(isPresented: $isFirstPresented, index: $cardIndex)
            }
        }
    }
}


struct CardSwipeView: View {
    @State private var currentIndex: Int = 0
    @State private var dragOffset: CGFloat = 0
    @State var person = [UserProfile(name: cards[0]),UserProfile(name: cards[1]),UserProfile(name: cards[2]),UserProfile(name: cards[3]),UserProfile(name: cards[4])]
     
    @State var isView = false
    @State var tIndex = 0
    
    @Binding var showDetailView : Bool
    
    var namespace: Namespace.ID
    
    @Binding var cardIndex: Int
    
    @State private var img: [UIImage] = [UIImage(named: "testImage")!,UIImage(named: "testImage")!,UIImage(named: "testImage")!,UIImage(named: "testImage")!,UIImage(named: "testImage")!]
    
    
    var body: some View {
        GeometryReader { geometry in
            let cardWidth = CGFloat(320)
            let cardHeight = CGFloat(450)
            let spacing: CGFloat = 0
            
            if isView {
                HStack(spacing: 0) {
                    ForEach(0..<cards.count) { index in
                        Rectangle()
                            .matchedGeometryEffect(id: "Pic", in: namespace)
                            .foregroundColor(.clear)
                            .background(.black.opacity(0.2))
                            .background(
                                Image(uiImage: img[index])
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 320, height: 450)
                                    .clipped()
                            )
                            .cornerRadius(10)
                            .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 10)
                            .frame(width: index == currentIndex ? cardWidth : cardWidth*0.8, height: index == currentIndex ? cardHeight : cardHeight*0.8)
                            .scaleEffect(index == currentIndex ? 1.0 : 0.8)
                            .animation(.spring(), value: dragOffset)
                            .onTapGesture {
                                tIndex = index
                                var transaction = Transaction()
                                transaction.disablesAnimations = true
                                withTransaction(transaction) {
                                    // ここで画面遷移を発生させる
                                    withAnimation(.spring(response: 0.1, dampingFraction: 0.3)) {
                                        showDetailView = true
                                    }
                                }
                            }
                            .fullScreenCover(isPresented: $showDetailView) {
                                DetailView(showDetailView: $showDetailView, index: $tIndex, namespace: namespace)
                            }
                            .onChange(of: currentIndex) {
                                cardIndex = currentIndex
                            }
                    }
                }
                .offset(x: -CGFloat(currentIndex) * (cardWidth*0.8 + spacing) + dragOffset + (geometry.size.width - cardWidth) / 2)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            dragOffset = value.translation.width
                        }
                        .onEnded { value in
                            let threshold: CGFloat = 50
                            if value.translation.width < -threshold {
                                if currentIndex < cards.count - 1 {
                                    currentIndex += 1
                                }
                            } else if value.translation.width > threshold {
                                if currentIndex > 0 {
                                    currentIndex -= 1
                                }
                            }
                            dragOffset = 0
                        }
                )
                .animation(.spring(), value: dragOffset)
            } else {
                Spacer()
                Text("Matching somebody ...")
                    .font(
                        Font.custom("Modern Era", size: 18)
                            .weight(.medium)
                    )
                    .foregroundColor(.black)
                    .frame(height: 450)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 12)
                Spacer()
            }
        }
        .frame(height: 450)
        .task {
            print("start")
            Task {
                do {
                    for index in 0..<5 {
                        try await fetchAllState(name: person[index].name, saveData: $person[index])
                    }
                } catch {
                    print("Failed to fetch data: \(error)")
                }
            }
        }
        .onChange(of: person[4].number) {
            print("fire")
            for index in 0..<5 {
                if let url = person[index].profileImageURL1 {
                    print(url)
                    loadImage(urlString: url) { image in
                        if let image = image {
                            img[index] = image
                        } else {
                            print("didnt get image")
                        }
                    }
                } else {
                    print("didnt get url")
                }
            }
        }
        
        .onChange(of: img[4]) {
            isView = true
            personFix = person
        }
    }
}

#Preview {
    TopDowntomeet()
    // DateTime(isTime: Binding<Bool>.constant(true))
}
