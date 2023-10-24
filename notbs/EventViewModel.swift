
import FirebaseFirestore

class EventViewModel: ObservableObject {
    @Published var events: [Event] = []
    private var db = Firestore.firestore()
    var userId: String

    init(userId: String) {
        self.userId = userId
        fetchData()
    }

    func fetchData(completion: ((Result<Void, Error>) -> Void)? = nil) {
        let userRef = db.collection("users").document(userId)
        userRef.collection("events").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting events: \(error)")
                completion?(.failure(error))
                return
            }
            
            self.events = querySnapshot?.documents.compactMap({ document in
                let data = document.data()
                let group = data["group"] as? String ?? ""
                let type = data["type"] as? String ?? ""
                let timestamp = data["date"] as? Timestamp
                let date = timestamp?.dateValue() ?? Date()
                // Inside fetchData():
                let imageURL = data["imageURL"] as? String
                return Event(group: group, type: type, date: date, imageURL: imageURL)

//                return Event(group: group, type: type, date: date)
            }) ?? []

            completion?(.success(()))
        }
    }
}

//struct Event {
//    var group: String
//    var type: String
//    var date: Date
//}
struct Event {
    var group: String
    var type: String
    var date: Date
    var imageURL: String?  // Add this line for the imageURL
}

