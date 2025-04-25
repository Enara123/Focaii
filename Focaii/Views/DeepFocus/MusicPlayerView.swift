//
//  MusicPlayerView.swift
//  Focaii
//
//  Created by Siluni on 2025-04-23.
//

// MusicPlayerView.swift

import SwiftUI

struct MusicPlayerView: View {
    @StateObject private var musicManager = MusicManager.shared

    var body: some View {
        VStack {
            HStack(spacing: 16) {
                Image(systemName: "music.note")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(Color.accent)
                VStack(alignment: .leading) {
                    Text("Playing: \(musicManager.currentTrackName.capitalized)")
                        .font(.subheadline)
                }
                HStack {
                    Button(action: {
                        musicManager.previousTrack()
                    }) {
                        Image(systemName: "backward.fill")
                            .padding()
                    }

                    Button(action: {
                        musicManager.togglePlayback()
                    }) {
                        Image(systemName: musicManager.isPlaying ? "pause.fill" : "play.fill")
                            .padding(10)
                            .foregroundColor(Color.primary)
                    }
                    
                    Button(action: {
                        musicManager.nextTrack()
                    }) {
                        Image(systemName: "forward.fill")
                            .padding()
                    }
                }
            }
            .padding(.horizontal)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.gray.opacity(0.2))
                .background(Color.BG_3)
                .cornerRadius(16)
                .shadow(color: .black.opacity(0.2), radius: 2, x: 2, y: 2)
        )
        .padding(.horizontal)
        .frame(maxWidth: .infinity)
    }
}
