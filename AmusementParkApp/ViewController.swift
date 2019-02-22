//
//  ViewController.swift
//  AmusementParkApp
//
//  Created by chirag on 21/07/18.
//  Copyright © 2018 Chirag Jadhwani. All rights reserved.
// WedFinal

import UIKit

protocol Passable {
    
}

extension UIStackView {
    
    func addBackground(color: UIColor) {
        let subview = UIView(frame: bounds)
        subview.backgroundColor = color
        subview.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(subview, at: 0)
    }
    
}








var GuestEntrant: Guest?
var EmployeeEntrant: Employee?
var VendorEntrant: Vendor?
var ThePassForGuest: PassForGuest?
var ThePassForEmployee: PassForEmployee?
var ThePassForVendor: passForVendor?

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    let ProjectPicker = UIPickerView()
    let CompanyPicker = UIPickerView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        subOptionOne.addTarget(self, action: #selector(CallOption1), for: UIControlEvents.touchUpInside)
        subOptionTwo.addTarget(self, action: #selector(CallOption2), for: UIControlEvents.touchUpInside)
        subOptionThree.addTarget(self, action: #selector(CallOption3), for: UIControlEvents.touchUpInside)
        subOptionFour.addTarget(self, action: #selector(CallOption4), for: UIControlEvents.touchUpInside)
        subOptionFive.addTarget(self, action: #selector(CallOption5), for: UIControlEvents.touchUpInside)
        ProjectPicker.delegate = self
        CompanyPicker.delegate = self
        ProjectField.inputView = ProjectPicker
        CompanyField.inputView = CompanyPicker
        showDatePicker(sender: birthdayPicker)
        showDatePicker(sender: visitPicker)
        DateOfBirthField.text = nil
        DateOfBirthField.isUserInteractionEnabled = false
        
        SSNField.text = nil
        SSNField.isUserInteractionEnabled = false
        
        ProjectField.text = nil
        ProjectField.isUserInteractionEnabled = false
        
        FirstNameField.text = nil
        FirstNameField.isUserInteractionEnabled = false
        
        LastNameField.text = nil
        LastNameField.isUserInteractionEnabled = false
        
        CompanyField.text = nil
        CompanyField.isUserInteractionEnabled = false
        
        DateOfVisitField.text = nil
        DateOfVisitField.isUserInteractionEnabled = false
        
        StreetAddressField.text = nil
        StreetAddressField.isUserInteractionEnabled = false
        
        CityField.text = nil
        CityField.isUserInteractionEnabled = false
        
        StateField.text = nil
        StateField.isUserInteractionEnabled = false
        
        ZipField.text = nil
        ZipField.isUserInteractionEnabled = false
        firstLevel.addBackground(color: UIColor(red: 30/255, green: 101/255, blue: 109/255, alpha: 1.0))
        subOptionOne.setTitleColor(UIColor.white, for: .normal)
        subOptionTwo.setTitleColor(UIColor.white, for: .normal)
        subOptionThree.setTitleColor(UIColor.white, for: .normal)
        subOptionFour.setTitleColor(UIColor.white, for: .normal)
        subOptionFive.setTitleColor(UIColor.white, for: .normal)
        secondaryLevel.addBackground(color: UIColor(red: 241/255, green: 243/255, blue: 206/255, alpha: 0.5))
        /*
        backgroundView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        backgroundView.heightAnchor.constraint(equalTo: firstLevel.heightAnchor)
        backgroundView.trailingAnchor.constraint(equalTo: firstLevel.trailingAnchor)
        backgroundView.leadingAnchor.constraint(equalTo: firstLevel.leadingAnchor)
        backgroundView.bottomAnchor.constraint(equalTo: firstLevel.bottomAnchor)
        backgroundView.topAnchor.constraint(equalTo: firstLevel.topAnchor)
        */
    }
    
    // MARK:  Alerts handler
    
    //
    
    
    let Projects: [String] = ["",ProjectClassifications.P1001.rawValue, ProjectClassifications.P1002.rawValue, ProjectClassifications.P1003.rawValue, ProjectClassifications.P2001.rawValue, ProjectClassifications.P2002.rawValue]
    let Companies: [String] = ["",VendorCompanies.Acme.rawValue, VendorCompanies.Fedex.rawValue, VendorCompanies.NWElectrical.rawValue, VendorCompanies.Orkin.rawValue]
    
    @IBOutlet weak var firstLevel: UIStackView!

    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == ProjectPicker {
            return Projects.count
            
        } else if pickerView == CompanyPicker {
            return Companies.count
        } else {
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == ProjectPicker {
            return Projects[row]
        } else if pickerView == CompanyPicker {
            return Companies[row]
        } else {
            return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == ProjectPicker {
            ProjectField.text = Projects[row]
        } else if pickerView == CompanyPicker {
            CompanyField.text = Companies[row]
        }
    }

    
    
    
    
    // Outlets
    
    @IBOutlet weak var MainGuestButton: UIButton!
    @IBOutlet weak var MainEmployeeButton: UIButton!
    @IBOutlet weak var MainManagerButton: UIButton!
    @IBOutlet weak var MainVendorButton: UIButton!
    @IBOutlet weak var DateOfBirthField: UITextField!
    @IBOutlet weak var SSNField: UITextField!
    @IBOutlet weak var ProjectField: UITextField!
    @IBOutlet weak var FirstNameField: UITextField!
    @IBOutlet weak var LastNameField: UITextField!
    @IBOutlet weak var CompanyField: UITextField!
    @IBOutlet weak var DateOfVisitField: UITextField!
    @IBOutlet weak var StreetAddressField: UITextField!
    @IBOutlet weak var CityField: UITextField!
    @IBOutlet weak var StateField: UITextField!
    @IBOutlet weak var ZipField: UITextField!
    @IBOutlet weak var secondaryLevel: UIStackView!
    
    
    
    let birthdayPicker = UIDatePicker()
    let visitPicker = UIDatePicker()
    func showDatePicker(sender: UIDatePicker){
        
        if sender == birthdayPicker {
            //Formate Date
            birthdayPicker.datePickerMode = .date
            
            //ToolBar
            let toolbar = UIToolbar();
            toolbar.sizeToFit()
            let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneBirthdayPicker));
            let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
            let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
            
            toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
            
            DateOfBirthField.inputAccessoryView = toolbar
            DateOfBirthField.inputView = birthdayPicker
        } else if sender == visitPicker {
            //Formate Date
            visitPicker.datePickerMode = .date
            
            //ToolBar
            let toolbar = UIToolbar();
            toolbar.sizeToFit()
            let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneVisitPicker));
            let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
            let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
            
            toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
            
            DateOfVisitField.inputAccessoryView = toolbar
            DateOfVisitField.inputView = visitPicker
        }
    }
    
    @objc func doneBirthdayPicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        DateOfBirthField.text = formatter.string(from: birthdayPicker.date)
        self.view.endEditing(true)
    }
    @objc func doneVisitPicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        DateOfVisitField.text = formatter.string(from: visitPicker.date)
        self.view.endEditing(true)
    }
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    

    
    // Initially when the app is launched.. by default guest is selected
    
    enum entrantTypes {
        case Guest
        case Employee
        case Manager
        case Vendor
    }
    
    enum subOptions {
        case Child
        case Adult
        case VIP
        case SeasonPass
        case Senior
        case FoodServices
        case RideServices
        case MaintenanceServices
        case Contractor
        case Vendor
        case Manager
    }
    
    var track: [entrantTypes] = []
    var subOptionOne: UIButton = UIButton(type: .system)
    var subOptionTwo: UIButton = UIButton(type: .system)
    var subOptionThree: UIButton = UIButton(type: .system)
    var subOptionFour: UIButton = UIButton(type: .system)
    var subOptionFive: UIButton = UIButton(type: .system)

    //
    
    @IBAction func toActivateGuest(_ sender: Any) {
        track.append(.Guest)

        for view in secondaryLevel.arrangedSubviews {
            secondaryLevel.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
        subOptionOne.setTitle("Child", for: .normal)
        subOptionTwo.setTitle("Adult", for: .normal)
        subOptionThree.setTitle("VIP", for: .normal)
        subOptionFour.setTitle("Season Pass", for: .normal)
        subOptionFive.setTitle("Senior", for: .normal)
        secondaryLevel.addArrangedSubview(subOptionOne)
        secondaryLevel.addArrangedSubview(subOptionTwo)
        secondaryLevel.addArrangedSubview(subOptionThree)
        secondaryLevel.addArrangedSubview(subOptionFour)
        secondaryLevel.addArrangedSubview(subOptionFive)
        DateOfBirthField.text = ""
        DateOfBirthField.isUserInteractionEnabled = true
        
        SSNField.text = nil
        SSNField.isUserInteractionEnabled = false
        
        ProjectField.text = nil
        ProjectField.isUserInteractionEnabled = false
        
        FirstNameField.text = ""
        FirstNameField.isUserInteractionEnabled = true
        
        LastNameField.text = ""
        LastNameField.isUserInteractionEnabled = true
        
        CompanyField.text = nil
        CompanyField.isUserInteractionEnabled = false
        
        DateOfVisitField.text = nil
        DateOfVisitField.isUserInteractionEnabled = false
        
        StreetAddressField.text = ""
        StreetAddressField.isUserInteractionEnabled = true
        
        CityField.text = ""
        CityField.isUserInteractionEnabled = true
        
        StateField.text = ""
        StateField.isUserInteractionEnabled = true
        
        ZipField.text = ""
        ZipField.isUserInteractionEnabled = true
    }
    
    

    
    
    var subTracker: [subOptions] = []
    
    @objc func CallOption2() {
        if track.last == .Guest {
            subButtonsForGuest(entrant: subOptionTwo)
            
        } else if track.last == .Employee {
            subButtonsForEmployees(entrant: subOptionTwo)
        } else if track.last == .Manager {
            subButtonsForManagers(entrant: subOptionTwo)
        }
    }
    
    @objc func CallOption1() {
        if track.last == .Guest {
            subButtonsForGuest(entrant: subOptionOne)
        } else if track.last == .Employee {
            subButtonsForEmployees(entrant: subOptionOne)
        } else if track.last == .Manager {
            subButtonsForManagers(entrant: subOptionOne)
        }
    }
    
    @objc func CallOption3() {
        if track.last == .Guest {
            subButtonsForGuest(entrant: subOptionThree)
        } else if track.last == .Employee {
            subButtonsForEmployees(entrant: subOptionThree)
        } else if track.last == .Manager {
            subButtonsForManagers(entrant: subOptionThree)
        }
    }
    
    @objc func CallOption4() {
        if track.last == .Guest {
            subButtonsForGuest(entrant: subOptionFour)
        } else if track.last == .Employee {
            subButtonsForEmployees(entrant: subOptionFour)
        }
    }
    
    @objc func CallOption5() {
        if track.last == .Guest {
            subButtonsForGuest(entrant: subOptionFive)
        }
    }
    
    
    func subButtonsForGuest(entrant: UIButton) {
        if entrant == subOptionOne {
            subTracker.append(.Child)
            //UIChanges
            
            
            
        } else if entrant == subOptionTwo {
            subTracker.append(.Adult)
            //UIChanges
            
            
            
            
        } else if entrant == subOptionThree {
            subTracker.append(.VIP)
            
            //UIChanges
            
            
            
        } else if entrant == subOptionFour{
            subTracker.append(.SeasonPass)
            //UIChanges
            
        } else if entrant == subOptionFive {
            subTracker.append(.Senior)
            
            
        }
    }
    
    func subButtonsForEmployees(entrant: UIButton) {
        if entrant == subOptionOne {
            subTracker.append(.FoodServices)
        } else if entrant == subOptionTwo {
            subTracker.append(.RideServices)
        } else if entrant == subOptionThree {
            subTracker.append(.MaintenanceServices)
        } else if entrant == subOptionFour {
            subTracker.append(.Contractor)
        }
    }
    var managerTrack: [ManagerTypes] = []
    func subButtonsForManagers(entrant: UIButton) {
        if entrant == subOptionOne {
            managerTrack.append(.ShiftManager)
        } else if entrant == subOptionTwo {
            managerTrack.append(.GeneralManager)
        } else if entrant == subOptionThree {
            managerTrack.append(.SeniorManager)
        }
    }
    
    
    

    
    @IBAction func toActivateEmployee(_ sender: Any) {
        track.append(.Employee)
     
        for view in secondaryLevel.arrangedSubviews {
            secondaryLevel.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
        subOptionOne.setTitle("Food Services", for: .normal)
        subOptionTwo.setTitle("Ride Services", for: .normal)
        subOptionThree.setTitle("Maintenance", for: .normal)
        subOptionFour.setTitle("Contractor", for: .normal)
        secondaryLevel.addArrangedSubview(subOptionOne)
        secondaryLevel.addArrangedSubview(subOptionTwo)
        secondaryLevel.addArrangedSubview(subOptionThree)
        secondaryLevel.addArrangedSubview(subOptionFour)
        
        DateOfBirthField.text = ""
        DateOfBirthField.isUserInteractionEnabled = true
        
        SSNField.text = ""
        SSNField.isUserInteractionEnabled = true
        
        ProjectField.text = ""
        ProjectField.isUserInteractionEnabled = true
        
        FirstNameField.text = ""
        FirstNameField.isUserInteractionEnabled = true
        
        LastNameField.text = ""
        LastNameField.isUserInteractionEnabled = true
        
        CompanyField.text = nil
        CompanyField.isUserInteractionEnabled = false
        
        DateOfVisitField.text = nil
        DateOfVisitField.isUserInteractionEnabled = false
        
        StreetAddressField.text = ""
        StreetAddressField.isUserInteractionEnabled = true
        
        CityField.text = ""
        CityField.isUserInteractionEnabled = true
        
        StateField.text = ""
        StateField.isUserInteractionEnabled = true
        
        ZipField.text = ""
        ZipField.isUserInteractionEnabled = true
    }
    
    @IBAction func toActivateManager(_ sender: Any) {
        track.append(.Manager)
        subTracker.append(.Manager)
        for view in secondaryLevel.arrangedSubviews {
            secondaryLevel.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
        subOptionOne.setTitle("Shift Manager", for: .normal)
        subOptionTwo.setTitle("General Manager", for: .normal)
        subOptionThree.setTitle("Senior Manager", for: .normal)
        secondaryLevel.addArrangedSubview(subOptionOne)
        secondaryLevel.addArrangedSubview(subOptionTwo)
        secondaryLevel.addArrangedSubview(subOptionThree)
        DateOfBirthField.text = ""
        DateOfBirthField.isUserInteractionEnabled = true
        
        SSNField.text = ""
        SSNField.isUserInteractionEnabled = true
        
        ProjectField.text = nil
        ProjectField.isUserInteractionEnabled = false
        
        FirstNameField.text = ""
        FirstNameField.isUserInteractionEnabled = true
        
        LastNameField.text = ""
        LastNameField.isUserInteractionEnabled = true
        
        CompanyField.text = nil
        CompanyField.isUserInteractionEnabled = false
        
        DateOfVisitField.text = nil
        DateOfVisitField.isUserInteractionEnabled = false
        
        StreetAddressField.text = ""
        StreetAddressField.isUserInteractionEnabled = true
        
        CityField.text = ""
        CityField.isUserInteractionEnabled = true
        
        StateField.text = ""
        StateField.isUserInteractionEnabled = true
        
        ZipField.text = ""
        ZipField.isUserInteractionEnabled = true
        
    }
    
    @IBAction func toActivateVendor(_ sender: Any) {
        track.append(.Vendor)
        subTracker.append(.Vendor)
        for view in secondaryLevel.arrangedSubviews {
            secondaryLevel.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
        DateOfBirthField.text = ""
        DateOfBirthField.isUserInteractionEnabled = true
        
        SSNField.text = nil
        SSNField.isUserInteractionEnabled = false
        
        ProjectField.text = nil
        ProjectField.isUserInteractionEnabled = false
        
        FirstNameField.text = ""
        FirstNameField.isUserInteractionEnabled = true
        
        LastNameField.text = ""
        LastNameField.isUserInteractionEnabled = true
        
        CompanyField.text = ""
        CompanyField.isUserInteractionEnabled = true
        
        DateOfVisitField.text = ""
        DateOfVisitField.isUserInteractionEnabled = true
        
        StreetAddressField.text = nil
        StreetAddressField.isUserInteractionEnabled = false
        
        CityField.text = nil
        CityField.isUserInteractionEnabled = false
        
        StateField.text = nil
        StateField.isUserInteractionEnabled = false
        
        ZipField.text = nil
        ZipField.isUserInteractionEnabled = false
    }
    
    
    
    //
    
 
    enum ErrorsForPassGeneration: Error {
        case EnterUser
        case ErrorInPassGeneration
        case someError
    }
    
    func passGeneration(Entrant: subOptions) throws -> Bool {
        // guest pass generation begin!
        
        var result: Bool?
        
        if Entrant == .Child {
            print("Generating pass for Child")
            guard let DOB = DateOfBirthField.text else {throw ErrorsForGuest.AgeIsMissing}
            do {
            GuestEntrant = Child(Birthday: DOB)
            guard let guest = GuestEntrant else {throw ErrorsForPassGeneration.EnterUser}
            ThePassForGuest = PassForGuest(Entrant: guest)
            guard let pass = ThePassForGuest else {throw ErrorsForPassGeneration.ErrorInPassGeneration}
            result = try pass.generatePass()
            
            ThePassForVendor = nil
            VendorEntrant = nil
            EmployeeEntrant = nil
            ThePassForEmployee = nil
            } catch ErrorsForGuest.AgeIsMissing {
                // handle errors
                let alert = UIAlertController(title: "Error", message: "Please fill in the required details: Birthday", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } catch ErrorsForGuest.ThisEntrantIsNotAChild {
                let alert = UIAlertController(title: "Error", message: "Please select a valid option", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } catch ErrorsForPassGeneration.EnterUser {
                let alert = UIAlertController(title: "Error", message: "Please select a user", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } catch ErrorsForPassGeneration.ErrorInPassGeneration {
                let alert = UIAlertController(title: "Error", message: "Please select a valid user", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        } else if Entrant == .Adult {
            print("Generating pass for Adult")
            do {
                GuestEntrant = Guest()
                guard let guest = GuestEntrant else {throw ErrorsForPassGeneration.EnterUser}
                ThePassForGuest = PassForGuest(Entrant: guest)
                guard let pass = ThePassForGuest else {throw ErrorsForPassGeneration.ErrorInPassGeneration}
                result = try pass.generatePass()
                ThePassForVendor = nil
                VendorEntrant = nil
                EmployeeEntrant = nil
                ThePassForEmployee = nil
            } catch ErrorsForPassGeneration.EnterUser {
                let alert = UIAlertController(title: "Error", message: "Please select a user", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } catch ErrorsForPassGeneration.ErrorInPassGeneration {
                let alert = UIAlertController(title: "Error", message: "Please select a valid user", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        } else if Entrant == .VIP {
            print("Generating pass for VIP")
            do {
                GuestEntrant = VIPGuest()
                guard let guest = GuestEntrant else {throw ErrorsForPassGeneration.EnterUser}
                ThePassForGuest = PassForGuest(Entrant: guest)
                guard let pass = ThePassForGuest else {throw ErrorsForPassGeneration.ErrorInPassGeneration}
                result = try pass.generatePass()
                
                ThePassForVendor = nil
                VendorEntrant = nil
                EmployeeEntrant = nil
                ThePassForEmployee = nil
            } catch ErrorsForPassGeneration.EnterUser {
                let alert = UIAlertController(title: "Error", message: "Please select a user", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } catch ErrorsForPassGeneration.ErrorInPassGeneration {
                let alert = UIAlertController(title: "Error", message: "Please select a valid user", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        } else if Entrant == .SeasonPass {
            print("Generating pass for Season Pass Holder")
            do {
                guard let FirstName = FirstNameField.text else {throw ErrorsForEmployees.MissingFirstName}
                guard let LastName = LastNameField.text else {throw ErrorsForEmployees.MissingLastName}
                guard let StreetAddress = StreetAddressField.text else {throw ErrorsForEmployees.MissingAddress}
                guard let City = CityField.text else {throw ErrorsForEmployees.MissingCity}
                guard let State = StateField.text else {throw ErrorsForEmployees.MissingState}
                guard let ZipCode = ZipField.text else {throw ErrorsForEmployees.MissingZip}
                guard let DOB = DateOfBirthField.text else {throw ErrorsForGuest.AgeIsMissing}
                GuestEntrant = seasonPassGuest(firstName: FirstName, lastName: LastName, streetAddress: StreetAddress, city: City, state: State, zip: ZipCode, DateOfBirth: DOB)
                guard let guest = GuestEntrant else {throw ErrorsForPassGeneration.EnterUser}
                ThePassForGuest = PassForGuest(Entrant: guest)
                guard let pass = ThePassForGuest else {throw ErrorsForPassGeneration.ErrorInPassGeneration}
                result = try pass.generatePass()
                
                ThePassForVendor = nil
                VendorEntrant = nil
                EmployeeEntrant = nil
                ThePassForEmployee = nil
            } catch ErrorsForPassGeneration.EnterUser {
                let alert = UIAlertController(title: "Error", message: "Please select a user", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } catch ErrorsForPassGeneration.ErrorInPassGeneration {
                let alert = UIAlertController(title: "Error", message: "Please select a valid user", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } catch ErrorsForEmployees.AllDetailsMissing {
                let alert = UIAlertController(title: "Error", message: ErrorsForEmployees.AllDetailsMissing.rawValue, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } catch ErrorsForEmployees.MissingFirstName {
                let alert = UIAlertController(title: "Error", message: ErrorsForEmployees.MissingFirstName.rawValue, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } catch ErrorsForEmployees.MissingLastName {
                let alert = UIAlertController(title: "Error", message: ErrorsForEmployees.MissingLastName.rawValue, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } catch ErrorsForEmployees.MissingAddress {
                let alert = UIAlertController(title: "Error", message: ErrorsForEmployees.MissingAddress.rawValue, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } catch ErrorsForEmployees.MissingCity {
                let alert = UIAlertController(title: "Error", message: ErrorsForEmployees.MissingCity.rawValue, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } catch ErrorsForEmployees.MissingState {
                let alert = UIAlertController(title: "Error", message: ErrorsForEmployees.MissingState.rawValue, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }catch ErrorsForEmployees.MissingZip {
                let alert = UIAlertController(title: "Error", message: ErrorsForEmployees.MissingZip.rawValue, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } catch ErrorsForGuest.AgeIsMissing {
                let alert = UIAlertController(title: "Error", message: ErrorsForGuest.AgeIsMissing.rawValue, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } catch ErrorsForGuest.invalidZip {
                let alert = UIAlertController(title: "Error", message: ErrorsForGuest.invalidZip.rawValue, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        } else if Entrant == .Senior {
            // ZIP CODE VALIDATION
            do {
                guard let FirstName = FirstNameField.text else {throw ErrorsForEmployees.MissingFirstName}
                guard let LastName = LastNameField.text else {throw ErrorsForEmployees.MissingLastName}
                guard let Birthday = DateOfBirthField.text else { throw ErrorsForGuest.AgeIsMissing}
                GuestEntrant = seniorGuest(firstName: FirstName, lastName: LastName, DateOfBirth: Birthday)
                guard let guest = GuestEntrant else {throw ErrorsForPassGeneration.EnterUser}
                ThePassForGuest = PassForGuest(Entrant: guest)
                guard let pass = ThePassForGuest else {throw ErrorsForPassGeneration.ErrorInPassGeneration}
                result = try pass.generatePass()
                
                ThePassForVendor = nil
                VendorEntrant = nil
                EmployeeEntrant = nil
                ThePassForEmployee = nil
            } catch ErrorsForPassGeneration.EnterUser {
                let alert = UIAlertController(title: "Error", message: "Please select a user", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } catch ErrorsForPassGeneration.ErrorInPassGeneration {
                let alert = UIAlertController(title: "Error", message: "Please select a valid user", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } catch ErrorsForEmployees.AllDetailsMissing {
                let alert = UIAlertController(title: "Error", message: ErrorsForEmployees.AllDetailsMissing.rawValue, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } catch ErrorsForEmployees.MissingFirstName {
                let alert = UIAlertController(title: "Error", message: ErrorsForEmployees.MissingFirstName.rawValue, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } catch ErrorsForEmployees.MissingLastName {
                let alert = UIAlertController(title: "Error", message: ErrorsForEmployees.MissingLastName.rawValue, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } catch ErrorsForGuest.AgeIsMissing {
                let alert = UIAlertController(title: "Error", message: ErrorsForGuest.AgeIsMissing.rawValue, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        } else if Entrant == .FoodServices {
            
            do {
                guard let FirstName = FirstNameField.text else {throw ErrorsForEmployees.MissingFirstName}
                guard let LastName = LastNameField.text else {throw ErrorsForEmployees.MissingLastName}
                guard let StreetAddress = StreetAddressField.text else {throw ErrorsForEmployees.MissingAddress}
                guard let City = CityField.text else {throw ErrorsForEmployees.MissingCity}
                guard let State = StateField.text else {throw ErrorsForEmployees.MissingState}
                guard let ZipCode = ZipField.text else {throw ErrorsForEmployees.MissingZip}
                guard let SSNO = SSNField.text else {throw ErrorsForEmployees.MissingSSN}
                guard let DOB = DateOfBirthField.text else {throw ErrorsForEmployees.MissingDateOfBirth}
                EmployeeEntrant = FoodServices(firstName: FirstName, lastName: LastName, streetAddress: StreetAddress, city: City, state: State, zip: ZipCode, SSN: SSNO, DateOfBirth: DOB)
                guard let employee = EmployeeEntrant else {throw ErrorsForPassGeneration.EnterUser}
                ThePassForEmployee = PassForEmployee(Entrant: employee)
                guard let pass = ThePassForEmployee else {throw ErrorsForPassGeneration.ErrorInPassGeneration}
                result = try pass.generatePass()
                ThePassForVendor = nil
                VendorEntrant = nil
                GuestEntrant = nil
                ThePassForGuest = nil
            } catch ErrorsForPassGeneration.EnterUser {
                let alert = UIAlertController(title: "Error", message: "Please select a user", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } catch ErrorsForPassGeneration.ErrorInPassGeneration {
                let alert = UIAlertController(title: "Error", message: "Please select a valid user", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } catch ErrorsForEmployees.AllDetailsMissing {
                let alert = UIAlertController(title: "Error", message: ErrorsForEmployees.AllDetailsMissing.rawValue, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } catch ErrorsForEmployees.MissingFirstName {
                let alert = UIAlertController(title: "Error", message: ErrorsForEmployees.MissingFirstName.rawValue, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } catch ErrorsForEmployees.MissingLastName {
                let alert = UIAlertController(title: "Error", message: ErrorsForEmployees.MissingLastName.rawValue, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } catch ErrorsForEmployees.MissingAddress {
                let alert = UIAlertController(title: "Error", message: ErrorsForEmployees.MissingAddress.rawValue, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } catch ErrorsForEmployees.MissingCity {
                let alert = UIAlertController(title: "Error", message: ErrorsForEmployees.MissingCity.rawValue, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } catch ErrorsForEmployees.MissingState {
                let alert = UIAlertController(title: "Error", message: ErrorsForEmployees.MissingState.rawValue, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }catch ErrorsForEmployees.MissingZip {
                let alert = UIAlertController(title: "Error", message: ErrorsForEmployees.MissingZip.rawValue, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } catch ErrorsForEmployees.MissingSSN {
                let alert = UIAlertController(title: "Error", message: ErrorsForEmployees.MissingSSN.rawValue, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } catch ErrorsForEmployees.MissingDateOfBirth {
                let alert = UIAlertController(title: "Error", message: ErrorsForEmployees.MissingDateOfBirth.rawValue, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } catch ErrorsForEmployees.InvalidZip {
                let alert = UIAlertController(title: "Error", message: ErrorsForEmployees.InvalidZip.rawValue, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        } else if Entrant == .RideServices {
            do {
                guard let FirstName = FirstNameField.text else {throw ErrorsForEmployees.MissingFirstName}
                guard let LastName = LastNameField.text else {throw ErrorsForEmployees.MissingLastName}
                guard let StreetAddress = StreetAddressField.text else {throw ErrorsForEmployees.MissingAddress}
                guard let City = CityField.text else {throw ErrorsForEmployees.MissingCity}
                guard let State = StateField.text else {throw ErrorsForEmployees.MissingState}
                guard let ZipCode = ZipField.text else {throw ErrorsForEmployees.MissingZip}
                guard let SSNO = SSNField.text else {throw ErrorsForEmployees.MissingSSN}
                guard let DOB = DateOfBirthField.text else {throw ErrorsForEmployees.MissingDateOfBirth}
                EmployeeEntrant = RideServices(firstName: FirstName, lastName: LastName, streetAddress: StreetAddress, city: City, state: State, zip: ZipCode, SSN: SSNO, DateOfBirth: DOB)
                guard let employee = EmployeeEntrant else {throw ErrorsForPassGeneration.EnterUser}
                ThePassForEmployee = PassForEmployee(Entrant: employee)
                guard let pass = ThePassForEmployee else {throw ErrorsForPassGeneration.ErrorInPassGeneration}
                result = try pass.generatePass()
                ThePassForVendor = nil
                VendorEntrant = nil
                GuestEntrant = nil
                ThePassForGuest = nil
            } catch ErrorsForPassGeneration.EnterUser {
                let alert = UIAlertController(title: "Error", message: "Please select a user", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } catch ErrorsForPassGeneration.ErrorInPassGeneration {
                let alert = UIAlertController(title: "Error", message: "Please select a valid user", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } catch ErrorsForEmployees.AllDetailsMissing {
                let alert = UIAlertController(title: "Error", message: ErrorsForEmployees.AllDetailsMissing.rawValue, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } catch ErrorsForEmployees.MissingFirstName {
                let alert = UIAlertController(title: "Error", message: ErrorsForEmployees.MissingFirstName.rawValue, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } catch ErrorsForEmployees.MissingLastName {
                let alert = UIAlertController(title: "Error", message: ErrorsForEmployees.MissingLastName.rawValue, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } catch ErrorsForEmployees.MissingAddress {
                let alert = UIAlertController(title: "Error", message: ErrorsForEmployees.MissingAddress.rawValue, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } catch ErrorsForEmployees.MissingCity {
                let alert = UIAlertController(title: "Error", message: ErrorsForEmployees.MissingCity.rawValue, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } catch ErrorsForEmployees.MissingState {
                let alert = UIAlertController(title: "Error", message: ErrorsForEmployees.MissingState.rawValue, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }catch ErrorsForEmployees.MissingZip {
                let alert = UIAlertController(title: "Error", message: ErrorsForEmployees.MissingZip.rawValue, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } catch ErrorsForEmployees.MissingSSN {
                let alert = UIAlertController(title: "Error", message: ErrorsForEmployees.MissingSSN.rawValue, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } catch ErrorsForEmployees.MissingDateOfBirth {
                let alert = UIAlertController(title: "Error", message: ErrorsForEmployees.MissingDateOfBirth.rawValue, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } catch ErrorsForEmployees.InvalidZip {
                let alert = UIAlertController(title: "Error", message: ErrorsForEmployees.InvalidZip.rawValue, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        } else if Entrant == .MaintenanceServices {
            do {
                guard let FirstName = FirstNameField.text else {throw ErrorsForEmployees.MissingFirstName}
                guard let LastName = LastNameField.text else {throw ErrorsForEmployees.MissingLastName}
                guard let StreetAddress = StreetAddressField.text else {throw ErrorsForEmployees.MissingAddress}
                guard let City = CityField.text else {throw ErrorsForEmployees.MissingCity}
                guard let State = StateField.text else {throw ErrorsForEmployees.MissingState}
                guard let ZipCode = ZipField.text else {throw ErrorsForEmployees.MissingZip}
                guard let SSNO = SSNField.text else {throw ErrorsForEmployees.MissingSSN}
                guard let DOB = DateOfBirthField.text else {throw ErrorsForEmployees.MissingDateOfBirth}
                EmployeeEntrant = MaintenanceServices(firstName: FirstName, lastName: LastName, streetAddress: StreetAddress, city: City, state: State, zip: ZipCode, SSN: SSNO, DateOfBirth: DOB)
                guard let employee = EmployeeEntrant else {throw ErrorsForPassGeneration.EnterUser}
                ThePassForEmployee = PassForEmployee(Entrant: employee)
                guard let pass = ThePassForEmployee else {throw ErrorsForPassGeneration.ErrorInPassGeneration}
                result = try pass.generatePass()
                ThePassForVendor = nil
                VendorEntrant = nil
                GuestEntrant = nil
                ThePassForGuest = nil
            } catch ErrorsForPassGeneration.EnterUser {
                let alert = UIAlertController(title: "Error", message: "Please select a user", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } catch ErrorsForPassGeneration.ErrorInPassGeneration {
                let alert = UIAlertController(title: "Error", message: "Please select a valid user", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } catch ErrorsForEmployees.AllDetailsMissing {
                let alert = UIAlertController(title: "Error", message: ErrorsForEmployees.AllDetailsMissing.rawValue, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } catch ErrorsForEmployees.MissingFirstName {
                let alert = UIAlertController(title: "Error", message: ErrorsForEmployees.MissingFirstName.rawValue, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } catch ErrorsForEmployees.MissingLastName {
                let alert = UIAlertController(title: "Error", message: ErrorsForEmployees.MissingLastName.rawValue, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } catch ErrorsForEmployees.MissingAddress {
                let alert = UIAlertController(title: "Error", message: ErrorsForEmployees.MissingAddress.rawValue, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } catch ErrorsForEmployees.MissingCity {
                let alert = UIAlertController(title: "Error", message: ErrorsForEmployees.MissingCity.rawValue, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } catch ErrorsForEmployees.MissingState {
                let alert = UIAlertController(title: "Error", message: ErrorsForEmployees.MissingState.rawValue, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }catch ErrorsForEmployees.MissingZip {
                let alert = UIAlertController(title: "Error", message: ErrorsForEmployees.MissingZip.rawValue, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } catch ErrorsForEmployees.MissingSSN {
                let alert = UIAlertController(title: "Error", message: ErrorsForEmployees.MissingSSN.rawValue, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } catch ErrorsForEmployees.MissingDateOfBirth {
                let alert = UIAlertController(title: "Error", message: ErrorsForEmployees.MissingDateOfBirth.rawValue, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } catch ErrorsForEmployees.InvalidZip {
                let alert = UIAlertController(title: "Error", message: ErrorsForEmployees.InvalidZip.rawValue, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        } else if Entrant == .Manager {
            do {
                guard let FirstName = FirstNameField.text else {throw ErrorsForEmployees.MissingFirstName}
                guard let LastName = LastNameField.text else {throw ErrorsForEmployees.MissingLastName}
                guard let StreetAddress = StreetAddressField.text else {throw ErrorsForEmployees.MissingAddress}
                guard let City = CityField.text else {throw ErrorsForEmployees.MissingCity}
                guard let State = StateField.text else {throw ErrorsForEmployees.MissingState}
                guard let ZipCode = ZipField.text else {throw ErrorsForEmployees.MissingZip}
                guard let SSNO = SSNField.text else {throw ErrorsForEmployees.MissingSSN}
                guard let DOB = DateOfBirthField.text else {throw ErrorsForEmployees.MissingDateOfBirth}
                guard let ManagerType = managerTrack.last else {throw ErrorsForEmployees.MissingManagerType}
                EmployeeEntrant = Manager(firstName: FirstName, lastName: LastName, streetAddress: StreetAddress, city: City, state: State, zip: ZipCode, SSN: SSNO, DateOfBirth: DOB, managerType: ManagerType.rawValue)
                guard let employee = EmployeeEntrant else {throw ErrorsForPassGeneration.EnterUser}
                ThePassForEmployee = PassForEmployee(Entrant: employee)
                guard let pass = ThePassForEmployee else {throw ErrorsForPassGeneration.ErrorInPassGeneration}
                result = try pass.generatePass()
                ThePassForVendor = nil
                VendorEntrant = nil
                GuestEntrant = nil
                ThePassForGuest = nil
            } catch ErrorsForPassGeneration.EnterUser {
                let alert = UIAlertController(title: "Error", message: "Please select a user", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } catch ErrorsForPassGeneration.ErrorInPassGeneration {
                let alert = UIAlertController(title: "Error", message: "Please select a valid user", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } catch ErrorsForEmployees.AllDetailsMissing {
                let alert = UIAlertController(title: "Error", message: ErrorsForEmployees.AllDetailsMissing.rawValue, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } catch ErrorsForEmployees.MissingFirstName {
                let alert = UIAlertController(title: "Error", message: ErrorsForEmployees.MissingFirstName.rawValue, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } catch ErrorsForEmployees.MissingLastName {
                let alert = UIAlertController(title: "Error", message: ErrorsForEmployees.MissingLastName.rawValue, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } catch ErrorsForEmployees.MissingAddress {
                let alert = UIAlertController(title: "Error", message: ErrorsForEmployees.MissingAddress.rawValue, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } catch ErrorsForEmployees.MissingCity {
                let alert = UIAlertController(title: "Error", message: ErrorsForEmployees.MissingCity.rawValue, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } catch ErrorsForEmployees.MissingState {
                let alert = UIAlertController(title: "Error", message: ErrorsForEmployees.MissingState.rawValue, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }catch ErrorsForEmployees.MissingZip {
                let alert = UIAlertController(title: "Error", message: ErrorsForEmployees.MissingZip.rawValue, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } catch ErrorsForEmployees.MissingManagerType {
                let alert = UIAlertController(title: "Error", message: ErrorsForEmployees.MissingManagerType.rawValue, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } catch ErrorsForEmployees.MissingSSN {
                let alert = UIAlertController(title: "Error", message: ErrorsForEmployees.MissingSSN.rawValue, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } catch ErrorsForEmployees.MissingDateOfBirth {
                let alert = UIAlertController(title: "Error", message: ErrorsForEmployees.MissingDateOfBirth.rawValue, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } catch ErrorsForEmployees.InvalidZip {
                let alert = UIAlertController(title: "Error", message: ErrorsForEmployees.InvalidZip.rawValue, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        } else if Entrant == .Contractor {
            do {
                guard let FirstName = FirstNameField.text else {throw ErrorsForEmployees.MissingFirstName}
                guard let LastName = LastNameField.text else {throw ErrorsForEmployees.MissingLastName}
                guard let StreetAddress = StreetAddressField.text else {throw ErrorsForEmployees.MissingAddress}
                guard let City = CityField.text else {throw ErrorsForEmployees.MissingCity}
                guard let State = StateField.text else {throw ErrorsForEmployees.MissingState}
                guard let ZipCode = ZipField.text else {throw ErrorsForEmployees.MissingZip}
                guard let Project = ProjectField.text else {throw ErrorsForEmployees.MissingProject}
                guard let SSNO = SSNField.text else {throw ErrorsForEmployees.MissingSSN}
                guard let DOB = DateOfBirthField.text else {throw ErrorsForEmployees.MissingDateOfBirth}
                EmployeeEntrant = Contractor(firstName: FirstName, lastName: LastName, streetAddress: StreetAddress, city: City, state: State, zip: ZipCode, SSN: SSNO, DateOfBirth: DOB, project: Project)
                guard let employee = EmployeeEntrant else {throw ErrorsForPassGeneration.EnterUser}
                ThePassForEmployee = PassForEmployee(Entrant: employee)
                guard let pass = ThePassForEmployee else {throw ErrorsForPassGeneration.ErrorInPassGeneration}
                result = try pass.generatePass()
                ThePassForVendor = nil
                VendorEntrant = nil
                GuestEntrant = nil
                ThePassForGuest = nil
            } catch ErrorsForPassGeneration.EnterUser {
                let alert = UIAlertController(title: "Error", message: "Please select a user", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } catch ErrorsForPassGeneration.ErrorInPassGeneration {
                let alert = UIAlertController(title: "Error", message: "Please select a valid user", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } catch ErrorsForEmployees.AllDetailsMissing {
                let alert = UIAlertController(title: "Error", message: ErrorsForEmployees.AllDetailsMissing.rawValue, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } catch ErrorsForEmployees.MissingFirstName {
                let alert = UIAlertController(title: "Error", message: ErrorsForEmployees.MissingFirstName.rawValue, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } catch ErrorsForEmployees.MissingLastName {
                let alert = UIAlertController(title: "Error", message: ErrorsForEmployees.MissingLastName.rawValue, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } catch ErrorsForEmployees.MissingAddress {
                let alert = UIAlertController(title: "Error", message: ErrorsForEmployees.MissingAddress.rawValue, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } catch ErrorsForEmployees.MissingCity {
                let alert = UIAlertController(title: "Error", message: ErrorsForEmployees.MissingCity.rawValue, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } catch ErrorsForEmployees.MissingState {
                let alert = UIAlertController(title: "Error", message: ErrorsForEmployees.MissingState.rawValue, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }catch ErrorsForEmployees.MissingZip {
                let alert = UIAlertController(title: "Error", message: ErrorsForEmployees.MissingZip.rawValue, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } catch ErrorsForEmployees.MissingProject {
                let alert = UIAlertController(title: "Error", message: ErrorsForEmployees.MissingProject.rawValue, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } catch ErrorsForEmployees.MissingSSN {
                let alert = UIAlertController(title: "Error", message: ErrorsForEmployees.MissingSSN.rawValue, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } catch ErrorsForEmployees.MissingDateOfBirth {
                let alert = UIAlertController(title: "Error", message: ErrorsForEmployees.MissingDateOfBirth.rawValue, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } catch ErrorsForEmployees.InvalidZip {
                let alert = UIAlertController(title: "Error", message: ErrorsForEmployees.InvalidZip.rawValue, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        } else if Entrant == .Vendor {
            do {
                guard let FirstName = FirstNameField.text else {throw ErrorsForEmployees.MissingFirstName}
                guard let LastName = LastNameField.text else {throw ErrorsForEmployees.MissingLastName}
                guard let Company = CompanyField.text else {throw ErrorsForEmployees.MissingVendorCompany}
                guard let DOB = DateOfBirthField.text else {throw ErrorsForEmployees.MissingDateOfBirth}
                guard let DOV = DateOfVisitField.text else {throw ErrorsForEmployees.MissingDateOfVisit}
                VendorEntrant = Vendor(firstName: FirstName, lastName: LastName, vendorCompany: Company, dateOfBirth: DOB, dateOfVisit: DOV)
                guard let vendor = VendorEntrant else {throw ErrorsForPassGeneration.EnterUser}
                ThePassForVendor = passForVendor(Entrant: vendor)
                guard let pass = ThePassForVendor else {throw ErrorsForPassGeneration.ErrorInPassGeneration}
                result = try pass.generatePass()
                ThePassForEmployee = nil
                EmployeeEntrant = nil
                GuestEntrant = nil
                ThePassForGuest = nil
            } catch ErrorsForPassGeneration.EnterUser {
                let alert = UIAlertController(title: "Error", message: "Please select a user", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } catch ErrorsForPassGeneration.ErrorInPassGeneration {
                let alert = UIAlertController(title: "Error", message: "Please select a valid user", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } catch ErrorsForEmployees.AllDetailsMissing {
                let alert = UIAlertController(title: "Error", message: ErrorsForEmployees.AllDetailsMissing.rawValue, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } catch ErrorsForEmployees.MissingFirstName {
                let alert = UIAlertController(title: "Error", message: ErrorsForEmployees.MissingFirstName.rawValue, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } catch ErrorsForEmployees.MissingLastName {
                let alert = UIAlertController(title: "Error", message: ErrorsForEmployees.MissingLastName.rawValue, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } catch ErrorsForEmployees.MissingVendorCompany {
                let alert = UIAlertController(title: "Error", message: ErrorsForEmployees.MissingVendorCompany.rawValue, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } catch ErrorsForEmployees.MissingDateOfBirth {
                let alert = UIAlertController(title: "Error", message: ErrorsForEmployees.MissingDateOfBirth.rawValue, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } catch ErrorsForEmployees.MissingDateOfVisit {
                let alert = UIAlertController(title: "Error", message: ErrorsForEmployees.MissingDateOfVisit.rawValue, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        // Guest pass generation over
        if result != nil {
            return result!
        } else {
            throw ErrorsForPassGeneration.someError
        }
    }
    
 @IBAction func generatePass(_ sender: Any) {
        var result = false
        
        // guest pass generation begin!
    
            if subTracker.last == .Child {
                do {
                    result = try passGeneration(Entrant: .Child)
                } catch {
                    // handle errors
                }
            } else if subTracker.last == .Adult {
                do {
                    result = try passGeneration(Entrant: .Adult)
                } catch {
                    // handle errors
                }
            } else if subTracker.last == .VIP {
                do {
                    result = try passGeneration(Entrant: .VIP)
                } catch {
                    // handle errors
                }
            } else if subTracker.last == .SeasonPass {
                do {
                    result = try passGeneration(Entrant: .SeasonPass)
                } catch {
                    // handle errors
                }
            } else if subTracker.last == .Senior {
                do {
                    result = try passGeneration(Entrant: .Senior)
                } catch {
                    // handle errors
                }
                 // Guest pass generation over
                // Now employees
            } else if subTracker.last == .FoodServices {
                do {
                   result = try passGeneration(Entrant: .FoodServices)
                } catch {
                    //Handle errors
                }
            } else if subTracker.last == .RideServices {
                do {
                    result = try passGeneration(Entrant: .RideServices)
                } catch {
                    // Handle errors
                }
            } else if subTracker.last == .MaintenanceServices {
                do {
                    result = try passGeneration(Entrant: .MaintenanceServices)
                } catch {
                    //Handle errors
                }
            } else if subTracker.last == .Manager {
                do {
                    result = try passGeneration(Entrant: .Manager)
                } catch {
                    // Handle errors
                }
            } else if subTracker.last == .Contractor {
                do {
                    result = try passGeneration(Entrant: .Contractor)
                } catch {
                    // Handle errors
                }
            } else if subTracker.last == .Vendor {
                do{
                    result = try passGeneration(Entrant: .Vendor)
                } catch {
                    // Handle errors
                }
            }

        if result {
            performSegue(withIdentifier: "ToTest", sender: nil)
            print(ThePassForGuest as Any)
            print(ThePassForGuest?.Entrant as Any)
            print(ThePassForEmployee as Any)
            print(ThePassForEmployee?.Entrant as Any)
            print(ThePassForVendor as Any)
            print(ThePassForVendor?.Entrant as Any)
        } else {
            let alert = UIAlertController(title: "Error", message: "Please select a user", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    @IBAction func populateData(_ sender: Any) {
        if subTracker.last == .Child {
            DateOfBirthField.text = "24/06/2018"
            DateOfBirthField.isUserInteractionEnabled = true
            
            SSNField.text = nil
            SSNField.isUserInteractionEnabled = false
            
            ProjectField.text = nil
            ProjectField.isUserInteractionEnabled = false
            
            FirstNameField.text = nil
            FirstNameField.isUserInteractionEnabled = false
            
            LastNameField.text = nil
            LastNameField.isUserInteractionEnabled = false
            
            CompanyField.text = nil
            CompanyField.isUserInteractionEnabled = false
            
            DateOfVisitField.text = nil
            DateOfVisitField.isUserInteractionEnabled = false
            
            StreetAddressField.text = nil
            StreetAddressField.isUserInteractionEnabled = false
            
            CityField.text = nil
            CityField.isUserInteractionEnabled = false
            
            StateField.text = nil
            StateField.isUserInteractionEnabled = false
            
            ZipField.text = nil
            ZipField.isUserInteractionEnabled = false
        } else if subTracker.last == .Adult || subTracker.last == .VIP {
            DateOfBirthField.text = nil
            DateOfBirthField.isUserInteractionEnabled = false
            
            SSNField.text = nil
            SSNField.isUserInteractionEnabled = false
            
            ProjectField.text = nil
            ProjectField.isUserInteractionEnabled = false
            
            FirstNameField.text = nil
            FirstNameField.isUserInteractionEnabled = false
            
            LastNameField.text = nil
            LastNameField.isUserInteractionEnabled = false
            
            CompanyField.text = nil
            CompanyField.isUserInteractionEnabled = false
            
            DateOfVisitField.text = nil
            DateOfVisitField.isUserInteractionEnabled = false
            
            StreetAddressField.text = nil
            StreetAddressField.isUserInteractionEnabled = false
            
            CityField.text = nil
            CityField.isUserInteractionEnabled = false
            
            StateField.text = nil
            StateField.isUserInteractionEnabled = false
            
            ZipField.text = nil
            ZipField.isUserInteractionEnabled = false
        } else if subTracker.last == .FoodServices || subTracker.last == .RideServices || subTracker.last == .MaintenanceServices || subTracker.last == .Manager {
            DateOfBirthField.text = "24/06/2000"
            DateOfBirthField.isUserInteractionEnabled = true
            
            SSNField.text = "000000000"
            SSNField.isUserInteractionEnabled = true
            
            ProjectField.text = nil
            ProjectField.isUserInteractionEnabled = false
            
            FirstNameField.text = "Chirag"
            FirstNameField.isUserInteractionEnabled = true
            
            LastNameField.text = "Jadhwani"
            LastNameField.isUserInteractionEnabled = true
            
            CompanyField.text = nil
            CompanyField.isUserInteractionEnabled = false
            
            DateOfVisitField.text = nil
            DateOfVisitField.isUserInteractionEnabled = false
            
            StreetAddressField.text = "Lower Mall"
            StreetAddressField.isUserInteractionEnabled = true
            
            CityField.text = "Vancouver"
            CityField.isUserInteractionEnabled = true
            
            StateField.text = "British Columbia"
            StateField.isUserInteractionEnabled = true
            
            ZipField.text = "00000"
            ZipField.isUserInteractionEnabled = true
        } else if subTracker.last == .Contractor {
            DateOfBirthField.text = "24/06/2000"
            DateOfBirthField.isUserInteractionEnabled = true
            
            SSNField.text = "00000000"
            SSNField.isUserInteractionEnabled = true
            
            ProjectField.text = "2001"
            ProjectField.isUserInteractionEnabled = true
            
            FirstNameField.text = "Chirag"
            FirstNameField.isUserInteractionEnabled = true
            
            LastNameField.text = "Jadhwani"
            LastNameField.isUserInteractionEnabled = true
            
            CompanyField.text = nil
            CompanyField.isUserInteractionEnabled = false
            
            DateOfVisitField.text = nil
            DateOfVisitField.isUserInteractionEnabled = false
            
            StreetAddressField.text = "Lower mall"
            StreetAddressField.isUserInteractionEnabled = true
            
            CityField.text = "Vancouver"
            CityField.isUserInteractionEnabled = true
            
            StateField.text = "British Columbia"
            StateField.isUserInteractionEnabled = true
            
            ZipField.text = "00000"
            ZipField.isUserInteractionEnabled = true
        } else if subTracker.last == .Vendor {
            DateOfBirthField.text = "24/06/2000"
            DateOfBirthField.isUserInteractionEnabled = true
            
            SSNField.text = nil
            SSNField.isUserInteractionEnabled = false
            
            ProjectField.text = nil
            ProjectField.isUserInteractionEnabled = false
            
            FirstNameField.text = "Chirag"
            FirstNameField.isUserInteractionEnabled = true
            
            LastNameField.text = "Jadhwani"
            LastNameField.isUserInteractionEnabled = true
            
            CompanyField.text = "NWElectrical"
            CompanyField.isUserInteractionEnabled = true
            
            DateOfVisitField.text = "21/02/2019"
            DateOfVisitField.isUserInteractionEnabled = true
            
            StreetAddressField.text = nil
            StreetAddressField.isUserInteractionEnabled = false
            
            CityField.text = nil
            CityField.isUserInteractionEnabled = false
            
            StateField.text = nil
            StateField.isUserInteractionEnabled = false
            
            ZipField.text = nil
            ZipField.isUserInteractionEnabled = false
        } else if subTracker.last == .Senior {
            DateOfBirthField.text = "24/06/1950"
            DateOfBirthField.isUserInteractionEnabled = true
            
            SSNField.text = nil
            SSNField.isUserInteractionEnabled = false
            
            ProjectField.text = nil
            ProjectField.isUserInteractionEnabled = false
            
            FirstNameField.text = "Chirag"
            FirstNameField.isUserInteractionEnabled = true
            
            LastNameField.text = "Jadhwani"
            LastNameField.isUserInteractionEnabled = true
            
            CompanyField.text = nil
            CompanyField.isUserInteractionEnabled = false
            
            DateOfVisitField.text = nil
            DateOfVisitField.isUserInteractionEnabled = false
            
            StreetAddressField.text = nil
            StreetAddressField.isUserInteractionEnabled = false
            
            CityField.text = nil
            CityField.isUserInteractionEnabled = false
            
            StateField.text = nil
            StateField.isUserInteractionEnabled = false
            
            ZipField.text = nil
            ZipField.isUserInteractionEnabled = false
        } else if subTracker.last == .SeasonPass {
            DateOfBirthField.text = "24/06/2000"
            DateOfBirthField.isUserInteractionEnabled = true
            
            SSNField.text = nil
            SSNField.isUserInteractionEnabled = false
            
            ProjectField.text = nil
            ProjectField.isUserInteractionEnabled = false
            
            FirstNameField.text = "Chirag"
            FirstNameField.isUserInteractionEnabled = true
            
            LastNameField.text = "Jadhwani"
            LastNameField.isUserInteractionEnabled = true
            
            CompanyField.text = nil
            CompanyField.isUserInteractionEnabled = false
            
            DateOfVisitField.text = nil
            DateOfVisitField.isUserInteractionEnabled = false
            
            StreetAddressField.text = "Lower mall"
            StreetAddressField.isUserInteractionEnabled = true
            
            CityField.text = "Vancouver"
            CityField.isUserInteractionEnabled = true
            
            StateField.text = "British Columbia"
            StateField.isUserInteractionEnabled = true
            
            ZipField.text = "00000"
            ZipField.isUserInteractionEnabled = true
        } else {
            let alert = UIAlertController(title: "Error", message: "Please select a user", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
}

