//
//
//
//import SwiftUI
//import MapKit
//
//struct MedicineCabinetView_Previews: PreviewProvider {
//
//    static var previews: some View {
//        MedicineCabinetView()
//    }
//}
//
//struct MedicineCabinetView: View {
//
//    @State private var newMedicine = ""
//    @State private var isAddingMedicine = false
//
//    @State private var medicines: [String] = UserDefaults.standard.arrayValue(forKey: "medicines")
//
//    let colors: [Color] = [.pink, .blue, .green, .orange, .yellow, .purple]
//
//
//    @State private var region = MKCoordinateRegion(
//        center: CLLocationCoordinate2D(latitude: 35.9132, longitude: -79.0558),
//        span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
//    )
//
//    var body: some View {
//        VStack {
//            Text("Medicine Cabinet")
//                .font(.largeTitle)
//                .fontWeight(.heavy)
//                .padding(.top, 15)
//
//            Button(action: {
//                self.isAddingMedicine.toggle()
//            }) {
//                Image(systemName: "plus")
//                    .resizable()
//                    .frame(width: 30, height: 30)
//                    .foregroundColor(.blue)
//            }
//            .padding(.bottom, 10)
//
//            if isAddingMedicine {
//                VStack {
//                    TextField("Medicine Name", text: $newMedicine)
//                        .textFieldStyle(RoundedBorderTextFieldStyle())
//                        .padding(.bottom, 10)
//
//
//
//                    Button("Add Medicine") {
//                        if !newMedicine.isEmpty {
//                            medicines.append(newMedicine)
//                            UserDefaults.standard.setArray(medicines, forKey: "medicines")
//                            newMedicine = ""
//                        }
//
//                    }
//                    .padding(.bottom, 10)
//                }
//                .padding()
//            }
//
//
//
//            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: 3), spacing: 20) {
//                ForEach(medicines, id: \.self) { medicine in
//                    VStack {
//                        Image(systemName: "pills")
//                            .resizable()
//                            .frame(width: 50, height: 50)
//                            .foregroundColor(colors.randomElement() ?? .blue)
//                        Text(medicine)
//                            .font(.caption)
//                    }
//                    .padding()
//                    .background(Color.white)
//                    .cornerRadius(10)
//                    .shadow(color: .gray, radius: 5, x: 0, y: 0)
//                }
//            }
//            .padding()
//
//            Text("Closest Pharmacies")
//                .font(.title2)
//                .fontWeight(.bold)
//                .padding(.top, 15)
//
//            // Map view
//            Map(coordinateRegion: $region)
//                .cornerRadius(10)
//                .padding()
//                .frame(height: 200)
//
//            Spacer()
//        }
//        .onAppear {
//            // Refresh medicines from UserDefaults when the view appears
//            self.medicines = UserDefaults.standard.arrayValue(forKey: "medicines")
//        }
//    }
//}
//
//
//extension UserDefaults {
//    func setArray(_ array: [String], forKey key: String) {
//        set(array, forKey: key)
//    }
//
//    func arrayValue(forKey key: String) -> [String] {
//        return stringArray(forKey: key) ?? []
//    }
//}


//import SwiftUI
//import MapKit
//
//struct Medicine: Codable, Identifiable {
//    let id = UUID()
//    var name: String
//    var dosage: String
//}
//
//extension UserDefaults {
//    func setMedicines(_ medicines: [Medicine], forKey key: String) {
//        if let encodedData = try? JSONEncoder().encode(medicines) {
//            set(encodedData, forKey: key)
//        }
//    }
//
//    func medicines(forKey key: String) -> [Medicine] {
//        if let data = data(forKey: key), let medicines = try? JSONDecoder().decode([Medicine].self, from: data) {
//            return medicines
//        }
//        return []
//    }
//}
//
//struct MedicineCabinetView_Previews: PreviewProvider {
//    static var previews: some View {
//        MedicineCabinetView()
//    }
//}
//
//struct MedicineCabinetView: View {
//    @State private var newMedicineName = ""
//    @State private var newMedicineDosage = ""
//    @State private var isAddingMedicine = false
//
//    @State private var medicines: [Medicine] = UserDefaults.standard.medicines(forKey: "medicines")
//
//    let colors: [Color] = [.pink, .blue, .green, .orange, .yellow, .purple]
//
//    @State private var region = MKCoordinateRegion(
//        center: CLLocationCoordinate2D(latitude: 35.9132, longitude: -79.0558),
//        span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
//    )
//
//    var body: some View {
//        VStack {
//            Text("Medicine Cabinet")
//                .font(.largeTitle)
//                .fontWeight(.heavy)
//                .padding(.top, 15)
//
//            Button(action: {
//                self.isAddingMedicine.toggle()
//            }) {
//                Image(systemName: "plus")
//                    .resizable()
//                    .frame(width: 30, height: 30)
//                    .foregroundColor(.blue)
//            }
//            .padding(.bottom, 10)
//
//            if isAddingMedicine {
//                VStack {
//                    TextField("Medicine Name", text: $newMedicineName)
//                        .textFieldStyle(RoundedBorderTextFieldStyle())
//                    TextField("Dosage", text: $newMedicineDosage)
//                        .textFieldStyle(RoundedBorderTextFieldStyle())
//                        .padding(.bottom, 10)
//
//                    Button("Add Medicine") {
//                        if !newMedicineName.isEmpty && !newMedicineDosage.isEmpty {
//                            let newMedicine = Medicine(name: newMedicineName, dosage: newMedicineDosage)
//                            medicines.append(newMedicine)
//                            UserDefaults.standard.setMedicines(medicines, forKey: "medicines")
//                            newMedicineName = ""
//                            newMedicineDosage = ""
//                        }
//                    }
//                    .padding(.bottom, 10)
//                }
//                .padding()
//            }
//
//            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: 3), spacing: 20) {
//                ForEach(medicines) { medicine in
//                    VStack {
//                        Image(systemName: "pills")
//                            .resizable()
//                            .frame(width: 50, height: 50)
//                            .foregroundColor(colors.randomElement() ?? .blue)
//                        Text("\(medicine.name) - \(medicine.dosage)")
//                            .font(.caption)
//                    }
//                    .padding()
//                    .background(Color.white)
//                    .cornerRadius(10)
//                    .shadow(color: .gray, radius: 5, x: 0, y: 0)
//                }
//            }
//            .padding()
//
//            Text("Closest Pharmacies")
//                .font(.title2)
//                .fontWeight(.bold)
//                .padding(.top, 15)
//
//            Map(coordinateRegion: $region)
//                .cornerRadius(10)
//                .padding()
//                .frame(height: 200)
//
//            Spacer()
//        }
//        .onAppear {
//            self.medicines = UserDefaults.standard.medicines(forKey: "medicines")
//        }
//    }
//}


//import SwiftUI
//import MapKit
//import CoreLocation
//
//struct Medicine: Codable, Identifiable {
//    let id = UUID()
//    var name: String
//    var dosage: String
//}
//
//extension UserDefaults {
//    func setMedicines(_ medicines: [Medicine], forKey key: String) {
//        if let encodedData = try? JSONEncoder().encode(medicines) {
//            set(encodedData, forKey: key)
//        }
//    }
//
//    func medicines(forKey key: String) -> [Medicine] {
//        if let data = data(forKey: key), let medicines = try? JSONDecoder().decode([Medicine].self, from: data) {
//            return medicines
//        }
//        return []
//    }
//}
//
//class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
//    private let locationManager = CLLocationManager()
//    @Published var location: CLLocation? = nil
//
//    override init() {
//        super.init()
//        self.locationManager.delegate = self
//        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        self.locationManager.requestWhenInUseAuthorization()
//        self.locationManager.startUpdatingLocation()
//    }
//
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        location = locations.first
//    }
//}
//
//struct MedicineCabinetView: View {
//    @State private var newMedicineName = ""
//    @State private var newMedicineDosage = ""
//    @State private var isAddingMedicine = false
//
//    @State private var medicines: [Medicine] = UserDefaults.standard.medicines(forKey: "medicines")
//
//    let colors: [Color] = [.pink, .blue, .green, .orange, .yellow, .purple]
//
//    @ObservedObject var locationManager = LocationManager()
//
//    var body: some View {
//        VStack {
//            Text("Medicine Cabinet")
//                .font(.largeTitle)
//                .fontWeight(.heavy)
//                .padding(.top, 15)
//
//            Button(action: {
//                self.isAddingMedicine.toggle()
//            }) {
//                Image(systemName: "plus")
//                    .resizable()
//                    .frame(width: 30, height: 30)
//                    .foregroundColor(.blue)
//            }
//            .padding(.bottom, 10)
//
//            if isAddingMedicine {
//                VStack {
//                    TextField("Medicine Name", text: $newMedicineName)
//                        .textFieldStyle(RoundedBorderTextFieldStyle())
//                    TextField("Dosage", text: $newMedicineDosage)
//                        .textFieldStyle(RoundedBorderTextFieldStyle())
//                        .padding(.bottom, 10)
//
//                    Button("Add Medicine") {
//                        if !newMedicineName.isEmpty && !newMedicineDosage.isEmpty {
//                            let newMedicine = Medicine(name: newMedicineName, dosage: newMedicineDosage)
//                            medicines.append(newMedicine)
//                            UserDefaults.standard.setMedicines(medicines, forKey: "medicines")
//                            newMedicineName = ""
//                            newMedicineDosage = ""
//                        }
//                    }
//                    .padding(.bottom, 10)
//                }
//                .padding()
//            }
//
//            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: 3), spacing: 20) {
//                ForEach(medicines) { medicine in
//                    VStack {
//                        Image(systemName: "pills")
//                            .resizable()
//                            .frame(width: 50, height: 50)
//                            .foregroundColor(colors.randomElement() ?? .blue)
//                        Text("\(medicine.name) - \(medicine.dosage)")
//                            .font(.caption)
//                    }
//                    .padding()
//                    .background(Color.white)
//                    .cornerRadius(10)
//                    .shadow(color: .gray, radius: 5, x: 0, y: 0)
//                }
//            }
//            .padding()
//
//            Text("Closest Pharmacies")
//                .font(.title2)
//                .fontWeight(.bold)
//                .padding(.top, 15)
//
//            if let location = locationManager.location {
//                Map(coordinateRegion: .constant(MKCoordinateRegion(
//                    center: location.coordinate,
//                    span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
//                )))
//                .cornerRadius(10)
//                .padding()
//                .frame(height: 200)
//            } else {
//                Text("Determining your location...")
//            }
//
//            Spacer()
//        }
//        .onAppear {
//            self.medicines = UserDefaults.standard.medicines(forKey: "medicines")
//        }
//    }
//}
//
//struct MedicineCabinetView_Previews: PreviewProvider {
//    static var previews: some View {
//        MedicineCabinetView()
//    }
//}


//import SwiftUI
//import MapKit
//import CoreLocation
//
//struct Medicine: Codable, Identifiable {
//    let id = UUID()
//    var name: String
//    var dosage: String
//}
//
//extension UserDefaults {
//    func setMedicines(_ medicines: [Medicine], forKey key: String) {
//        if let encodedData = try? JSONEncoder().encode(medicines) {
//            set(encodedData, forKey: key)
//        }
//    }
//
//    func medicines(forKey key: String) -> [Medicine] {
//        if let data = data(forKey: key), let medicines = try? JSONDecoder().decode([Medicine].self, from: data) {
//            return medicines
//        }
//        return []
//    }
//}
//
//class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
//    private let locationManager = CLLocationManager()
//    @Published var location: CLLocation? = nil
//
//    override init() {
//        super.init()
//        self.locationManager.delegate = self
//        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        self.locationManager.requestWhenInUseAuthorization()
//        self.locationManager.startUpdatingLocation()
//    }
//
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        location = locations.first
//    }
//}
//
//struct Pharmacy: Identifiable {
//    let id = UUID()
//    let name: String
//    let location: CLLocationCoordinate2D
//}
//
//struct MedicineCabinetView: View {
//    @State private var newMedicineName = ""
//    @State private var newMedicineDosage = ""
//    @State private var isAddingMedicine = false
//    @State private var pharmacies: [Pharmacy] = []
//    @State private var showingAlert = false
//    @State private var alertMessage = ""
//
//    @State private var medicines: [Medicine] = UserDefaults.standard.medicines(forKey: "medicines")
//
//    let colors: [Color] = [.pink, .blue, .green, .orange, .yellow, .purple]
//
//    @ObservedObject var locationManager = LocationManager()
//
//    private func findPharmacies() {
//        guard let location = locationManager.location else {
//            alertMessage = "Your location is not available."
//            showingAlert = true
//            return
//        }
//
//        let request = MKLocalSearch.Request()
//        request.naturalLanguageQuery = "pharmacy"
//        request.region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 5000, longitudinalMeters: 5000)
//
//        let search = MKLocalSearch(request: request)
//        search.start { (response, error) in
//            guard let response = response else {
//                alertMessage = "Unable to find pharmacies: \(error?.localizedDescription ?? "Unknown error")"
//                showingAlert = true
//                return
//            }
//
//            self.pharmacies = response.mapItems.map {
//                Pharmacy(name: $0.name ?? "Unknown", location: $0.placemark.coordinate)
//            }
//        }
//    }
//
//    var body: some View {
//        VStack {
//            Text("Medicine Cabinet")
//                .font(.largeTitle)
//                .fontWeight(.heavy)
//                .padding(.top, 15)
//
//            // ... Medicine Adding UI code
//
//            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: 3), spacing: 20) {
//                // ... Medicine Display UI
//            }
//            .padding()
//
//            Text("Closest Pharmacies")
//                .font(.title2)
//                .fontWeight(.bold)
//                .padding(.top, 15)
//
//            if pharmacies.isEmpty {
//                if locationManager.location != nil {
//                    Button("Find Nearest Pharmacies") {
//                        findPharmacies()
//                    }
//                    .padding()
//                } else {
//                    Text("Determining your location...")
//                }
//            } else {
//                List(pharmacies) { pharmacy in
//                    VStack(alignment: .leading) {
//                        Text(pharmacy.name)
//                        Text("Latitude: \(pharmacy.location.latitude)")
//                        Text("Longitude: \(pharmacy.location.longitude)")
//                    }
//                }
//            }
//        }
//        .alert(isPresented: $showingAlert) {
//            Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
//        }
//        .onAppear {
//            self.medicines = UserDefaults.standard.medicines(forKey: "medicines")
//        }
//    }
//}
//
//struct MedicineCabinetView_Previews: PreviewProvider {
//    static var previews: some View {
//        MedicineCabinetView()
//    }
//}




//
//import SwiftUI
//import MapKit
//import CoreLocation
//
//struct Medicine: Codable, Identifiable {
//    let id = UUID()
//    var name: String
//    var dosage: String
//}
//
//extension UserDefaults {
//    func setMedicines(_ medicines: [Medicine], forKey key: String) {
//        if let encodedData = try? JSONEncoder().encode(medicines) {
//            set(encodedData, forKey: key)
//        }
//    }
//
//    func medicines(forKey key: String) -> [Medicine] {
//        if let data = data(forKey: key), let medicines = try? JSONDecoder().decode([Medicine].self, from: data) {
//            return medicines
//        }
//        return []
//    }
//}
//
//class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
//    private let locationManager = CLLocationManager()
//    @Published var location: CLLocation? = nil
//
//    override init() {
//        super.init()
//        self.locationManager.delegate = self
//        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        self.locationManager.requestWhenInUseAuthorization()
//        self.locationManager.startUpdatingLocation()
//    }
//
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        location = locations.first
//    }
//}
//
//struct Pharmacy: Identifiable {
//    let id = UUID()
//    let name: String
//    let location: CLLocationCoordinate2D
//}
//
//struct MedicineCabinetView: View {
//    @State private var newMedicineName = ""
//    @State private var newMedicineDosage = ""
//    @State private var isAddingMedicine = false
//    @State private var pharmacies: [Pharmacy] = []
//    @State private var showingAlert = false
//    @State private var alertMessage = ""
//
//    @State private var medicines: [Medicine] = UserDefaults.standard.medicines(forKey: "medicines")
//
//    let colors: [Color] = [.pink, .blue, .green, .orange, .yellow, .purple]
//
//    @ObservedObject var locationManager = LocationManager()
//
//    private func findPharmacies() {
//        guard let location = locationManager.location else {
//            alertMessage = "Your location is not available."
//            showingAlert = true
//            return
//        }
//
//        let request = MKLocalSearch.Request()
//        request.naturalLanguageQuery = "pharmacy"
//        request.region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 5000, longitudinalMeters: 5000)
//
//        let search = MKLocalSearch(request: request)
//        search.start { (response, error) in
//            guard let response = response else {
//                alertMessage = "Unable to find pharmacies: \(error?.localizedDescription ?? "Unknown error")"
//                showingAlert = true
//                return
//            }
//
//            self.pharmacies = response.mapItems.map {
//                Pharmacy(name: $0.name ?? "Unknown", location: $0.placemark.coordinate)
//            }
//        }
//    }
//
//    var body: some View {
//        VStack {
//            Text("Medicine Cabinet")
//                .font(.largeTitle)
//                .fontWeight(.heavy)
//                .padding(.top, 15)
//
//            Button(action: {
//                self.isAddingMedicine.toggle()
//            }) {
//                Image(systemName: "plus")
//                    .resizable()
//                    .frame(width: 30, height: 30)
//                    .foregroundColor(.blue)
//            }
//            .padding(.bottom, 10)
//
//            if isAddingMedicine {
//                VStack {
//                    TextField("Medicine Name", text: $newMedicineName)
//                        .textFieldStyle(RoundedBorderTextFieldStyle())
//                    TextField("Dosage", text: $newMedicineDosage)
//                        .textFieldStyle(RoundedBorderTextFieldStyle())
//                        .padding(.bottom, 10)
//
//                    Button("Add Medicine") {
//                        if !newMedicineName.isEmpty && !newMedicineDosage.isEmpty {
//                            let newMedicine = Medicine(name: newMedicineName, dosage: newMedicineDosage)
//                            medicines.append(newMedicine)
//                            UserDefaults.standard.setMedicines(medicines, forKey: "medicines")
//                            newMedicineName = ""
//                            newMedicineDosage = ""
//                        }
//                    }
//                    .padding(.bottom, 10)
//                }
//                .padding()
//            }
//
//            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: 3), spacing: 20) {
//                ForEach(medicines) { medicine in
//                    VStack {
//                        Image(systemName: "pills")
//                            .resizable()
//                            .frame(width: 50, height: 50)
//                            .foregroundColor(colors.randomElement() ?? .blue)
//                        Text("\(medicine.name) - \(medicine.dosage)")
//                            .font(.caption)
//                    }
//                    .padding()
//                    .background(Color.white)
//                    .cornerRadius(10)
//                    .shadow(color: .gray, radius: 5, x: 0, y: 0)
//                }
//            }
//            .padding()
//
//            Text("Closest Pharmacies")
//                .font(.title2)
//                .fontWeight(.bold)
//                .padding(.top, 15)
//
//            if pharmacies.isEmpty {
//                if locationManager.location != nil {
//                    Button("Find Nearest Pharmacies") {
//                        findPharmacies()
//                    }
//                    .padding()
//                } else {
//                    Text("Determining your location...")
//                }
//            } else {
//                List(pharmacies) { pharmacy in
//                    VStack(alignment: .leading) {
//                        Text(pharmacy.name)
//                        Text("Latitude: \(pharmacy.location.latitude)")
//                        Text("Longitude: \(pharmacy.location.longitude)")
//                    }
//                }
//            }
//        }
//        .alert(isPresented: $showingAlert) {
//            Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
//        }
//        .onAppear {
//            self.medicines = UserDefaults.standard.medicines(forKey: "medicines")
//        }
//    }
//}
//
//struct MedicineCabinetView_Previews: PreviewProvider {
//    static var previews: some View {
//        MedicineCabinetView()
//    }
//}


import SwiftUI
import MapKit
import CoreLocation

struct Medicine: Codable, Identifiable {
    let id = UUID()
    var name: String
    var dosage: String
}

extension UserDefaults {
    func setMedicines(_ medicines: [Medicine], forKey key: String) {
        if let encodedData = try? JSONEncoder().encode(medicines) {
            set(encodedData, forKey: key)
        }
    }

    func medicines(forKey key: String) -> [Medicine] {
        if let data = data(forKey: key), let medicines = try? JSONDecoder().decode([Medicine].self, from: data) {
            return medicines
        }
        return []
    }
}

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    @Published var location: CLLocation? = nil

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first
    }
}

class Pharmacy: NSObject, Identifiable, MKAnnotation {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D

    init(name: String, coordinate: CLLocationCoordinate2D) {
        self.name = name
        self.coordinate = coordinate
    }
}

struct MedicineCabinetView: View {
    @State private var newMedicineName = ""
    @State private var newMedicineDosage = ""
    @State private var isAddingMedicine = false
    @State private var pharmacies: [Pharmacy] = []
    @State private var showingAlert = false
    @State private var alertMessage = ""
    @State private var mapRegion = MKCoordinateRegion()

    @State private var medicines: [Medicine] = UserDefaults.standard.medicines(forKey: "medicines")

    let colors: [Color] = [.pink, .blue, .green, .orange, .yellow, .purple]

    @ObservedObject var locationManager = LocationManager()

    private func findPharmacies() {
        guard let location = locationManager.location else {
            alertMessage = "Your location is not available."
            showingAlert = true
            return
        }

        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "pharmacy"
        request.region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 5000, longitudinalMeters: 5000)

        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            guard let response = response else {
                alertMessage = "Unable to find pharmacies: \(error?.localizedDescription ?? "Unknown error")"
                showingAlert = true
                return
            }

            self.pharmacies = response.mapItems.map {
                Pharmacy(name: $0.name ?? "Unknown", coordinate: $0.placemark.coordinate)
            }

            if let firstPharmacy = pharmacies.first {
                mapRegion = MKCoordinateRegion(center: firstPharmacy.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
            }
        }
    }

    var body: some View {
        VStack {
            Text("Medicine Cabinet")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .padding(.top, 15)

            Button(action: {
                self.isAddingMedicine.toggle()
            }) {
                Image(systemName: "plus")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.blue)
            }
            .padding(.bottom, 10)

            if isAddingMedicine {
                VStack {
                    TextField("Medicine Name", text: $newMedicineName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Dosage", text: $newMedicineDosage)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.bottom, 10)

                    Button("Add Medicine") {
                        if !newMedicineName.isEmpty && !newMedicineDosage.isEmpty {
                            let newMedicine = Medicine(name: newMedicineName, dosage: newMedicineDosage)
                            medicines.append(newMedicine)
                            UserDefaults.standard.setMedicines(medicines, forKey: "medicines")
                            newMedicineName = ""
                            newMedicineDosage = ""
                        }
                    }
                    .padding(.bottom, 10)
                }
                .padding()
            }

            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: 3), spacing: 20) {
                ForEach(medicines) { medicine in
                    VStack {
                        Image(systemName: "pills")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(colors.randomElement() ?? .blue)
                        Text("\(medicine.name) - \(medicine.dosage)")
                            .font(.caption)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: .gray, radius: 5, x: 0, y: 0)
                }
            }
            .padding()

            Text("Closest Pharmacies")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top, 15)

            if pharmacies.isEmpty {
                if locationManager.location != nil {
                    Button("Find Nearest Pharmacies") {
                        findPharmacies()
                    }
                    .padding()
                } else {
                    Text("Determining your location...")
                }
            } else {
                Map(coordinateRegion: $mapRegion, showsUserLocation: true, annotationItems: pharmacies) { pharmacy in
                    MapAnnotation(coordinate: pharmacy.coordinate) {
                        Image(systemName: "location.circle.fill")
                            .foregroundColor(.blue)
                    }
                }
                .frame(height: 300)
            }
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
        .onAppear {
            self.medicines = UserDefaults.standard.medicines(forKey: "medicines")
        }
    }
}

struct MedicineCabinetView_Previews: PreviewProvider {
    static var previews: some View {
        MedicineCabinetView()
    }
}
