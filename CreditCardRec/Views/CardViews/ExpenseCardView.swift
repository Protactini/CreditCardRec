//
//  ExpenseCardView.swift
//  CreditCardRec
//
//  Created by Hongzhi ZHU on 4/11/25.
//


import SwiftUI

struct ExpenseCardView: View {
    let cashBack: CashBack
    
    // Animate each row in when the view appears
    @State private var showView = false
    
    var body: some View {
        HStack(spacing: 14) {
            Image(cashBack.productIcon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 45, height: 45)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(cashBack.product)
                    .fontWeight(.bold)
                
                Text(cashBack.spendType)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack(spacing: 8) {
                Text(cashBack.amountSpent)
                    .fontWeight(.bold)
                
                Text(Date().formatted(date: .numeric, time: .omitted))
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
        .opacity(showView ? 1 : 0)
        .onAppear {
            // Stagger the appearance by row index
            let delay = Double(getIndex()) * 0.1
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation(.easeInOut(duration: 0.3).delay(delay)) {
                    showView = true
                }
            }
        }
    }
    
    private func getIndex() -> Int {
        // Assumes you have a global `cashBacks: [CashBack]` array
        cashBacks.firstIndex { $0.id == cashBack.id } ?? 0
    }
}

struct ExpenseCardView_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseCardView(cashBack: cashBacks[0])
    }
}
