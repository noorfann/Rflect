//
//  LaunchView.swift
//  Rflect
//
//  Created by Zulfikar Noorfan on 18/05/25.
//

import SwiftUI

struct LaunchView: View {

    @State private var words: [String] = "Rflect your day.".split(separator: " ").map(String.init)
    @State private var showLoadingText: Bool = false
    @State private var visibleWords: Int = 0
    private let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()

    @State private var loops: Int = 0
    @Binding var showLaunchView: Bool

    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()

            Image("logo-transparent")
                .resizable()
                .frame(width: 150, height: 150)

            ZStack {
                if showLoadingText {
                    HStack(spacing: 8) {
                        ForEach(0..<words.count, id: \.self) { index in
                            Text(words[index])
                                .font(.headline)
                                .fontWeight(.heavy)
                                .foregroundStyle(Color.primary)
                                .opacity(index < visibleWords ? 1.0 : 0.0)
                                .animation(.smooth(duration: 0.5), value: visibleWords)
                        }
                    }
                    .transition(AnyTransition.scale.animation(.easeIn))
                }
            }
            .offset(y: 100)
        }
        .onAppear {
            showLoadingText.toggle()
        }
        .onReceive(
            timer,
            perform: { _ in
                withAnimation(.easeInOut(duration: 0.5)) {
                    if visibleWords <= words.count {
                        visibleWords += 1
                    } else {
                        loops += 1

                        if loops >= 1 {
                            showLaunchView = false
                        } else {
                            // Reset to start animation again
                            visibleWords = 0
                        }
                    }
                }
            })
    }
}

#Preview {
    LaunchView(showLaunchView: .constant(true))
}
