//
//  MusicManager.swift
//  Whisper
//
//  Created by Thamindu Gamage on 2024-06-02.
//

import AVFoundation
import SwiftUI

class MusicManager: NSObject, ObservableObject, AVAudioPlayerDelegate {
    private var player: AVAudioPlayer?
    private var musicFiles: [URL] = []
    private var currentIndex: Int = 0
    @Published var isPlaying: Bool = false
    @Published var isMuted: Bool = false
    @Published var currentTime: Double = 0
    @Published var duration: Double = 0
    @Published var currentFileName: String = "No Track"
    @Published var isRepeating: Bool = false
    @Published var isShuffling: Bool = false

    override init() {
        super.init()
        loadMusicFiles()
    }

    private func loadMusicFiles() {
        let fileManager = FileManager.default
        guard let resourceURL = Bundle.main.resourceURL else {
            print("Error: Could not find resource URL")
            return
        }

        do {
            let musicURLs = try fileManager.contentsOfDirectory(at: resourceURL, includingPropertiesForKeys: nil)
            musicFiles = musicURLs.filter { $0.pathExtension == "mp3" }
            if musicFiles.isEmpty {
                print("Error: No music files found in the directory")
            } else {
                currentFileName = musicFiles[currentIndex].lastPathComponent
            }
        } catch {
            print("Error loading music files: \(error.localizedDescription)")
        }
    }

    func playRandomMusic() {
        guard !musicFiles.isEmpty else { return }
        currentIndex = Int.random(in: 0..<musicFiles.count)
        playCurrentMusic()
    }

    func playCurrentMusic() {
        guard currentIndex < musicFiles.count else { return }
        let musicURL = musicFiles[currentIndex]

        do {
            player = try AVAudioPlayer(contentsOf: musicURL)
            player?.numberOfLoops = isRepeating ? -1 : 0
            player?.delegate = self
            player?.prepareToPlay()
            player?.play()
            isPlaying = true
            currentFileName = musicURL.lastPathComponent
            duration = player?.duration ?? 0
            
            // Update current time
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
                guard let player = self.player else {
                    timer.invalidate()
                    return
                }
                self.currentTime = player.currentTime
                if !player.isPlaying {
                    timer.invalidate()
                }
            }
        } catch {
            print("Error playing music: \(error.localizedDescription)")
        }
    }

    func stopMusic() {
        player?.stop()
        player?.currentTime = 0
        isPlaying = false
    }

    func toggleMute() {
        guard let player = player else { return }
        player.volume = isMuted ? 1.0 : 0.0
        isMuted.toggle()
    }

    func nextTrack() {
        currentIndex = (currentIndex + 1) % musicFiles.count
        playCurrentMusic()
    }

    func previousTrack() {
        currentIndex = (currentIndex - 1 + musicFiles.count) % musicFiles.count
        playCurrentMusic()
    }

    func toggleRepeat() {
        isRepeating.toggle()
        if isRepeating {
            player?.numberOfLoops = -1
        } else {
            player?.numberOfLoops = 0
        }
    }

    func toggleShuffle() {
        isShuffling.toggle()
    }

    func seek(to time: Double) {
        player?.currentTime = time
        currentTime = time
        if !isPlaying {
            player?.play()
            isPlaying = true
        }
    }

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if isRepeating {
            player.currentTime = 0
            player.play()
        } else {
            if isShuffling {
                playRandomMusic()
            } else {
                nextTrack()
            }
        }
    }
}
