import SwiftUI

struct TransactionView: View {
    let currentCard: Card
    @Binding var expandCards: Bool
    var animation: Namespace.ID
    @State private var showExpenseView = false

    var body: some View {
        VStack {
            // Use the shared CardView here
            CardView(
                expandCards: $expandCards,
                card: currentCard
            ) {
                // onTap to dismiss
                withAnimation(.easeInOut) {
                    showExpenseView = true
                    expandCards.toggle()
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    withAnimation(.easeInOut(duration: 0.35)) {
                        expandCards = false
                    }
                }
            }
            .matchedGeometryEffect(id: currentCard.id, in: animation)
            .frame(height: 200)
            .zIndex(10)

            // Expense list…
            GeometryReader { proxy in
                let offscreenY = proxy.size.height + 50
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 20) {
                        ForEach(cashBacks) { cashBack in
                            ExpenseCardView(cashBack: cashBack)
                        }
                    }
                    .padding()
                }
                .background(
                    Color.white
                        .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                        .ignoresSafeArea()
                )
                .offset(y: showExpenseView ? 0 : offscreenY)
            }
            .padding([.horizontal, .top])
            .zIndex(-10)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color("ColorBG").ignoresSafeArea())
        .onAppear {
            withAnimation(.easeInOut.delay(0.1)) {
                showExpenseView = true
            }
        }
    }
}

struct TransactionView_Previews: PreviewProvider {
    // Create a namespace for the matchedGeometryEffect
    @Namespace static var animation

    static var previews: some View {
        // Pick a sample card from your global `cards` array
        let sampleCard = cards.first!

        TransactionView(
            currentCard: sampleCard,
            expandCards:.constant(true),
            animation: animation
        )
        // TransactionView doesn’t need a Core Data context
    }
}
