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
    
    @State private var highscore = UserDefaults.standard.integer(forKey: "highscore")
    @State private var coins = 100
    @State private var betAmount = 10
    @State private var reels = [0, 1, 2]
    
    @State private var isChooseBet10 = true
    @State private var isChooseBet20 = false
    
    @State private var showingInfoView = false
    @State private var showGameOverModal = false
    
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
        UserDefaults.standard.set(highscore, forKey: "highscore")
    }
    
    func playLoses() {
        coins -= betAmount
    }
    
    func chooseBet20() {
        betAmount = 20
        isChooseBet20 = true
        isChooseBet10 = false
    }
    
    func chooseBet10() {
        betAmount = 10
        isChooseBet10 = true
        isChooseBet20 = false
    }
    
    
    // GAME IS OVER
    func isGameOver() {
        if coins <= 0 {
            // SHOW MODAL MESSAGE OF GAME OVER
            showGameOverModal = true
        }
    }
    
    func resetGame(){
        UserDefaults.standard.set(0, forKey: "highscore")
        highscore = 0
        coins = 100
        chooseBet10()
    }
    
    
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
                        
                        // GAME OVER
                        self.isGameOver()
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
                            self.chooseBet20()
                        } label: {
                            HStack(spacing: 30){
                                Text("20")
                                    .foregroundColor(isChooseBet20 ? Color("ColorBlueRMIT") : Color.white)
                                    .modifier(BetCapsuleModifier())
                               Image("casino-chips")
                                    .resizable()
                                    .opacity(isChooseBet20 ? 1 : 0 )
                                    .modifier(CasinoChipModifier())
                            }
                            .padding(.horizontal, 20)
                        }
                        
                        Spacer()
                        
                        Button {
                            self.chooseBet10()
                        } label: {
                            HStack(spacing: 30){
                                Image("casino-chips")
                                     .resizable()
                                     .opacity(isChooseBet10 ? 1 : 0 )
                                     .modifier(CasinoChipModifier())
                                Text("10")
                                    .foregroundColor(isChooseBet10 ? Color("ColorBlueRMIT") : Color.white)
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
                    self.resetGame()
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
            .blur(radius:  showGameOverModal ? 5 : 0 , opaque: false)
            
            
            // MARK: - GAMEOVER MODAL
            if showGameOverModal{
                ZStack{
                    Color("ColorBlackTransparent")
                        .edgesIgnoringSafeArea(.all)
                    VStack{
                        Text("GAME OVER")
                            .font(.system(.title, design: .rounded))
                            .fontWeight(.heavy)
                            .foregroundColor(Color.white)
                            .padding()
                            .frame(minWidth: 280, idealWidth: 280, maxWidth: 320)
                            .background(Color("ColorRedRMIT"))
                        
                        Spacer()
                        
                        VStack {
                            Image("rmit-casino-logo")
                                .resizable()
                                .scaledToFit()
                                .frame(maxHeight: 150)
                            Text("You lost all money!\nYou are not the god of gambler!\n Good luck next time!")
                                .font(.system(.body, design: .rounded))
                                .foregroundColor(Color.white)
                                .multilineTextAlignment(.center)
                            Button {
                                self.showGameOverModal = false
                                self.coins = 100
                            } label: {
                                Text("New Game".uppercased())
                            }
                            .padding(.vertical,10)
                            .padding(.horizontal, 20)
                            .background(
                                Capsule()
                                    .strokeBorder(lineWidth: 2)
                                    .foregroundColor(Color("ColorRedRMIT"))
                            )

                        }
                        Spacer()
                    }
                    .frame(minWidth: 280, idealWidth: 280, maxWidth: 320, minHeight: 280, idealHeight: 300, maxHeight: 350, alignment: .center)
                    .background(Color("ColorBlueRMIT"))
                    .cornerRadius(20)
                }
            }
            
        }
    }
}

// MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


