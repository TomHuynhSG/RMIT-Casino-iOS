//
//  ContentView.swift
//  RMIT Casino
//
//  Created by Tom Huynh on 8/1/22.
//

import SwiftUI

// MARK: - PROPERTIES

struct ContentView: View {
    
    // MARK: - BODY
    var body: some View {
        ZStack {
            // MARK: - BACKGROUND
            LinearGradient(gradient: Gradient(colors: [Color("ColorRedRMIT"), Color("ColorBrightPurpleRMIT")]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            
            // MARK: - GAME UI
            VStack {
                // MARK: - LOGO HEADER
                LogoView()
                Spacer()
                
                // MARK: - SCORE
                HStack{
                    HStack{
                        Text("Your\nMoney".uppercased())
                            .modifier(scoreLabelStyle())
                            .multilineTextAlignment(.trailing)
                        Text("100")
                            .modifier(scoreNumberStyle())
                    }
                    .modifier(scoreCapsuleStyle()
                    
                    )
                    Spacer()
                    HStack{
                        Text("200")
                            .modifier(scoreNumberStyle())
                            .multilineTextAlignment(.leading)
                        Text("High\nScore".uppercased())
                            .modifier(scoreLabelStyle())
                        
                    }
                    .modifier(scoreCapsuleStyle()
                    )
                }
                
                // MARK: - SLOT MACHINE
                VStack{
                    // MARK: - FIRST REEL
                    ZStack{
                        ReelView()
                        Image("bell")
                            .resizable()
                            .modifier(IconImageModifier())
                
                    }
                    HStack{
                        // MARK: - SECOND REEL
                        ZStack{
                            ReelView()
                            Image("cherry")
                                .resizable()
                                .modifier(IconImageModifier())
                    
                        }
                        
                        Spacer()
                        
                        // MARK: - THIRD REEL
                        ZStack{
                            ReelView()
                            Image("melon")
                                .resizable()
                                .modifier(IconImageModifier())
                    
                        }
                    }
                    
                    // MARK: - SPIN BUTTON
                    Button {
                        print("Press The Spin button")
                    } label: {
                        Image("spin")
                            .resizable()
                            .modifier(ReelImageModifier())
                    }
                    
                }
                
                
                // MARK: - FOOTER
                
                Spacer()
                
                HStack{
                    
                    HStack{
                        Button {
                            print("Bet 20 coins")
                        } label: {
                            HStack(spacing: 30){
                                Text("20")
                                    .modifier(BetCapsuleModifier())
                               Image("casino-chips")
                                    .resizable()
                                    .opacity(0)
                                    .modifier(CasinoChipModifier())
                            }
                            .padding(.horizontal, 20)
                        }
                        
                        Spacer()
                        
                        Button {
                            print("Bet 20 coins")
                        } label: {
                            HStack(spacing: 30){
                                Image("casino-chips")
                                     .resizable()
                                     .opacity(1)
                                     .modifier(CasinoChipModifier())
                                Text("10")
                                    .modifier(BetCapsuleModifier())
                               
                            }
                            .padding(.horizontal, 20)
                        }
                    }
                    
                }

                
            }
            .overlay(
                // RESET
                Button(action: {
                  print("Reset")
                }) {
                  Image(systemName: "arrow.2.circlepath.circle")
                    .foregroundColor(.white)
                }
                .modifier(ButtonModifier()),
                alignment: .topLeading
              )
              .overlay(
                // INFO
                Button(action: {
                    print("How to play")
                }) {
                  Image(systemName: "info.circle")
                    .foregroundColor(.white)
                }
                .modifier(ButtonModifier()),
                alignment: .topTrailing
              )
            .padding()
            .frame(maxWidth: 720)
        }
    }
}

// MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


