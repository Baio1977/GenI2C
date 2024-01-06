//
//  AppDelegate.swift
//  GenI2C
//
//  Created by 梁怀宇 on 2019/5/26.
//  Copyright © 2019 梁怀宇. All rights reserved.
//

import Cocoa

var CPUInfo:String = "", NativeDeviceName:String = "", NativePin = "", isVooLoaded:Bool = false, isNameFound:Bool = false, isPinFound:Bool = false
var TPAD:String = "", Device:String = "", DSDTFile:String = "", Paranthesesopen:String = "", Paranthesesclose:String = "", DSDTLine:String = "", scope:String = "", Spacing:String = "", APICNAME:String = "", SLAVName:String = "", GPIONAME:String = "", APICPin:String = "", HexTPAD:String = "", BlockBus:String = "", HexBlockBus:String = "", FolderPath:String = "\(NSHomeDirectory())/desktop/I2C-PATCH", BlockSSDT = [String](repeating: "", count: 16), GPI0SSDT = [String](repeating: "", count: 16), ScopeSelect:String = "", RenameFile:String = "", HexI2C:String = "", HexI2X:String = ""
var ManualGPIO = [String](repeating: "", count: 9), ManualAPIC = [String](repeating: "", count: 7),  ManualSPED = [String](repeating: "", count: 2), CRSInfo = [String](), CNL_H_SPED = [String](repeating: "", count: 47), Code = [String](), lines = [String](), IfLLess = [String](repeating: "", count: 6), IfLEqual = [String](repeating: "", count: 6), If2Brackets = [String](repeating: "", count: 6), MultiScope = [String](repeating: "", count: 6)
var Matched:Bool = false, CRSPatched:Bool = false, ExUSTP:Bool = false, ExSSCN:Bool = false, ExFMCN:Bool = false, ExAPIC:Bool = false, ExSLAV:Bool = false, ExGPIO:Bool = false, CatchSpacing:Bool = false, APICNameLineFound:Bool = false, SLAVNameLineFound:Bool = false, GPIONameLineFound:Bool = false, InterruptEnabled:Bool = false, PollingEnabled:Bool = false, Hetero:Bool = false, BlockI2C:Bool = false, ExI2CM:Bool = false, ExBADR:Bool = false, ExADR0:Bool = false,ExHID2:Bool = false, ExTPID:Bool = false, ExTPDF:Bool = false, LLess:Bool = false, LEqual:Bool = false, If2BracketsBool:Bool = false, MultiTPAD:Bool = false, MultiScopeBool:Bool = false
var line:Int = 0, i:Int = 0, n:Int = 0, total:Int = 0, APICPinLine:Int = 0, GPIOPinLine:Int = 0, APICPIN:Int = 0, GPIOPIN:Int = 0, GPIOPIN2:Int = 0, GPIOPIN3:Int = 0, APICNameLine:Int = 0, SLAVNameLine:Int = 0, GPIONAMELine:Int = 0, CheckConbLine:Int = 0, Choice:Int = -1, preChoice:Int = -1, ScopeLine:Int = 0, count:Int = 0, CRSLocation:Int = 0, CheckSLAVLocation:Int = 0, CPUChoice:Int = -1, MultiScopeCount:Int = 0, MultiTPADLineCount = [Int](repeating: 0, count: 6), MultiTPADLineCountIndex:Int = 0, MultiTPADUSRSelect:Int = 0, TargetTPAD:Int = 0

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, NSTextFieldDelegate {

    @IBOutlet weak var mainWindow: NSWindow!
    @IBOutlet weak var VerboseWindow: NSWindow!
    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var DSDTPath: NSTextField!
    @IBOutlet weak var TabView: NSTabView!
    @IBOutlet weak var Next1: NSButton!
    @IBOutlet weak var Next2: NSButton!
    @IBOutlet weak var Next3: NSButton!
    @IBOutlet weak var Next4: NSButton!
    @IBOutlet weak var DeviceName: NSTextField!
    @IBOutlet weak var Verbose: NSScrollView!
    @IBOutlet weak var InputAPICPin: NSView!
    @IBOutlet weak var APICPinText: NSTextField!
    @IBOutlet weak var Warning: NSTextField!
    @IBOutlet var VerboseTextView: NSTextView!
    @IBOutlet var RenameLabel: NSTextView!
    @IBOutlet weak var StateLabel: NSTextField!
    @IBOutlet weak var VersionLabel: NSTextField!
    @IBOutlet weak var IONameLabel: NSTextField!
    @IBOutlet weak var ModeLabel: NSTextField!
    @IBOutlet weak var PinLabel: NSTextField!
    @IBOutlet weak var DeviceNameLabel: NSTextField!
    @IBOutlet weak var CPUModelLabel: NSTextField!
    @IBOutlet weak var SatelliteLabel: NSTextField!
    @IBOutlet weak var SelectDeviceView: NSView!
    @IBOutlet weak var ScopeRadio0: NSButton!
    @IBOutlet weak var ScopeRadio1: NSButton!
    @IBOutlet weak var ScopeRadio2: NSButton!
    @IBOutlet weak var ScopeRadio3: NSButton!
    @IBOutlet weak var AMLPath: NSTextField!
    @IBOutlet weak var Decomplie: NSButton!
    @IBOutlet var DisassemblerVerbose: NSTextView!
    @IBOutlet weak var MainTab: NSTabView!
    @IBOutlet weak var Information: NSTabViewItem!
    @IBOutlet weak var GenSSDTTab: NSTabViewItem!
    @IBOutlet weak var Disassembler: NSTabViewItem!
    @IBOutlet weak var About: NSTabViewItem!
    @IBOutlet weak var Gen4ThisComputer: NSButton!
    @IBOutlet weak var IssueLabel: NSTextFieldCell!
    @IBOutlet weak var GenStep2: NSTabViewItem!
    @IBOutlet weak var GenStep4: NSTabViewItem!
    @IBOutlet weak var Diagnosis: NSTabViewItem!
    @IBOutlet weak var Indicator1: NSProgressIndicator!
    @IBOutlet weak var Indicator2: NSProgressIndicator!
    @IBOutlet weak var Indicator3: NSProgressIndicator!
    @IBOutlet weak var Indicator4: NSProgressIndicator!
    @IBOutlet weak var Indicator5: NSProgressIndicator!
    @IBOutlet weak var Indicator6: NSProgressIndicator!
    @IBOutlet weak var State1: NSImageView!
    @IBOutlet weak var State2: NSImageView!
    @IBOutlet weak var State3: NSImageView!
    @IBOutlet weak var State4: NSImageView!
    @IBOutlet weak var State5: NSImageView!
    @IBOutlet weak var State6: NSImageView!
    @IBOutlet var ErrorLabel: NSTextView!
    @IBOutlet weak var DiagnosisScrollView: NSScrollView!
    @IBOutlet weak var Version: NSTextField!
    
    let SelectDevice = NSAlert()
    var alert = NSAlert()
    
    @IBAction func InformationClick(_ sender: Any) {
        MainTab.selectTabViewItem(Information)
    }
    
    @IBAction func GenSSDTClick(_ sender: Any) {
        MainTab.selectTabViewItem(GenSSDTTab)
    }
    
    @IBAction func DiagnosisClick(_ sender: Any) {
        MainTab.selectTabViewItem(Diagnosis)
    }
    
    @IBAction func DisassemblerClick(_ sender: Any) {
        MainTab.selectTabViewItem(Disassembler)
    }
    
    @IBAction func SelectMode(_ sender: Any) {
        Choice = (sender as! NSButton).tag
        Next4.isEnabled = true
    }
    
    @IBAction func AboutClick(_ sender: Any) {
        MainTab.selectTabViewItem(About)
    }
    
    @IBAction func SelectDevice(_ sender: Any) {
        MultiTPADUSRSelect = (sender as! NSButton).tag
        scope = MultiScope[MultiTPADUSRSelect]
        SelectDevice.buttons[0].isEnabled = true
        verbose(text: "Choice : \((sender as! NSButton).tag)")
    }
    
    @IBAction func SelectCPU(_ sender: Any) {
        CPUChoice = (sender as! NSButton).tag
        Next3.isEnabled = true
    }
    
    @IBAction func InputAPICPin(_ sender: Any) {
        if APICPinText.stringValue.count >= 2 {
            let index = APICPinText.stringValue.index(APICPinText.stringValue.startIndex, offsetBy: 2)
            if String(APICPinText.stringValue[..<index]) == "0x" && APICPinText.stringValue.count == 4  {
                if Int(strtoul(APICPinText.stringValue, nil, 16)) >= 24 && Int(strtoul(APICPinText.stringValue, nil, 16)) <= 119 {
                    alert.buttons[0].isEnabled = true
                    Warning.stringValue = ""
                    APICPin = APICPinText.stringValue
                    APICPIN = Int(strtoul(APICPin, nil, 16))
                    verbose(text: "APIC Pin you input is \(APICPin)\n")
                } else {
                    Warning.stringValue = NSLocalizedString("APIC Pin should be between 0x18 and 0x77", comment: "")
                }
            } else {
                alert.buttons[0].isEnabled = false
            }
        } else {
            alert.buttons[0].isEnabled = false
        }
    }
    
    @IBAction func SelectDSDTButtom(_ sender: Any) {
        let openPanel:NSOpenPanel = NSOpenPanel()
        openPanel.canChooseDirectories = false
        openPanel.canChooseFiles = true
        openPanel.allowedFileTypes = ["dsl"]
        openPanel.allowsMultipleSelection = false
        openPanel.orderFrontRegardless()
        openPanel.beginSheetModal(for: window, completionHandler: {result in
            if (result == NSApplication.ModalResponse.OK)
            {
                let path:NSURL = openPanel.urls[0] as NSURL
                openPanel.close()
                let pathStr = path.absoluteString!.removingPercentEncoding!
                let index1 = pathStr.index(pathStr.startIndex, offsetBy: 7)
                let index2 = pathStr.index(pathStr.startIndex, offsetBy: pathStr.count)
                DSDTFile = String(pathStr[index1..<index2])
                self.DSDTPath.stringValue = DSDTFile
                self.verbose(text: "\(DSDTFile)\n")
                self.Next1.isEnabled = true
            }
        })
    }
    
    @IBAction func Next1(_ sender: Any) {
        if Gen4ThisComputer.state.rawValue == 0 {
            TabView.selectNextTabViewItem(Any?.self)
        } else {
            TPAD = NativeDeviceName
            Device = "Device (\(TPAD))"
            HexTPAD = Data(TPAD.utf8).map{String(format: "%02x", $0)}.joined()
            let CPUModel = CPUInfo.components(separatedBy: " ")[2].components(separatedBy: "-")[1]
            if CPUModel[CPUModel.index(CPUModel.startIndex, offsetBy: 0)] == "6" {
                CPUChoice = 0
            } else if CPUModel[CPUModel.index(CPUModel.startIndex, offsetBy: 0)] == "7" {
                CPUChoice = 1
            } else if CPUModel[CPUModel.index(CPUModel.startIndex, offsetBy: 0)] == "8" {
                if CPUModel.count == 5 {
                    if CPUModel[CPUModel.index(CPUModel.startIndex, offsetBy: 4)] == "H" {
                        CPUChoice = 1
                    } else if CPUModel[CPUModel.index(CPUModel.startIndex, offsetBy: 4)] == "U" {
                        CPUChoice = 2
                    } else {
                        IssueLabel.stringValue += "This CPU Model (\(CPUInfo)) is not supported\n"
                    }
                } else {
                    IssueLabel.stringValue += "This CPU Model (\(CPUInfo)) is not supported\n"
                }
            } else {
                IssueLabel.stringValue += "This CPU Model (\(CPUInfo)) is not supported\n"
            }
            Countline()
        }
    }
    
    @IBAction func Next3(_ sender: Any) {
        TabView.selectNextTabViewItem(Any?.self)
    }
    
    @IBAction func Next2(_ sender: Any) {
        verbose(text: "\nDevice: \(TPAD)\n")
        HexTPAD = Data(TPAD.utf8).map{String(format: "%02x", $0)}.joined()
        verbose(text: "\(HexTPAD)\n")
        Countline()
    }
    
    @IBAction func Next4(_ sender: Any) {
        TabView.selectNextTabViewItem(Any?.self)
        if Choice != preChoice {
            if Choice == 0 {
                verbose(text: "Selection: Interrupt (APIC or GPIO)\n")
            } else {
                verbose(text: "Selection: Polling\n")
            }
            preChoice = Choice
            Analysis2()
        }
    }
    @IBAction func Back2(_ sender: Any) {
        TabView.selectPreviousTabViewItem(Any?.self)
    }
    @IBAction func Back3(_ sender: Any) {
        TabView.selectPreviousTabViewItem(Any?.self)
    }
    @IBAction func Back4(_ sender: Any) {
        TabView.selectPreviousTabViewItem(Any?.self)
    }
    
    func Countline() {
        print("Countline()")
        verbose(text: "Start func : Countline()")
        let readHandler =  FileHandle(forReadingAtPath: DSDTFile)
        let data = readHandler?.readDataToEndOfFile()
        let readString = String(data: data!, encoding: String.Encoding.utf8)
        Matched = false
        line = 0
        lines = (readString?.components(separatedBy: "\n"))!
        count = lines.count
        ExUSTP = false
        ExSSCN = false
        ExFMCN = false
        Paranthesesopen = ""
        Paranthesesclose = ""
        total = 0
        while line < count
        {
            DSDTLine = lines[line]
            line += 1
            if DSDTLine.contains("If (USTP)"){
                verbose(text: "Found for USTP in DSDT at line \(line)\n")
                ExUSTP = true
            }
            if DSDTLine.contains("SSCN"){
                verbose(text: "Found for SSCN in DSDT at line \(line)\n")
                ExSSCN = true
            }
            if DSDTLine.contains("FMCN"){
                verbose(text: "Found for FMCN in DSDT at line \(line)\n")
                ExFMCN = true
            }
            var spaceopen, spaceclose, startline:Int
            if DSDTLine.contains(Device){
                if Matched {
                    MultiTPAD = true
                    MultiScopeBool = false
                    total = 0
                }
                verbose(text: "Found for \(Device) in DSDT at line \(line)\n")
                startline = line
                Paranthesesopen = lines[line]
                line += 1
                spaceopen = Paranthesesopen.positionOf(sub: "{")
                repeat{
                    Paranthesesclose = lines[line]
                    line += 1
                    spaceclose = Paranthesesclose.positionOf(sub: "}")
                    if Paranthesesclose.contains("_SB.PCI0.I2C") {
                        if MultiScopeBool {
                            if MultiScope[MultiScopeCount - 1] != String(Paranthesesclose[Paranthesesclose.index(Paranthesesclose.startIndex ,offsetBy: Paranthesesclose.positionOf(sub: "_SB.PCI0.I2C") + 12)]) {
                                MultiScope[MultiScopeCount] = String(Paranthesesclose[Paranthesesclose.index(Paranthesesclose.startIndex ,offsetBy: Paranthesesclose.positionOf(sub: "_SB.PCI0.I2C") + 12)])
                                MultiScopeCount += 1
                            }
                        } else {
                            MultiScope[MultiScopeCount] = String(Paranthesesclose[Paranthesesclose.index(Paranthesesclose.startIndex ,offsetBy: Paranthesesclose.positionOf(sub: "_SB.PCI0.I2C") + 12)])
                            MultiScopeCount += 1
                            MultiScopeBool = true
                        }
                    }
                } while spaceclose != spaceopen
                if total == 0 {
                    total += (line - startline)
                }
                else{
                    total += (line - startline) + 1
                }
                Matched = true
                MultiTPADLineCount[MultiTPADLineCountIndex] = total
                MultiTPADLineCountIndex += 1
            }
        }
        if Matched == false{
            TabView.selectTabViewItem(GenStep2)
            verbose(text: "No Device Found\n")
            let noDevice = NSAlert()
            noDevice.messageText = NSLocalizedString("No Device Found", comment: "")
            noDevice.informativeText = NSLocalizedString("There is no ", comment: "") + TPAD + NSLocalizedString(" in your DSDT. Please input again or exit", comment: "")
            noDevice.alertStyle = .informational
            noDevice.addButton(withTitle: NSLocalizedString("Input again", comment: ""))
            noDevice.addButton(withTitle: NSLocalizedString("Exit", comment: ""))
            verbose(text: "Pop-up to ask if input again")
            noDevice.beginSheetModal(for: self.window, completionHandler: {response -> Void in
                if response.rawValue == 1001 {
                    self.verbose(text: "Exit")
                    exit(0)
                }
            })
        } else {
            if Gen4ThisComputer.state.rawValue == 1 {
                TabView.selectTabViewItem(GenStep4)
            } else {
                TabView.selectTabViewItem(at: 1)
            }
            preAnalysis()
        }
    }
    
    func preAnalysis() {
        verbose(text: "Start func : preAnalysis()")
        if MultiTPAD {
            var count:Int = 0
            for _ in 0..<MultiScope.count {
                if MultiScope[count] != "" {
                    if count == 0 {
                        ScopeRadio0.isHidden = false
                        ScopeRadio0.title = "I2C" + MultiScope[count]
                    } else if count == 1 {
                        ScopeRadio1.isHidden = false
                        ScopeRadio1.title = "I2C" + MultiScope[count]
                    } else if count == 2 {
                        ScopeRadio2.isHidden = false
                        ScopeRadio2.title = "I2C" + MultiScope[count]
                    } else if count == 3 {
                        ScopeRadio3.isHidden = false
                        ScopeRadio3.title = "I2C" + MultiScope[count]
                    }
                    count += 1
                }
            }
            SelectDevice.accessoryView = SelectDeviceView
            SelectDevice.informativeText = NSLocalizedString("Multiple ", comment: "") + TPAD + NSLocalizedString(" found in the DSDT\nWhich Path is the Correct one?", comment: "")
            SelectDevice.alertStyle = .informational
            SelectDevice.addButton(withTitle: NSLocalizedString("OK", comment: ""))
            verbose(text: "Pop-up to ask which is the correct device path")
            SelectDevice.beginSheetModal(for: self.window, completionHandler: {respose -> Void in self.Analysis()})
        } else {
            Analysis()
        }
    }
    
    func Analysis() {
        print("Analysis()")
        verbose(text: "Start func : Analysis()")
        if MultiTPAD {
            Code = [String](repeating: "", count: MultiTPADLineCount[MultiTPADUSRSelect] + 1)
        } else {
            Code = [String](repeating: "", count: total + 1)
        }
        line = 0
        DSDTLine = ""
        Paranthesesopen = ""
        Paranthesesclose = ""
        i = 0
        while line < count - 1 {
            DSDTLine = lines[line]
            line += 1
            if DSDTLine.contains(Device){
                if (MultiTPAD && TargetTPAD == MultiTPADUSRSelect) || MultiTPAD == false {
                    var spaceopen, spaceclose:Int
                    Code[i] = DSDTLine
                    i += 1
                    Paranthesesopen = lines[line]
                    line += 1
                    Code[i] = Paranthesesopen
                    i += 1
                    spaceopen = Paranthesesopen.positionOf(sub: "{")
                    repeat{
                        Paranthesesclose = lines[line]
                        line += 1
                        spaceclose = Paranthesesclose.positionOf(sub: "}")
                        Code[i] = Paranthesesclose
                        i += 1
                    } while spaceopen != spaceclose
                }
                TargetTPAD = TargetTPAD + 1
            }
        }
        for i in 0...total {
            if Code[i].contains("Method (_CRS,") {
                var CRSStart, CRSEnd, CRSRangeScan:Int
                CRSRangeScan = i + 1
                CRSStart = Code[CRSRangeScan].positionOf(sub: "{") - 1
                repeat {
                    CRSEnd = Code[CRSRangeScan].positionOf(sub: "}") - 1
                    CRSRangeScan += 1
                } while CRSStart != CRSEnd
                n = CRSRangeScan - i
                CRSLocation = i
                CRSInfo = [String](repeating: "", count: n + 1)
                n = 0
                for CRSInfoLine in i...(CRSRangeScan - 1) {
                    CRSInfo[n] = Code[CRSInfoLine]
                    n += 1
                }
            } else if Code[i].contains("Method (XCRS,") {
                verbose(text: "\nRenamed _CRS detected!\nPlease use an error-corrected vanilla DSDT instead!\n")
                Pop_up(messageText: NSLocalizedString("Renamed _CRS detected!", comment: ""), informativeText: NSLocalizedString("Please use an error-corrected vanilla DSDT instead!", comment: ""))
                exit(0)
            }
            if Code[i].contains("GpioInt"){
                if ExGPIO == true {
                    ExGPIO = true
                    GPIONameLineFound = false
                }
                verbose(text: "Native GpioInt Found in \(TPAD) at line \(i)\n")
                ExGPIO = true
                GPIONAMELine = i
                for GPIONAMELine in (1...GPIONAMELine).reversed(){
                    if Code[GPIONAMELine].contains("Name (SBF") && GPIONameLineFound == false {
                        let str = Code[GPIONAMELine]
                        let index1 = str.index(str.startIndex, offsetBy: (Code[GPIONAMELine].positionOf(sub: "SBF")))
                        let index2 = str.index(str.startIndex, offsetBy: (Code[GPIONAMELine].positionOf(sub: "SBF") + 4))
                        GPIONAME = String(str[index1..<index2])
                        GPIONameLineFound = true
                    }
                }
                GPIOPinLine = i + 4
                let index1 = Code[GPIOPinLine].index(Code[GPIOPinLine].startIndex, offsetBy: Code[GPIOPinLine].positionOf(sub: "0x"))
                let HEXPIN = String(Code[GPIOPinLine][index1..<Code[GPIOPinLine].endIndex])
                GPIOPIN = Int(strtoul(HEXPIN, nil, 16))
                verbose(text: "GPIO Pin \(GPIOPIN)\n")
            }
            if Code[i].contains("Interrupt (ResourceConsumer") {
                if ExAPIC == true {
                    APICNameLineFound = false
                }
                verbose(text: "Native APIC Found in \(TPAD) at line \(i + 1)\n")
                ExAPIC = true
                APICNameLine = i
                for APICNameLine1 in (1...APICNameLine).reversed() {
                    if Code[APICNameLine1].contains("Name (SBF") && APICNameLineFound == false {
                        let index1 = Code[APICNameLine1].index(Code[APICNameLine1].startIndex, offsetBy: Code[APICNameLine1].positionOf(sub: "SBF"))
                        let index2 = Code[APICNameLine1].index(Code[APICNameLine1].startIndex, offsetBy: Code[APICNameLine1].positionOf(sub: "SBF") + 4)
                        APICNAME = String(Code[APICNameLine1][index1..<index2])
                        APICNameLineFound = true
                    }
                }
                APICPinLine = i + 2
                let index1 = Code[APICPinLine].index(Code[APICPinLine].startIndex, offsetBy: Code[APICPinLine].positionOf(sub: "0x"))
                let index2 = Code[APICPinLine].index(Code[APICPinLine].startIndex, offsetBy: Code[APICPinLine].positionOf(sub: "0x") + 10)
                APICPIN = Int(strtoul(String(Code[APICPinLine][index1..<index2]), nil, 16))
                verbose(text: "APIC Pin \(APICPIN)\n")
            }
            if Code[i].contains("I2cSerialBusV2 (0x") || Code[i].contains("I2cSerialBus (0x"){
                if ExSLAV == true {
                    SLAVNameLineFound = false
                    verbose(text: "Warning! Multiple I2C Bus Addresses exist in " + TPAD + " _CRS patching may be wrong!")
                }
                verbose(text: "Slave Address Found in \(TPAD) at line \(i + 1)\n")
                ExSLAV = true
                SLAVNameLine = i
                for SLAVNameLine1 in (1...SLAVNameLine).reversed() {
                    if Code[SLAVNameLine1].contains("Name (SBF") && SLAVNameLineFound == false {
                        let index1 = Code[SLAVNameLine1].index(Code[SLAVNameLine1].startIndex, offsetBy: Code[SLAVNameLine1].positionOf(sub: "SBF"))
                        let index2 = Code[SLAVNameLine1].index(Code[SLAVNameLine1].startIndex, offsetBy: Code[SLAVNameLine1].positionOf(sub: "SBF") + 4)
                        SLAVName = String(Code[SLAVNameLine1][index1..<index2])
                        SLAVNameLineFound = true
                        CheckConbLine = SLAVNameLine1
                        CheckSLAVLocation = SLAVNameLine1
                    }
                }
                ScopeLine = i + 1
                if scope == "" {
                    if Code[ScopeLine].contains("NULL") && MultiTPAD == false {
                        scope = MultiScope[0]
                    } else {
                        scope = String(Code[ScopeLine][Code[ScopeLine].index(Code[ScopeLine].startIndex, offsetBy: Code[ScopeLine].positionOf(sub: "\",") - 1)])
                    }
                }
                verbose(text: Code[ScopeLine] + "\n")
                /*
                let index1 = Code[ScopeLine].index(Code[ScopeLine].startIndex, offsetBy: Code[ScopeLine].positionOf(sub: "\",") - 1)
                let index2 = Code[ScopeLine].index(Code[ScopeLine].startIndex, offsetBy: Code[ScopeLine].positionOf(sub: "\","))
                scope = String(Code[ScopeLine][index1..<index2])
 */
            }
            if Code[i].contains("Name (") && CatchSpacing == false {
                let index1 = Code[i].index(Code[i].startIndex, offsetBy: 0)
                let index2 = Code[i].index(Code[i].startIndex, offsetBy: Code[i].positionOf(sub: "Name (") - 4)
                Spacing = String(Code[i][index1..<index2])
                CatchSpacing = true
            }
        }
        if SLAVNameLineFound == true && APICNameLineFound == true && SLAVName == APICNAME && Hetero == false {
            Hetero = true
            if CheckSLAVLocation > CRSLocation {
                BreakCombine()
            }
        }
        var IfString:String = ""
        var LLessCount:Int = 0
        var LEqualCount:Int = 0
        var If2BracketsCount:Int = 0
        for CRSLine in 0...n {
            if CRSInfo[CRSLine].contains("If (LLess (") {
                let index1 = CRSInfo[CRSLine].index(CRSInfo[CRSLine].startIndex, offsetBy: CRSInfo[CRSLine].positionOf(sub: "If (LLess (") + 11)
                let index2 = CRSInfo[CRSLine].index(CRSInfo[CRSLine].startIndex, offsetBy: CRSInfo[CRSLine].positionOf(sub: "If (LLess (") + 15)
                if !(IfString.contains(String(CRSInfo[CRSLine][index1..<index2]))) || LLess == false {
                    IfLLess[LLessCount] = String(CRSInfo[CRSLine][index1..<index2])
                    IfString += IfLLess[LLessCount] + " "
                    LLessCount += 1
                    LLess = true
                }
            }
            if CRSInfo[CRSLine].contains("If (LEqual (") {
                let index1 = CRSInfo[CRSLine].index(CRSInfo[CRSLine].startIndex, offsetBy: CRSInfo[CRSLine].positionOf(sub: "If (LEqual (")+12)
                let index2 = CRSInfo[CRSLine].index(CRSInfo[CRSLine].startIndex, offsetBy: CRSInfo[CRSLine].positionOf(sub: "If (LEqual (")+16)
                if !(IfString.contains(String(CRSInfo[CRSLine][index1..<index2]))) || LEqual == false {
                    IfLEqual[LEqualCount] = String(CRSInfo[CRSLine][index1..<index2])
                    IfString += IfLEqual[LEqualCount] + " "
                    LEqualCount += 1
                    LEqual = true
                }
            }
            if CRSInfo[CRSLine].contains("If ((") && (CRSInfo[CRSLine].contains("<") || CRSInfo[CRSLine].contains("==")) {
                let index1 = CRSInfo[CRSLine].index(CRSInfo[CRSLine].startIndex, offsetBy: CRSInfo[CRSLine].positionOf(sub: "If ((")+5)
                let index2 = CRSInfo[CRSLine].index(CRSInfo[CRSLine].startIndex, offsetBy: CRSInfo[CRSLine].positionOf(sub: "If ((")+9)
                if !(IfString.contains(String(CRSInfo[CRSLine][index1..<index2]))) || If2BracketsBool == false {
                    If2Brackets[If2BracketsCount] = String(CRSInfo[CRSLine][index1..<index2])
                    IfString += If2Brackets[If2BracketsCount] + " "
                    If2BracketsCount += 1
                    If2BracketsBool = true
                }
            }
            if CRSInfo[CRSLine].contains("I2CM (I2CX, BADR, SPED)") {
                ExI2CM = true
            }
            if CRSInfo[CRSLine].contains("BADR") {
                ExBADR = true
            }
            if CRSInfo[CRSLine].contains("ADR0") {
                ExADR0 = true
            }
            if CRSInfo[CRSLine].contains("HID2") {
                ExHID2 = true
            }
            if CRSInfo[CRSLine].contains("TPID") {
                ExTPID = true
            }
            if CRSInfo[CRSLine].contains("TPDF") {
                ExTPDF = true
            }
        }
        if SLAVNameLineFound == false {
            verbose(text: "\nThis is not a I2C Device!\n")
            Pop_up(messageText: NSLocalizedString("Warning", comment: ""), informativeText: NSLocalizedString("This is not a I2C Device!", comment: ""))
            exit(0)
        } else {
            
        }
        TabView.selectNextTabViewItem(Any?.self)
    }
    
    func Analysis2() {
        print("Analysis2()")
        verbose(text: "Start func : Analysis2()")
        if Choice == 0 {
            InterruptEnabled = true
        } else if Choice == 1 {
            PollingEnabled = true
        } else {
            
        }
        if ExAPIC && APICPIN >= 24 && APICPIN <= 47 {
            verbose(text: "APIC Pin value < 2F, Native APIC Supported, using instead\n")
            if Hetero == true {
                APICNAME = "SBFX"
            }
            PatchCRS2APIC()
            analysis3()
        } else if ExAPIC == false && ExGPIO == true {
            if InterruptEnabled == true {
                PatchCRS2GPIO()
            }
            if PollingEnabled == true {
                APICPIN = 63
                APICNAME = "SBFX"
                PatchCRS2APIC()
            }
            analysis3()
        } else if (ExAPIC && (APICPIN > 47 || APICPIN == 0) && InterruptEnabled && ExGPIO == false && APICPIN == 0) || (ExAPIC == false && ExGPIO == false && ExSLAV && InterruptEnabled) {
            alert.beginSheetModal(for: self.window, completionHandler: {response -> Void in
                self.analysis3()
            })
        } else {
            analysis3()
        }
    }
    
    func analysis3() {
        print("analysis3()")
        verbose(text: "Start func : Analysis3()")
        if ExAPIC == true && (APICPIN > 47 || APICPIN == 0) {
            if InterruptEnabled == true {
                if ExGPIO == false {
                    if APICPIN == 0 {
                        if APICPIN >= 24 && APICPIN <= 47 {
                            verbose(text: "APIC Pin value < 2F, Native APIC Supported, using instead\n")
                            if Hetero {
                                APICNAME = "SBFX"
                                PatchCRS2APIC()
                            }
                        } else {
                            GPIONAME = "SBFZ"
                            APIC2GPIO()
                            PatchCRS2GPIO()
                        }
                    } else if APICPIN > 47 {
                        verbose(text: "No native GpioInt found, Generating instead")
                        GPIONAME = "SBFZ"
                        APIC2GPIO()
                        PatchCRS2GPIO()
                    }
                } else if ExGPIO {
                    PatchCRS2GPIO()
                }
            } else if PollingEnabled == true {
                if Hetero {
                    APICNAME = "SBFX"
                    APICPIN = 63
                }
                if APICPIN == 0 {
                    verbose(text: "APIC Pin size uncertain, could be either APIC or polling")
                }
                PatchCRS2APIC()
            }
        } else if ExAPIC == false && ExGPIO == false && ExSLAV {
            if InterruptEnabled {
                if APICPIN >= 24 && APICPIN <= 47 {
                    verbose(text: "APIC Pin value < 2F, Native APIC Supported, No _CRS Patch required\n")
                } else {
                    GPIONAME = "SBFZ"
                    APIC2GPIO()
                    PatchCRS2GPIO()
                }
            } else if PollingEnabled {
                APICNAME = "SBFX"
                APICPIN = 63
                PatchCRS2APIC()
            }
        } else {
            verbose(text: "Undefined Situation")
        }
        GenSSDT()
        NSWorkspace.shared.selectFile(nil, inFileViewerRootedAtPath: FolderPath)
    }
    
    func PatchCRS2GPIO() {
        if CPUChoice != 3 {
            print("PatchCRS2GPIO()")
            verbose(text: "Start func : PatchCRS2GPIO")
            for CRSLine in 0...n {
                if CRSInfo[CRSLine].contains("Return (ConcatenateResTemplate") {
                    if ExI2CM {
                        let index = CRSInfo[CRSLine].index(CRSInfo[CRSLine].startIndex, offsetBy: CRSInfo[CRSLine].positionOf(sub: "BADR, "))
                        CRSInfo[CRSLine] = String(CRSInfo[CRSLine][..<index]) + "\\_SB.PCI0.I2C" + scope + "." + TPAD + ".BADR, " + "\\_SB.PCI0.I2C" + scope + "." + TPAD + ".SPED)" + ", " + GPIONAME + "))"
                    } else {
                        let index = CRSInfo[CRSLine].index(CRSInfo[CRSLine].startIndex, offsetBy: CRSInfo[CRSLine].positionOf(sub: ", SBF"))
                        CRSInfo[CRSLine] = String(CRSInfo[CRSLine][..<index]) + ", " + GPIONAME + "))"
                    }
                    CRSPatched = true
                } else if CRSInfo[CRSLine].contains("Return (SBF") {
                    let index = CRSInfo[CRSLine].index(CRSInfo[CRSLine].startIndex, offsetBy: CRSInfo[CRSLine].positionOf(sub: "("))
                    CRSInfo[CRSLine] = String(CRSInfo[CRSLine][..<index]) + "(ConcatenateResTemplate (" + SLAVName + ", " + GPIONAME + ")) // Usually this return won't function, please check your Windows Patch"
                    CRSPatched = true
                }
            }
            if CRSPatched == false {
                verbose(text: "Error! No _CRS Patch Applied!")
            }
            GPI0SSDT[0] = #"/*"#
            GPI0SSDT[1] = #" * Opencore add SSDT-GPI0 into EFI/OC/ACPI and Integrate in Config.plist. Clover add SSDT-GPI0 into Clover EFI/Clover/ACPI/Patched"#
            GPI0SSDT[2] = #" */"#
            GPI0SSDT[3] = "DefinitionBlock(\"\", \"SSDT\", 2, \"hack\", \"GPI0\", 0)"
            GPI0SSDT[4] = #"{"#
            GPI0SSDT[5] = #"    External (GPEN, FieldUnitObj)"#
            GPI0SSDT[6] = #"    External (GPHD, FieldUnitObj)"#
            GPI0SSDT[7] = #"    Scope (\)"#
            GPI0SSDT[8] = #"    {"#
            GPI0SSDT[9] = #"        If (_OSI ("Darwin"))"#
            GPI0SSDT[10] = #"        {"#
            GPI0SSDT[11] = #"            GPEN = One"#
            GPI0SSDT[12] = #"            GPHD = Zero"#
            GPI0SSDT[13] = #"        }"#
            GPI0SSDT[14] = #"    }"#
            GPI0SSDT[15] = #"}"#
            var SSDT:String = ""
            try! FileManager.default.createDirectory(atPath: FolderPath, withIntermediateDirectories: true, attributes: nil)
            let path:String = FolderPath + "/SSDT-GPI0.dsl"
            if FileManager.default.fileExists(atPath: path) {
                try! FileManager.default.removeItem(atPath: path)
                FileManager.default.createFile(atPath: path, contents: nil, attributes: nil)
            } else {
                FileManager.default.createFile(atPath: path, contents: nil, attributes: nil)
            }
            for Genindex in 0...15{
                SSDT += GPI0SSDT[Genindex] + "\n"
            }
            try! SSDT.write(toFile: path, atomically: true, encoding: String.Encoding.utf8)
            iasl(path: path)
        }
    }
    
    func PatchCRS2APIC() {
        print("PatchCRS2APIC()")
        verbose(text: "Start func : PatchCRS2APIC()")
        for CRSLine in 0...n {
            if CRSInfo[CRSLine].contains("Return (ConcatenateResTemplate") {
                if ExI2CM {
                    let index = CRSInfo[CRSLine].index(CRSInfo[CRSLine].startIndex, offsetBy: CRSInfo[CRSLine].positionOf(sub: "BADR, "))
                    CRSInfo[CRSLine] = String(CRSInfo[CRSLine][..<index]) + "\\_SB.PCI0.I2C" + scope + "." + TPAD + ".BADR, " + "\\_SB.PCI0.I2C" + scope + "." + TPAD + ".SPED)" + ", " + APICNAME + "))"
                } else {
                    let index = CRSInfo[CRSLine].index(CRSInfo[CRSLine].startIndex, offsetBy: CRSInfo[CRSLine].positionOf(sub: ", SBF"))
                    CRSInfo[CRSLine] = String(CRSInfo[CRSLine][..<index]) + ", " + APICNAME + "))"
                }
                CRSPatched = true
            } else if CRSInfo[CRSLine].contains("Return (SBF") {
                let index = CRSInfo[CRSLine].index(CRSInfo[CRSLine].startIndex, offsetBy: CRSInfo[CRSLine].positionOf(sub: "("))
                CRSInfo[CRSLine] = String(CRSInfo[CRSLine][..<index]) + "(ConcatenateResTemplate (" + SLAVName + ", " + APICNAME + ")) // Usually this return won't function, please check your Windows Patch"
                CRSPatched = true
            }
        }
        if CRSPatched == false {
            verbose(text: "Error! No _CRS Patch Applied!")
        }
    }
    
    func APIC2GPIO() {
        print("APIC2GPIO()")
        verbose(text: "Start func : APIC2GPIO()")
        if APICPIN >= 24 && APICPIN <= 47 {
            verbose(text: "APIC Pin value < 2F, Native APIC Supported, Generation Cancelled")
        } else {
            switch CPUChoice {
            case 0, 3 :
                if APICPIN > 47 && APICPIN <= 79 {
                    GPIOPIN = APICPIN - 24
                    GPIOPIN2 = APICPIN + 72
                } else if APICPIN > 79 && APICPIN <= 119 {
                    GPIOPIN = APICPIN - 24
                }
            case 1 :
                if APICPIN > 47 && APICPIN <= 71 {
                    GPIOPIN = APICPIN - 16
                    GPIOPIN2 = APICPIN + 240
                    if APICPIN > 47 && APICPIN <= 59 {
                        GPIOPIN3 = APICPIN + 304
                    }
                } else if APICPIN > 71 && APICPIN <= 95 {
                    GPIOPIN = APICPIN - 8
                    GPIOPIN3 = APICPIN + 152
                    GPIOPIN2 = APICPIN + 120
                } else if APICPIN > 95 && APICPIN <= 119 {
                    GPIOPIN = APICPIN
                    if APICPIN > 108 && APICPIN <= 115 {
                        GPIOPIN2 = APICPIN + 20
                    }
                }
            case 2 :
                if APICPIN > 47 && APICPIN <= 71 {
                    GPIOPIN = APICPIN - 16
                    GPIOPIN2 = APICPIN + 80
                } else if APICPIN > 71 && APICPIN <= 95 {
                    GPIOPIN2 = APICPIN + 184
                    GPIOPIN = APICPIN + 88
                } else if APICPIN > 95 && APICPIN <= 119 {
                    GPIOPIN = APICPIN
                    if APICPIN > 108 && APICPIN <= 115 {
                        GPIOPIN2 = APICPIN - 44
                    }
                }
            default:
                print("default")
            }
        }
    }
    
    func GenGPIO() {
        print("GenGPIO()")
        verbose(text: "Start func : GenGPIO()")
        ManualGPIO[0] = Spacing + "Name (SBFZ, ResourceTemplate ()"
        ManualGPIO[1] = Spacing + "{"
        ManualGPIO[2] = Spacing + "    GpioInt (Level, ActiveLow, Exclusive, PullUp, 0x0000,"
        ManualGPIO[3] = Spacing + #"       "\\ _SB.PCI0.GPI0", 0x00, ResourceConsumer, ,"#
        ManualGPIO[4] = Spacing + "        )"
        ManualGPIO[5] = Spacing + "        {   // Pin list"
        if GPIOPIN2 == 0 {
            ManualGPIO[6] = Spacing + "            0x" + String(format: "%0X", GPIOPIN)
        } else if GPIOPIN2 != 0 && GPIOPIN3 == 0 {
            ManualGPIO[6] = Spacing + "            0x" + String(format: "%0X", GPIOPIN) + " // Try this if the first one doesn't work: 0x" + String(format: "%0X", GPIOPIN2)
        } else {
            ManualGPIO[6] = Spacing + "            0x" + String(format: "%0X", GPIOPIN) + " // Try the following ones if the first one doesn't work: 0x" + String(format: "%0X", GPIOPIN2) + " 0x" + String(format: "%0X", GPIOPIN3)
        }
        ManualGPIO[7] = Spacing + "        }"
        ManualGPIO[8] = Spacing + "})"
    }
    
    func GenAPIC() {
        print("GenAPIC()")
        verbose(text: "Start func : GenAPIC()")
        ManualAPIC[0] = Spacing + "Name (SBFX, ResourceTemplate ()"
        ManualAPIC[1] = Spacing + "{"
        ManualAPIC[2] = Spacing + "    Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,,)"
        ManualAPIC[3] = Spacing + "    {"
        ManualAPIC[4] = Spacing + "        0x000000" + String(format: "%0X", APICPIN) + ","
        ManualAPIC[5] = Spacing + "    }"
        ManualAPIC[6] = Spacing + "})"
    }
    
    func GenSSDT() {
        print("GenSSDT()")
        verbose(text: "Start func : GenSSDT")
        if InterruptEnabled || PollingEnabled {
            if ExAPIC == false && ExGPIO == false && APICPIN < 47 {
                
            } else {
                try! FileManager.default.createDirectory(atPath: FolderPath, withIntermediateDirectories: true, attributes: nil)
                let path:String = FolderPath + "/SSDT-" + TPAD + ".dsl"
                if FileManager.default.fileExists(atPath: path) {
                    try! FileManager.default.removeItem(atPath: path)
                    FileManager.default.createFile(atPath: path, contents: nil, attributes: nil)
                } else {
                    FileManager.default.createFile(atPath: path, contents: nil, attributes: nil)
                }
                
                var RenameCRS = [String](repeating: "", count: 5)
                RenameCRS[0] = "/*"
                RenameCRS[1] = " * Add Rename EFI/Clover/config.plist\n"
                RenameCRS[2] = " * Find _CRS:          5F 43 52 53"
                RenameCRS[3] = " * Replace XCRS:       58 43 52 53"
                RenameCRS[4] = " * Target Bridge " + TPAD + ": " + HexTPAD
                
                var RenameUSTP = [String](repeating: "", count: 3)
                RenameUSTP[0] = " * "
                RenameUSTP[1] = " * Find USTP:          55 53 54 50 08"
                RenameUSTP[2] = " * Replace XSTP:       58 53 54 50 08"
                
                var Filehead = [String](repeating: "", count: 36)
                Filehead[0] = #"DefinitionBlock("", "SSDT", 2, "hack", "I2Cpatch", 0)"#
                Filehead[1] = "{"
                Filehead[2] = "    External(_SB.PCI0.I2C" + scope + "." + TPAD + ", DeviceObj)"
                if CheckSLAVLocation < CRSLocation {
                    Filehead[3] = "    External(_SB.PCI0.I2C" + scope + "." + TPAD + "." + SLAVName + ", IntObj)"
                    if (PollingEnabled && ExAPIC && Hetero == false) || APICPIN < 47 && APICPIN != 0 && ExAPIC && Hetero == false {
                        Filehead[4] = "    External(_SB.PCI0.I2C" + scope + "." + TPAD + "." + APICNAME + ", IntObj)"
                    }
                    if InterruptEnabled && ExGPIO && (APICPIN > 47 || APICPIN == 0 || ExAPIC == false) {
                        Filehead[5] = "    External(_SB.PCI0.I2C" + scope + "." + TPAD + "." + GPIONAME + ", IntObj)"
                    }
                }
                
                var AddFhLe:Int = 6
                var AddFhEq:Int = 12
                var AddFhIf2B:Int = 18
                
                for Genindex in 0...5 {
                    if IfLLess[Genindex] != "" && (IfLLess[Genindex] != "Zero" || IfLLess[Genindex] != "One)") {
                        Filehead[AddFhLe] = "    External(" + IfLLess[Genindex] + ", FieldUnitObj)"
                        AddFhLe += 1
                    }
                    if IfLEqual[Genindex] != "" && (IfLEqual[Genindex] != "Zero" || IfLEqual[Genindex] != "One)") {
                        Filehead[AddFhEq] = "    External(" + IfLEqual[Genindex] + ", FieldUnitObj)"
                        AddFhEq += 1
                    }
                    if If2Brackets[Genindex] != "" && (If2Brackets[Genindex] != "Zero" || If2Brackets[Genindex] != "One)") {
                        Filehead[AddFhIf2B] = "    External(" + If2Brackets[Genindex] + ", FieldUnitObj)"
                        AddFhIf2B += 1
                    }
                }
                if ExI2CM {
                    Filehead[24] = "    External(_SB.PCI0.I2C" + scope + ".I2CX, IntObj)"
                    Filehead[25] = "    External(_SB.PCI0.I2CM, MethodObj)"
                    Filehead[26] = "    External(_SB.PCI0.I2C" + scope + "." + TPAD + ".BADR, IntObj)"
                    Filehead[27] = "    External(_SB.PCI0.I2C" + scope + "." + TPAD + ".SPED, IntObj)"
                }
                if ExBADR && ExI2CM == false {
                    Filehead[28] = "    External(_SB.PCI0.I2C" + scope + "." + TPAD + ".BADR, IntObj)"
                }
                if ExADR0 {
                    Filehead[29] = "    External(_SB.PCI0.I2C" + scope + "." + TPAD + ".ADR0, IntObj)"
                }
                if ExHID2 {
                    Filehead[30] = "    External(_SB.PCI0.I2C" + scope + "." + TPAD + ".HID2, IntObj)"
                }
                if ExTPID {
                    Filehead[31] = "    External(_SB.PCI0.I2C" + scope + "." + TPAD + ".TPID, IntObj)"
                }
                if ExTPDF {
                    Filehead[32] = "    External(_SB.PCI0.I2C" + scope + "." + TPAD + ".TPDF, IntObj)"
                }
                if ExUSTP {
                    Filehead[33] = "    Name (USTP, One)"
                }
                Filehead[34] = "    Scope(_SB.PCI0.I2C" + scope + "." + TPAD + ")"
                Filehead[35] = "    {"
                
                var fileContent:String = ""
                for Genindex in 0..<RenameCRS.count {
                    if RenameCRS[Genindex] != "" && RenameCRS[Genindex] != "\n" {
                        fileContent += RenameCRS[Genindex] + "\n"
                    }
                }
                if ExUSTP {
                    for Genindex in 0..<RenameUSTP.count {
                        fileContent += RenameUSTP[Genindex] + "\n"
                    }
                }
                fileContent += " */\n"
                for Genindex in 0..<Filehead.count {
                    if Filehead[Genindex] != "" && Filehead[Genindex] != "\n" {
                        fileContent += Filehead[Genindex] + "\n"
                    }
                }
                if ExUSTP == false && (ExFMCN == false || ExSSCN == false) {
                    GenSPED()
                    if CPUChoice == 0 || CPUChoice == 3 {
                        if ExSSCN == false && ExFMCN {
                            fileContent += ManualSPED[0] + "\n"
                        } else if ExFMCN == false && ExSSCN {
                            fileContent += ManualSPED[1] + "\n"
                        } else {
                            fileContent += ManualSPED[0] + "\n" + ManualSPED[1] + "\n"
                        }
                    }
                }
                if InterruptEnabled && ExGPIO == false && APICPIN > 47 {
                    GenGPIO()
                    for Genindex in 0..<ManualGPIO.count {
                        fileContent += ManualGPIO[Genindex] + "\n"
                    }
                }
                if (PollingEnabled && ExAPIC == false) || Hetero {
                    GenAPIC()
                    for Genindex in 0..<ManualAPIC.count {
                        fileContent += ManualAPIC[Genindex] + "\n"
                    }
                }
                for Genindex in 0...CRSInfo.count - 2 {
                    if (CRSInfo[Genindex] != "" && CRSInfo[Genindex] != "\n") || Hetero == false {
                        fileContent += CRSInfo[Genindex] + "\n"
                    }
                }
                fileContent += "    }\n}"
                try! fileContent.write(toFile: path, atomically: true, encoding: String.Encoding.utf8)
                iasl(path: path)
            }
        }
        RenameLabel.string += "++++++++++++++++++++++++++++++++++++++\n\n"
        if InterruptEnabled || PollingEnabled {
            RenameLabel.string += "    Add Rename EFI/Clover/config.plist\n"
            RenameLabel.string += "    Find _CRS:          5F 43 52 53\n"
            RenameLabel.string += "    Replace XCRS:       58 43 52 53\n"
            RenameLabel.string += "    Target Bridge \(TPAD): \(HexTPAD)\n\n"
            if InterruptEnabled && (APICPIN > 47 || (APICPIN == 0 && ExGPIO && ExAPIC)) {
                RenameLabel.string += "    Add Rename EFI/Clover/config.plist\n"
                RenameLabel.string += "    Find _STA:          5F 53 54 41\n"
                RenameLabel.string += "    Replace XSTA:       58 53 54 41\n"
                RenameLabel.string += "    Target Bridge GPI0: 47 50 49 30\n\n"
            }
            if ExUSTP && BlockI2C == false {
                RenameLabel.string += "    Find USTP:          55 53 54 50 08\n"
                RenameLabel.string += "    Replace XSTP:       58 53 54 50 08\n\n"
            } else if ExUSTP == false && ExSSCN && ExFMCN == false && CPUChoice == 1 && BlockI2C == false {
                RenameLabel.string += "    Find SSCN:          53 53 43 4E\n"
                RenameLabel.string += "    Replace XSCN:       58 53 43 4E\n"
            }
        } else if BlockI2C {
            RenameLabel.string += "    Add Rename EFI/Clover/config.plist\n"
            RenameLabel.string += "    Find _STA:          5F 53 54 41\n"
            RenameLabel.string += "    Replace XSTA:       58 53 54 41\n"
            RenameLabel.string += "    Target Bridge \(BlockBus): \(HexBlockBus)\n\n"
        }
        RenameLabel.string += "Please use the Rename(s) above in the given order\n\n"
        RenameLabel.string += "++++++++++++++++++++++++++++++++++++++"
        GenReadme(Rename: RenameLabel.string)
    }
    
    func BreakCombine() {
        print("BreakCombine()")
        verbose(text: "Start func : BreakCombine()")
        for BreakIndex in 0...3 {
            CRSInfo[CRSInfo.count - 1 - (total + 1 - (CheckConbLine + 7)) + BreakIndex] = ""
        }
    }
    
    func GenSPED() {
        print("GenSPED()")
        verbose(text: "Start func : GenSPED()")
        if CPUChoice == 0 || CPUChoice == 3 {
            if scope == "0" || scope == "2" || scope == "3" {
                ManualSPED[0] = Spacing + "Name (SSCN, Package () { 432, 507, 30 })"
                ManualSPED[1] = Spacing + "Name (FMCN, Package () { 72, 160, 30 })"
            } else if scope == "1" {
                ManualSPED[0] = Spacing + "Name (SSCN, Package () { 528, 640, 30 })"
                ManualSPED[1] = Spacing + "Name (FMCN, Package () { 128, 160, 30 })"
            }
        } else if CPUChoice == 1 {
            if ExSSCN {
                CNL_H_SPED[0] = "/* "
                CNL_H_SPED[1] = " * Find SSCN:          53 53 43 4E"
                CNL_H_SPED[2] = " * Replace XSCN:       58 53 43 4E"
                CNL_H_SPED[3] = " */"
            }
            CNL_H_SPED[4] = #"DefinitionBlock("", "SSDT", 2, "hack", "I2C-SPED", 0)"#
            CNL_H_SPED[5] = "{"
            CNL_H_SPED[6] = "    External(_SB_.PCI0.I2C" + scope + ", DeviceObj)"
            CNL_H_SPED[7] = "    External(SSD" + scope + ", IntObj)"
            CNL_H_SPED[8] = "    External(SSH" + scope + ", IntObj)"
            CNL_H_SPED[9] = "    External(SSL" + scope + ", IntObj)"
            CNL_H_SPED[10] = "    Scope(_SB.PCI0.I2C\(scope))"
            CNL_H_SPED[11] = "    {"
            CNL_H_SPED[12] = #"       If (_OSI ("Darwin"))"#
            CNL_H_SPED[13] = "        {"
            CNL_H_SPED[14] = "            Method (PKGX, 3, Serialized)"
            CNL_H_SPED[15] = "            {"
            CNL_H_SPED[16] = "                Name (PKG, Package (0x03)"
            CNL_H_SPED[17] = "                {"
            CNL_H_SPED[18] = "                    Zero, "
            CNL_H_SPED[19] = "                    Zero, "
            CNL_H_SPED[20] = "                    Zero"
            CNL_H_SPED[21] = "                })"
            CNL_H_SPED[22] = "                Store (Arg0, Index (PKG, Zero))"
            CNL_H_SPED[23] = "                Store (Arg1, Index (PKG, One))"
            CNL_H_SPED[24] = "                Store (Arg2, Index (PKG, 0x02))"
            CNL_H_SPED[25] = "                Return (PKG)"
            CNL_H_SPED[26] = "           }"
            CNL_H_SPED[27] = "           Method (SSCN, 0, NotSerialized)"
            CNL_H_SPED[28] = "           {"
            CNL_H_SPED[29] = "               Return (PKGX (SSH" + scope + ", SSL" + scope + ", SSD" + scope + "))"
            CNL_H_SPED[30] = "           }"
            CNL_H_SPED[31] = "           Method (FMCN, 0, NotSerialized)"
            CNL_H_SPED[32] = "           {"
            CNL_H_SPED[33] = "               Name (PKG, Package (0x03)"
            CNL_H_SPED[34] = "               {"
            CNL_H_SPED[35] = "                   0x0101, "
            CNL_H_SPED[36] = "                   0x012C, "
            CNL_H_SPED[37] = "                   0x62"
            CNL_H_SPED[38] = "               })"
            CNL_H_SPED[39] = "               Return (PKG)"
            CNL_H_SPED[40] = "           }"
            CNL_H_SPED[41] = "       }"
            CNL_H_SPED[42] = "   }"
            CNL_H_SPED[43] = "}"
            
            let path:String = FolderPath + "/SSDT-I2C\(scope)-SPED.dsl"
            var fileContent:String = ""
            for Genindex in 0..<CNL_H_SPED.count{
                if CNL_H_SPED[Genindex] != "" && CNL_H_SPED[Genindex] != "\n" {
                    fileContent += CNL_H_SPED[Genindex] + "\n"
                }
            }
            try! FileManager.default.createDirectory(atPath: FolderPath, withIntermediateDirectories: true, attributes: nil)
            if FileManager.default.fileExists(atPath: path) {
                try! FileManager.default.removeItem(atPath: path)
                FileManager.default.createFile(atPath: path, contents: nil, attributes: nil)
            } else {
                FileManager.default.createFile(atPath: path, contents: nil, attributes: nil)
            }
            try! fileContent.write(toFile: path, atomically: true, encoding: String.Encoding.utf8)
            iasl(path: path)
        }
    }
    
    func GenSKL() {

    }
    
    func GenBlockI2C() {
        
    }
    
    func verbose(text:String) {
        VerboseTextView.string += text
    }
    
    @IBAction func OpenVerbose(_ sender: Any) {
        VerboseWindow.setIsVisible(true)
    }
    
    @IBAction func OpenMacLog(_ sender: Any) {
        let t = Process()
        t.launchPath = Bundle.main.path(forResource: "maclog", ofType: nil)
        t.arguments = ["-b", "-F", "voodoo"]
        t.launch()
    }
    
    func controlTextDidChange(_ notification: Notification) {
        if DeviceName.stringValue.count < 4 {
            Next2.isEnabled = false
        } else if DeviceName.stringValue.count == 4 {
            TPAD = DeviceName.stringValue
            Device = "Device (\(TPAD))"
            Next2.isEnabled = true
        }
        if DeviceName.stringValue.count > 4 {
            let index = DeviceName.stringValue.index(DeviceName.stringValue.startIndex, offsetBy: 4)
            DeviceName.stringValue = String(DeviceName.stringValue[..<index])
        }
        if APICPinText.stringValue.count < 4 {
            alert.buttons[0].isEnabled = false
        } else if APICPinText.stringValue.count == 4 {
            let index = APICPinText.stringValue.index(APICPinText.stringValue.startIndex, offsetBy: 2)
            if String(APICPinText.stringValue[..<index]) == "0x" && APICPinText.stringValue.count == 4  {
                if Int(strtoul(APICPinText.stringValue, nil, 16)) >= 24 && Int(strtoul(APICPinText.stringValue, nil, 16)) <= 119 {
                    alert.buttons[0].isEnabled = true
                    Warning.stringValue = ""
                    APICPin = APICPinText.stringValue
                    APICPIN = Int(strtoul(APICPin, nil, 16))
                    verbose(text: "APIC Pin you input is \(APICPin)\n")
                } else {
                    Warning.stringValue = NSLocalizedString("APIC Pin should be between 0x18 and 0x77", comment: "")
                }
            }
        } else if APICPinText.stringValue.count > 4 {
            APICPinText.stringValue = String(APICPinText.stringValue[..<APICPinText.stringValue.index(APICPinText.stringValue.startIndex, offsetBy: 4)])
        }
        if APICPinText.stringValue.count >= 2 {
            if String(APICPinText.stringValue[..<APICPinText.stringValue.index(APICPinText.stringValue.startIndex,offsetBy: 2)]) != "0x" {
                APICPinText.stringValue = "0x"
            }
        } else {
            APICPinText.stringValue = "0x"
        }
    }
    
    func Pop_up(messageText:String, informativeText:String) {
        let Pop_up = NSAlert()
        Pop_up.messageText = messageText
        Pop_up.informativeText = informativeText
        Pop_up.alertStyle = .informational
        Pop_up.addButton(withTitle: NSLocalizedString("OK", comment: ""))
        //Pop_up.beginSheetModal(for: AMLDecomplier, completionHandler: {respose -> Void in})
        Pop_up.runModal()
    }
    
    func iasl(path:String) {
        let t = Process()
        t.launchPath = Bundle.main.path(forResource: "iasl", ofType: nil)
        t.arguments = [path]
        t.launch()
    }
    
    @IBAction func SaveLog(_ sender: Any) {
        let a = Process()
        let pipe = Pipe()
        a.standardOutput = pipe
        a.launchPath = "/usr/bin/who"
        a.launch()
        a.waitUntilExit()
        let outdata = pipe.fileHandleForReading.availableData
        let outputString = String(data: outdata, encoding: String.Encoding.utf8)!
        let timeline = outputString.components(separatedBy: "\n")[0]
        let month = timeline.components(separatedBy: " ").filter{$0 != ""}[2]//time.components(separatedBy: " ")[0]
        let date = Date()
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy"
        let year = dateFormat.string(from: date)
        var month_num:String = ""
        switch month {
        case "Jan":
            month_num = "1"
        case "Feb":
            month_num = "2"
        case "Mar":
            month_num = "3"
        case "Apr":
            month_num = "4"
        case "May":
            month_num = "5"
        case "Jun":
            month_num = "6"
        case "Jul":
            month_num = "7"
        case "Aug":
            month_num = "8"
        case "Sept":
            month_num = "9"
        case "Oct":
            month_num = "10"
        case "Nov":
            month_num = "11"
        case "Dec":
            month_num = "12"
        default:
            print("default")
        }
        var curDate:String = ""
        curDate = "\(year)-\(month_num)-\(timeline.components(separatedBy: " ").filter{$0 != ""}[3]) \(timeline.components(separatedBy: " ").filter{$0 != ""}[4]):00"
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        var dateDate = dateFormatter.date(from: curDate)!
        dateDate = dateDate - 60
        curDate = dateFormatter.string(from: dateDate)
        let b = Process()
        let pipe1 = Pipe()
        b.standardOutput = pipe1
        b.launchPath = "/usr/bin/log"
        b.arguments = ["show", "--predicate", "(eventMessage CONTAINS[c] \"VoodooI2C\") || (eventMessage CONTAINS[c] \"VoodooGPIO\")", "--last", "boot"]// "--start", "\(curDate)"]
        b.launch()
        b.waitUntilExit()
        var data:Data
        data = pipe1.fileHandleForReading.readDataToEndOfFile()
        let Log = String(data: data, encoding: String.Encoding.utf8)!
        
        let path = FolderPath + "/GenI2C.log"
        try! FileManager.default.createDirectory(atPath: FolderPath, withIntermediateDirectories: true, attributes: nil)
        if FileManager.default.fileExists(atPath: path) {
            try! FileManager.default.removeItem(atPath: path)
            FileManager.default.createFile(atPath: path, contents: nil, attributes: nil)
        } else {
            FileManager.default.createFile(atPath: path, contents: nil, attributes: nil)
        }
        try! Log.write(toFile: path, atomically: true, encoding: String.Encoding.utf8)
        NSWorkspace.shared.selectFile(path, inFileViewerRootedAtPath: FolderPath)
    }
    
    @IBAction func SelectAMLPath(_ sender: Any) {
        let openPanel:NSOpenPanel = NSOpenPanel()
        openPanel.canChooseDirectories = true
        openPanel.canChooseFiles = false
        openPanel.allowsMultipleSelection = false
        openPanel.beginSheetModal(for: mainWindow, completionHandler: {result in
            if (result == NSApplication.ModalResponse.OK)
            {
                let path:NSURL = openPanel.urls[0] as NSURL
                openPanel.close()
                let pathStr = path.absoluteString!.removingPercentEncoding!
                let index1 = pathStr.index(pathStr.startIndex, offsetBy: 7)
                let index2 = pathStr.index(pathStr.startIndex, offsetBy: pathStr.count)
                DSDTFile = String(pathStr[index1..<index2])
                self.AMLPath.stringValue = DSDTFile
                self.Decomplie.isEnabled = true
            }
        })
    }
    
    @IBAction func Disassemble(_ sender: Any) {
        let Disassemble = Process()
        let DisassemblePipe = Pipe()
        Disassemble.standardOutput = DisassemblePipe
        Disassemble.launchPath = Bundle.main.path(forResource: "iasl", ofType: nil)
        Disassemble.arguments = ["-d"]
        for file in try! FileManager.default.contentsOfDirectory(atPath: AMLPath.stringValue) {
            if file == "DSDT.aml" || (file.contains("SSDT-") && file.contains(".aml")) {
                Disassemble.arguments?.append(AMLPath.stringValue + file)
            }
        }
        Disassemble.launch()
        Disassemble.waitUntilExit()
        if FileManager.default.fileExists(atPath: AMLPath.stringValue + "DSDT.dsl") && (Int((try! FileManager.default.attributesOfItem(atPath: AMLPath.stringValue + "DSDT.aml") as NSDictionary).fileSize()) > 128){
            
        } else {
            Disassemble.arguments = ["-d", "-da"]
            for file in try! FileManager.default.contentsOfDirectory(atPath: AMLPath.stringValue) {
                if file == "DSDT.aml" || (file.contains("SSDT-") && file.contains(".aml")) {
                    Disassemble.arguments?.append(AMLPath.stringValue + file)
                }
            }
            Disassemble.launch()
        }
        if FileManager.default.fileExists(atPath: AMLPath.stringValue + "DSDT.dsl") && (Int((try! FileManager.default.attributesOfItem(atPath: AMLPath.stringValue + "DSDT.aml") as NSDictionary).fileSize()) > 128) {
            Pop_up(messageText: "Success!", informativeText: "")
        } else {
            Pop_up(messageText: "Failed!", informativeText: "")
        }
        let DisassembleData = DisassemblePipe.fileHandleForReading.readDataToEndOfFile()
        let DisassembleString = String(data: DisassembleData, encoding: String.Encoding.utf8)!
        DisassemblerVerbose.string = DisassembleString
        NSWorkspace.shared.selectFile(AMLPath.stringValue + "DSDT.dsl", inFileViewerRootedAtPath: AMLPath.stringValue)
    }
    
    @IBAction func Diagnosis(_ sender: Any) {
        State1.isHidden = true
        State2.isHidden = true
        State3.isHidden = true
        State4.isHidden = true
        State5.isHidden = true
        State6.isHidden = true
        Indicator1.startAnimation(self)
        Indicator2.startAnimation(self)
        Indicator3.startAnimation(self)
        Indicator4.startAnimation(self)
        Indicator5.startAnimation(self)
        Indicator6.startAnimation(self)
        
        if DiagnosisCPU() {
            Indicator1.stopAnimation(self)
            State1.isHidden = false
        } else {
            Indicator1.stopAnimation(self)
            State1.isHidden = false
            State1.image = NSImage.init(named: "NSStatusUnavailable")
        }
        if DiagnosisAppleIntel().0 {
            Indicator2.stopAnimation(self)
            State2.isHidden = false
            State2.image = NSImage.init(named: "NSStatusUnavailable")
        } else {
            Indicator2.stopAnimation(self)
            State2.isHidden = false
        }
        if DiagnosisAppleIntel().1 {
            Indicator3.stopAnimation(self)
            State3.isHidden = false
            State3.image = NSImage.init(named: "NSStatusUnavailable")
        } else {
            Indicator3.stopAnimation(self)
            State3.isHidden = false
        }
        if DiagnosisVoodooI2C() {
            Indicator4.stopAnimation(self)
            State4.isHidden = false
        } else {
            Indicator4.stopAnimation(self)
            State4.isHidden = false
            State4.image = NSImage.init(named: "NSStatusUnavailable")
        }
        if DiagnosisMT2() {
            Indicator5.stopAnimation(self)
            State5.isHidden = false
        } else {
            Indicator5.stopAnimation(self)
            State5.isHidden = false
            State5.image = NSImage.init(named: "NSStatusUnavailable")
        }
        var haveError:Bool = false, haveWarning:Bool = false
        var Errors = [String]()
        let queue = DispatchQueue.init(label: "queue")
        queue.async {
            (haveError, haveWarning, Errors) = DiagnosisLog()
            if haveError {
                DispatchQueue.main.async {
                    self.Indicator6.stopAnimation(self)
                    self.State6.isHidden = false
                    self.State6.image = NSImage.init(named: "NSStatusUnavailable")
                    for error in Errors {
                        self.ErrorLabel.string += error + "\n"
                    }
                }
            } else if haveWarning && !haveError {
                DispatchQueue.main.async {
                    self.DiagnosisScrollView.isHidden = false
                    self.Indicator6.stopAnimation(self)
                    self.State6.isHidden = false
                    for error in Errors {
                        self.ErrorLabel.string += error + "\n"
                    }
                    self.State6.image = NSImage.init(named: "NSStatusPartiallyAvailable")
                }
            } else {
                DispatchQueue.main.async {
                    self.Indicator6.stopAnimation(self)
                    self.State6.isHidden = false
                }
            }
        }
    }
    
    @IBAction func Feedback(_ sender: Any) {
        Pop_up(messageText: NSLocalizedString("Report your bug", comment: ""), informativeText: NSLocalizedString("Please open a new issue on Github", comment: ""))
        NSWorkspace.shared.open(URL(string: "https://github.com/Baio1977/GenI2C/issues")!)
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        let attention = NSAlert()
        attention.messageText = "Terms of Use"
        attention.informativeText = "THIS SOFTWARE IS *NOT* SUPPORTED BY THE VoodooI2C DEVELOPER TEAM\n\nDO NOT REQUEST ANY SUPPORT FROM GITHUB ISSUES IN VoodooI2C OR THE VoodooI2C GITTER CHAT ROOM WITH ANY INFORMATION GENERATED FROM THIS APPLICATION. INFORMATION INCLUDED BUT NOT LIMITED TO SCREENSHOTS, GENERATED PATCHES, SYSTEM LOGS.\n\nAutomated patches are not granted to always correct, please open an issue if you descovered a bug, pull requests will be highly appreciated.\n\nThis software is released under the MIT License."
        attention.addButton(withTitle: "Agree")
        attention.addButton(withTitle: "Disagree")
        attention.beginSheetModal(for: self.window, completionHandler: {response -> Void in
            print(response.rawValue)
            if response.rawValue == 1001 {
                exit(0)
            }
        })
        
        let infoDictionary = Bundle.main.infoDictionary!
        let minorVersion = infoDictionary["CFBundleShortVersionString"]!//版本号（内部标示） let appVersion = minorVersion as! String
        Version.stringValue = "Version \(minorVersion)"
        
        mainWindow.standardWindowButton(.zoomButton)?.isHidden = true
        mainWindow = NSApplication.shared.windows[0]
        
        let CPUModel = Process()
        let pipeCPU = Pipe()
        CPUModel.standardOutput = pipeCPU
        CPUModel.launchPath = "/usr/sbin/sysctl"
        CPUModel.arguments = ["machdep.cpu.brand_string"]
        CPUModel.launch()
        let CPUdata = pipeCPU.fileHandleForReading.readDataToEndOfFile()
        let CPUString = String(data: CPUdata, encoding: String.Encoding.utf8)!
        CPUInfo = String(CPUString[CPUString.index(CPUString.startIndex, offsetBy: 26)..<CPUString.endIndex])
        CPUModelLabel.stringValue += CPUInfo
        let kextstat = Process()
        let pipe1 = Pipe()
        kextstat.standardOutput = pipe1
        kextstat.launchPath = "/usr/sbin/kextstat"
        kextstat.arguments = ["-b", "com.alexandred.VoodooI2C"]
        kextstat.launch()
        let kextdata = pipe1.fileHandleForReading.readDataToEndOfFile()
        let kextStrings = String(data: kextdata, encoding: String.Encoding.utf8)!.components(separatedBy: "\n")
        if kextStrings.count <= 2 {
            Gen4ThisComputer.isEnabled = false
            IssueLabel.stringValue += "VoodooI2C is not loaded\n"
            isVooLoaded = false
            StateLabel.stringValue += NSLocalizedString("Not Loaded", comment: "")
            VersionLabel.stringValue += NSLocalizedString("nil", comment: "")
            DeviceNameLabel.stringValue += NSLocalizedString("nil", comment: "")
            IONameLabel.stringValue +=  NSLocalizedString("nil", comment: "")
            ModeLabel.stringValue += NSLocalizedString("nil", comment: "")
            PinLabel.stringValue +=  "Pin : " + NSLocalizedString("nil", comment: "")
            SatelliteLabel.stringValue += NSLocalizedString("nil", comment: "")
        } else {
            isVooLoaded = true
            StateLabel.stringValue += NSLocalizedString("Loaded", comment: "")
            let Satellites = ["com.alexandred.VoodooI2CHID", "me.kishorprins.VoodooI2CELAN", "com.alexandred.VoodooI2CSynaptics", "me.kishorprins.VoodooI2CFTE", "org.coolstar.VoodooI2CAtmelMXT", "com.blankmac.VoodooI2CUPDDEngine"]
            for i in Satellites {
                let Satellite = Process()
                let SatellitePipe = Pipe()
                Satellite.standardOutput = SatellitePipe
                Satellite.launchPath = "/usr/sbin/kextstat"
                Satellite.arguments = ["-b", i]
                Satellite.launch()
                let Satellitedata = SatellitePipe.fileHandleForReading.readDataToEndOfFile()
                let SatelliteStrings = String(data: Satellitedata, encoding: String.Encoding.utf8)!.components(separatedBy: "\n")
                if SatelliteStrings.count > 2 {
                    SatelliteLabel.stringValue += i.components(separatedBy: ".")[2] + " "
                }
            }
            let ioregPCI = Process()
            let pipePCI = Pipe()
            ioregPCI.standardOutput = pipePCI
            ioregPCI.launchPath = "/usr/sbin/ioreg"
            ioregPCI.arguments = ["-x", "-n", "PCI0", "-r", "-d", "3"]
            ioregPCI.launch()
            let PCIdata = pipePCI.fileHandleForReading.readDataToEndOfFile()
            let PCIStrings = String(data: PCIdata, encoding: String.Encoding.utf8)!.components(separatedBy: "\n")
            var I2CCount:Int = 0
            for line in 0..<PCIStrings.count {
                if PCIStrings[line].contains("I2C") {
                    I2CCount += 1
                }
            }
            var index:Int = 0
            var I2CName = [String](repeating: "", count: I2CCount)
            for line in 0..<PCIStrings.count {
                if PCIStrings[line].contains("I2C") {
                    I2CName[index] = String(PCIStrings[line][PCIStrings[line].index(PCIStrings[line].startIndex, offsetBy: 8)..<PCIStrings[line].index(PCIStrings[line].startIndex, offsetBy: 12)])
                    index += 1
                }
            }
            
            for i in 0..<I2CCount {
                let ioregI2C = Process()
                let pipeI2C = Pipe()
                ioregI2C.standardOutput = pipeI2C
                ioregI2C.launchPath = "/usr/sbin/ioreg"
                ioregI2C.arguments = ["-x", "-n", I2CName[i], "-r", "-d", "5"]
                ioregI2C.launch()
                let I2Cdata = pipeI2C.fileHandleForReading.readDataToEndOfFile()
                let I2CStrings = String(data: I2Cdata, encoding: String.Encoding.utf8)!
                if I2CStrings.contains("<class VoodooI2CDeviceNub") {
                    isNameFound = true
                    Gen4ThisComputer.isEnabled = true
                    NativeDeviceName = String(I2CStrings[I2CStrings.index(I2CStrings.startIndex, offsetBy: I2CStrings.positionOf(sub: "<class VoodooI2CDeviceNub")-6)..<I2CStrings.index(I2CStrings.startIndex, offsetBy: I2CStrings.positionOf(sub: "<class VoodooI2CDeviceNub")-2)])
                }
            }
            if isNameFound {
                DeviceNameLabel.stringValue += NativeDeviceName
            } else {
                Gen4ThisComputer.isEnabled = false
                IssueLabel.stringValue += "Native device name not found\n"
            }
            
            let VoodooI2CInfo = kextStrings[1][kextStrings[1].index(kextStrings[1].startIndex, offsetBy: 52)..<kextStrings[1].endIndex].components(separatedBy: " ")
            let VoodooI2CVersion = VoodooI2CInfo[1].replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: "")
            VersionLabel.stringValue += VoodooI2CVersion
            let ioreg = Process()
            let pipe = Pipe()
            ioreg.standardOutput = pipe
            ioreg.launchPath = "/usr/sbin/ioreg"
            ioreg.arguments = ["-x", "-n", NativeDeviceName, "-r"]
            ioreg.launch()
            let ioregdata = pipe.fileHandleForReading.readDataToEndOfFile()
            let ioregStrings = String(data: ioregdata, encoding: String.Encoding.utf8)!.components(separatedBy: "\n")
            var openline:Int = 0
            var closeline:Int = 0
            for line in 0..<ioregStrings.count {
                if ioregStrings[line].contains("<class VoodooI2CDeviceNub") {
                    openline = line + 2
                    for i in 1..<ioregStrings.count - line {
                        if ioregStrings[line + i].contains("}") && !ioregStrings[line + i].contains("=") {
                            closeline = line + i - 1
                            break
                        }
                    }
                    break
                }
            }
            var ioregVoodooI2C = [String](repeating: "", count: closeline - openline + 1)
            for line in openline...closeline {
                ioregVoodooI2C[line - openline] = ioregStrings[line]
            }
            for line in 0..<ioregVoodooI2C.count {
                if ioregVoodooI2C[line].contains("IOName") {
                    IONameLabel.stringValue += ioregVoodooI2C[line][ioregVoodooI2C[line].index(ioregVoodooI2C[line].startIndex, offsetBy: 18)..<ioregVoodooI2C[line].index(ioregVoodooI2C[line].startIndex, offsetBy: ioregVoodooI2C[line].count - 1)]
                }
                if ioregVoodooI2C[line].contains("IOInterruptControllers") {
                    
                }
                if ioregVoodooI2C[line].contains("IOInterruptSpecifiers") {
                    NativePin = String(ioregVoodooI2C[line][ioregVoodooI2C[line].index(ioregVoodooI2C[line].startIndex, offsetBy: 34)..<ioregVoodooI2C[line].index(ioregVoodooI2C[line].startIndex, offsetBy: 36)])
                    PinLabel.stringValue += "Pin : 0x" + NativePin
                }
                if ioregVoodooI2C[line].contains("IOInterruptControllers") {
                    if ioregVoodooI2C[line].contains("io-apic") {
                        PinLabel.stringValue = "APIC " + PinLabel.stringValue
                        if NativePin == "" || Int(strtoul(NativePin, nil, 16)) > 47 {
                            ModeLabel.stringValue += NSLocalizedString("Polling", comment: "")
                        } else {
                            ModeLabel.stringValue += NSLocalizedString("Interrupt(APIC)", comment: "")
                        }
                    } else {
                        ModeLabel.stringValue += NSLocalizedString("Interrupt(GPIO)", comment: "")
                        PinLabel.stringValue = "GPIO " + PinLabel.stringValue
                    }
                }
                if ioregVoodooI2C[line].contains("gpioPin") {
                    NativePin = String(ioregVoodooI2C[line][ioregVoodooI2C[line].index(ioregVoodooI2C[line].startIndex, offsetBy: 18)..<ioregVoodooI2C[line].endIndex])
                    PinLabel.stringValue = "GPIO Pin : " + NativePin
                    ModeLabel.stringValue += NSLocalizedString("Interrupt(GPIO)", comment: "")
                }
            }
        }
        /*
         let accessory = NSTextField(frame: NSRect(x: 0, y: 0, width: 50, height: 20))
         let font = NSFont.systemFont(ofSize: NSFont.systemFontSize)
         accessory.stringValue = "0x"
         accessory.isEditable = true
         accessory.drawsBackground = true
         */
        alert.accessoryView = InputAPICPin
        alert.messageText = NSLocalizedString("No native APIC found", comment: "")
        alert.informativeText = NSLocalizedString("Failed to extract APIC Pin. Please input your APIC Pin in Hex, and start with \"0x\"", comment: "")
        alert.helpAnchor = "NSAlert"
        alert.showsHelp = true
        //alert.showsSuppressionButton = true
        alert.alertStyle = .informational
        alert.addButton(withTitle: NSLocalizedString("OK", comment: "")).isEnabled = false
        //alert.window.contentView?.addSubview(AlertView)
    }
    
    func application(_ sender: NSApplication, openFile filename: String) -> Bool {
        DSDTFile = filename
        DSDTPath.stringValue = DSDTFile
        verbose(text: "\(DSDTFile)\n")
        MainTab.selectTabViewItem(GenSSDTTab)
        Next1.isEnabled = true
        return true
    }
    
    
    //Handle for the dock icon click
    func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        if flag {
            return false
        } else {
            window.makeKeyAndOrderFront(self)
            return true
        }
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    @IBAction func Github(_ sender: Any) {
        NSWorkspace.shared.open(URL(string: "https://github.com/Baio1977/GenI2C")!)
    }
    @IBAction func VoodooI2C(_ sender: Any) {
        NSWorkspace.shared.open(URL(string: "https://github.com/VoodooI2C/VoodooI2C")!)
    }
    @IBAction func OCLittleTraslated(_ sender: Any) {
        NSWorkspace.shared.open(URL(string: "https://github.com/5T33Z0/OC-Little-Translated")!)
    }
    @IBAction func OCAT(_ sender: Any) {
        NSWorkspace.shared.open(URL(string: "https://github.com/ic005k/OCAuxiliaryTools")!)
    }
}

extension String {
    //返回第一次出现的指定子字符串在此字符串中的索引
    //（如果backwards参数设置为true，则返回最后出现的位置）
    func positionOf(sub:String, backwards:Bool = false)->Int {
        var pos = -1
        if let range = range(of:sub, options: backwards ? .backwards : .literal ) {
            if !range.isEmpty {
                pos = self.distance(from:startIndex, to:range.lowerBound)
            }
        }
        return pos
    }
}
