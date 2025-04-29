//
//  SearchOverlayView.swift
//  CreditCardRec
//
//  Created by Hongzhi ZHU on 4/28/25.
//

import SwiftUI

struct FindCardSearchOverlayView: View {
    @Binding var expandSearch: Bool
    @Binding var selectedAreas: [CashBackArea]
    var animation: Namespace.ID

    var body: some View {
        VStack {
            Rectangle()
                .opacity(0)
                .frame(maxWidth: .infinity, maxHeight:40)
            
            // Grid of all areas
            let columns = [GridItem(.adaptive(minimum: 80), spacing: 16)]
            ScrollView {
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
                                        selectedAreas.insert(area, at: 0)
                                    }
                                }
                                .matchedGeometryEffect(id: area.rawValue, in: animation)
                                .debugBorder(DebugConfig.color(at: 3))
                        }
                    }
                }
            }
            Spacer()
                .opacity(1)
        }
    }
}

struct FindCardSearchOverlayView_Previews: PreviewProvider {
    @Namespace static var animation

    static var previews: some View {
        FindCardSearchOverlayView(
            expandSearch: .constant(true),
            selectedAreas: .constant([]),
            animation: animation
        )
    }
}
