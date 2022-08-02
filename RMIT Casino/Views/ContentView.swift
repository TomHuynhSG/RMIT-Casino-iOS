//
//  ContentView.swift
//  RMIT Casino
//
//  Created by Tom Huynh on 8/1/22.
//

import SwiftUI

struct ContentView: View {
    // MARK: - PROPERTIES
    let icons = ["apple","bar","bell","cherry","clover","diamond", "grape", "heart", "horseshoe","lemon","melon","money","orange"]
    
    @State private var highscore = 0
    @State private var coins = 100
    @State private var betAmount = 10
    @State private var reels = [0, 1, 2]
    @State private var showingInfoView = false
    
    // MARK: - FUNCTIONS
    
    // SPIN LOGIC
    func spinReels(){
        // reels[0] = Int.random(in: 0...symbols.count - 1)
        reels = reels.map({ _ in
            Int.random(in: 0...icons.count - 1)
        })
    }
    
    // CHECK WINNING LOGIC
    func checkWinning(){
        if reels[0]==reels[1] && reels[1]==reels[2] && reels[2]==reels[0]{
            // PLAYER WINS LOGIC
            playerWins()
            
            // NEW HIGHSCORE LOGIC
            if coins > highscore{
                newHighScore()
            }
            
        } else {
            // PLAYER LOSES
            playLoses()
        }
    }
    
    func playerWins() {
        coins += betAmount * 10
    }
    
    func newHighScore(){
        highscore = coins
    }
    
    func playLoses() {
        coins -= betAmount
    }
    
    
    // GAME IS OVER
    
    
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
                        Text("\(coins)")
                            .modifier(scoreNumberStyle())
                    }
                    .modifier(scoreCapsuleStyle()
                    
                    )
                    Spacer()
                    HStack{
                        Text("\(highscore)")
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
                        Image(icons[reels[0]])
                            .resizable()
                            .modifier(IconImageModifier())
                
                    }
                    HStack{
                        // MARK: - SECOND REEL
                        ZStack{
                            ReelView()
                            Image(icons[reels[1]])
                                .resizable()
                                .modifier(IconImageModifier())
                    
                        }
                        
                        Spacer()
                        
                        // MARK: - THIRD REEL
                        ZStack{
                            ReelView()
                            Image(icons[reels[2]])
                                .resizable()
                                .modifier(IconImageModifier())
                    
                        }
                    }
                    
                    // MARK: - SPIN BUTTON
                    Button {
                        // SPIN THE REELS
                        self.spinReels()
                        
                        // CHECK WINNING
                        self.checkWinning()
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


