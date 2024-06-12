//
//  MusicManagerTests.swift
//  WhisperTests
//
//  Created by Thamindu Gamage on 2024-06-11.
//

import XCTest
@testable import Whisper
import AVFoundation

class MusicManagerTests: XCTestCase {
    var musicManager: MusicManager!
    
    override func setUp() {
        super.setUp()
        musicManager = MusicManager()
    }
    
    override func tearDown() {
        musicManager = nil
        super.tearDown()
    }
    
    func testPlayPauseMusic() {
        // Prepare a mock music file URL (assuming you have a valid music file in the test bundle)
        let bundle = Bundle(for: type(of: self))
        guard let musicURL = bundle.url(forResource: "music_1", withExtension: "mp3") else {
            XCTFail("Failed to locate test music file.")
            return
        }
        
        // Load the music files into the MusicManager
        musicManager.musicFiles = [musicURL]
        musicManager.currentIndex = 0
        
        // Test play music
        musicManager.playCurrentMusic()
        XCTAssertTrue(musicManager.isPlaying, "Music should be playing.")
        
        // Test pause music
        musicManager.playPauseMusic()
        XCTAssertFalse(musicManager.isPlaying, "Music should be paused.")
        
        // Test resume music
        musicManager.playPauseMusic()
        XCTAssertTrue(musicManager.isPlaying, "Music should be playing again.")
    }
    
    func testStopMusic() {
        // Prepare a mock music file URL (assuming you have a valid music file in the test bundle)
        let bundle = Bundle(for: type(of: self))
        guard let musicURL = bundle.url(forResource: "music_1", withExtension: "mp3") else {
            XCTFail("Failed to locate test music file.")
            return
        }
        
        // Load the music files into the MusicManager
        musicManager.musicFiles = [musicURL]
        musicManager.currentIndex = 0
        
        // Test play music
        musicManager.playCurrentMusic()
        XCTAssertTrue(musicManager.isPlaying, "Music should be playing.")
        
        // Test stop music
        musicManager.stopMusic()
        XCTAssertFalse(musicManager.isPlaying, "Music should be stopped.")
        XCTAssertEqual(musicManager.currentTime, 0, "Current time should be reset to 0.")
    }
    
    func testToggleMute() {
        // Prepare a mock music file URL (assuming you have a valid music file in the test bundle)
        let bundle = Bundle(for: type(of: self))
        guard let musicURL = bundle.url(forResource: "music_1", withExtension: "mp3") else {
            XCTFail("Failed to locate test music file.")
            return
        }
        
        // Load the music files into the MusicManager
        musicManager.musicFiles = [musicURL]
        musicManager.currentIndex = 0
        
        // Test play music
        musicManager.playCurrentMusic()
        XCTAssertTrue(musicManager.isPlaying, "Music should be playing.")
        
        // Test toggle mute
        musicManager.toggleMute()
        XCTAssertTrue(musicManager.isMuted, "Music should be muted.")
        
        // Test toggle unmute
        musicManager.toggleMute()
        XCTAssertFalse(musicManager.isMuted, "Music should be unmuted.")
    }
    
    func testNextPreviousTrack() {
        // Prepare mock music file URLs (assuming you have valid music files in the test bundle)
        let bundle = Bundle(for: type(of: self))
        guard let musicURL1 = bundle.url(forResource: "music_1", withExtension: "mp3"),
              let musicURL2 = bundle.url(forResource: "music_1", withExtension: "mp3") else {
            XCTFail("Failed to locate test music files.")
            return
        }
        
        // Load the music files into the MusicManager
        musicManager.musicFiles = [musicURL1, musicURL2]
        musicManager.currentIndex = 0
        
        // Test play current music
        musicManager.playCurrentMusic()
        XCTAssertTrue(musicManager.isPlaying, "Music should be playing.")
        
        // Test next track
        musicManager.nextTrack()
        XCTAssertEqual(musicManager.currentIndex, 1, "Current index should be 1.")
        
        // Test previous track
        musicManager.previousTrack()
        XCTAssertEqual(musicManager.currentIndex, 0, "Current index should be 0.")
    }
}

