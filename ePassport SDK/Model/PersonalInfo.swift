//
//  PersonalInfo.swift
//  ePassport SDK
//
//  Created by Mateo Garcia on 23/04/24.
//

import SwiftUI

struct PersonalInfoView: View {
	let name: String
	let lastName: String
	let country: String
	let birthDate: String
	let gender: String
	let signatureImage: UIImage
	
	var body: some View {
		VStack(alignment: .leading, spacing: 0) {
			LabelValuePair(label: "Nombre(s)", value: name)
			LabelValuePair(label: "Apellidos", value: lastName)
			LabelValuePair(label: "País", value: country)
			LabelValuePair(label: "Fecha de Nac.", value: birthDate)
			LabelValuePair(label: "Genero", value: gender)
			Image(uiImage: signatureImage)
				.resizable()
				.renderingMode(.original)
				.aspectRatio(contentMode: .fit)
				.frame(width: 200, height: 200)
				.padding(.top)
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
