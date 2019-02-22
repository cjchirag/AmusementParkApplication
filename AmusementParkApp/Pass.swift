




// 2. -> Define pass





/// This protocol is to couple the two types of pass.. struct for guest pass and class for employee pass.
protocol aPass {
    func swipeAt(area: Area) throws -> Bool
    mutating func generatePass() throws -> Bool
}
/// Errors that could arise during swipe.
enum swipeErrors: String, Error {
    case accessDenied = "Dear passholder, you do not have access to this particular area in the facility"
    case passNotGenerated = "Pass is not valid"
}
/// Errors specific to guest pass
enum ErrorsForGuest: String, Error {
    case ThisEntrantIsNotAChild = "The Entrant is not a child"
    case AgeIsMissing = "The age is missing"
    case passNotGenerated = "Pass is not valid"
}
/// An object to represent the functions and properties of a guest pass
class PassForGuest: aPass {
    var Entrant: Guest
    
    init(Entrant: Guest) {
        self.Entrant = Entrant
    }
    
    // generatePass() function is called to validate the pass. This function is necessary since it validates the properties in the Entrant object. By validating if a property of Entrant object exsist or not.. accordingly errors can be thrown.. Errors which show property is missing. If all the required property exist.. then a stored property of Entrant project "passGenerated" is set to true. passGenerated stored property is used as a flag... for all the swipe operations.. if passGenerated is true then only the operation will occur.. or else an error is thrown -> swipeErrors.passNotGenerated.
    func generatePass() throws -> Bool {
        // A pass is always generated if the Entrant is of type Guest or VIP since there are no parameters. However, if it is a child.. it is checked if the DOB is entered. Then the age is calculated and it is determined if the child should be given access according to their age.
        if Entrant is Child {
            guard let childGuest = Entrant as? Child else { throw ErrorsForGuest.ThisEntrantIsNotAChild }
            
            if childGuest.Age < 5 && childGuest.Age >= 0 && childGuest.Birthday != "" {
                self.Entrant.passGenerated = true
                print("The age is \(childGuest.Age)")
                return true
            } else if childGuest.Age == -1 {
                throw ErrorsForGuest.AgeIsMissing
            } else {
                throw ErrorsForGuest.ThisEntrantIsNotAChild
            }
        } else if Entrant is seasonPassGuest {
            if self.Entrant.firstName == "" && self.Entrant.lastName == "" && self.Entrant.zip == "" && self.Entrant.state == "" && self.Entrant.streetAddress == "" && self.Entrant.city == "" && self.Entrant.Birthday == "" {
                self.Entrant.passGenerated = false
                throw ErrorsForEmployees.AllDetailsMissing
            } else if self.Entrant.firstName == "" || self.Entrant.firstName == nil {
                throw ErrorsForEmployees.MissingFirstName
            } else if self.Entrant.lastName == "" || self.Entrant.lastName == nil {
                throw ErrorsForEmployees.MissingLastName
            }  else if self.Entrant.streetAddress == "" || self.Entrant.streetAddress == nil {
                throw ErrorsForEmployees.MissingAddress
            }  else if self.Entrant.city == "" || self.Entrant.city == nil {
                throw ErrorsForEmployees.MissingCity
            }  else if self.Entrant.state == "" || self.Entrant.state == nil {
                throw ErrorsForEmployees.MissingState
            }  else if self.Entrant.zip == "" || self.Entrant.zip == nil {
                throw ErrorsForEmployees.MissingZip
            } else if self.Entrant.Birthday == "" || self.Entrant.Birthday == nil {
                throw ErrorsForGuest.AgeIsMissing
            } else {
                self.Entrant.passGenerated = true
                return true
            }
        } else if Entrant is seniorGuest {
            guard let SeniorGuest = self.Entrant as? seniorGuest else {throw ErrorsForGuest.passNotGenerated}
            if self.Entrant.firstName == "" && self.Entrant.lastName == "" && SeniorGuest.Birthday == "" {
                self.Entrant.passGenerated = false
                throw ErrorsForEmployees.AllDetailsMissing
            } else if self.Entrant.firstName == "" || self.Entrant.firstName == nil {
                throw ErrorsForEmployees.MissingFirstName
            } else if self.Entrant.lastName == "" || self.Entrant.lastName == nil {
                throw ErrorsForEmployees.MissingLastName
            } else if SeniorGuest.Birthday == "" || self.Entrant.Birthday == nil {
                throw ErrorsForGuest.AgeIsMissing
            } else {
                self.Entrant.passGenerated = true
                return true
            }
        } else if Entrant is Guest || Entrant is VIPGuest {
            self.Entrant.passGenerated = true
            return true
        } else {
            return false
        }
    }
    
    
    func swipeAt(area: Area) throws -> Bool {
        
        
        if self.Entrant.passGenerated {
            if area == .Amusement {
                return true
            } else {
                throw swipeErrors.accessDenied
            }
            
        } else {
            throw swipeErrors.passNotGenerated
        }
    }
    
    func swipeAtRide() -> Bool {
        return true
    }
    
    func swipeToSkipRideLines() throws -> Bool {

        if self.Entrant.passGenerated {
            
            if self.Entrant.skipRideAccess {
                return true
            } else {
                throw swipeErrors.accessDenied
            }
            
        } else {
            throw swipeErrors.passNotGenerated
        }
    }
    
    func swipeToAvailDiscounts(for item: discountItems) -> Double {
        var discountValue: Double = 0.0
        if self.Entrant.passGenerated {
            if self.Entrant.discountOffers {
                let dictionaryOfDiscountValues = self.Entrant.availDiscount
                for (key, value) in dictionaryOfDiscountValues {
                    if key == item {
                        discountValue = value
                    }
                }
            }
            
        }
        return discountValue
    }        /*
        guard let passStatus = self.Entrant.passGenerated else {throw swipeErrors.passNotGenerated}
        if passStatus {
            var discountValue: Double = 0.0
            if self.Entrant is VIPGuest {
                guard let VIPEntrant = self.Entrant as? VIPGuest else {return 0.0}
                let dictionaryOfDiscountValues = VIPEntrant.availDiscount
                for (key, value) in dictionaryOfDiscountValues {
                    if key == item {
                        discountValue = value
                    }
                }
            }
            return discountValue
        } else {
            throw swipeErrors.passNotGenerated
        }
        */
    }

    


enum ErrorsForEmployees: String, Error {
    case AllDetailsMissing = "All properties are empty"
    case MissingFirstName = "The first name of the entrant is missing"
    case MissingLastName = "The last name of the entrant is missing"
    case MissingAddress = "The street address of the entrant is missing"
    case MissingCity = "The city of the entrant is missing"
    case MissingState = "The state of the entrant is missing"
    case MissingZip = "The Zip code of the entrant is missing"
    case MissingVendorCompany = "The vendor's company is missing"
    case MissingDateOfBirth = "The date of birth is missing"
    case MissingDateOfVisit = "The date of visit is missing"
    case MissingProject = "The contractor's project is missing"
    case MissingSSN = "The SSN is missing"
    case MissingManagerType = "The type of manager is missing"
}
class PassForEmployee {
    var Entrant: Employee
    
    init(Entrant: Employee){
        self.Entrant = Entrant
    }
    
    func generatePass() throws -> Bool {
        if self.Entrant is Contractor {
            if self.Entrant.firstName == "" && self.Entrant.lastName == "" && self.Entrant.zip == "" && self.Entrant.state == "" && self.Entrant.streetAddress == "" && self.Entrant.city == "" && self.Entrant.SSN == "" && self.Entrant.Birthday == "" && self.Entrant.project == "" {
                self.Entrant.passGenerated = false
                throw ErrorsForEmployees.AllDetailsMissing
            } else if self.Entrant.firstName == "" || self.Entrant.firstName == nil {
                throw ErrorsForEmployees.MissingFirstName
            } else if self.Entrant.lastName == "" || self.Entrant.lastName == nil {
                throw ErrorsForEmployees.MissingLastName
            }  else if self.Entrant.streetAddress == "" || self.Entrant.streetAddress == nil {
                throw ErrorsForEmployees.MissingAddress
            }  else if self.Entrant.city == "" || self.Entrant.city == nil {
                throw ErrorsForEmployees.MissingCity
            }  else if self.Entrant.state == "" || self.Entrant.state == nil {
                throw ErrorsForEmployees.MissingState
            }  else if self.Entrant.zip == "" || self.Entrant.zip == nil {
                throw ErrorsForEmployees.MissingZip
            } else if self.Entrant.Birthday == "" || self.Entrant.Birthday == nil {
                throw ErrorsForEmployees.MissingDateOfBirth
            } else if self.Entrant.SSN == "" || self.Entrant.SSN == nil {
                throw ErrorsForEmployees.MissingSSN
            } else if self.Entrant.project == "" || self.Entrant.project == nil {
                throw ErrorsForEmployees.MissingProject
            } else {
                self.Entrant.passGenerated = true
                return true
            }
        } else if Entrant is Manager {
            guard let theManager = self.Entrant as? Manager else {throw ErrorsForEmployees.AllDetailsMissing}
            if self.Entrant.firstName == "" && self.Entrant.lastName == "" && self.Entrant.zip == "" && self.Entrant.state == "" && self.Entrant.streetAddress == "" && self.Entrant.city == "" && self.Entrant.SSN == "" && self.Entrant.Birthday == "" && theManager.ManagerType == "" {
                self.Entrant.passGenerated = false
                throw ErrorsForEmployees.AllDetailsMissing
            } else if self.Entrant.firstName == "" || self.Entrant.firstName == nil {
                throw ErrorsForEmployees.MissingFirstName
            } else if self.Entrant.lastName == "" || self.Entrant.lastName == nil {
                throw ErrorsForEmployees.MissingLastName
            }  else if self.Entrant.streetAddress == "" || self.Entrant.streetAddress == nil {
                throw ErrorsForEmployees.MissingAddress
            }  else if self.Entrant.city == "" || self.Entrant.city == nil {
                throw ErrorsForEmployees.MissingCity
            }  else if self.Entrant.state == "" || self.Entrant.state == nil {
                throw ErrorsForEmployees.MissingState
            }  else if self.Entrant.zip == "" || self.Entrant.zip == nil {
                throw ErrorsForEmployees.MissingZip
            } else if self.Entrant.Birthday == "" || self.Entrant.Birthday == nil {
                throw ErrorsForEmployees.MissingDateOfBirth
            } else if self.Entrant.SSN == "" || self.Entrant.SSN == nil {
                throw ErrorsForEmployees.MissingSSN
            } else if theManager.ManagerType == "" || theManager.ManagerType == nil{
                throw ErrorsForEmployees.MissingManagerType
            } else {
                self.Entrant.passGenerated = true
                return true
            }
        } else {
            if self.Entrant.firstName == "" && self.Entrant.lastName == "" && self.Entrant.zip == "" && self.Entrant.state == "" && self.Entrant.streetAddress == "" && self.Entrant.city == "" && self.Entrant.SSN == "" && self.Entrant.Birthday == "" {
                self.Entrant.passGenerated = false
                throw ErrorsForEmployees.AllDetailsMissing
            } else if self.Entrant.firstName == "" || self.Entrant.firstName == nil {
                throw ErrorsForEmployees.MissingFirstName
            } else if self.Entrant.lastName == "" || self.Entrant.lastName == nil {
                throw ErrorsForEmployees.MissingLastName
            }  else if self.Entrant.streetAddress == "" || self.Entrant.streetAddress == nil {
                throw ErrorsForEmployees.MissingAddress
            }  else if self.Entrant.city == "" || self.Entrant.city == nil {
                throw ErrorsForEmployees.MissingCity
            }  else if self.Entrant.state == "" || self.Entrant.state == nil {
                throw ErrorsForEmployees.MissingState
            }  else if self.Entrant.zip == "" || self.Entrant.zip == nil {
                throw ErrorsForEmployees.MissingZip
            } else if self.Entrant.Birthday == "" || self.Entrant.Birthday == nil {
                throw ErrorsForEmployees.MissingDateOfBirth
            } else if self.Entrant.SSN == "" || self.Entrant.SSN == nil {
                throw ErrorsForEmployees.MissingSSN
            } else {
                self.Entrant.passGenerated = true
                return true
            }
        }
    }
    
    func swipeToSkipRideLines() throws -> Bool {
        
        if self.Entrant.passGenerated {
            if self.Entrant.skipRideAccess {
                return true
            } else {
                throw swipeErrors.accessDenied
            }
        } else {
            throw swipeErrors.passNotGenerated
        }
    }
    
    func swipeToAvailDiscounts(for item: discountItems) -> Double {
        var discountValue: Double = 0.0
        if self.Entrant.passGenerated {
            
            let dictionaryOfDiscountValues = self.Entrant.availDiscount
            for (key, value) in dictionaryOfDiscountValues {
                if key == item {
                    discountValue = value
                }
            }
          
        }
          return discountValue
    }
    func swipeAtRide() -> Bool {
        if self.Entrant is Contractor {
            return false
        } else {
            return true
        }
    }
    func swipeAt(area: Area) throws -> Bool {
        
        if self.Entrant.passGenerated {
            if self.Entrant is Manager {
                // Since manager has access to all areas in the site
                return true
            } else if self.Entrant is Contractor {
                var accessStatus: Bool?
                
                 if self.Entrant.project == ProjectClassifications.P1001.rawValue {
                 if area == .Amusement {
                 accessStatus = false
                 } else if area == .Kitchen {
                 accessStatus = true
                 } else if area == .Maintenance {
                 accessStatus = false
                 } else if area == .Office {
                 accessStatus = false
                 } else if area == .RideControl {
                 accessStatus = false
                 }
                 } else if self.Entrant.project == ProjectClassifications.P1002.rawValue {
                 if area == .Amusement {
                 accessStatus = true
                 } else if area == .Kitchen {
                 accessStatus = true
                 } else if area == .Maintenance {
                 accessStatus = false
                 } else if area == .Office {
                 accessStatus = false
                 } else if area == .RideControl {
                 accessStatus = true
                 }
                 }else if self.Entrant.project == ProjectClassifications.P1003.rawValue {
                 if area == .Amusement {
                 accessStatus = false
                 } else if area == .Kitchen {
                 accessStatus = false
                 } else if area == .Maintenance {
                 accessStatus = true
                 } else if area == .Office {
                 accessStatus = true
                 } else if area == .RideControl {
                 accessStatus = false
                 }
                 }else if self.Entrant.project == ProjectClassifications.P2001.rawValue {
                 if area == .Amusement {
                 accessStatus = true
                 } else if area == .Kitchen {
                 accessStatus = true
                 } else if area == .Maintenance {
                 accessStatus = true
                 } else if area == .Office {
                 accessStatus = true
                 } else if area == .RideControl {
                 accessStatus = true
                 }
                 } else if self.Entrant.project == ProjectClassifications.P2002.rawValue {
                 if area == .Amusement {
                 accessStatus = true
                 } else if area == .Kitchen {
                 accessStatus = true
                 } else if area == .Maintenance {
                 accessStatus = true
                 } else if area == .Office {
                 accessStatus = true
                 } else if area == .RideControl {
                 accessStatus = true
                 }
                 } else {
                 throw ErrorsForEmployees.MissingProject
                 }
                guard let accessResponse = accessStatus else {throw ErrorsForEmployees.MissingProject}
                return accessResponse
            } else {
                var access: Bool = false
                for allowedArea in self.Entrant.accessAreas {
                    if allowedArea == area {
                        access = true
                    } else {
                        access = false
                    }
                }
                if access == true {
                    return true
                } else {
                    throw swipeErrors.accessDenied
                }
            }
            
        } else {
            throw swipeErrors.passNotGenerated
        }
    }
}

class passForVendor {
    var Entrant: Vendor
    
    init(Entrant: Vendor) {
        self.Entrant = Entrant
    }
    func generatePass() throws -> Bool {
        if self.Entrant.firstName == "" && self.Entrant.lastName == "" && self.Entrant.dateOfVisit == "" && self.Entrant.dateOfBirth == "" && self.Entrant.vendorCompany == "" {
            self.Entrant.passGenerated = false
            throw ErrorsForEmployees.AllDetailsMissing
        } else if self.Entrant.firstName == "" || self.Entrant.firstName == nil {
            throw ErrorsForEmployees.MissingFirstName
        } else if self.Entrant.lastName == "" || self.Entrant.lastName == nil {
            throw ErrorsForEmployees.MissingLastName
        }  else if self.Entrant.vendorCompany == "" || self.Entrant.vendorCompany == nil {
            throw ErrorsForEmployees.MissingVendorCompany
        }  else if self.Entrant.dateOfBirth == "" || self.Entrant.dateOfBirth == nil {
            throw ErrorsForEmployees.MissingDateOfBirth
        }  else if self.Entrant.dateOfVisit == "" || self.Entrant.dateOfVisit == nil {
            throw ErrorsForEmployees.MissingDateOfVisit
        } else {
            self.Entrant.passGenerated = true
            return true
        }
    }
    func swipeToSkipRideLines() throws -> Bool {
        return self.Entrant.skipRideAccess
    }
    
    func swipeToAvailDiscounts(for item: discountItems) -> Double {
        return 0.0
    }
    
    func swipeAtRide() -> Bool {
        return false
    }
    
    func swipeAt(area: Area) throws -> Bool {
            guard let theCompany = self.Entrant.vendorCompany else { throw ErrorsForEmployees.MissingVendorCompany }
            var accessStatus: Bool?
            if theCompany == VendorCompanies.Acme.rawValue {
                if area == .Amusement {
                    accessStatus = false
                } else if area == .Kitchen {
                    accessStatus = true
                } else if area == .Maintenance {
                    accessStatus = false
                } else if area == .Office {
                    accessStatus = false
                } else if area == .RideControl {
                    accessStatus = false
                }
            } else if theCompany == VendorCompanies.Orkin.rawValue {
                if area == .Amusement {
                    accessStatus = true
                } else if area == .Kitchen {
                    accessStatus = true
                } else if area == .Maintenance {
                    accessStatus = false
                } else if area == .Office {
                    accessStatus = false
                } else if area == .RideControl {
                    accessStatus = true
                }
            }else if theCompany == VendorCompanies.Fedex.rawValue {
                if area == .Amusement {
                    accessStatus = false
                } else if area == .Kitchen {
                    accessStatus = false
                } else if area == .Maintenance {
                    accessStatus = true
                } else if area == .Office {
                    accessStatus = true
                } else if area == .RideControl {
                    accessStatus = false
                }
            }else if theCompany == VendorCompanies.NWElectrical.rawValue {
                if area == .Amusement {
                    accessStatus = true
                } else if area == .Kitchen {
                    accessStatus = true
                } else if area == .Maintenance {
                    accessStatus = true
                } else if area == .Office {
                    accessStatus = true
                } else if area == .RideControl {
                    accessStatus = true
                }
            }
            else {
                throw ErrorsForEmployees.MissingVendorCompany
            }
        guard let accessResponse = accessStatus else { throw ErrorsForEmployees.MissingVendorCompany }
        if accessResponse {
            return true
        } else {
            throw swipeErrors.accessDenied
        }
    }
}

