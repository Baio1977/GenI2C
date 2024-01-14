[![](https://img.shields.io/badge/EFI-Release-informational?style=flat&logo=apple&logoColor=white&color=9debeb)](https://github.com/Baio1977/EFI-Varie-Hackintosh)
[![](https://img.shields.io/badge/Telegram-HackintoshLifeIT-informational?style=flat&logo=telegram&logoColor=white&color=5fb659)](https://t.me/HackintoshLife_it)

## Action Build

👉 [![Actions](https://github.com/Baio1977/GenI2C/actions/workflows/WORKFLOW-FILE/badge.svg)](https://github.com/Baio1977/GenI2C/actions)

## Download

👉 [![Release](https://img.shields.io/github/release/Baio1977/GenI2C.svg)](https://github.com/Baio1977/GenI2C/releases)

# GenI2C_Refresh

Generate SSDT hotpatches for your Touchable Device and get ready for VoodooI2C! 😜

## Terms of Use

THIS SOFTWARE IS *NOT* SUPPORTED BY THE VoodooI2C DEVELOPER TEAM

DO NOT REQUEST ANY SUPPORT FROM GITHUB ISSUES IN VoodooI2C OR THE VoodooI2C GITTER CHAT ROOM WITH ANY INFORMATION GENERATED FROM THIS APPLICATION. INFORMATION INCLUDED BUT NOT LIMITED TO SCREENSHOTS, GENERATED PATCHES, SYSTEM LOGS.

Automated patches are not granted to always correct, please open an issue if you descovered a bug, pull requests will be highly appreciated.

This software is released under the [MIT License](/LICENSE)

## Features

- VoodooI2C Information
  - Loaded Status
  - Attatched Submodules
  - Log Extracting
  - Working Mode (APIC, GPIO, Polling)
  - APIC/GPIO Pin showing

- SSDT Generation
  - Using **External** references to maintain APIC/GPIO Pin Bios injection
  - Generate I2C Bus Speed Patch
  - Generate GPIO Pin when manually pinning is required
  - Polling mode patch supported (VoodooI2CHID only)

- Tools
  - ACPI Disassembler

- VoodooI2C Diagnosis
  - Ckeck CPU Generation Support
  - AppleIntelLpssI2C.kext/AppleIntelLpssI2CController.kext blocking detection
  - Check VoodooI2C Status
  - Check Magic Trackpad 2 Simulator Engine Status
  - Analyze VoodooI2C Logs

## GenI2C Credits

- Bat.bat [(@williambj1)](https://github.com/williambj1) for the idea and the **Visual Basic .Net** part of the project
- DogAndPot [(@DogAndPot)](https://github.com/DogAndPot) for the **Swift** part of the project
- **宪武** for sample SSDTs and theoretical support
- [Alexandred](https://github.com/alexandred) for VoodooI2C [(Full Credits)](https://voodooi2c.github.io/#Credits%20and%20Acknowledgments/Credits%20and%20Acknowledgments)
- Startpenghubingzhou [(@penghubingzhou)](https://github.com/penghubingzhou) for providing theoretical support and his fancy DSDT
- Steve Zheng [(@stevezhengshiqi)](https://github.com/stevezhengshiqi) for testing and bug reporting
- http://patorjk.com for the amazing ASCII Art font `Impossible`

## GenI2C_Refresh Credits

- Baio1977 [(@Baio1977)](https://github.com/Baio1977) for resuming development and compatibility with Opencore Bootloader
- Lorys89 [(@Lorys89)](https://github.com/Lorys89) for development, support and immense developer qualities
- Massimiliano [(@mbarbierato)](https://github.com/mbarbierato) for development, support and various code fixes
