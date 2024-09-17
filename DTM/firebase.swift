//
//  firebase.swift
//  DTM
//
//  Created by 水野裕介 on 2024/07/28.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseStorage

var waitForFirebase = false // trueのときは処理を待ってて欲しい期間



// UserProfile struct
class UserProfile {
    var name: String
    var number: String?
    var gender: String?
    var sexualOrientation: String?
    var year: String?
    var height: String?
    var nationality1: String?
    var nationality2: String?
    var nationality3: String?
    var hometown: String?
    var faculty: String?
    var oftenGo: String?
    var music1: String?
    var music2: String?
    var hobby1: String?
    var hobby2: String?
    var prompt1Select: String?
    var prompt1: String?
    var prompt2Select: String?
    var prompt2: String?
    var prompt3Select: String?
    var prompt3: String?
    var profileImageURL1: String?
    var profileImageURL2: String?
    var profileImageURL3: String?
    var profileImageURL4: String?
    var profileImageURL5: String?
    var profileImageURL6: String?
    
    // カスタムイニシャライザ
    init(name: String = userName, number: String? = "", gender: String? = "", sexualOrientation: String? = "", year: String? = "", height: String? = "", nationality1: String? = "", nationality2: String? = "", nationality3: String? = "", hometown: String? = "", faculty: String? = "", oftenGo: String? = "", music1: String? = "", music2: String? = "", hobby1: String? = "", hobby2: String? = "", prompt1Select: String? = "", prompt1: String? = "", prompt2Select: String? = "", prompt2: String? = "", prompt3Select: String? = "", prompt3: String? = "", profileImageURL1: String? = "", profileImageURL2: String? = "", profileImageURL3: String? = "", profileImageURL4: String? = "", profileImageURL5: String? = "", profileImageURL6: String? = "") {
        self.name = name
        self.number = number
        self.gender = gender
        self.sexualOrientation = sexualOrientation
        self.year = year
        self.height = height
        self.nationality1 = nationality1
        self.nationality2 = nationality2
        self.nationality3 = nationality3
        self.hometown = hometown
        self.faculty = faculty
        self.oftenGo = oftenGo
        self.music1 = music1
        self.music2 = music2
        self.hobby1 = hobby1
        self.hobby2 = hobby2
        self.prompt1Select = prompt1Select
        self.prompt1 = prompt1
        self.prompt2Select = prompt2Select
        self.prompt2 = prompt2
        self.prompt3Select = prompt3Select
        self.prompt3 = prompt3
        self.profileImageURL1 = profileImageURL1
        self.profileImageURL2 = profileImageURL2
        self.profileImageURL3 = profileImageURL3
        self.profileImageURL4 = profileImageURL4
        self.profileImageURL5 = profileImageURL5
        self.profileImageURL6 = profileImageURL6
    }
}

struct matchData {
    var days: String
    var events: String
    var latitude: String
    var longitiude: String
    var place: String
}

func fetchAll(name: String, saveData: UserProfile) async throws {
    let db = Firestore.firestore()
    let userRef = db.collection("users").document(name)
    
    do {
        let document = try await userRef.getDocument()
        if document.exists {
            print("In fetchAll: start fetching data")
            DispatchQueue.main.async {
                saveData.number = document.get("number") as? String ?? ""
                saveData.gender = document.get("gender") as? String ?? ""
                saveData.sexualOrientation = document.get("sexualOrientation") as? String ?? ""
                saveData.year = document.get("year") as? String ?? ""
                saveData.height = document.get("height") as? String ?? ""
                saveData.nationality1 = document.get("nationality1") as? String ?? ""
                saveData.nationality2 = document.get("nationality2") as? String ?? ""
                saveData.nationality3 = document.get("nationality3") as? String ?? ""
                saveData.hometown = document.get("hometown") as? String ?? ""
                saveData.faculty = document.get("faculty") as? String ?? ""
                saveData.oftenGo = document.get("oftenGo") as? String ?? ""
                saveData.music1 = document.get("music1") as? String ?? ""
                saveData.music2 = document.get("music2") as? String ?? ""
                saveData.hobby1 = document.get("hobby1") as? String ?? ""
                saveData.hobby2 = document.get("hobby2") as? String ?? ""
                saveData.prompt1Select = document.get("prompt1Select") as? String ?? ""
                saveData.prompt1 = document.get("prompt1") as? String ?? ""
                saveData.prompt2Select = document.get("prompt2Select") as? String ?? ""
                saveData.prompt2 = document.get("prompt2") as? String ?? ""
                saveData.prompt3Select = document.get("prompt3Select") as? String ?? ""
                saveData.prompt3 = document.get("prompt3") as? String ?? ""
                saveData.profileImageURL1 = document.get("profileImageURL1") as? String ?? ""
                saveData.profileImageURL2 = document.get("profileImageURL2") as? String ?? ""
                saveData.profileImageURL3 = document.get("profileImageURL3") as? String ?? ""
                saveData.profileImageURL4 = document.get("profileImageURL4") as? String ?? ""
                saveData.profileImageURL5 = document.get("profileImageURL5") as? String ?? ""
                saveData.profileImageURL6 = document.get("profileImageURL6") as? String ?? ""
            }

        } else {
            print("Document does not exist")
        }
    } catch {
        print("Error getting document: \(error)")
    }
}

func fetchAllState(name: String, saveData: Binding<UserProfile>) async throws {
    let db = Firestore.firestore()
    let userRef = db.collection("users").document(name)
    
    do {
        let document = try await userRef.getDocument()
        if document.exists {
            print("In fetchAll: start fetching data")
            DispatchQueue.main.async {
                saveData.number.wrappedValue = document.get("number") as? String ?? ""
                saveData.gender.wrappedValue = document.get("gender") as? String ?? ""
                saveData.sexualOrientation.wrappedValue = document.get("sexualOrientation") as? String ?? ""
                saveData.year.wrappedValue = document.get("year") as? String ?? ""
                saveData.height.wrappedValue = document.get("height") as? String ?? ""
                saveData.nationality1.wrappedValue = document.get("nationality1") as? String ?? ""
                saveData.nationality2.wrappedValue = document.get("nationality2") as? String ?? ""
                saveData.nationality3.wrappedValue = document.get("nationality3") as? String ?? ""
                saveData.hometown.wrappedValue = document.get("hometown") as? String ?? ""
                saveData.faculty.wrappedValue = document.get("faculty") as? String ?? ""
                saveData.oftenGo.wrappedValue = document.get("oftenGo") as? String ?? ""
                saveData.music1.wrappedValue = document.get("music1") as? String ?? ""
                saveData.music2.wrappedValue = document.get("music2") as? String ?? ""
                saveData.hobby1.wrappedValue = document.get("hobby1") as? String ?? ""
                saveData.hobby2.wrappedValue = document.get("hobby2") as? String ?? ""
                saveData.prompt1Select.wrappedValue = document.get("prompt1Select") as? String ?? ""
                saveData.prompt1.wrappedValue = document.get("prompt1") as? String ?? ""
                saveData.prompt2Select.wrappedValue = document.get("prompt2Select") as? String ?? ""
                saveData.prompt2.wrappedValue = document.get("prompt2") as? String ?? ""
                saveData.prompt3Select.wrappedValue = document.get("prompt3Select") as? String ?? ""
                saveData.prompt3.wrappedValue = document.get("prompt3") as? String ?? ""
                saveData.profileImageURL1.wrappedValue = document.get("profileImageURL1") as? String ?? ""
                saveData.profileImageURL2.wrappedValue = document.get("profileImageURL2") as? String ?? ""
                saveData.profileImageURL3.wrappedValue = document.get("profileImageURL3") as? String ?? ""
                saveData.profileImageURL4.wrappedValue = document.get("profileImageURL4") as? String ?? ""
                saveData.profileImageURL5.wrappedValue = document.get("profileImageURL5") as? String ?? ""
                saveData.profileImageURL6.wrappedValue = document.get("profileImageURL6") as? String ?? ""
            }
            
        } else {
            print("Document does not exist")
        }
    } catch {
        print("Error getting document: \(error)")
    }
}

func loadImage(urlString: String, completion: @escaping (UIImage?) -> Void) {
    guard let url = URL(string: urlString) else {
        completion(nil)
        return
    }
    
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        if let data = data {
            let image = UIImage(data: data)
            DispatchQueue.main.async {
                completion(image)
            }
        } else {
            DispatchQueue.main.async {
                completion(nil)
            }
        }
    }
    
    task.resume()
}



func fetchData(value: String, what: String, number: Binding<String?>) async throws {
    let db = Firestore.firestore()
    let userRef = db.collection("users").document(value)
    
    do {
        let document = try await userRef.getDocument()
        if document.exists {
            DispatchQueue.main.async {
                number.wrappedValue = document.get(what) as? String ?? "No name"
            }
        } else {
            print("Document does not exist")
        }
    } catch {
        print("cannot catch data")
    }
}

// UserProfile saving funciton (making new database)
func saveUserProfile(userProfile: UserProfile) {
    let db = Firestore.firestore()
    let userRef = db.collection("users").document(userProfile.name)
    db.runTransaction({ (transaction, errorPointer) -> Any? in
        let userDocument: DocumentSnapshot
        do {
            userDocument = try transaction.getDocument(userRef)
        } catch let error as NSError {
            errorPointer?.pointee = error
            return nil
        }
        
        // Check if the user already exists
        if userDocument.exists {
            // User with the same name already exists, abort the transaction
            errorPointer?.pointee = NSError(
                domain: "FirestoreErrorDomain",
                code: 1,
                userInfo: [NSLocalizedDescriptionKey: "User with the same name already exists"]
            )
            return nil
        }
        
        // Set the user data
        transaction.setData([
            "name": userProfile.name,
            "number": userProfile.number as Any,
            "gender": userProfile.gender as Any,
            "sexualOrientation": userProfile.sexualOrientation as Any,
            "year": userProfile.year as Any,
            "height": userProfile.height as Any,
            "nationality1": userProfile.nationality1 as Any,
            "nationality2": userProfile.nationality2 as Any,
            "nationality3": userProfile.nationality3 as Any,
            "hometown": userProfile.hometown as Any,
            "faculty": userProfile.faculty as Any,
            "oftenGo": userProfile.oftenGo as Any,
            "music1": userProfile.music1 as Any,
            "music2": userProfile.music2 as Any,
            "hobby1": userProfile.hobby1 as Any,
            "hobby2": userProfile.hobby2 as Any,
            "prompt1Select": userProfile.prompt1 as Any,
            "prompt1": userProfile.prompt1 as Any,
            "prompt2Select": userProfile.prompt2 as Any,
            "prompt2": userProfile.prompt2 as Any,
            "prompt3Select": userProfile.prompt3 as Any,
            "prompt3": userProfile.prompt3 as Any,
            "profileImageURL1": userProfile.profileImageURL1 as Any,
            "profileImageURL2": userProfile.profileImageURL2 as Any,
            "profileImageURL3": userProfile.profileImageURL3 as Any,
            "profileImageURL4": userProfile.profileImageURL4 as Any,
            "profileImageURL5": userProfile.profileImageURL5 as Any,
            "profileImageURL6": userProfile.profileImageURL6 as Any
        ], forDocument: userRef)
        
        return nil
    }) { (object, error) in
        print(error as Any)
    }
}

// UserProfile update function
func updateProfile(segment: String, value: String) {
    userRef.updateData([
        "\(segment)": value
    ]) { error in
        if let error = error {
            print(error.localizedDescription)
        } else {
            print("succes")
        }
    }
}

// UserProfile update function
func updateProfileBro(segment: String, value: String) {
    broRef.updateData([
        "\(segment)": value
    ]) { error in
        if let error = error {
            print(error.localizedDescription)
        } else {
            print("succes")
        }
    }
}

func setDouble(to: String, from: String, state: String) {
    let db = Firestore.firestore()
    let matchRef1 = db.collection("matching").document(to)
    let matchRef2 = db.collection("matching").document(from)
    
    db.runTransaction({ (transaction, errorPointer) -> Any? in
        let userDocument1: DocumentSnapshot
        let userDocument2: DocumentSnapshot
        do {
            userDocument1 = try transaction.getDocument(matchRef1)
            userDocument2 = try transaction.getDocument(matchRef2)
        } catch let error as NSError {
            errorPointer?.pointee = error
            return nil
        }
        
        // フィールド名とインデックスを指定して配列の要素にアクセス
        let fieldPath1 = FieldPath([from])  // 5番目の要素を指定
        let fieldPath2 = FieldPath([to])    // 5番目の要素を指定
        
        // 配列の取得とキャスト
        guard var currentArray1 = userDocument1.get(fieldPath1) as? [Any] else {
            print("No array found or invalid format")
            return nil
        }
        guard var currentArray2 = userDocument2.get(fieldPath2) as? [Any] else {
            print("No array found or invalid format")
            return nil
        }
        
        // 5番目の要素を更新
        currentArray1[5] = state
        currentArray2[5] = state
        
        // データを更新
        transaction.updateData([
            fieldPath1: currentArray1
        ], forDocument: matchRef1)
        transaction.updateData([
            fieldPath2: currentArray2
        ], forDocument: matchRef2)
        return nil
    }) { (object, error) in
        print(error as Any)
    }
}


// UserProfile update function
func setMatch(to: String, from: String, day: String, event: String, map: [String], place: String) {
    let db = Firestore.firestore()
    let matchRef = db.collection("match").document("to\(to)")
    db.runTransaction({ (transaction, errorPointer) -> Any? in
        let userDocument: DocumentSnapshot
        do {
            userDocument = try transaction.getDocument(matchRef)
        } catch let error as NSError {
            errorPointer?.pointee = error
            return nil
        }
        
        // Set the user data
        transaction.setData([
            "from\(from)": [day, event, map[0], map[1], place, ""]
        ], forDocument: matchRef)
        
        return nil
    }) { (object, error) in
        print(error as Any)
    }
}

func searchMatch(to: String, completion: @escaping ([String: Any]?) -> Void) {
    let db = Firestore.firestore()
    let matchRef = db.collection("match").document("to\(to)")
    
    matchRef.getDocument { (document, error) in
        if let error = error {
            print("Error getting document: \(error)")
            completion(nil)
        } else if let document = document, document.exists {
            // ドキュメントが存在する場合、その全フィールドを取得
            DispatchQueue.main.async {
                print("Document data: \(document.data() ?? [:])")
                completion(document.data())
            }
        } else {
            print("Document does not exist(searchMatch: no match you get)")
            completion(nil)
        }
    }
}

func fetchMatch(to: String, matchData: Binding<[String]>, getFrom: Binding<String>) async throws {
    let db = Firestore.firestore()
    let matchRef = db.collection("match").document("to\(to)")
    
    // ここを繰り返し処理するかも
    await searchMatch(to: to) { database in
        if let data = database {
            let fieldNames = Array(data.keys)
            for fieldName in fieldNames {
                getFrom.wrappedValue = fieldName
            }
        }
    }
    
    matchRef.getDocument { (document, error) in
        if let error = error {
            print("In fetchMatch : Error getting document: \(error)")
        } else if let document = document, document.exists {
            DispatchQueue.main.async {
                // フィールドパスにドットが含まれているため、FieldPathを使用
                let fieldPath = FieldPath([getFrom.wrappedValue])
                if let data = document.get(fieldPath) {
                    print(data)
                    matchData.wrappedValue = data as! Array<String>
                } else {
                    print("In fetchMatch : No field $\(getFrom)$ found")
                }
            }
        }
    }
    
}

// Arthurが追加したイベント情報を取得（日時とバーの場所とイベントキー）
func getDouble() async throws {
    let db = Firestore.firestore()
    let ref = db.collection("doubledates").document("events")
    
    do {
        // getDocumentのasync版を使用
        let document = try await ref.getDocument()
        
        if document.exists {
            if let data = document.data() {
                // キーを抽出し、数値キーのみフィルタリングして最大のキーを見つける
                let maxKey = data.keys.compactMap { Int($0) }.max()
                
                if let maxKey = maxKey, let maxData = data["\(maxKey)"] as? [Any] {
                    // maxDataが配列であると仮定し、1つ目の要素を取得
                    if let firstElement = maxData.first as? String {
                        print("1つ目の要素: \(firstElement)")
                    } else {
                        print("1つ目の要素が文字列ではありません")
                    }
                }
            }
        } else {
            print("Document does not exist")
        }
    } catch {
        print("Error fetching document: \(error)")
    }
}

// 申し込まれたときに、名前のドキュメントを作成
func createInvite(to: String, from: String, eventKey: String) async throws {
    let db = Firestore.firestore()
    let ref = db.collection("doubledates").document(to)
    do {
        try await ref.setData([
            "from" : from,
            "invite" : eventKey
        ])
        print("successfully create invite")
    } catch {
        print("In createInvite: \(error)")
    }
}


// DoubleDatesページを開いたときに、自分の名前のドキュメントがあるか確認
func checkInvite(name: String, completion: @escaping (Bool) -> Void) {
    let db = Firestore.firestore()
    let ref = db.collection("doubledates").document(name)
    ref.getDocument { document, error in
        if let error = error {
            print("In checkInvite: \(error)")
        } else if let document = document, document.exists {
            completion(true)
        } else {
            completion(false)
        }
    }
}

// DoubleDatesページを開いたときに、matchに自分の名前があるか確認
func checkDoubleMatch(name: String, completion: @escaping (Bool) -> Void) async throws {
    let db = Firestore.firestore()
    let ref = db.collection("doubledates").document("events")
    do {
        // getDocumentのasync版を使用
        let document = try await ref.getDocument()
        if document.exists {
            if let data = document.data() {
                let maxKey = data.keys.compactMap { Int($0) }.max()
                if let maxKey = maxKey, let maxData = data["\(maxKey)"] as? [Any] {
                    // maxDataが配列であると仮定し、1つ目の要素を取得
                    if let thirdElement = maxData[2] as? [String : [String]] {
                        print("3つ目の要素: \(thirdElement)")
                        for element in thirdElement {
                            if element.key.prefix(5) == "match" {
                                print(element.value)
                                for i in 1...2 {
                                    var parts = element.value[i].split(separator: "&")
                                    if parts[0] == name || parts[1] == name {
                                        print(parts)
                                        completion(true)
                                    } else {
                                        completion(false)
                                    }
                                }
                            } else {
                                completion(false)
                            }
                        }
                    } else {
                        print("データ型が指定された形式ではなかった")
                    }
                }
            }
        } else {
            print("In checkDoubleMatch: document not found")
            completion(false)
        }
    }
}

// キャンセル、confirm時にドキュメントを削除
func doubleDelete(name: String) {
    let db = Firestore.firestore()
    let ref = db.collection("doubledates").document(name)
    ref.delete()
}


// confirmされたときに、stateに追加する
func doubleState(name1: String, name2: String) async throws {
    let db = Firestore.firestore()
    let ref = db.collection("doubledates").document("events")

    do {
        // ドキュメントを取得
        let document = try await ref.getDocument()
        if document.exists {
            if let data = document.data() {
                // キーの最大値を取得
                let maxKey = data.keys.compactMap { Int($0) }.max()
                
                // 最大キーが存在する場合
                if let maxKey = maxKey, let maxData = data["\(maxKey)"] as? [Any] {
                    // 3番目の要素を取得 (stateフィールドを含む)
                    if let thirdElement = maxData[2] as? [String: Any] {
                        if let stateArray = thirdElement["state"] as? [String] {
                            // 既存のstate配列に新しいペアを追加
                            let newPair = "\(name1)&\(name2)"
                            
                            // Firestoreの`arrayUnion`を使って新しいペアを追加
                            try await ref.updateData([
                                "\(maxKey).2.state": FieldValue.arrayUnion([newPair])
                            ])
                            
                            print("新しいペアが追加されました: \(newPair)")
                        } else {
                            print("stateフィールドが存在しないか、配列ではありません")
                        }
                    } else {
                        print("指定された形式でデータがありません")
                    }
                } else {
                    print("最大キーが見つかりませんでした")
                }
            }
        } else {
            print("ドキュメントが存在しません")
        }
    } catch {
        print("エラー: \(error.localizedDescription)")
        throw error
    }
}



func matchDelete(to: String, completion: @escaping (Bool) -> Void) {
    let db = Firestore.firestore()
    let matchRef = db.collection("match").document("to\(to)")
    
    matchRef.getDocument { (document, error) in
        if let error = error {
            print("Error getting document: \(error)")
            DispatchQueue.main.async {
                completion(false)
            }
        } else if let document = document, document.exists {
            DispatchQueue.main.async {
                if let database = document.data() {
                    let fieldNames = Array(database.keys)
                    let fieldPath = FieldPath([fieldNames[0]])
                    
                    print("to\(to)のドキュメントから")
                    print("こいつをけします: \(fieldPath)")
                    waitForFirebase = true
                    matchRef.updateData([
                        fieldPath: FieldValue.delete()
                    ]) { err in
                        if let err = err {
                            print("Error removing field: \(err)")
                            DispatchQueue.main.async {
                                completion(false)
                            }
                        } else {
                            print("Field successfully removed!")
                            waitForFirebase = false
                            DispatchQueue.main.async {
                                completion(true)
                            }
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(false)
                    }
                }
            }
        } else {
            DispatchQueue.main.async {
                completion(false)
            }
        }
    }
}



// Storageに画像を保存
func uploadImage(image: UIImage, name: String, number: String, completion: @escaping (URL?) -> Void) {
    let storageRef = Storage.storage().reference().child("images/\(name)/\(number).jpg")
    
    guard let imageData = image.jpegData(compressionQuality: 0.8) else {
        completion(nil)
        return
    }
    
    storageRef.putData(imageData, metadata: nil) { metadata, error in
        if let error = error {
            print("Error uploading image: \(error)")
            completion(nil)
            return
        }
        
        storageRef.downloadURL { url, error in
            if let error = error {
                print("Error getting download URL: \(error)")
                completion(nil)
                return
            }
            
            completion(url)
        }
    }
}

func confirmMatch(one: String, two: String, detail: Binding<[String]>) async throws {
    let db = Firestore.firestore()
    let set1 = db.collection("matching").document(one)
    let set2 = db.collection("matching").document(two)
    
    db.runTransaction({ (transaction, errorPointer) -> Any? in
        let userDocument: DocumentSnapshot
        let userDocument2: DocumentSnapshot
        
        do {
            userDocument = try transaction.getDocument(set1)
            userDocument2 = try transaction.getDocument(set2)
            print("successfully confirm match!")
        } catch let error as NSError {
            errorPointer?.pointee = error
            return nil
        }
        transaction.setData([
            two : detail.wrappedValue
        ], forDocument: set1)
        
        transaction.setData([
            one : detail.wrappedValue
        ], forDocument: set2)
        
        return nil
        
    }) { (object, error) in
        print(error as Any)
    }
}

func searchUser(name: String, completion: @escaping (Bool, String) -> Void) {
    let db = Firestore.firestore()
    let usersCollection = db.collection("users")
    
    // 名前を分割して、名字と名前に分け、大文字小文字を無視するために小文字化
    let nameParts = name.lowercased().split(separator: " ")
    guard nameParts.count == 2 else {
        completion(false, "")
        return
    }
    let firstName = String(nameParts[0])
    let lastName = String(nameParts[1])
    
    usersCollection.getDocuments { (snapshot, error) in
        guard let documents = snapshot?.documents, error == nil else {
            completion(false, "")
            return
        }
        
        for document in documents {
            let docName = document.get("name") as? String ?? ""
            let docNameParts = docName.lowercased().split(separator: ".")
            if docNameParts.count != 2 { continue }
            
            let docFirstName = String(docNameParts[0])
            let docLastName = String(docNameParts[1])
            
            // 名と姓が大文字小文字を区別せずに一致するかチェック
            if firstName == docFirstName && lastName == docLastName {
                completion(true, docFirstName + " " + docLastName)
                return
            }
            
            // 姓の3文字以上が大文字小文字を区別せずに連続して一致するかチェック
            if firstName == docFirstName && containsThreeConsecutiveMatchingCharacters(lastName, docLastName) {
                completion(true, docFirstName + " " + docLastName)
                return
            }
        }
        
        completion(false, "")
    }
}

// 連続して一致する3文字以上の部分があるかどうかを確認する関数
func containsThreeConsecutiveMatchingCharacters(_ str1: String, _ str2: String) -> Bool {
    let len1 = str1.count
    let len2 = str2.count
    
    guard len1 >= 3 && len2 >= 3 else { return false }
    
    for i in 0..<(len1 - 2) {
        let subStr1 = str1[str1.index(str1.startIndex, offsetBy: i)..<str1.index(str1.startIndex, offsetBy: i + 3)]
        if str2.contains(subStr1) {
            return true
        }
    }
    
    return false
}


func fetchMatching(to: String, completion: @escaping ([String: Any]?) -> Void) async throws {
    let db = Firestore.firestore()
    if !to.isEmpty {
        let matchRef = db.collection("matching").document("\(to)")
        matchRef.getDocument { (document, error) in
            if let error = error {
                print("Error getting document: \(error)")
                completion(nil)
            } else if let document = document, document.exists {
                // ドキュメントが存在する場合、その全フィールドを取得
                do {
                    DispatchQueue.main.async {
                        print("In fetchMaching Document data: \(document.data() ?? [:])")
                        completion(document.data())
                    }
                } catch {
                    print("sorry")
                }
            } else {
                print("Document does not exist")
                completion(nil)
            }
        }
    } else {
        print("Error: 'to' is nil or empty")
    }
}
