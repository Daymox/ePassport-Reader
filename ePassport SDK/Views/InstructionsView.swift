//
//  InstructionsView.swift
//  ePassport SDK
//
//  Created by Mateo Garcia on 15/04/24.
//

import SwiftUI

struct InstructionsView: View {
	
	@State private var isZoomed = false
	
	var body: some View {
		VStack(alignment: .leading) {
			Instructions(label: "Instrucciones de Uso")
				.font(.title)
				.scaleEffect(isZoomed ? 1.1 : 1)
			
			Instructions(label: "1. Escanea el código MRZ del pasaporte que se encuentra en la parte inferior del mismo.")
				.scaleEffect(isZoomed ? 1.1 : 1)
			
			Instructions(label: "2. Acerca el dispositivo al pasaporte y espera a que se capture la información del chip NFC.")
				.scaleEffect(isZoomed ? 1.1 : 1)
		}
		.padding()
		.onAppear {
			withAnimation(Animation.easeInOut(duration: 1).repeatForever().repeatForever(autoreverses: false)) {
				self.isZoomed.toggle()
			}
			
		}
	}
}


#Preview {
	InstructionsView()
}
