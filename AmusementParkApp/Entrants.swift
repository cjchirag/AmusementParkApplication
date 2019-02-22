import Foundation

/*
 
 This project is divided into 3 parts.. 1. To define Entrant types 2. To define passes 3. Test cases. To make it convenient for you, I have called the function which prints the test cases in the initial viewDidLoad(). So, when you remove the comments inside the function and press the start button to execute the app.. All the statements will be printed.
 
 And my notes to justify how I have achieved each criteria
 
 CRITERIA 1: Inheritance is used for Guest objects -> Guest, VIPGuest, Child
 Protocol is used as a type to couple types of Employee -> protocol Employee
 Struct is used to design guest pass
 
 CRITERIA 2: Enumerations are used for defining Entrant types (Entrants), discount items (discountItems), areas within the park (Area) and the errors the app can throw.
 
 CRITERIA 3: convenience inits for Entrants are used since the user might not enter stored properties while creating an instance of Entrants. This allows for scope to throw errors since these stored properties are optionals in case there are missing properties. A convinience init is also present at PassForEmployee.. so if the user has not declared stored properties during Entrant object initialisation, the user can initialise the stored properties of Entrants during the instance of pass object. I have used a flag.. "propertiesEntered"... which is turned true when the stored properties are entered. I have used this flag since at two instances the optional stored properties can be defined. So if stored properties are defined during Entrant object initialisation.. then the Pass object's convinience init method will be non-functional.
 CRITERIA 4: Stored properties of required business information being optional.. appropriate detailed errors can be thrown according to the missing property causing the problem.
 CRITERIA 5: Swipe methods for area access, discount access, and to skip ride lines.
 Appropriate errors are thrown if the pass is not generated or access is denied
 CRITERIA 6: Test cases are commented. Two possible actions the user can take are: 1) generatePass() for checking if the pass is valid or not according to the business rules matrix of required information 2) A swipe method. Also various possible scenarios are shown when errors could appear.
 
 */








// 1. -> Define entrant types





extension Date {
    var age: Int {
        return Calendar.current.dateComponents([.year], from: self, to: Date()).year!
    }
}

protocol validGuest {
    var passGenerated: Bool {get set}
}

enum Entrants: String {
    case ClassicGuest = "Adult Guest"
    case VIPGuest = "VIP"
    case ChildGuest = "Child Guest"
    case RideServices = "Ride Services"
    case Maintenance = "Maintenance Services"
    case FoodServices = "Food Services"
    case Manager = "Manager"
    case seasonPassGuest = "Season Pass Holder"
    case seniorGuest = "Senior Guest"
    case contractor = "Contractor"
    case vendor = "Vendor"
}

enum discountItems {
    case food
    case merchandise
}

enum Area {
    case Amusement
    case Kitchen
    case RideControl
    case Maintenance
    case Office
}

enum VendorCompanies: String {
    case Acme = "Acme"
    case Orkin = "Orkin"
    case Fedex = "Fedex"
    case NWElectrical = "NWElectrical"
}

enum ProjectClassifications: String {
    case P1001 = "1001"
    case P1002 = "1002"
    case P1003 = "1003"
    case P2001 = "2001"
    case P2002 = "2002"
}



class Guest: validGuest, Passable {
    var firstName: String?
    var lastName: String?
    var streetAddress: String?
    var city: String?
    var state: String?
    var zip: String?
    var passGenerated: Bool = false
    var guestType: Entrants {
        return .ClassicGuest
    }
    var skipRideAccess: Bool {
        return false
    }
    var discountOffers: Bool {
        return false
    }
    var availDiscount: [discountItems: Double] { return [:] }
}

class VIPGuest: Guest {
    override var guestType: Entrants {
        return .VIPGuest
    }
    override var skipRideAccess: Bool { return true }
    override var discountOffers: Bool {
        return true
    }
    override var availDiscount: [discountItems: Double] { return [.food: 10.0, .merchandise: 20.0] }
}

class Child: Guest {
    override var guestType: Entrants {
        return .ChildGuest
    }
    var Birthday: String?
    override init() {
        
    }
    convenience init(Birthday: String) {
        self.init()
        self.Birthday = Birthday
    }
    var Age: Int {
        guard let DOB = self.Birthday else {return 0}
        
        let Components = DOB.components(separatedBy: "/")
        var ageDOB: Date?
        if DOB != "" {
            ageDOB = Calendar.current.date(from: DateComponents(year:
                Int(Components[2]), month: Int(Components[1]), day:
                Int(Components[0])))
            return ageDOB?.age ?? -1
        } else {
            return -1
        }
    }
}

class seasonPassGuest : Guest {
    var propertiesEntered: Bool?
    
    
    override init() {
        self.propertiesEntered = false
    }
    
    required convenience init(firstName: String, lastName: String, streetAddress: String, city: String, state: String, zip: String) {
        self.init()
        self.propertiesEntered = true
        self.firstName = firstName
        self.lastName = lastName
        self.streetAddress = streetAddress
        self.city = city
        self.state = state
        self.zip = zip
    }
    
    override var guestType: Entrants{
        return .seasonPassGuest
    }
    override var skipRideAccess: Bool { return true }
    override var availDiscount: [discountItems: Double] { return [.food: 10.0, .merchandise: 20.0] }
    override var discountOffers: Bool {
        return true
    }
    
}

class seniorGuest : Guest {
    var propertiesEntered: Bool?
    var Birthday: String?
    
    override init() {
        self.propertiesEntered = false
    }
    
    required convenience init(firstName: String, lastName: String, DateOfBirth: String) {
        self.init()
        self.propertiesEntered = true
        self.firstName = firstName
        self.lastName = lastName
        self.Birthday = DateOfBirth
    }
    
    override var guestType: Entrants{
        return .seniorGuest
    }
    override var skipRideAccess: Bool { return true }
    override var availDiscount: [discountItems: Double] { return [.food: 10.0, .merchandise: 10.0] }
    override var discountOffers: Bool {
        return true
    }
    
}










protocol Employee: Passable {
    var entrantType: Entrants { get }
    var propertiesEntered: Bool? { get set } // Since Entrant's optional stored properties can be initialised at two instances (during Entrants instance and PassForEmployee instance), this stored properties allows the personal information to be initialised only once. If at the beginning, Entrant object initialises all the stored properties.. later at PassForEmployee init method would be ineffective.
    var passGenerated: Bool {get set}
    var firstName: String? { get set }
    var lastName: String? { get set }
    var streetAddress: String? { get set }
    var city: String? { get set }
    var state: String? { get set }
    var zip: String? { get set }
    var project: String? {get set}
    var accessAreas: [Area] {get set}
    var skipRideAccess: Bool {get set}
    var discountEligible: Bool { get set }
    var availDiscount: [discountItems: Double] { get }
}

class FoodServices: Employee {
    var propertiesEntered: Bool?
    let entrantType: Entrants = .FoodServices
    var passGenerated: Bool = false
    var firstName: String?
    var lastName: String?
    var streetAddress: String?
    var city: String?
    var state: String?
    var zip: String?
    var project: String? = nil
    
    var discountEligible: Bool = true
    
    init() {
        self.propertiesEntered = false
    }
    
    required convenience init(firstName: String, lastName: String, streetAddress: String, city: String, state: String, zip: String) {
        self.init()
        self.propertiesEntered = true
        self.firstName = firstName
        self.lastName = lastName
        self.streetAddress = streetAddress
        self.city = city
        self.state = state
        self.zip = zip
    }
    
    var accessAreas: [Area] = [.Amusement, .Kitchen]
    var skipRideAccess: Bool = false
    let availDiscount: [discountItems : Double] = [.food: 15.0, .merchandise: 25.0]
}

class RideServices: Employee, Passable {
    var propertiesEntered: Bool?
    let entrantType: Entrants = .RideServices
    var passGenerated: Bool = false
    var firstName: String?
    var lastName: String?
    var streetAddress: String?
    var city: String?
    var state: String?
    var zip: String?
    var project: String? = nil
    
    init() {
        self.propertiesEntered = false
    }
    
    required convenience init(firstName: String, lastName: String, streetAddress: String, city: String, state: String, zip: String) {
        self.init()
        self.propertiesEntered = true
        self.firstName = firstName
        self.lastName = lastName
        self.streetAddress = streetAddress
        self.city = city
        self.state = state
        self.zip = zip
    }
    
    var accessAreas: [Area] = [.Amusement, .RideControl]
    var skipRideAccess: Bool = false
    var discountEligible: Bool = true
    let availDiscount: [discountItems : Double] = [.food: 15.0, .merchandise: 25.0]
}

class MaintenanceServices: Employee, Passable {
    var propertiesEntered: Bool?
    let entrantType: Entrants = .Maintenance
    var passGenerated: Bool = false
    var firstName: String?
    var lastName: String?
    var streetAddress: String?
    var city: String?
    var state: String?
    var zip: String?
    var project: String? = nil
    
    init() {
        self.propertiesEntered = false
    }
    
    required convenience init(firstName: String, lastName: String, streetAddress: String, city: String, state: String, zip: String) {
        self.init()
        self.propertiesEntered = true
        self.firstName = firstName
        self.lastName = lastName
        self.streetAddress = streetAddress
        self.city = city
        self.state = state
        self.zip = zip
    }
    
    var accessAreas: [Area] = [.Amusement, .Maintenance, .RideControl, .Kitchen]
    
    var skipRideAccess: Bool = false
    var discountEligible: Bool = true
    let availDiscount: [discountItems : Double] = [.food: 15.0, .merchandise: 25.0]
}

class Manager: Employee, Passable {
    var propertiesEntered: Bool?
    let entrantType: Entrants = .Manager
    var passGenerated: Bool = false
    var firstName: String?
    var lastName: String?
    var streetAddress: String?
    var city: String?
    var state: String?
    var zip: String?
    var project: String? = nil
    
    init() {
        self.propertiesEntered = false
    }
    
    required convenience init(firstName: String, lastName: String, streetAddress: String, city: String, state: String, zip: String) {
        self.init()
        self.propertiesEntered = true
        self.firstName = firstName
        self.lastName = lastName
        self.streetAddress = streetAddress
        self.city = city
        self.state = state
        self.zip = zip
    }
    
    var accessAreas: [Area] = [.Amusement, .Kitchen, .Maintenance, .Office, .RideControl]
    
    var skipRideAccess: Bool = false
    var discountEligible: Bool = true
    let availDiscount: [discountItems : Double] = [.food: 15.0, .merchandise: 25.0]
    
}


class Contractor: Employee, Passable {
    var propertiesEntered: Bool?
    let entrantType: Entrants = .contractor
    var passGenerated: Bool = false
    var firstName: String?
    var lastName: String?
    var streetAddress: String?
    var city: String?
    var state: String?
    var zip: String?
    var project: String?
    
    init() {
        self.propertiesEntered = false
    }
    
    required convenience init(firstName: String, lastName: String, streetAddress: String, city: String, state: String, zip: String, project: String) {
        self.init()
        self.propertiesEntered = true
        self.firstName = firstName
        self.lastName = lastName
        self.streetAddress = streetAddress
        self.city = city
        self.state = state
        self.zip = zip
        self.project = project
    }
    
    var accessAreas: [Area] = [.Amusement, .Kitchen]
    var skipRideAccess: Bool = false
    var discountEligible: Bool = false
    let availDiscount: [discountItems : Double] = [:]
}



class Vendor: Passable {
    var propertiesEntered: Bool?
    let entrantType: Entrants = .vendor
    var passGenerated: Bool?
    var firstName: String?
    var lastName: String?
    var vendorCompany: String?
    var dateOfBirth: String?
    var dateOfVisit: String?
    
    init() {
        self.propertiesEntered = false
    }
    
    required convenience init(firstName: String, lastName: String, vendorCompany: String, dateOfBirth: String, dateOfVisit: String) {
        self.init()
        self.propertiesEntered = true
        self.firstName = firstName
        self.lastName = lastName
        self.vendorCompany = vendorCompany
        self.dateOfBirth = dateOfBirth
        self.dateOfVisit = dateOfVisit
    }
    var skipRideAccess: Bool = false
    var discountEligible: Bool = false
    let availDiscount: [discountItems : Double] = [:]
}
