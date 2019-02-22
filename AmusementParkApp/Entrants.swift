import Foundation

/*
 
My notes to justify how I have achieved each criteria
 
 CRITERIA 1: I have used all the major UIElements and in addition used picker views.
 
 CRITERIA 2: In viewdidLoad of the initial view controller -> All properties are disabled.
            When an entrant is selected (Guest, Manager, Employees, Vendor): The properties are enabled
 
 CRITERIA 3: Passes are generated as per the rules in the generatePass function called in the intial view.
 
 CRITERIA 4 & 5: four major swipe functions can be called from each pass object in the second view.
 
 CRITERIA 6: Populate data function of the view controller fills in the details as per the business matrix rules.
 
 CRITERIA 7: Protocols are used to couple Employees. Inheritance is used to couple Guest entrants.
 
 CRITERIA 8 & 9: Appropriate errors are thrown and caught shown in the view with UIAlert informing whether all properties are missing, whether a specific property is missing, whether the user has selected an Entrant, or has entered an invalid input (Birthday for child). To avoid errors in Dates.. I have used Date pickers in the text field.
 
 */





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

enum Area: String {
    case Amusement = "Amusement"
    case Kitchen = "Kitchen"
    case RideControl = "Ride Control"
    case Maintenance = "Maintenance"
    case Office = "Office"
    case PlaceHolder
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
    var Birthday: String?
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
    
    required convenience init(firstName: String, lastName: String, streetAddress: String, city: String, state: String, zip: String, DateOfBirth: String) {
        self.init()
        self.propertiesEntered = true
        self.firstName = firstName
        self.lastName = lastName
        self.streetAddress = streetAddress
        self.city = city
        self.state = state
        self.zip = zip
        self.Birthday = DateOfBirth
    }
    
    override var guestType: Entrants{
        return .seasonPassGuest
    }
    override var skipRideAccess: Bool { return true }
    override var availDiscount: [discountItems: Double] { return [.food: 10.0, .merchandise: 20.0] }
    override var discountOffers: Bool {
        return true
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

class seniorGuest : Guest {
    var propertiesEntered: Bool?
    
    
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
    var propertiesEntered: Bool? { get set }
    var passGenerated: Bool {get set}
    var firstName: String? { get set }
    var lastName: String? { get set }
    var streetAddress: String? { get set }
    var city: String? { get set }
    var state: String? { get set }
    var zip: String? { get set }
    var project: String? {get set}
    var SSN: String? {get set}
    var Birthday: String? {get set}
    var accessAreas: [String] {get set}
    var skipRideAccess: Bool {get set}
    var discountEligible: Bool { get set }
    var Age: Int? {get set}
    func ageCalculator()
    var availDiscount: [discountItems: Double] { get }
}

class FoodServices: Employee {
    var Age: Int?
    
    func ageCalculator() {
            guard let DOB = self.Birthday else {return}
            
            let Components = DOB.components(separatedBy: "/")
            var ageDOB: Date?
            if DOB != "" {
                ageDOB = Calendar.current.date(from: DateComponents(year:
                    Int(Components[2]), month: Int(Components[1]), day:
                    Int(Components[0])))
                self.Age = ageDOB?.age ?? -1
            } else {
                self.Age = -1
            }
    }
    
    
    var SSN: String?
    var Birthday: String?
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
    
    required convenience init(firstName: String, lastName: String, streetAddress: String, city: String, state: String, zip: String, SSN: String, DateOfBirth: String) {
        self.init()
        self.propertiesEntered = true
        self.firstName = firstName
        self.lastName = lastName
        self.streetAddress = streetAddress
        self.city = city
        self.state = state
        self.zip = zip
        self.SSN = SSN
        self.Birthday = DateOfBirth
    }
    
    var accessAreas: [String] = [Area.Amusement.rawValue, Area.Kitchen.rawValue]
    var skipRideAccess: Bool = false
    let availDiscount: [discountItems : Double] = [.food: 15.0, .merchandise: 25.0]
    
}

class RideServices: Employee, Passable {
    func ageCalculator() {
        guard let DOB = self.Birthday else {return}
        
        let Components = DOB.components(separatedBy: "/")
        var ageDOB: Date?
        if DOB != "" {
            ageDOB = Calendar.current.date(from: DateComponents(year:
                Int(Components[2]), month: Int(Components[1]), day:
                Int(Components[0])))
            self.Age = ageDOB?.age ?? -1
        } else {
            self.Age = -1
        }
    }
    
    var Age: Int?
    var Birthday: String?
    var SSN: String?
    
    
    
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
    
    required convenience init(firstName: String, lastName: String, streetAddress: String, city: String, state: String, zip: String, SSN: String, DateOfBirth: String) {
        self.init()
        self.propertiesEntered = true
        self.firstName = firstName
        self.lastName = lastName
        self.streetAddress = streetAddress
        self.city = city
        self.state = state
        self.zip = zip
        self.SSN = SSN
        self.Birthday = DateOfBirth
    }
    
    var accessAreas: [String] = [Area.Amusement.rawValue, Area.RideControl.rawValue]
    var skipRideAccess: Bool = false
    var discountEligible: Bool = true
    let availDiscount: [discountItems : Double] = [.food: 15.0, .merchandise: 25.0]
}

class MaintenanceServices: Employee, Passable {
    func ageCalculator() {
        guard let DOB = self.Birthday else {return}
        
        let Components = DOB.components(separatedBy: "/")
        var ageDOB: Date?
        if DOB != "" {
            ageDOB = Calendar.current.date(from: DateComponents(year:
                Int(Components[2]), month: Int(Components[1]), day:
                Int(Components[0])))
            self.Age = ageDOB?.age ?? -1
        } else {
            self.Age = -1
        }
    }
    
    var Age: Int?
    var Birthday: String?
    var SSN: String?
    
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
    
    required convenience init(firstName: String, lastName: String, streetAddress: String, city: String, state: String, zip: String, SSN: String, DateOfBirth: String) {
        self.init()
        self.propertiesEntered = true
        self.firstName = firstName
        self.lastName = lastName
        self.streetAddress = streetAddress
        self.city = city
        self.state = state
        self.zip = zip
        self.SSN = SSN
        self.Birthday = DateOfBirth
    }
    
    var accessAreas: [String] = [Area.Amusement.rawValue, Area.Maintenance.rawValue, Area.RideControl.rawValue, Area.Kitchen.rawValue]
    
    var skipRideAccess: Bool = false
    var discountEligible: Bool = true
    let availDiscount: [discountItems : Double] = [.food: 15.0, .merchandise: 25.0]
}
enum ManagerTypes: String {
    case ShiftManager = "Shift Manager"
    case GeneralManager = "General Manager"
    case SeniorManager = "Senior Manager"
}



class Manager: Employee, Passable {
    func ageCalculator() {
        guard let DOB = self.Birthday else {return}
        
        let Components = DOB.components(separatedBy: "/")
        var ageDOB: Date?
        if DOB != "" {
            ageDOB = Calendar.current.date(from: DateComponents(year:
                Int(Components[2]), month: Int(Components[1]), day:
                Int(Components[0])))
            self.Age = ageDOB?.age ?? -1
        } else {
            self.Age = -1
        }
    }
    
    var Age: Int?
    var Birthday: String?
    var SSN: String?
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
    var ManagerType: String?
    init() {
        self.propertiesEntered = false
    }
    
    required convenience init(firstName: String, lastName: String, streetAddress: String, city: String, state: String, zip: String, SSN: String, DateOfBirth: String, managerType: String) {
        self.init()
        self.propertiesEntered = true
        self.firstName = firstName
        self.lastName = lastName
        self.streetAddress = streetAddress
        self.city = city
        self.state = state
        self.zip = zip
        self.SSN = SSN
        self.Birthday = DateOfBirth
        self.ManagerType = managerType
    }
    
    var accessAreas: [String] = [Area.Amusement.rawValue, Area.Kitchen.rawValue, Area.Maintenance.rawValue, Area.Office.rawValue, Area.RideControl.rawValue]
    
    var skipRideAccess: Bool = false
    var discountEligible: Bool = true
    let availDiscount: [discountItems : Double] = [.food: 25.0, .merchandise: 25.0]
    
}


class Contractor: Employee, Passable {
    func ageCalculator() {
        guard let DOB = self.Birthday else {return}
        
        let Components = DOB.components(separatedBy: "/")
        var ageDOB: Date?
        if DOB != "" {
            ageDOB = Calendar.current.date(from: DateComponents(year:
                Int(Components[2]), month: Int(Components[1]), day:
                Int(Components[0])))
            self.Age = ageDOB?.age ?? -1
        } else {
            self.Age = -1
        }
    }
    
    var Age: Int?
    var Birthday: String?
    var SSN: String?
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
    
    required convenience init(firstName: String, lastName: String, streetAddress: String, city: String, state: String, zip: String, SSN: String, DateOfBirth: String, project: String) {
        self.init()
        self.propertiesEntered = true
        self.firstName = firstName
        self.lastName = lastName
        self.streetAddress = streetAddress
        self.city = city
        self.state = state
        self.zip = zip
        self.SSN = SSN
        self.Birthday = DateOfBirth
        self.project = project
    }
    
    var accessAreas: [String] = []
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
