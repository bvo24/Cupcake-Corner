//
//  CheckoutView.swift
//  Cupcake Corner
//
//  Created by Brian Vo on 5/10/24.
//

import SwiftUI

struct CheckoutView: View {
    var order : Order
    
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    @State private var checkoutError = false
    
    var body: some View {
        
        ScrollView{
            VStack{
                AsyncImage(url:URL(string:"https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                    }placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                Text("Your total is \(order.cost, format: .currency(code: "USD"))")
                    .font(.title)
                Button("Place order"){
                    Task{
                        await placeOrder()
                    }
                    
                }
                .padding()
                
                   
                    
                
            }
            
            
            
        }
        .navigationTitle("Checkout")
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert("Thank you", isPresented: $showingConfirmation){
            
        }message: {
            Text(confirmationMessage)
        }
        .alert("Unable to process order internet issue", isPresented: $checkoutError){
            
        }message:{
            Text("Check your connection")
        }
        
    }
    
    func placeOrder() async{
        
        guard let encoded = try? JSONEncoder().encode(order) else{
            print("Could not encode order")
            return
        }
        let url  = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url:url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//            request.httpMethod = "POST"
        
        do{
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            
            
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "Your order for \(decodedOrder.quantity) x \(Order.types[decodedOrder.type].lowercased()) cupcakes it on it's way"
            showingConfirmation = true
            
            
        }catch{
            print("Check out failed \(error.localizedDescription)")
            checkoutError = true
            
        }
        
        
        
    }
    
    
    
    
    
    
}

#Preview {
    CheckoutView(order: Order())
}
