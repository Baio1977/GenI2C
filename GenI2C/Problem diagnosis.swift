//
//  Problem diagnosis.swift
//  GenI2C
//
//  Created by 梁怀宇 on 2019/6/28.
//  Copyright © 2019 梁怀宇. All rights reserved.
//

import Foundation

func DiagnosisCPU() -> Bool {
    let CPU = Process()
    let pipeCPU = Pipe()
    CPU.standardOutput = pipeCPU
    CPU.launchPath = "/usr/sbin/sysctl"
    CPU.arguments = ["machdep.cpu.brand_string"]
    //CPU.waitUntilExit()
    CPU.launch()
    let CPUdata = pipeCPU.fileHandleForReading.readDataToEndOfFile()
    let CPUString = String(data: CPUdata, encoding: String.Encoding.utf8)!
    let CPUInfo = String(CPUString[CPUString.index(CPUString.startIndex, offsetBy: 26)..<CPUString.endIndex])
    //let CPUModel = CPUInfo.components(separatedBy: " ")[2].components(separatedBy: "-")[1]
    let CPUModel = CPUInfo.components(separatedBy: " ")[2]
    if (CPUModel.contains("-")){
        let CPUModel = CPUModel.components(separatedBy: "-")[1]
    }
    if CPUInfo.components(separatedBy: " ")[1].contains("Core") {
        if (String(CPUModel).count > 5){
            return true;
        } else {
            if Int(String(CPUModel[CPUModel.index(CPUModel.startIndex, offsetBy: 0)]))! < 4 {
                return false
            } else {
                return true
            }
        }
    } else {
        return false
    }
}

func DiagnosisAppleIntel() -> (Bool, Bool) {
    print("DiagnosisAppleIntel()")
    var AppleIntelLpssI2CLoad:Bool, AppleIntelLpssI2CControllerLoad:Bool
    let AppleIntelLpssI2C = Process()
    let AppleIntelLpssI2CPipe = Pipe()
    AppleIntelLpssI2C.standardOutput = AppleIntelLpssI2CPipe
    AppleIntelLpssI2C.launchPath = "/usr/sbin/kextstat"
    AppleIntelLpssI2C.arguments = ["-b", "com.apple.driver.AppleIntelLpssI2C"]
    //AppleIntelLpssI2C.waitUntilExit()
    AppleIntelLpssI2C.launch()
    let AppleIntelLpssI2CData = AppleIntelLpssI2CPipe.fileHandleForReading.readDataToEndOfFile()
    let AppleIntelLpssI2CStrings = String(data: AppleIntelLpssI2CData, encoding: String.Encoding.utf8)!.components(separatedBy: "\n")
    if AppleIntelLpssI2CStrings.count <= 2 {
        AppleIntelLpssI2CLoad = false
    } else {
        AppleIntelLpssI2CLoad = true
    }
    let AppleIntelLpssI2CController = Process()
    let AppleIntelLpssI2CControllerPipe = Pipe()
    AppleIntelLpssI2CController.standardOutput = AppleIntelLpssI2CControllerPipe
    AppleIntelLpssI2CController.launchPath = "/usr/sbin/kextstat"
    AppleIntelLpssI2CController.arguments = ["-b", "com.apple.driver.AppleIntelLpssI2C"]
    //AppleIntelLpssI2CController.waitUntilExit()
    AppleIntelLpssI2CController.launch()
    let AppleIntelLpssI2CControllerData = AppleIntelLpssI2CControllerPipe.fileHandleForReading.readDataToEndOfFile()
    let AppleIntelLpssI2CControllerStrings = String(data: AppleIntelLpssI2CControllerData, encoding: String.Encoding.utf8)!.components(separatedBy: "\n")
    if AppleIntelLpssI2CControllerStrings.count <= 2 {
        AppleIntelLpssI2CControllerLoad = false
    } else {
        AppleIntelLpssI2CControllerLoad = true
    }
    return (AppleIntelLpssI2CLoad, AppleIntelLpssI2CControllerLoad)
}

func DiagnosisVoodooI2C() -> Bool {
    let VoodooI2C = Process()
    let VoodooI2CPipe = Pipe()
    VoodooI2C.standardOutput = VoodooI2CPipe
    VoodooI2C.launchPath = "/usr/sbin/kextstat"
    VoodooI2C.arguments = ["-b", "com.alexandred.VoodooI2C"]
    VoodooI2C.launch()
    let VoodooI2CData = VoodooI2CPipe.fileHandleForReading.readDataToEndOfFile()
    let VoodooI2CStrings = String(data: VoodooI2CData, encoding: String.Encoding.utf8)!.components(separatedBy: "\n")
    if VoodooI2CStrings.count <= 2 {
        return false
    } else {
        return true
    }
}

func DiagnosisMT2() -> Bool {
    let MT2 = Process()
    let MT2Pipe = Pipe()
    MT2.standardOutput = MT2Pipe
    MT2.launchPath = "/usr/sbin/ioreg"
    MT2.arguments = ["-x", "grep", "MT2"]
    MT2.launch()
    let MT2Data = MT2Pipe.fileHandleForReading.readDataToEndOfFile()
    let MT2String = String(data: MT2Data, encoding: String.Encoding.utf8)!.components(separatedBy: "\n")
    if MT2String.count >= 2 {
        return true
    } else {
        return false
    }
}

func DiagnosisLog() -> (Bool, Bool, [String]) {
    print("DiagnosisLog()")
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
    b.arguments = ["show", "--predicate", "(eventMessage CONTAINS[c] \"VoodooI2C\") || (eventMessage CONTAINS[c] \"VoodooGPIO\")", "--start", "\(curDate)"]
    b.launch()
    //b.waitUntilExit()
    var data:Data
    data = pipe1.fileHandleForReading.readDataToEndOfFile()
    let Log = String(data: data, encoding: String.Encoding.utf8)!.components(separatedBy: "\n")
    var i:Int = 0
    var HaveError:Bool = false, HaveWarning:Bool = false
    for line in Log {
        if line.contains("Could not find GPIO controller") {
            HaveError = true
            print(line)
            i += 1
        }
        if line.contains("Pin cannot be used as IRQ") {
            HaveError = true
            print(line)
            i += 1
        }
        if line.contains("Could not get interrupt event source") {
            if line.contains("using polling instead") {
                HaveWarning = true
            }else{
                HaveError = true
            }
            print(line)
            i += 1
        }
        if line.contains("Unknown Synopsys component type: 0xffffffff") {
            HaveError = true
            print(line)
            i += 1
        }
        if line.contains("Found F12 but this protocol is not yet implemented") {
            HaveError = true
            print(line)
            i += 1
        }
        if line.contains("cannot be used as IRQ") {
            HaveError = true
            print(line)
            i += 1
        }
        if line.contains("slave address not acknowledged (7bit mode)") {
            HaveError = true
            print(line)
            i += 1
        }
        if line.contains("Could not get controller") {
            HaveError = true
            print(line)
            i += 1
        }
        if line.contains("Warning: Error getting bus config, using defaults where necessary") {
            HaveWarning = true
            print(line)
            i += 1
        }
    }
    var errors = [String](repeating: "", count: i)
    i = 0
    for line in Log {
        if line.contains("Could not find GPIO controller") {
            errors[i] = "The GPIO controller enable patch has not been applied."
            i += 1
        }
        if line.contains("Pin cannot be used as IRQ") {
            errors[i] = "The GPIO pin for your device in the DSDT is likely wrong."
            i += 1
        }
        if line.contains("Could not get interrupt event source") {
            if line.contains("using polling instead") {
                errors[i] = "Device works in polling mode"
            }else{
                errors[i] = "Could not find either APIC or GPIO interrupts in your device's DSDT entry."
            }
            i += 1
        }
        if line.contains("Unknown Synopsys component type: 0xffffffff") {
            errors[i] = "The I2C controller patch has not been applied."
            i += 1
        }
        if line.contains("Found F12 but this protocol is not yet implemented") {
            errors[i] = "The Synaptics device implements F12 which is not yet supported by VoodooI2CSynaptics."
            i += 1
        }
        if line.contains("cannot be used as IRQ") {
            errors[i] = "GPIO Pin Out of range"
            i += 1
        }
        if line.contains("slave address not acknowledged (7bit mode)") {
            errors[i] = "Slave Address Error"
            i += 1
        }
        if line.contains("Could not get controller") {
            errors[i] = "Could not get controller"
            i += 1
        }
        if line.contains("Warning: Error getting bus config, using defaults where necessary") {
            errors[i] = "Missing SSCN or FMCN bus speed config"
            i += 1
        }
    }
    return (HaveError, HaveWarning, errors)
}
