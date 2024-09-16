import SwiftUI
import MapKit

struct TopYourMeetUpsView: View {
    @State private var isRevise = false
    
    @State private var isSearch = false
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Spacer()
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
            
            HStack(spacing: 0) {
                Text("Meet ups")
                    .font(
                        Font.custom("Modern Era", size: 28)
                            .weight(.bold)
                    )
                    .foregroundColor(.black)
                    .frame(width: 122, height: 20, alignment: .leading)
                    .padding(.top, 12)
                    .padding(.leading, 20)
                Spacer()
            }
            
            Text("Any meet ups will appear here")
                .font(
                    Font.custom("Modern Era", size: 18)
                        .weight(.bold)
                )
                .multilineTextAlignment(.center)
                .foregroundColor(.black)
                .frame(width: 263, height: 16, alignment: .top)
                .padding(.top, 168)
            
            Button {
                // search profiles
                isSearch = true
            }label: {
                HStack(alignment: .center, spacing: 10) {
                    Text("Search profiles")
                        .font(
                            Font.custom("Modern Era", size: 18)
                                .weight(.bold)
                        )
                        .multilineTextAlignment(.center)
                        .foregroundColor(Constants.GraysWhite)
                        .frame(width: 147, alignment: .top)
                }
                    .padding(10)
                    .frame(width: 177, height: 48, alignment: .center)
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
                    .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                    .padding(.top, 158)
            }
            .fullScreenCover(isPresented: $isSearch) {
                serarchProfileView()
            }
            
            Spacer()
            
            Divider()
                .padding(.bottom, 8)
        }
    }
}

#Preview {
    TopYourMeetUpsView()
}

let profileInfo = ["Profile name", "Sex", "Orientation", "Year", "Height", "Nationality", "Faculty", "Hometown", "Social Nights", "Hobbies", "Music Taste"]

struct ProfileReviseView: View {
    @Environment(\.dismiss) var dismiss
    @State private var img: [UIImage] = Array(repeating: UIImage(), count: 6)
    
    @State var profileContent: [String] = [
        userProfile.name,
        userProfile.gender ?? "",
        userProfile.sexualOrientation ?? "",
        userProfile.year ?? "",
        userProfile.height ?? "",
        userProfile.nationality1 ?? "",
        userProfile.faculty ?? "",
        userProfile.hometown ?? "",
        userProfile.oftenGo ?? "",
        "\(userProfile.music1 ?? ""), \(userProfile.music2 ?? "")",
        "\(userProfile.hobby1 ?? ""), \(userProfile.hobby2 ?? "")"
    ]

    @State private var selectedIndex: Int? = nil
    @State var onTap = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    Spacer()
                    Button {
                        dismiss()
                    } label: {
                        Image("Close button")
                            .frame(width: 11.8, height: 11.8)
                    }
                    .frame(alignment: .bottomTrailing)
                    .padding(.top, 12)
                    .padding(.trailing, 20)
                }
                Text(userProfile.name)
                    .font(
                        Font.custom("Modern Era", size: 24)
                            .weight(.bold)
                    )
                    .multilineTextAlignment(.center)
                    .foregroundColor(.black)
                    .foregroundColor(Constants.ContentGrey)
                    .frame(width: 393, height: 24.76923, alignment: .top)
                Text(userProfile.name+"@mail.mcgill.ca")
                    .font(Font.custom("Modern Era", size: 14))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Constants.ContentGrey)
                    .frame(width: 393, height: 14.15385, alignment: .top)
                    .padding(.top, 12)
                HStack(spacing: 0) {
                    Text("Photos")
                        .font(
                            Font.custom("Modern Era", size: 16)
                                .weight(.medium)
                        )
                        .foregroundColor(Constants.ContentGrey)
                        .frame(width: 80, alignment: .topLeading)
                        .padding(.top, 12)
                        .padding(.leading, 18)
                    Spacer()
                }
                
                HStack(spacing: 0) {
                    ZStack {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 110, height: 118)
                            .background(
                                Image(uiImage: img[0])
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 110, height: 118)
                                    .clipped()
                            )
                            .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                    }
                        .frame(width: 109.69613, height: 100)
                        .background(Constants.GraysWhite)
                        .cornerRadius(10)
                        .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                        .padding(.leading, 18)
                        .onAppear {
                            if let url = userProfile.profileImageURL1 {
                                loadImage(urlString: url) { image in
                                    if let image = image {
                                        img[0] = image
                                    } else {
                                        print("didint get image")
                                    }
                                }
                            } else {
                                print("didint get url")
                            }
                        }
                    Spacer()
                    ZStack {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 110, height: 118)
                            .background(
                                Image(uiImage: img[1])
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 110, height: 118)
                                    .clipped()
                            )
                            .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                    }
                    .frame(width: 109.69613, height: 100)
                    .background(Constants.GraysWhite)
                    .cornerRadius(10)
                    .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                    .onAppear {
                        if let url = userProfile.profileImageURL2 {
                            loadImage(urlString: url) { image in
                                if let image = image {
                                    img[1] = image
                                } else {
                                    print("didint get image")
                                }
                            }
                        } else {
                            print("didint get url")
                        }
                    }
                    Spacer()
                    ZStack {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 110, height: 118)
                            .background(
                                Image(uiImage: img[2])
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 110, height: 118)
                                    .clipped()
                            )
                            .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                    }
                    .frame(width: 109.69613, height: 100)
                    .background(Constants.GraysWhite)
                    .cornerRadius(10)
                    .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                    .padding(.trailing, 18)
                    .onAppear {
                        if let url = userProfile.profileImageURL3 {
                            loadImage(urlString: url) { image in
                                if let image = image {
                                    img[2] = image
                                } else {
                                    print("didint get image")
                                }
                            }
                        } else {
                            print("didint get url")
                        }
                    }
                }
                .padding(.top, 10)
                
                HStack(spacing: 0) {
                    ZStack {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 110, height: 118)
                            .background(
                                Image(uiImage: img[3])
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 110, height: 118)
                                    .clipped()
                            )
                            .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                    }
                    .frame(width: 109.69613, height: 100)
                    .background(Constants.GraysWhite)
                    .cornerRadius(10)
                    .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                    .padding(.leading, 18)
                    .onAppear {
                        if let url = userProfile.profileImageURL4 {
                            loadImage(urlString: url) { image in
                                if let image = image {
                                    img[3] = image
                                } else {
                                    print("didint get image")
                                }
                            }
                        } else {
                            print("didint get url")
                        }
                    }
                    Spacer()
                    ZStack {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 110, height: 118)
                            .background(
                                Image(uiImage: img[4])
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 110, height: 118)
                                    .clipped()
                            )
                            .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                    }
                    .frame(width: 109.69613, height: 100)
                    .background(Constants.GraysWhite)
                    .cornerRadius(10)
                    .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                    .onAppear {
                        if let url = userProfile.profileImageURL5 {
                            loadImage(urlString: url) { image in
                                if let image = image {
                                    img[4] = image
                                } else {
                                    print("didint get image")
                                }
                            }
                        } else {
                            print("didint get url")
                        }
                    }
                    Spacer()
                    ZStack {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 110, height: 118)
                            .background(
                                Image(uiImage: img[5])
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 110, height: 118)
                                    .clipped()
                            )
                            .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                    }
                    .frame(width: 109.69613, height: 100)
                    .background(Constants.GraysWhite)
                    .cornerRadius(10)
                    .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                    .padding(.trailing, 18)
                    .onAppear {
                        if let url = userProfile.profileImageURL6 {
                            loadImage(urlString: url) { image in
                                if let image = image {
                                    img[5] = image
                                } else {
                                    print("didint get image")
                                }
                            }
                        } else {
                            print("didint get url")
                        }
                    }
                }
                .padding(.top, 28)
                
                Text("Drag to reorder, tap to change")
                    .font(Font.custom("Modern Era", size: 12))
                    .foregroundColor(Constants.InfoGrey)
                    .frame(width: 393, alignment: .topLeading)
                    .padding(.top, 20)
                    .padding(.leading, 18)
                
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 284.00177, height: 0.6)
                    .background(Constants.InfoGrey)
                    .padding(.top, 12)
                
                HStack(spacing: 0) {
                    Text("Prompts")
                        .font(
                            Font.custom("Modern Era", size: 16)
                                .weight(.medium)
                        )
                        .foregroundColor(Constants.ContentGrey)
                        .frame(width: 84, alignment: .topLeading)
                        .padding(.top, 18)
                        .padding(.leading, 18)
                    Spacer()
                }
                
                ZStack {
                    VStack(spacing: 0) {
                        Text(userProfile.prompt1Select ?? "No prompt selected")
                            .font(
                                Font.custom("Modern Era", size: 14)
                                    .weight(.bold)
                            )
                            .foregroundColor(.black)
                            .frame(width: 297, alignment: .topLeading)
                        Text(userProfile.prompt1 ?? "")
                            .font(Font.custom("Modern Era", size: 14))
                            .foregroundColor(Constants.ContentGrey)
                            .frame(width: 305, alignment: .topLeading)
                            .padding(.top, 5)
                    }
                    .padding(.horizontal, 12)
                }
                    .frame(width: 339, height: 84)
                    .cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .inset(by: 0.5)
                            .stroke(Constants.BorderGrey, lineWidth: Constants.StrokeBorder)
                    )
                    .padding(.top, 10)
                ZStack {
                    VStack(spacing: 0) {
                        Text(userProfile.prompt2Select ?? "No prompt selected")
                            .font(
                                Font.custom("Modern Era", size: 14)
                                    .weight(.bold)
                            )
                            .foregroundColor(.black)
                            .frame(width: 297, alignment: .topLeading)
                        Text(userProfile.prompt2 ?? "")
                            .font(Font.custom("Modern Era", size: 14))
                            .foregroundColor(Constants.ContentGrey)
                            .frame(width: 305, alignment: .topLeading)
                            .padding(.top, 5)
                    }
                    .padding(.horizontal, 12)
                }
                .frame(width: 339, height: 84)
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .inset(by: 0.5)
                        .stroke(Constants.BorderGrey, lineWidth: Constants.StrokeBorder)
                )
                .padding(.top, 12)
                ZStack {
                    VStack(spacing: 0) {
                        Text(userProfile.prompt3Select ?? "No prompt selected")
                            .font(
                                Font.custom("Modern Era", size: 14)
                                    .weight(.bold)
                            )
                            .foregroundColor(.black)
                            .frame(width: 297, alignment: .topLeading)
                        Text(userProfile.prompt3 ?? "")
                            .font(Font.custom("Modern Era", size: 14))
                            .foregroundColor(Constants.ContentGrey)
                            .frame(width: 305, alignment: .topLeading)
                            .padding(.top, 5)
                    }
                    .padding(.horizontal, 12)
                }
                .frame(width: 339, height: 84)
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .inset(by: 0.5)
                        .stroke(Constants.BorderGrey, lineWidth: Constants.StrokeBorder)
                )
                .padding(.top, 12)
                
                HStack(spacing: 0) {
                    Text("Info")
                        .font(
                            Font.custom("Modern Era", size: 16)
                                .weight(.medium)
                        )
                        .foregroundColor(Constants.ContentGrey)
                        .frame(width: 84, alignment: .topLeading)
                        .padding(.top, 30)
                        .padding(.bottom, 10)
                        .padding(.leading, 18)
                    Spacer()
                }
                
                ForEach(0..<11, id: \.self){ index in
                    HStack(spacing: 0) {
                        Text("\(profileInfo[index]): ")
                            .font(
                                Font.custom("Modern Era", size: 14)
                                    .weight(.medium)
                            )
                            .foregroundColor(.black)
                            .frame(width: 87, alignment: .topLeading)
                            .padding(.trailing, 36)
                        Text(profileContent[index])
                            .font(
                                Font.custom("Modern Era", size: 14)
                                    .weight(.medium)
                            )
                            .multilineTextAlignment(.center)
                            .foregroundColor(Constants.InfoGrey)
                        Spacer()
                        Button {
                            selectedIndex = index
                            onTap = true
                        }label: {
                            Image("Edit_profile_info")
                                .frame(width: 20, height: 20)
                        }
                        .sheet(isPresented: $onTap) {
                            if let index = selectedIndex {
                                switch index {
                                case 1...3: RegisterC1()
                                case 4: RegisterC1_2()
                                case 5: RegisterC2()
                                case 6...8: RegisterC3()
                                case 9: RegisterC4()
                                case 10: RegisterC5()
                                default:
                                    Text("Error occured")
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 15)
                    .padding(.vertical, 10)
                    Divider()
                        .padding(.horizontal, 10)
                }
                
            }
            .task {
                Task {
                    do {
                        try await fetchAll(name: userName, saveData: userProfile)
                    } catch {
                        print("In profile section: \(error)")
                    }
                }
            }
        }
    }
}
