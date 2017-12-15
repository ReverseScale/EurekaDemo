//
//  ViewController.swift
//  EurekaDemo
//
//  Created by WhatsXie on 2017/12/14.
//  Copyright © 2017年 R.S. All rights reserved.
//

import UIKit
import Eureka
import CoreLocation

class ViewController: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        title = "Eureka Basis"
        setupEurekaUI()
    }
    
    func setupEurekaUI() {
        
        LabelRow.defaultCellUpdate = { cell, row in cell.detailTextLabel?.textColor = UIColor.orange}
        CheckRow.defaultCellUpdate = { cell, row in cell.tintColor = UIColor.orange}
        form +++ Section("Basis")
            <<< LabelRow("LabelRows") {
                $0.title = $0.tag
                $0.value = "tap the row"
                }.onCellSelection{cell, row in
                    row.title = (row.title ?? "") + "Summer"
                    row.reload()
                }
            <<< DateRow() {
                $0.value = Date()
                $0.title = "DataRow"
            }
            <<< CheckRow() {
                $0.title = "CheckRow"
                $0.value = true
            }
            <<< SwitchRow() {
                $0.title = "SwitchRow"
                $0.value = true
            }
            <<< SliderRow() {
                $0.title = "SliderRow"
                $0.value = 5
            }
            <<< StepperRow() {
                $0.title = "StepperRow"
                $0.value = 1.0
            }
        
        +++ Section("SegmentedRow")
            <<< SegmentedRow<String>() {
                $0.title = "Hello World"
                $0.options = ["OC","Swift","Python","C#"]
                $0.value = "HW"
            }
            <<< SegmentedRow<String>() {
                $0.options = ["AI","AR"]
                $0.value = "AA"
                }.cellSetup{cell, row in
                    cell.imageView?.image = UIImage(named:"SwifterAI")
            }
            <<< SegmentedRow<String>() {
              $0.options = ["1","2","3"]
            }
        
        +++ Section("Examples")
            <<< AlertRow<String>() {
                $0.title = "AlertRow"
                $0.selectorTitle = "Where are you going to do?"
                $0.options = ["I am going to fish","I am going to shopping","GuanNiPiShi"]
                $0.value = "Alert"
                }.onChange{(row) in
                    print(row.value ?? "")
                }.onPresent{(_, to) in
                    to.view.tintColor = UIColor.purple
            }
            <<< ActionSheetRow<String>() {
                $0.title = "ActionSheetRow"
                $0.selectorTitle = "What are you seeing?"
                $0.options = ["You are like my dad!","How can I do for me?","Ni Mei De","Fuck"]
                $0.value = "Sheet"
            }
            <<< PushRow<String>() {
                $0.title = "PushRow"
                $0.options = ["ABC","DEF"]
                $0.value = "Push"
                $0.selectorTitle = "Push Title"
                }.onPresent{from, to in
                    to.dismissOnSelection = false
                    to.dismissOnChange = false
            }
        
        form +++ Section("Generic picker")
            <<< PickerRow<String>("Picker Row") { (row : PickerRow<String>) -> Void in
                row.options = []
                for i in 1...10{
                    row.options.append("option \(i)")
                }
            }
            <<< PickerInputRow<String>("Picker Input Row"){
                $0.title = "Options"
                $0.options = []
                for i in 1...10{
                    $0.options.append("option \(i)")
                }
                $0.value = $0.options.first
            }
        
        +++ Section("FieldRow examples")
            
            <<< TextRow() {
                $0.title = "TextRow"
                $0.placeholder = "Placeholder"
            }
            
            <<< DecimalRow() {
                $0.title = "DecimalRow"
                $0.value = 5
                $0.formatter = DecimalFormatter()
                $0.useFormatterDuringInput = true
                //$0.useFormatterOnDidBeginEditing = true
                }.cellSetup { cell, _  in
                    cell.textField.keyboardType = .numberPad
            }
            
            <<< URLRow() {
                $0.title = "URLRow"
                $0.value = URL(string: "http://xmartlabs.com")
            }
            
            <<< PhoneRow() {
                $0.title = "PhoneRow (disabled)"
                $0.value = "+598 9898983510"
                $0.disabled = true
            }
            
            <<< NameRow() {
                $0.title =  "NameRow"
            }
            
            <<< PasswordRow() {
                $0.title = "PasswordRow"
                $0.value = "password"
            }
            
            <<< IntRow() {
                $0.title = "IntRow"
                $0.value = 2015
            }
            
            <<< EmailRow() {
                $0.title = "EmailRow"
                $0.value = "a@b.com"
            }
            
            <<< TwitterRow() {
                $0.title = "TwitterRow"
                $0.value = "@xmartlabs"
            }
            
            <<< AccountRow() {
                $0.title = "AccountRow"
                $0.placeholder = "Placeholder"
            }
            
            <<< ZipCodeRow() {
                $0.title = "ZipCodeRow"
                $0.placeholder = "90210"
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

class EurekaLogoViewNib: UIView {
    @IBOutlet weak var imageHeaderView: UIImageView!
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class CustomCellsController : FormViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Eureka Custom"
        setupEurekaCustomUI()
    }
    
    func setupEurekaCustomUI() {
        form +++
            Section() {
                var header = HeaderFooterView<EurekaLogoViewNib>(.nibFile(name: "EurekaSectionHeader", bundle: nil))
                header.onSetupView = { (view, section) -> () in
                    view.imageHeaderView.alpha = 0;
                    UIView.animate(withDuration: 2.0, animations: { [weak view] in
                        view?.imageHeaderView.alpha = 1
                    })
                    view.layer.transform = CATransform3DMakeScale(0.9, 0.9, 1)
                    UIView.animate(withDuration: 1.0, animations: { [weak view] in
                        view?.layer.transform = CATransform3DIdentity
                    })
                }
                $0.header = header
        }
            +++ Section("WeekDay cell")
            
            <<< WeekDayRow(){
                $0.value = [.monday, .wednesday, .friday]
            }
            
            <<< TextFloatLabelRow() {
                $0.title = "Float Label Row, type something to see.."
            }
            
            <<< IntFloatLabelRow() {
                $0.title = "Float Label Row, type something to see.."
        }
    }

}

class ListSectionsController: FormViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Eureka List"
        setupEurekaListUI()
    }
    func setupEurekaListUI() {
        let continents = ["Africa", "Antarctica", "Asia", "Australia", "Europe", "North America", "South America"]
        
        form +++ SelectableSection<ImageCheckRow<String>>() { section in
            section.header = HeaderFooterView(title: "Where do you live?")
        }
        
        for option in continents {
            form.last! <<< ImageCheckRow<String>(option){ lrow in
                lrow.title = option
                lrow.selectableValue = option
                lrow.value = nil
            }
        }
        
        let oceans = ["Arctic", "Atlantic", "Indian", "Pacific", "Southern"]
        
        form +++ SelectableSection<ImageCheckRow<String>>("And which of the following oceans have you taken a bath in?", selectionType: .multipleSelection)
        for option in oceans {
            form.last! <<< ImageCheckRow<String>(option){ lrow in
                lrow.title = option
                lrow.selectableValue = option
                lrow.value = nil
                }.cellSetup { cell, _ in
                    cell.trueImage = UIImage(named: "selectedRectangle")!
                    cell.falseImage = UIImage(named: "unselectedRectangle")!
                    cell.accessoryType = .checkmark
            }
        }
    }
    
    override func valueHasBeenChanged(for row: BaseRow, oldValue: Any?, newValue: Any?) {
        if row.section === form[0] {
            print("Single Selection:\((row.section as! SelectableSection<ImageCheckRow<String>>).selectedRow()?.baseValue ?? "No row selected")")
        }
        else if row.section === form[1] {
            print("Mutiple Selection:\((row.section as! SelectableSection<ImageCheckRow<String>>).selectedRows().map({$0.baseValue}))")
        }
    }
}

class MultivaluedSectionsController: FormViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Eureka Multivalued"

        setupEurekaMultivaluedUI()
    }
    func setupEurekaMultivaluedUI() {
        form +++
            Section("Multivalued examples")
            <<< ButtonRow(){
                $0.title = "Multivalued Sections"
                $0.presentationMode = .segueName(segueName: "MultivaluedControllerSegue", onDismiss: nil)
        }
    }
}

class MultivaluedController: FormViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Multivalued Examples"
        form +++
            MultivaluedSection(multivaluedOptions: [.Reorder, .Insert, .Delete],
                               header: "Multivalued TextField",
                               footer: ".Insert multivaluedOption adds the 'Add New Tag' button row as last cell.") {
                                $0.tag = "textfields"
                                $0.addButtonProvider = { section in
                                    return ButtonRow(){
                                        $0.title = "Add New Tag"
                                        }.cellUpdate { cell, row in
                                            cell.textLabel?.textAlignment = .left
                                    }
                                }
                                $0.multivaluedRowToInsertAt = { index in
                                    return NameRow() {
                                        $0.placeholder = "Tag Name"
                                    }
                                }
                                $0 <<< NameRow() {
                                    $0.placeholder = "Tag Name"
                                }
            }
            
            +++
            
            MultivaluedSection(multivaluedOptions: [.Insert, .Delete],
                               header: "Multivalued ActionSheet Selector example",
                               footer: ".Insert multivaluedOption adds a 'Add' button row as last cell.") {
                                $0.tag = "options"
                                $0.multivaluedRowToInsertAt = { index in
                                    return ActionSheetRow<String>{
                                        $0.title = "Tap to select.."
                                        $0.options = ["Option 1", "Option 2", "Option 3", "Option 4", "Option 5"]
                                    }
                                }
                                $0 <<< ActionSheetRow<String> {
                                    $0.title = "Tap to select.."
                                    $0.options = ["Option 1", "Option 2", "Option 3", "Option 4", "Option 5"]
                                }
                                
            }
            
            +++
            
            MultivaluedSection(multivaluedOptions: [.Insert, .Delete, .Reorder],
                               header: "Multivalued Push Selector example",
                               footer: "") {
                                $0.tag = "push"
                                $0.multivaluedRowToInsertAt = { index in
                                    return PushRow<String>{
                                        $0.title = "Tap to select ;)..at \(index)"
                                        $0.options = ["Option 1", "Option 2", "Option 3"]
                                    }
                                }
                                $0 <<< PushRow<String> {
                                    $0.title = "Tap to select ;).."
                                    $0.options = ["Option 1", "Option 2", "Option 3"]
                                }
                                
        }
    }
    
    @IBAction func saved(_ sender: Any) {
        print("\(form.values())")
    }
}
