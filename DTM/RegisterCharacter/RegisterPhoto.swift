//
//  RegisterPhoto.swift
//  DTM
//
//  Created by 水野裕介 on 2024/06/23.
//

import SwiftUI

struct RegisterPhoto: View {
    @State var inputReason3 = ""
    @State private var isInput = false
    @State var reason3 = ""
    @State private var isComplete = false
    @State private var isLater = false
    
    
    @State var selectedImage1: UIImage?
    @State var selectedImage2: UIImage?
    @State var selectedImage3: UIImage?
    @State var selectedImage4: UIImage?
    @State var selectedImage5: UIImage?
    @State var selectedImage6: UIImage?
    
    @State var isPickerPresented1 = false
    @State var isPickerPresented2 = false
    @State var isPickerPresented3 = false
    @State var isPickerPresented4 = false
    @State var isPickerPresented5 = false
    @State var isPickerPresented6 = false
    
    @State private var showingImagePicker1 = false
    @State private var showingPhotoLibraryPicker1 = false
    @State private var showingImagePicker2 = false
    @State private var showingPhotoLibraryPicker2 = false
    @State private var showingImagePicker3 = false
    @State private var showingPhotoLibraryPicker3 = false
    @State private var showingImagePicker4 = false
    @State private var showingPhotoLibraryPicker4 = false
    @State private var showingImagePicker5 = false
    @State private var showingPhotoLibraryPicker5 = false
    @State private var showingImagePicker6 = false
    @State private var showingPhotoLibraryPicker6 = false
    
    var now = 11
    public var body: some View {
        VStack(spacing: 0) {
            Button {
                isLater = true
                
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
            .fullScreenCover(isPresented: $isLater) {
                TopMainTab(selection: Binding<Int>.constant(3))
            }
            
            // Line
            VStack(spacing: 0) {
                ZStack {
                    HStack {
                        ForEach(1...11, id:\.self) { number in
                            Image(systemName: number <= now ? "circle.fill" : "circle")
                                .frame(width: 15, height: 15)
                                .foregroundColor(number <= now ? Color(red: 0.89, green: 0.17, blue: 0.3) : Color(red: 0.85, green: 0.85, blue: 0.85))
                            if number != 11 {
                                Spacer()
                            }
                        }
                    }
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
                }
            }
            .frame(width: 329, height: 15)
            .padding(.top, 48)
            .padding(.trailing, 32)
            .padding(.leading, 32)
            
            // Number
            VStack(alignment: .leading, spacing: 0) {
                
                VStack(alignment: .center, spacing: 0) {
                    Text("Add six photos of\nyourself")
                        .font(
                            Font.custom("New York", size: 28)
                                .weight(.bold)
                        )
                        .foregroundColor(.black)
                        .frame(width: 329, alignment: .topLeading)
                    
                    HStack(spacing: 0) {
                        Text("It’s important you are in them all")
                            .font(
                                Font.custom("ModernEra-Medium", size: 16)
                                    .weight(.bold)
                            )
                            .multilineTextAlignment(.center)
                            .foregroundColor(.black)
                        Image(systemName: "info.circle")
                            .padding(.leading, 10)
                    }
                    .frame(height: 10, alignment: .top)
                    .padding(.top, 30)
                }
                
                // photos
                VStack(spacing: 0) {
                    HStack (spacing: 0) {
                        // 1
                        ZStack {
                            if let image1 = selectedImage1 {
                                Image(uiImage: image1)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 90, height: 81)
                                    .cornerRadius(10)
                            } else {
                                Image("add-pic")
                                    .resizable()
                                    .padding(.leading, 6)
                                    .foregroundColor(.clear)
                                    .frame(width: 80, height: 72)
                                    .padding(.horizontal, 5)
                                    .padding(.vertical, 4.5)
                                    .cornerRadius(10)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .inset(by: 0.5)
                                            .stroke(Color(red: 0.51, green: 0.51, blue: 0.51), lineWidth: 1)
                                    )
                            }
                            
                            Button(action: {
                                isPickerPresented1.toggle()
                            }) {
                                Rectangle()
                                    .foregroundColor(.white.opacity(0))
                                    .frame(width: 90, height: 81)
                                    .cornerRadius(8)
                            }
                            .actionSheet(isPresented: $isPickerPresented1) {
                                ActionSheet(title: Text("写真を選ぶ"), message: nil, buttons: [
                                    .default(Text("カメラ")) {
                                        showingImagePicker1 = true
                                    },
                                    .default(Text("フォトライブラリ")) {
                                        showingPhotoLibraryPicker1 = true
                                    },
                                    .cancel()
                                ])
                            }
                            .sheet(isPresented: $showingImagePicker1) {
                                ImagePicker(image: $selectedImage1, sourceType: .camera)
                            }
                            .sheet(isPresented: $showingPhotoLibraryPicker1) {
                                PhotoLibraryPicker(image: $selectedImage1)
                            }
                        }
                        Spacer()
                        // 2
                        ZStack {
                            if let image2 = selectedImage2 {
                                Image(uiImage: image2)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 90, height: 81)
                                    .cornerRadius(10)
                            } else {
                                Image("add-pic")
                                    .resizable()
                                    .padding(.leading, 6)
                                    .foregroundColor(.clear)
                                    .frame(width: 80, height: 72)
                                    .padding(.horizontal, 5)
                                    .padding(.vertical, 4.5)
                                    .cornerRadius(10)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .inset(by: 0.5)
                                            .stroke(Color(red: 0.51, green: 0.51, blue: 0.51), lineWidth: 1)
                                    )
                            }
                            
                            Button(action: {
                                isPickerPresented2.toggle()
                            }) {
                                Rectangle()
                                    .foregroundColor(.white.opacity(0))
                                    .frame(width: 90, height: 81)
                                    .cornerRadius(8)
                            }
                            .actionSheet(isPresented: $isPickerPresented2) {
                                ActionSheet(title: Text("写真を選ぶ"), message: nil, buttons: [
                                    .default(Text("カメラ")) {
                                        if selectedImage1 == nil {
                                            showingImagePicker1 = true
                                        } else {
                                            showingImagePicker2 = true
                                        }
                                    },
                                    .default(Text("フォトライブラリ")) {
                                        if selectedImage1 == nil {
                                            showingPhotoLibraryPicker1 = true
                                        } else {
                                            showingPhotoLibraryPicker2 = true
                                        }
                                    },
                                    .cancel()
                                ])
                            }
                            .sheet(isPresented: $showingImagePicker2) {
                                ImagePicker(image: $selectedImage2, sourceType: .camera)
                            }
                            .sheet(isPresented: $showingPhotoLibraryPicker2) {
                                PhotoLibraryPicker(image: $selectedImage2)
                            }
                        }
                        Spacer()
                        // 3
                        ZStack {
                            if let image3 = selectedImage3 {
                                Image(uiImage: image3)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 90, height: 81)
                                    .cornerRadius(10)
                            } else {
                                Image("add-pic")
                                    .resizable()
                                    .padding(.leading, 6)
                                    .foregroundColor(.clear)
                                    .frame(width: 80, height: 72)
                                    .padding(.horizontal, 5)
                                    .padding(.vertical, 4.5)
                                    .cornerRadius(10)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .inset(by: 0.5)
                                            .stroke(Color(red: 0.51, green: 0.51, blue: 0.51), lineWidth: 1)
                                    )
                            }
                            
                            Button(action: {
                                isPickerPresented3.toggle()
                            }) {
                                Rectangle()
                                    .foregroundColor(.white.opacity(0))
                                    .frame(width: 90, height: 81)
                                    .cornerRadius(8)
                            }
                            .actionSheet(isPresented: $isPickerPresented3) {
                                ActionSheet(title: Text("写真を選ぶ"), message: nil, buttons: [
                                    .default(Text("カメラ")) {
                                        if selectedImage1 == nil {
                                            showingImagePicker1 = true
                                        } else if selectedImage2 == nil {
                                            showingImagePicker2 = true
                                        } else {
                                            showingImagePicker3 = true
                                        }
                                    },
                                    .default(Text("フォトライブラリ")) {
                                        if selectedImage1 == nil {
                                            showingPhotoLibraryPicker1 = true
                                        } else if selectedImage2 == nil {
                                            showingPhotoLibraryPicker2 = true
                                        } else {
                                            showingPhotoLibraryPicker3 = true
                                        }
                                    },
                                    .cancel()
                                ])
                            }
                            .sheet(isPresented: $showingImagePicker3) {
                                ImagePicker(image: $selectedImage3, sourceType: .camera)
                            }
                            .sheet(isPresented: $showingPhotoLibraryPicker3) {
                                PhotoLibraryPicker(image: $selectedImage3)
                            }
                        }
                    }
                    .padding(.top, 10)
                    .padding(.bottom, 15)
                    
                    HStack {
                        // 1
                        ZStack {
                            if let image4 = selectedImage4 {
                                Image(uiImage: image4)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 90, height: 81)
                                    .cornerRadius(10)
                            } else {
                                Image("add-pic")
                                    .resizable()
                                    .padding(.leading, 6)
                                    .foregroundColor(.clear)
                                    .frame(width: 80, height: 72)
                                    .padding(.horizontal, 5)
                                    .padding(.vertical, 4.5)
                                    .cornerRadius(10)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .inset(by: 0.5)
                                            .stroke(Color(red: 0.51, green: 0.51, blue: 0.51), lineWidth: 1)
                                    )
                            }
                            
                            Button(action: {
                                isPickerPresented4.toggle()
                            }) {
                                Rectangle()
                                    .foregroundColor(.white.opacity(0))
                                    .frame(width: 90, height: 81)
                                    .cornerRadius(8)
                            }
                            .actionSheet(isPresented: $isPickerPresented4) {
                                ActionSheet(title: Text("写真を選ぶ"), message: nil, buttons: [
                                    .default(Text("カメラ")) {
                                        if selectedImage1 == nil {
                                            showingImagePicker1 = true
                                        } else if selectedImage2 == nil {
                                            showingImagePicker2 = true
                                        } else if selectedImage3 == nil {
                                            showingImagePicker3 = true
                                        } else {
                                            showingImagePicker4 = true
                                        }
                                    },
                                    .default(Text("フォトライブラリ")) {
                                        if selectedImage1 == nil {
                                            showingPhotoLibraryPicker1 = true
                                        } else if selectedImage2 == nil {
                                            showingPhotoLibraryPicker2 = true
                                        } else if selectedImage3 == nil {
                                            showingPhotoLibraryPicker3 = true
                                        } else {
                                            showingPhotoLibraryPicker4 = true
                                        }
                                    },
                                    .cancel()
                                ])
                            }
                            .sheet(isPresented: $showingImagePicker4) {
                                ImagePicker(image: $selectedImage4, sourceType: .camera)
                            }
                            .sheet(isPresented: $showingPhotoLibraryPicker4) {
                                PhotoLibraryPicker(image: $selectedImage4)
                            }
                        }
                        Spacer()
                        // 2
                        ZStack {
                            if let image5 = selectedImage5 {
                                Image(uiImage: image5)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 90, height: 81)
                                    .cornerRadius(10)
                            } else {
                                Image("add-pic")
                                    .resizable()
                                    .padding(.leading, 6)
                                    .foregroundColor(.clear)
                                    .frame(width: 80, height: 72)
                                    .padding(.horizontal, 5)
                                    .padding(.vertical, 4.5)
                                    .cornerRadius(10)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .inset(by: 0.5)
                                            .stroke(Color(red: 0.51, green: 0.51, blue: 0.51), lineWidth: 1)
                                    )
                            }
                            
                            Button(action: {
                                isPickerPresented5.toggle()
                            }) {
                                Rectangle()
                                    .foregroundColor(.white.opacity(0))
                                    .frame(width: 90, height: 81)
                                    .cornerRadius(8)
                            }
                            .actionSheet(isPresented: $isPickerPresented5) {
                                ActionSheet(title: Text("写真を選ぶ"), message: nil, buttons: [
                                    .default(Text("カメラ")) {
                                        if selectedImage1 == nil {
                                            showingImagePicker1 = true
                                        } else if selectedImage2 == nil {
                                            showingImagePicker2 = true
                                        } else if selectedImage3 == nil {
                                            showingImagePicker3 = true
                                        } else if selectedImage4 == nil {
                                            showingImagePicker4 = true
                                        } else {
                                            showingImagePicker5 = true
                                        }
                                    },
                                    .default(Text("フォトライブラリ")) {
                                        if selectedImage1 == nil {
                                            showingPhotoLibraryPicker1 = true
                                        } else if selectedImage2 == nil {
                                            showingPhotoLibraryPicker2 = true
                                        } else if selectedImage3 == nil {
                                            showingPhotoLibraryPicker3 = true
                                        } else if selectedImage4 == nil {
                                            showingPhotoLibraryPicker4 = true
                                        } else {
                                            showingPhotoLibraryPicker5 = true
                                        }
                                    },
                                    .cancel()
                                ])
                            }
                            .sheet(isPresented: $showingImagePicker5) {
                                ImagePicker(image: $selectedImage5, sourceType: .camera)
                            }
                            .sheet(isPresented: $showingPhotoLibraryPicker5) {
                                PhotoLibraryPicker(image: $selectedImage5)
                            }
                        }
                        Spacer()
                        // 3
                        ZStack {
                            if let image6 = selectedImage6 {
                                Image(uiImage: image6)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 90, height: 81)
                                    .cornerRadius(10)
                            } else {
                                Image("add-pic")
                                    .resizable()
                                    .padding(.leading, 6)
                                    .foregroundColor(.clear)
                                    .frame(width: 80, height: 72)
                                    .padding(.horizontal, 5)
                                    .padding(.vertical, 4.5)
                                    .cornerRadius(10)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .inset(by: 0.5)
                                            .stroke(Color(red: 0.51, green: 0.51, blue: 0.51), lineWidth: 1)
                                    )
                            }
                            
                            Button(action: {
                                isPickerPresented6.toggle()
                            }) {
                                Rectangle()
                                    .foregroundColor(.white.opacity(0))
                                    .frame(width: 90, height: 81)
                                    .cornerRadius(8)
                            }
                            .actionSheet(isPresented: $isPickerPresented6) {
                                ActionSheet(title: Text("写真を選ぶ"), message: nil, buttons: [
                                    .default(Text("カメラ")) {
                                        if selectedImage1 == nil {
                                            showingImagePicker1 = true
                                        } else if selectedImage2 == nil {
                                            showingImagePicker2 = true
                                        } else if selectedImage3 == nil {
                                            showingImagePicker3 = true
                                        } else if selectedImage4 == nil {
                                            showingImagePicker4 = true
                                        } else if selectedImage5 == nil {
                                            showingImagePicker5 = true
                                        } else {
                                            showingImagePicker6 = true
                                        }
                                    },
                                    .default(Text("フォトライブラリ")) {
                                        if selectedImage1 == nil {
                                            showingPhotoLibraryPicker1 = true
                                        } else if selectedImage2 == nil {
                                            showingPhotoLibraryPicker2 = true
                                        } else if selectedImage3 == nil {
                                            showingPhotoLibraryPicker3 = true
                                        } else if selectedImage4 == nil {
                                            showingPhotoLibraryPicker4 = true
                                        } else if selectedImage5 == nil {
                                            showingPhotoLibraryPicker5 = true
                                        } else {
                                            showingPhotoLibraryPicker6 = true
                                        }
                                    },
                                    .cancel()
                                ])
                            }
                            .sheet(isPresented: $showingImagePicker6) {
                                ImagePicker(image: $selectedImage6, sourceType: .camera)
                            }
                            .sheet(isPresented: $showingPhotoLibraryPicker6) {
                                PhotoLibraryPicker(image: $selectedImage6)
                            }
                        }
                    }
                }
                .padding(.top, 58)
                .padding(.bottom, 84)
                // Next
                Button {
                    isComplete = true
                } label: {
                    Text("Create profile")
                        .font(
                            Font.custom("ModernEra-Medium", size: 16)
                        )
                        .bold()
                        .frame(width: 147, height: 22)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 10)
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
                        .cornerRadius(27)
                        .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .simultaneousGesture(TapGesture().onEnded {
                    // 実行させたい処理を記載
                    if let image1 = selectedImage1 {
                        uploadImage(image: image1, name: userName, number: "1") { url in
                            if let url = url {
                                // saveImageUrlToFirestore(url: url)
                                updateProfile(segment: "profileImageURL1", value: url.absoluteString)
                            }
                        }
                    }
                    if let image2 = selectedImage2 {
                        uploadImage(image: image2, name: userName, number: "2") { url in
                            if let url = url {
                                // saveImageUrlToFirestore(url: url)
                                updateProfile(segment: "profileImageURL2", value: url.absoluteString)
                            }
                        }
                    }
                    if let image3 = selectedImage3 {
                        uploadImage(image: image3, name: userName, number: "3") { url in
                            if let url = url {
                                // saveImageUrlToFirestore(url: url)
                                updateProfile(segment: "profileImageURL3", value: url.absoluteString)
                            }
                        }
                    }
                    if let image4 = selectedImage4 {
                        uploadImage(image: image4, name: userName, number: "4") { url in
                            if let url = url {
                                // saveImageUrlToFirestore(url: url)
                                updateProfile(segment: "profileImageURL4", value: url.absoluteString)
                            }
                        }
                    }
                    if let image5 = selectedImage5 {
                        uploadImage(image: image5, name: userName, number: "5") { url in
                            if let url = url {
                                // saveImageUrlToFirestore(url: url)
                                updateProfile(segment: "profileImageURL5", value: url.absoluteString)
                            }
                        }
                    }
                    if let image6 = selectedImage6 {
                        uploadImage(image: image6, name: userName, number: "6") { url in
                            if let url = url {
                                // saveImageUrlToFirestore(url: url)
                                updateProfile(segment: "profileImageURL6", value: url.absoluteString)
                            }
                        }
                    }
                    
                })
                .fullScreenCover(isPresented: $isComplete) {
                    TopMainTab(selection: Binding<Int>.constant(3))
                }
                
                Spacer()
            }
            .padding(.top, 50)
            .padding(.leading, 30)
            .padding(.trailing, 30)
        }
        .frame(maxWidth: .infinity)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    RegisterPhoto()
}

