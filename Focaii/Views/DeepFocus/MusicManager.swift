//
//  MusicManager.swift
//  Focaii
//
//  Created by Siluni on 2025-04-24.
//

// MusicManager.swift

import Foundation
import AVFoundation
import Combine

class MusicManager: ObservableObject {
    static let shared = MusicManager()
    
    @Published var isPlaying = false
    @Published var currentTrackIndex = 0
    @Published var currentTrackName: String = ""

    private var player: AVAudioPlayer?
    private let playlist: [String] = ["lofi", "deepchill", "slowfi"]

    private init() {
        loadTrack(at: currentTrackIndex)
    }

    private func loadTrack(at index: Int) {
        guard playlist.indices.contains(index) else { return }
        let trackName = playlist[index]
        currentTrackName = trackName

        guard let url = Bundle.main.url(forResource: trackName, withExtension: "mp3") else {
            print("Audio file not found: \(trackName).mp3")
            return
        }

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.numberOfLoops = -1
            player?.prepareToPlay()
        } catch {
            print("Failed to load audio: \(error)")
        }
    }

    func togglePlayback() {
        guard let player = player else { return }
        if isPlaying {
            player.pause()
        } else {
            player.play()
        }
        isPlaying.toggle()
    }

    func stop() {
        player?.stop()
        player?.currentTime = 0
        isPlaying = false
    }

    func nextTrack() {
        stop()
        currentTrackIndex = (currentTrackIndex + 1) % playlist.count
        loadTrack(at: currentTrackIndex)
        play()
    }

    func previousTrack() {
        stop()
        currentTrackIndex = (currentTrackIndex - 1 + playlist.count) % playlist.count
        loadTrack(at: currentTrackIndex)
        play()
    }

    private func play() {
        player?.play()
        isPlaying = true
    }
}
