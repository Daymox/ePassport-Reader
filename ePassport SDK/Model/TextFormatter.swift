//
//  TextFormatter.swift
//  ePassport SDK
//
//  Created by Mateo Garcia on 9/04/24.
//

import SwiftUI

struct DisclosureHeader: View {
	let title: String
	@Binding var isExpanded: Bool
	
	var body: some View {
		HStack {
			Text(title)
				.font(.headline)
			Spacer()
			Button(action: {
				withAnimation {
					self.isExpanded.toggle()
				}
			}) {
				Image(systemName: isExpanded ? "chevron.down" : "chevron.right")
					.imageScale(.medium)
					.foregroundColor(.blue)
			}
		}
		.contentShape(Rectangle())
	}
}

struct LabelValuePair: View {
	let label: String
	let value: String
	
	var body: some View {
		HStack {
			Text(label)
				.fontWeight(.bold)
			Spacer()
			Text(value)
		}
		.padding(.vertical)
	}
}

struct Header: View {
	let label: String
	let value: String
	
	var body: some View {
		VStack(alignment: .leading, spacing: 8) {
			Text(label)
				.fontWeight(.bold)
			Text(value)
		}
		.padding(.vertical)
	}
}

struct Instructions: View {
	let label: String
	
	var body: some View {
		Text(label)
			.foregroundColor(.gray)
			.opacity(0.5)
			.padding()
	}
}

struct PersonalInfoView: View {
	let name: String
	let lastName: String
	let country: String
	let birthDate: String
	let gender: String
	
	var body: some View {
		VStack(alignment: .leading, spacing: 0) {
			LabelValuePair(label: "Nombre(s)", value: name)
			LabelValuePair(label: "Apellidos", value: lastName)
			LabelValuePair(label: "País", value: country)
			LabelValuePair(label: "Fecha de Nac.", value: birthDate)
			LabelValuePair(label: "Genero", value: gender)
		}
		.padding(.vertical)
	}
}

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

struct DniInfoView: View {
	let title: String
	let documentNumber: String
	
	var body: some View {
		VStack(alignment: .leading, spacing: 8) {
			Text(title)
				.fontWeight(.bold)
				.padding(.bottom)
			LabelValuePair(label: "Documento", value: documentNumber)
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
		}.joined(separator: " - ")
	}
}

//struct ValidityInfoView: View {
////	let accessControl: String
////	let activeAuthentication: String
////	let chipAuthentication: String
////	let dataGroupHashes: [String]
////	let documentSigner: String
////	let countrySigner: String
//	
////	var body: some View {
//////		LabelValuePair(label: "Control de Acceso", value: accessControl)
//////		LabelValuePair(label: "Autenticación Activa", value: activeAuthentication)
//////		LabelValuePair(label: "Autenticación del Chip", value: chipAuthentication)
//////		LabelValuePair(label: "Data Group Hashes", value: dataGroupHashes)
//////		LabelValuePair(label: "Firma del Documento", value: documentSigner)
//////		LabelValuePair(label: "Firma del País", value: countrySigner)
////	}
//}

func dateFormatter(_ date: String) -> String {
	let year = String(date.prefix(2))
	let month = String(date.dropFirst(2).prefix(2))
	let day = String(date.dropFirst(4))
	let result = "\(day) - \(month) - \(Int(year)! + 2000) "
	
	return result
}

