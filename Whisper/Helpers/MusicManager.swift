//
//  MusicManager.swift
//  Whisper
//
//  Created by Thamindu Gamage on 2024-06-02.
//
import AVFoundation
import SwiftUI

class MusicManager: ObservableObject {
    private var player: AVAudioPlayer?
    private var musicFiles: [URL] = []
    @Published var isPlaying: Bool = false
    @Published var isMuted: Bool = false
    
    init() {
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
            }
        } catch {
            print("Error loading music files: \(error.localizedDescription)")
        }
    }
    
    func playRandomMusic() {
        guard !musicFiles.isEmpty else { return }
        
        let randomIndex = Int.random(in: 0..<musicFiles.count)
        let randomMusicURL = musicFiles[randomIndex]
        
        do {
            player = try AVAudioPlayer(contentsOf: randomMusicURL)
            player?.numberOfLoops = -1 // Loop indefinitely
            player?.play()
            isPlaying = true
        } catch {
            print("Error playing music: \(error.localizedDescription)")
        }
    }
    
    func stopMusic() {
        player?.stop()
        isPlaying = false
    }
    
    func toggleMute() {
        guard let player = player else { return }
        player.volume = isMuted ? 1.0 : 0.0
        isMuted.toggle()
    }
}
