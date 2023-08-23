//
//  OfferView.swift
//  HiScore
//
//  Created by RATPC-043 on 21/08/23.
//

import SwiftUI

struct OfferView: View {
    // 1. Static data
       let itemPerRow: CGFloat = 2
       let horizontalSpacing: CGFloat = 16
       let height: CGFloat = 300
    var body: some View {
        ZStack {
            VStack {
               Text("Earn More Rewards")
                   .font(Font.custom("Maven Pro", size: 28)
                           .weight(.semibold))
                   .multilineTextAlignment(.center)
                   .foregroundColor(.white)
               Text("Deposit & choose the rewards you want")
                   .font(Font.custom("Maven Pro", size: 14)
                           .weight(.regular))
                   .multilineTextAlignment(.center)
                   .foregroundColor(.white)
                GeometryReader { geometry in
                    ScrollView {
                        // 4. Iterate cards and fillup in the VStack
                        VStack(alignment: .leading, spacing: 8) {
                            ForEach(0..<5) { i in
                                CardView(imageName: "Rectangle", buttonText: "₹1 - ₹99") {
                                }
                            }
                        }
                    }
                }
           }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(UIColor.HSAppThemeColor))
    }
}

struct OfferView_Previews: PreviewProvider {
    static var previews: some View {
        OfferView()
    }
}
