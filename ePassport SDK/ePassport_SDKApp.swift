//
//  ePassport_SDKApp.swift
//  ePassport SDK
//
//  Created by Mateo Garcia on 3/04/24.
//

import SwiftUI

@main
struct ePassport_SDKApp: App {
	let settings = UserSettings()
	
	var body: some Scene {
		WindowGroup {
			MainView()
				.environmentObject(settings)
		}
	}
}

