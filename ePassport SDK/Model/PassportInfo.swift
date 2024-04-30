//
//  PassportViews.swift
//  ePassport SDK
//
//  Created by Mateo Garcia on 23/04/24.
//

import SwiftUI
import NFCPassportReader

struct PassportInfoView: View {
	let title: String
	let documentNumber: String
	let expirationDate: String
	
	var body: some View {
		VStack(alignment: .leading, spacing: 8) {
			Text(title)
				.fontWeight(.bold)
				.padding(.bottom)
			LabelValuePair(label: "Número de Pasaporte", value: documentNumber)
			LabelValuePair(label: "Fecha de Exp.", value: expirationDate)
				.foregroundColor(.secondary)
		}
		.padding(.vertical)
	}
}

struct ChipInfoView: View {
	let ldsVersion: String
	let dataGroup: [String]
	
	var body: some View {
		VStack(alignment: .leading, spacing: 8) {
			LabelValuePair(label: "LDS Version", value: ldsVersion)
			LabelValuePair(label: "Data Group", value: transformedDataGroup)
		}
	}
	
	private var transformedDataGroup: String {
		return dataGroup.map {
			String($0.dropFirst(2))
		}.joined(separator: ", ")
	}
}

struct ValidityInfoView: View {
	@Binding var passport: NFCPassportModel
	
	var body: some View {
		let accessControl: String = {
			if passport.PACEStatus == .success {
				return "PACE"
			} else if passport.BACStatus == .success {
				return "BAC"
			} else if passport.PACEStatus == .success && passport.BACStatus == .success {
				return "SAC"
			}else {
				return "Unknown"
			}
		}()
		
		var activeAuthentication: String
		if passport.isChipAuthenticationSupported {
			switch passport.chipAuthenticationStatus {
			case .success:
				activeAuthentication = "SUCCESS"
			case .failed:
				activeAuthentication = "FAILED"
			case .notDone:
				activeAuthentication = "NOT SUPPORTED"
			}
		} else {
			activeAuthentication = "NOT SUPPORTED"
		}
		
		let chipAuthentication: String = {
			if passport.chipAuthenticationStatus == .success {
				return "SUCCESS"
			} else if passport.chipAuthenticationStatus == .failed {
				return "FAILED"
			} else {
				return "NOT DONE"
			}
		}()
		
		return VStack {
			LabelValuePair(label: "Access Control", value: accessControl)
			LabelValuePair(label: "Active Authentication", value: activeAuthentication)
			LabelValuePair(label: "Chip Authentication", value: chipAuthentication)
			LabelValuePair(label: "Data Group Hashes", value: passport.passportDataNotTampered ? "SUCCESS" : "FAILED")
			LabelValuePair(label: "Document Signing", value: passport.passportCorrectlySigned ? "SUCCESS" : "FAILED")
		}
	}
}

struct HashesInfoView: View {
	@Binding var passport: NFCPassportModel
	
	var body: some View {
		
		VStack(alignment: .leading, spacing: 8) {
			ForEach(getDataGroupHashes(passport), id: \.label) { dataGroup in
				Text(dataGroup.label)
					.fontWeight(.bold)
				Text(dataGroup.value)
					.padding(.bottom, 20)
			}
			.padding(.vertical)
		}
	}
}
