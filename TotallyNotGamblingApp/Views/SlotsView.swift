//
//  ContentView.swift
//  TotallyNotGamblingApp
//
//  Created by jjurlits on 3/23/21.
//

import SwiftUI



struct SlotsView: View {
    @ObservedObject var viewModel = SlotsMachineViewModel(SlotsMachine())
    
    let transition = AnyTransition.scale.animation(.easeInOut(duration: 0.5))
        
    var body: some View {
        ZStack {
            Background()
                
            VStack {
                Spacer()
                
                HStack {
                    Text("Credits: \(viewModel.credits)")
                        .primaryLabel()
                    
                    if viewModel.shouldShowPayoutLabel {
                        Text(viewModel.payout).primaryLabel()
                    }
                }
                
                
                Spacer()
                
                HStack {
                    ForEach(viewModel.slots, id: \.id) {
                        Text($0.symbol)
                            .primaryLabel(font: .system(size: 60))
                            .transition(transition)
                    }
                }
                
                Spacer()
                
                HStack {
                    Button(
                        action: {
                            viewModel.resetButtonTapped()
                            
                        },
                        label: {
                            Text("Start Over").primaryLabel()
                    })
                    
                    Button(
                        action: {
                            withAnimation {
                                viewModel.spinButtonTapped()
                            }
                           
                        },
                        label: {
                            Text("Spin🤩")
                            .primaryLabel(backgroundColor: Color("button-accent-color"))
                    })
                }
                
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SlotsView()
    }
}

struct PrimaryLabel: ViewModifier {
    let textColor: Color
    let backgroundColor: Color
    let font: Font
    
    func body(content: Content) -> some View {
        content
            .font(font)
            .foregroundColor(textColor)
            .padding()
            .background(backgroundColor)
            .cornerRadius(16)
    }
    
    init(backgroundColor: Color? = nil, textColor: Color? = nil, font: Font? = nil) {
        self.textColor = textColor ?? Color.white
        self.backgroundColor = backgroundColor ?? Color("controls-background")
        self.font = font ?? Font.headline
    }
}

extension View {
    func primaryLabel(backgroundColor: Color? = nil, textColor: Color? = nil, font: Font? = nil) -> some View {
        modifier(PrimaryLabel(backgroundColor: backgroundColor, textColor: textColor, font: font))
    }
}
