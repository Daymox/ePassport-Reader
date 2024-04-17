//
//  PassportCardView.swift
//  ePassport SDK
//
//  Created by Mateo Garcia on 4/04/24.
//

import SwiftUI
import NFCPassportReader

struct PassportCardView: View {
	
	@EnvironmentObject var userSettings: UserSettings
	
	@Binding var passport: NFCPassportModel
	
	@State var isReaded = false
	@State var isPersonalInfoExpanded = false
	@State var isDocumentsExpanded = false
	@State var isChipInfoExpanded = false
	@State var isValidityInfoExpanded = false
	
	var body: some View {
		VStack {
			headerSection
			chipInformationSection
		}
	}
	
	private var headerSection: some View {
		HStack {
			VStack(alignment: .leading) {
				Header(label: "Nombre", value: passport.firstName)
				Header(label: "Genero ", value: passport.gender)
			}
			Spacer()
			Image(uiImage: passport.passportImage ?? UIImage(named: "user")!)
				.resizable()
				.renderingMode(.original)
				.aspectRatio(contentMode: .fit)
				.frame(width: 120, height: 120)
				.padding(.top)
		}
		.padding(.horizontal)
	}
	
	private var chipInformationSection: some View {
		List {
			Section(header: disclosureHeader(title: "Información Personal", isExpanded: $isPersonalInfoExpanded)) {
				if isPersonalInfoExpanded {
					PersonalInformation(passport: $passport)
				}
			}
			Section(header: disclosureHeader(title: "Documentos", isExpanded: $isDocumentsExpanded)) {
				if isDocumentsExpanded {
					DocumentInformation(passport: $passport)
				}
			}
			Section(header: disclosureHeader(title: "Chip", isExpanded: $isChipInfoExpanded)) {
				if isChipInfoExpanded {
					ChipInformation(passport: $passport)
				}
			}
			Section(header: disclosureHeader(title: "Validación Información", isExpanded: $isValidityInfoExpanded)) {
				if isValidityInfoExpanded {
					ChipInformation(passport: $passport)
				}
			}
		}
	}
	
	private func disclosureHeader(title: String, isExpanded: Binding<Bool>) -> some View {
		DisclosureHeader(title: title, isExpanded: isExpanded)
	}
}

struct PersonalInformation: View {
	
	@Binding var passport: NFCPassportModel
	
	var body: some View {
		PersonalInfoView(
			name: passport.firstName,
			lastName: passport.lastName,
			country: passport.nationality,
			birthDate: dateFormatter(passport.dateOfBirth),
			gender: passport.gender)
	}
}

struct DocumentInformation: View {
	
	@Binding var passport: NFCPassportModel
	
	var body: some View {
		PassportInfoView(
			title: "Pasaporte",
			documentNumber: passport.documentNumber,
			expirationDate: dateFormatter(passport.documentExpiryDate))
		
		DniInfoView(
			title: "DNI",
			documentNumber: passport.personalNumber ?? "")
	}
}

struct ChipInformation: View {
	
	@Binding var passport: NFCPassportModel
	
	var body: some View {
		ChipInfoView(
			ldsVersion: passport.LDSVersion,
			dataGroup: passport.dataGroupsPresent)
	}
}

//struct ValidityInformation: View {
//	
//	@Binding var passport: NFCPassportModel
//	
//	var body: some View {
//		ValidityInfoView(
//			accessControl: passport.cardAccess,
//			activeAuthentication: passport.activeAuthenticationPassed
//			chipAuthentication: passport.chipAuthentication,
//			dataGroupHashes: passport.dataGroupHashes,
//			documentSigner: passport.documentSigningCertificate,
//			countrySigner: passport.countrySigningCertificate)
//	}
//}

struct PassportCard: PreviewProvider {
	static var previews: some View {
		let passport: NFCPassportModel
		if let passportData = loadPassportDataFromJSON() {
			passport = NFCPassportModel(from: passportData)
		} else {
			passport = NFCPassportModel()
		}
		
		let userSettings = UserSettings()
		userSettings.passport = passport
		
		return NavigationView {
			PassportCardView(passport: .constant(passport))
				.environmentObject(userSettings)
		}
	}
	
	private static func loadPassportDataFromJSON() -> [String: String]? {
		guard let fileURL = Bundle.main.url(forResource: "passport", withExtension: "json"),
			  let data = try? Data(contentsOf: fileURL),
			  let json = try? JSONSerialization.jsonObject(with: data, options: []),
			  let passportData = json as? [String: String] else {
			return nil
		}
		return passportData
	}
}
