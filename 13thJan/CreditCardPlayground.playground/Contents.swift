import SwiftUI
import PlaygroundSupport

struct CreditCardView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            HStack {
                Text("Flipkart Axis Bank Credit Card")
                    .font(.system(size: 20, weight: .semibold, design: .monospaced))
                Spacer()
                Image("american_ex")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 40)
                    .clipped()
                    .cornerRadius(4)
            }
            
            VStack(spacing: 6) {
                HStack {
                    Spacer()
                    Text("7438")
                    Spacer()
                    Text("3425")
                    Spacer()
                    Text("7894")
                    Spacer()
                    Text("5465")
                    Spacer()
                }
                .font(.system(size: 25, weight: .semibold, design: .rounded))
                
                Spacer(minLength: 30)
                HStack {
                    Text("VALID\nTHRU")
                        .font(.system(size: 8, weight: .light))
                    Text("08/25")
                        .font(.system(size: 22, weight: .bold))
                }
            }
            
            HStack {
                Text("RANJITH KUMAR")
                    .font(.system(size: 22, weight: .bold))
                Spacer()
                Image("mastercard")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 40)
                    .clipped()
                    .cornerRadius(4)
            }
        }
        .foregroundColor(.white)
        .padding()
        .background(
            LinearGradient(colors: [Color(red: 176/255, green: 143/255, blue: 38/255, opacity: 1), Color.black], startPoint: .top, endPoint: .bottom)
        )
        .overlay(RoundedRectangle(cornerRadius: 6)
                    .stroke(Color.black.opacity(0.5), lineWidth: 1)
        )
        .cornerRadius(6)
        .shadow(radius: 5)
        .padding(.horizontal)
        .padding(.top, 8)
    }
}

PlaygroundPage.current.setLiveView(CreditCardView())
