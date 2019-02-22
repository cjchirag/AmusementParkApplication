


import Foundation

// 2. -> Define pass

extension String  {
    var isNumber: Bool {
        return !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
}
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

/// An object to represent the functions and properties of a guest pass

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
