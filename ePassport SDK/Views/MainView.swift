//
//  MainView.swift
//  ePassport SDK
//
//  Created by Mateo Garcia on 3/04/24.
//

import SwiftUI
import NFCPassportReader
import MRZParser

struct MainView: View {
	@EnvironmentObject var userSettings: UserSettings
	
	@State private var showScanner: Bool = false
	@State private var showPersonalData: Bool = false
	@State private var enableNfcButton: Bool = false
	
	private let passportReader = PassportReader()
	
	var body: some View {
		NavigationView {
			ZStack {
				NavigationLink(destination: PassportCardView(passport: .constant(userSettings.passport ?? NFCPassportModel()), isReaded: $showPersonalData.wrappedValue), isActive: $showPersonalData) {
					EmptyView()
				}
				List {
					Section {
						Button(action: {
							showScanner = true
						}) {
							Label("Escanear MRZ", systemImage: "camera.viewfinder")
						}
						.sheet(isPresented: $showScanner) {
							MRZScanner(completionHandler: handleMRZScan)
						}
						
						Button(action: {
							readPassportFromNFC()
						}) {
							Label("Leer NFC", systemImage: "sensor")
						}
						.disabled(!enableNfcButton)
					}
				}
				InstructionsView()
			}
			.navigationBarTitle("Lector ePassport", displayMode: .automatic)
		}
		
	}
}


// MARK: - View Functions
extension MainView {
	
	func handleMRZScan(mrz: String) {
		if let (documentNumber, birthDate, expiryDate) = parseMRZ(mrz: mrz) {
			userSettings.documentNumber = documentNumber
			userSettings.birthDate = birthDate
			userSettings.expiryDate = expiryDate
			enableNfcButton = true
		}
		showScanner = false
	}
}

// MARK: - User Interaction Functions
extension MainView {
	
	func parseMRZ(mrz: String) -> (String, Date, Date)? {
		let parser = MRZParser(isOCRCorrectionEnabled: true)
		if let result = parser.parse(mrzString: mrz),
		   let documentNumber = result.documentNumber,
		   let birthDate = result.birthdate,
		   let expiryDate = result.expiryDate {
			print(mrz)
			return (documentNumber, birthDate, expiryDate)
		}
		return nil
	}
	
	func readPassportFromNFC() {
		let dateFormatter = DateFormatter()
		dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
		dateFormatter.dateFormat = "YYMMdd"
		
		let documentNumber = userSettings.documentNumber
		let birthDate = dateFormatter.string(from: userSettings.birthDate)
		let expiryDate = dateFormatter.string(from: userSettings.expiryDate)
		
		let utilities = Utilities()
		let mrzKey = utilities.getMRZKey(passportNumber: documentNumber, dateOfBirth: birthDate, dateOfExpiry: expiryDate)
		
		if let masterList = Bundle.main.url(forResource: "masterList", withExtension: ".pem") {
			passportReader.setMasterListURL(masterList)
		} else {
			print("MasterList.pem no se encontró")
		}

		passportReader.passiveAuthenticationUsesOpenSSL = !userSettings.newVerification
		
		Task {
			do {
				let passport = try await passportReader.readPassport(mrzKey: mrzKey)
				
				self.userSettings.passport = passport
				self.showPersonalData = true
			} catch {
				print("Error al leer el pasaporte NFC: \(error)")
			}
		}
	}
}

struct Main_Previews: PreviewProvider {
	static var previews: some View {
		let userSettings = UserSettings()
		
		return Group {
			MainView()
				.environmentObject(userSettings)
		}
	}
}
