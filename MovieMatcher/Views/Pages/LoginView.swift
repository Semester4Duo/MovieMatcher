//
//  LoginView.swift
//  MovieMatcher
//
//  Created by Dylan Nas on 24/09/2021.
//

import SwiftUI

struct LoginView: View {
    @Environment(\.managedObjectContext)
    var moc
    @State private var email: String = ""
    @State private var password: String = ""
    @Binding var isLoggedIn:Bool
    
    var body: some View {
        GeometryReader{ geometry in
            ZStack{
                BackgroundView()
                VStack{
                    Spacer()
                    Group{
                        Text("Log in").titleText()
                        TextField("", text: $email)
                            .placeholder(when: email.isEmpty){
                                Text("Email")
                                    .foregroundColor(.white)
                                    .zIndex(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                                    .padding(.leading)
                                    .opacity(0.6)
                                    
                            }
                            .textFieldStyle(OvalTextFieldStyle())
                            .padding(.vertical)
                            .padding(.horizontal, 25)
                            .foregroundColor(.white)
                            
                        
                        SecureField("password", text: $password)
                            .placeholder(when: email.isEmpty){
                                Text("Password")
                                    .foregroundColor(.white)
                                    .zIndex(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                                    .padding(.leading)
                                    .opacity(0.6)
                                    
                            }
                            .textFieldStyle(OvalTextFieldStyle())
                            .padding(.horizontal, 25)
                            .padding(.bottom)
                        
                        Button("Sign in"){
                            Login(mail:email)
                        }
                        .frame(width: geometry.size.width - 50, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .buttonStyle()
                        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                        
                        Button("Forgot password"){
                            
                        }
                    }
                    
                    Spacer()
                    Spacer()
                    Spacer()
                    Group{
                        Text("Or connect with")
                            .foregroundColor(.white)
                            .padding(.bottom, 10)
                        HStack{
                            Button("Apple"){
                                
                            }
                            .frame(width: geometry.size.width/2-30, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .buttonStyle()
                            Button("Other options"){
                                
                            }
                            .frame(width: geometry.size.width/2-30, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .buttonStyle()
                        }
                        .opacity(0.8)
                        HStack{
                            Text("Dont have a account?")
                                .foregroundColor(.white)
                            Button("sign up"){
                                
                            }
                        }
                    }
                    Spacer()
                }
            }
        }
    }
    
    func Login(mail:String){
        guard let url = URL(string: "https://moviematcher.kurza.nl/user?email=\(mail)") else{
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                print(String(decoding: data, as: UTF8.self))
                if let decodedResponse = try? JSONDecoder().decode(UserDTO.self, from: data) {
                    print()
                    // we have good data – go back to the main thread
                    DispatchQueue.main.async {
                        // update our UI
                        var user: UserDTO  = decodedResponse
                        
                        let currentUser = User(context: moc)
                        currentUser.id = user.id
                        currentUser.email = user.email
                        
                        try? moc.save()
                        
                        isLoggedIn = true;
                        print(user)
                    }
                    // everything is good, so we can exit
                    return
                }
            }
            // if we're still here it means there was a problem
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }
        .resume()
    }
}
//
//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView(isLoggedIn: Binding<Bool>)
//    }
//}
