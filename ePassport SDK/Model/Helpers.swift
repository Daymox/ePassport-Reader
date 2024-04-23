//
//  Helpers.swift
//  ePassport SDK
//
//  Created by Mateo Garcia on 23/04/24.
//

import SwiftUI
import NFCPassportReader

func getDataGroupHashes(_ passport: NFCPassportModel) -> [LabelValuePair] {
	var dataGroupHashes = [LabelValuePair]()
	
	for id in DataGroupId.allCases {
		if let hash = passport.dataGroupHashes[id] {
			let label = "\(hash.id)"
			let value = """
				SOD: \(hash.sodHash)

				Computed: \(hash.computedHash)
				"""
			dataGroupHashes.append(LabelValuePair(label: label, value: value))
		}
	}
	
	return dataGroupHashes
}


func dateFormatter(_ date: String) -> String {
	let year = String(date.prefix(2))
	let month = String(date.dropFirst(2).prefix(2))
	let day = String(date.dropFirst(4))
	let result = "\(day) - \(month) - \(year)"
	
	return result
}


