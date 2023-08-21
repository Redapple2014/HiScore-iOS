//
//  CardView.swift
//  HiScore
//
//  Created by RATPC-043 on 21/08/23.
//

import SwiftUI
import Lottie

struct CardView: View {
    var imageName: String
    var buttonText: String
    var buttonAction: () -> Void
    
    var body: some View {
        ZStack {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 164, height: 212)
                .overlay {
                    VStack {
                        Spacer()
                        Button(action: buttonAction) {
                            VStack(spacing: 0) {
                                Text("ADD")
                                    .font(Font.custom("Maven Pro", size: 10)
                                            .weight(.heavy))
                                    .foregroundColor(Color(UIColor.HSBlackTextColor))
                                Text(buttonText)
                                    .font(Font.custom("Rajdhani", size: 18)
                                            .weight(.bold))
                                    .foregroundColor(Color(UIColor.HSBlackTextColor))
                            }
                            .multilineTextAlignment(.center)
                            .frame(width: 140, height: 42)
                            .padding(4)
                            .background(Color.clear)
                        }
                        .background(
                            LinearGradient(
                                stops: [
                                    Gradient.Stop(color: .white, location: 0.00),
                                    Gradient.Stop(color: .white.opacity(0.5), location: 1.00),
                                ],
                                startPoint: UnitPoint(x: 0.5, y: 0),
                                endPoint: UnitPoint(x: 0.5, y: 1)
                            )
                        )
                        .cornerRadius(8)
                        .padding(.bottom, 12)
                    }
                }
        }
        .padding(0)
        .cornerRadius(10)
        .background(Color.clear)
    }
}
struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(imageName: "Rectangle", buttonText: "₹1 - ₹99") {
        }
    }
}
