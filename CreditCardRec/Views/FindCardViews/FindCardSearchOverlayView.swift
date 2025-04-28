//
//  SearchOverlayView.swift
//  CreditCardRec
//
//  Created by Hongzhi ZHU on 4/28/25.
//

import SwiftUI

struct FindCardSearchOverlayView: View {
    @Binding var selectedAreas: [CashBackArea]
    var animation: Namespace.ID

    var body: some View {
        VStack {
            
            // Grid of all areas
            let columns = [GridItem(.adaptive(minimum: 80), spacing: 16)]
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(CashBackArea.allCases) { area in
                    if !selectedAreas.contains(area) {
                        Text(area.rawValue)
                            .font(.caption2)
                            .multilineTextAlignment(.center)
                            .padding(10)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color(.systemGray5))
                            )
                            .foregroundColor(.primary)
                            .onTapGesture {
                                withAnimation(.spring()) {
                                    selectedAreas.append(area)
                                }
                            }
                            .matchedGeometryEffect(id: area.rawValue, in: animation)
                            .debugBorder(DebugConfig.color(at: 3))
                    }
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 40)

            Spacer()
        }
        .background(Color(.systemBackground).ignoresSafeArea())
        .transition(.opacity.combined(with: .move(edge: .top)))
    }
}

struct FindCardSearchOverlayView_Previews: PreviewProvider {
    @Namespace static var animation

    static var previews: some View {
        FindCardSearchOverlayView(
            selectedAreas: .constant([]),
            animation: animation
        )
    }
}
