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

struct Instructions: View {
	let label: String
	
	var body: some View {
		Text(label)
			.foregroundColor(.gray)
			.opacity(0.5)
			.padding()
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
			LabelValuePair(label: "Fecha de Expiración", value: expirationDate)
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
