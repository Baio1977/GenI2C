//
//  GenReadme.swift
//  GenI2C
//
//  Created by 梁怀宇 on 2019/7/1.
//  Copyright © 2019 梁怀宇. All rights reserved.
//

import Foundation

func GenReadme (Rename: String) {
    print("GenReadme()")
    var Readme:String = ""
    Readme += NSLocalizedString("1. Opencore Bootloader : Put VoodooI2C and the Satellite into EFI/OC/Kext , generate rename(s) with (https://github.com/corpnewt/ACPIRename) and insert in config.plist\n", comment: "")
    Readme += NSLocalizedString("2. Clover Bootloader : Put VoodooI2C and the Satellite into Clover/Kexts/Other , place SSDT aml files into Clover/ACPI/patched add insert rename(s) in config.plist\n", comment: "")
    Readme += Rename
    Readme += NSLocalizedString("3.\n\n If you have problems here: https://github.com/Baio1977/GenI2C\n\n", comment: "")
    
    let path:String = FolderPath + "/Readme.txt"
    try! FileManager.default.createDirectory(atPath: FolderPath, withIntermediateDirectories: true, attributes: nil)
    if FileManager.default.fileExists(atPath: path) {
        try! FileManager.default.removeItem(atPath: path)
        FileManager.default.createFile(atPath: path, contents: nil, attributes: nil)
    } else {
        FileManager.default.createFile(atPath: path, contents: nil, attributes: nil)
    }
    try! Readme.write(toFile: path, atomically: true, encoding: String.Encoding.utf8)
}
