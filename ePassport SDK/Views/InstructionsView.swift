//
//  InstructionsView.swift
//  ePassport SDK
//
//  Created by Mateo Garcia on 15/04/24.
//

import SwiftUI

struct InstructionsView: View {
	var body: some View {
		VStack(alignment: .leading) {
			Instructions(label: "Instrucciones de Uso")
				.font(.title)
			
			Instructions(label: "1. Escanea el código MRZ del pasaporte que se encuentra en la parte inferior del mismo.")
			
			Instructions(label: "2. Acerca el dispositivo al pasaporte y espera a que se capture la información del chip NFC.")
		}
		.padding()
	}
}


#Preview {
    InstructionsView()
}
