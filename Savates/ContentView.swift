//
//  ContentView.swift
//  Savates
//
//  Created by Raphaël Payet on 04/07/2020.
//  Copyright © 2020 Oriapy. All rights reserved.
//

import SwiftUI

let customBlue = Color(red: 0.537, green: 0.733, blue: 0.871, opacity: 1.000)
let customOrange = Color(red: 0.961, green: 0.722, blue: 0.545, opacity: 1.000)
let customBlack = Color(red: 0.231, green: 0.314, blue: 0.373, opacity: 1.000)

let screen = UIScreen.main.bounds

struct ContentView: View {
    
    @State var shoeColor : String   = "purple"
    @State var showCard  : Bool     = false
    @State var viewState : CGSize   = .zero
    
    var body: some View {
        ZStack {
            VStack {
                Image("\(shoeColor)-shoes")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: screen.size.width , height: screen.size.height * 2/3)
                    .edgesIgnoringSafeArea(.top)
                
                HStack {
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Text("Summer Kit")
                            .font(.headline)
                            Spacer()
                            Text("Price : $9.99")
                                .font(.headline)
                                .offset(y : 10)
                        }
                        Text("Beach shoes")
                            .font(.body)
                            .foregroundColor(.gray)
                        
                        //Color Buttons
                        HStack {
                            Button(action : {
                                self.shoeColor = "blue"
                            }) {
                                RoundColor(color: .blue, isSelected: false)
                            }
                            Button(action : {
                                self.shoeColor = "purple"
                            }) {
                                RoundColor(color: .purple, isSelected: false)
                            }
                            
                            Button(action : {
                                self.shoeColor = "orange"
                            }) {
                                RoundColor(color: customOrange, isSelected: false)
                            }
                            Button(action : {
                                self.shoeColor = "yellow"
                            }) {
                                RoundColor(color: .yellow, isSelected: false)
                            }
                            Button(action : {
                                self.shoeColor = "white"
                            }) {
                                RoundColor(color: .white, isSelected: false)
                            }
                        }
                        
                        HStack {
                            MessageBubbleContent()
                            SeeMoreButtonContent()
                            Button(action : {
                                self.showCard.toggle()
                            }) {
                                AddToCartButtonContent()
                            }
                        }
                        
                    }
                    Spacer()
                }.padding(.horizontal, 50)
                
                Spacer()
            }
            NavBarItems()
            
            ZStack {
                Color(.black)
                    .opacity(showCard ? 0.5 : 0)
                    .edgesIgnoringSafeArea(.all)
                CartView(shoeColor: $shoeColor, showCard: $showCard)
                    .offset(y : self.viewState.height)
                .offset(y : showCard ? 0 : screen.size.height)
                
                    .gesture(
                        DragGesture()
                            .onChanged({ (value) in
                                self.viewState.height = value.translation.height
                            })
                        
                            .onEnded({ (value) in
                                self.viewState = .zero
                                
                                if value.translation.height > 100 {
                                    self.showCard = false
                                }
                            })
                )
            }.animation(.easeOut)
            
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct NavBarItems: View {
    var body: some View {
        VStack {
            HStack {
                Button(action : { }) {
                    Image(systemName: "arrow.left")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(.white)
                }
                
                Spacer()
                
                Button(action: { }) {
                    Image("basket")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.white)
                }
            }.padding()
            Spacer()
        }
    }
}



struct RoundColor: View {
    var color : Color
    var isSelected : Bool
    
    var body: some View {
        ZStack {
            if isSelected {
                Circle()
                .stroke()
                .frame(width: 50, height: 50)
                .foregroundColor(color)
            }
            
            if color == .white {
                Circle()
                    .stroke()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.black)
            } else {
                Circle()
                .frame(width: 40, height: 40)
                .foregroundColor(color)
            }
        }
    }
}


struct MessageBubbleContent: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .foregroundColor(customOrange)
            Image(systemName: "bubble.right.fill")
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(.white)
            
        }.frame(width: 60, height: 60)
    }
}

struct SeeMoreButtonContent: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .stroke(lineWidth: 2)
                .foregroundColor(customBlue)
            Text("See more")
                .foregroundColor(customBlue)
        }.frame(width: 120, height: 60)
    }
}

struct AddToCartButtonContent: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .foregroundColor(customBlue)
            Text("+ Add to cart")
                .foregroundColor(.white)
        }.frame(width: 120, height: 60)
    }
}

struct CartView: View {
    
    @Binding var shoeColor : String
    @Binding var showCard  : Bool
    
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                RoundedRectangle(cornerRadius: 30, style: .continuous)
                    .foregroundColor(.white)
                
                VStack {
                    HStack {
                        Spacer()
                        Text("Bag")
                            .font(.custom("Helvetica", size: 25))
                            .fontWeight(.bold)
                        Spacer()
                        Button(action : {
                            self.showCard.toggle()
                        }) {
                            Image(systemName: "xmark")
                            .font(.title)
                            .foregroundColor(customBlack)
                        }
                    }.padding()
                    HStack {
                        Image("\(shoeColor)-shoes")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                        
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Summer shoes")
                                .font(.headline)
                            Text("Beach Kit")
                                .foregroundColor(.gray)
                        }
                        
                        Text("Price 9.99$")
                    }
                    Text("Checkout")
                        .foregroundColor(.white)
                        .frame(width : screen.size.width - 80 ,height : 60)
                        .background(customBlue)
                        .cornerRadius(10)
                    
                }
            }.frame(width: screen.size.width - 30, height: screen.size.height * 1/3)
        }
    }
}
