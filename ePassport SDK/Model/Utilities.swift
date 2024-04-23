//
//  Utilities.swift
//  ePassport SDK
//
//  Created by Mateo Garcia on 9/04/24.
//

import SwiftUI
import NFCPassportReader

class Utilities {
	
	func getMRZKey(passportNumber: String, dateOfBirth: String, dateOfExpiry: String ) -> String {
		
		// Pad fields if necessary
		let pptNr = pad( passportNumber, fieldLength:9)
		let dob = pad( dateOfBirth, fieldLength:6)
		let exp = pad( dateOfExpiry, fieldLength:6)
		
		// Calculate checksums
		let passportNrChksum = calcCheckSum(pptNr)
		let dateOfBirthChksum = calcCheckSum(dob)
		let expiryDateChksum = calcCheckSum(exp)

		let mrzKey = "\(pptNr)\(passportNrChksum)\(dob)\(dateOfBirthChksum)\(exp)\(expiryDateChksum)"
		
		return mrzKey
	}
	
	func pad( _ value : String, fieldLength:Int ) -> String {
		// Pad out field lengths with < if they are too short
		let paddedValue = (value + String(repeating: "<", count: fieldLength)).prefix(fieldLength)
		return String(paddedValue)
	}
	
	func calcCheckSum( _ checkString : String ) -> Int {
		let characterDict  = ["0" : "0", "1" : "1", "2" : "2", "3" : "3", "4" : "4", "5" : "5", "6" : "6", "7" : "7", "8" : "8", "9" : "9", "<" : "0", " " : "0", "A" : "10", "B" : "11", "C" : "12", "D" : "13", "E" : "14", "F" : "15", "G" : "16", "H" : "17", "I" : "18", "J" : "19", "K" : "20", "L" : "21", "M" : "22", "N" : "23", "O" : "24", "P" : "25", "Q" : "26", "R" : "27", "S" : "28","T" : "29", "U" : "30", "V" : "31", "W" : "32", "X" : "33", "Y" : "34", "Z" : "35"]
		
		var sum = 0
		var m = 0
		let multipliers : [Int] = [7, 3, 1]
		for c in checkString {
			guard let lookup = characterDict["\(c)"],
				let number = Int(lookup) else { return 0 }
			let product = number * multipliers[m]
			sum += product
			m = (m+1) % 3
		}
		
		return (sum % 10)
	}
}

struct DisclosureHeader: View {
	let title: String
	
	@Binding var passport: NFCPassportModel
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
	let id = UUID()
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
