//
//  UserSettings.swift
//  ePassport SDK
//
//  Created by Mateo Garcia on 9/04/24.
//

import SwiftUI
import Combine
import NFCPassportReader

final class UserSettings: ObservableObject {

	private enum Keys {
		static let documentNumber = "documentNumber"
		static let birthDate = "birthDate"
		static let expiryDate = "expiryDate"
		static let newVerification = "newVerification"
		
		static let allVals = [documentNumber, birthDate, expiryDate, newVerification]
	}
	
	private let cancellable: Cancellable
	private let defaults: UserDefaults
	
	let objectWillChange = PassthroughSubject<Void, Never>()
	
	init(defaults: UserDefaults = .standard) {
		self.defaults = defaults
		
		defaults.register(defaults: [
			Keys.documentNumber: "",
			Keys.birthDate: Date().timeIntervalSince1970,
			Keys.expiryDate: Date().timeIntervalSince1970,
		])
		
		cancellable = NotificationCenter.default
			.publisher(for: UserDefaults.didChangeNotification)
			.map { _ in () }
			.subscribe(objectWillChange)
	}
	
	var documentNumber: String {
		set { defaults.set(newValue, forKey: Keys.documentNumber) }
		get { defaults.string(forKey: Keys.documentNumber) ?? "" }
	}
	
	var birthDate: Date {
		set {
			defaults.set(newValue.timeIntervalSince1970, forKey: Keys.birthDate)
		}
		get {
			let d = Date(timeIntervalSince1970: defaults.double(forKey: Keys.birthDate))
			return d
		}
	}
	
	var expiryDate: Date {
		set {
			defaults.set(newValue.timeIntervalSince1970, forKey: Keys.expiryDate) }
		get {
			let d = Date(timeIntervalSince1970: defaults.double(forKey: Keys.expiryDate))
			return d
		}
	}
	
	var newVerification: Bool {
		set {
			defaults.set(newValue, forKey: Keys.newVerification)
		}
		get {
			defaults.bool(forKey: Keys.newVerification)
		}
	}
	
	@Published var passport : NFCPassportModel?
}
