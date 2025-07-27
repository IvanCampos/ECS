//
//  AVPlayerViewModel.swift
//  ECS
//
//  Created by IVAN CAMPOS on 7/26/25.
//

import AVKit

@MainActor
@Observable
class AVPlayerViewModel: NSObject {
    var isPlaying: Bool = false
    private var avPlayerViewController: AVPlayerViewController?
    private var avPlayer = AVPlayer()
    private let videoURL: URL? = {
        // Return URL for the video to play. For example:
        // Bundle.main.url(forResource: "MyVideo", withExtension: "mp4")
        return nil
    }()

    func makePlayerViewController() -> AVPlayerViewController {
        let avPlayerViewController = AVPlayerViewController()
        avPlayerViewController.player = avPlayer
        avPlayerViewController.delegate = self
        self.avPlayerViewController = avPlayerViewController
        return avPlayerViewController
    }

    func play() {
        guard !isPlaying, let videoURL else { return }
        isPlaying = true

        let item = AVPlayerItem(url: videoURL)
        avPlayer.replaceCurrentItem(with: item)
        avPlayer.play()
    }

    func reset() {
        guard isPlaying else { return }
        isPlaying = false
        avPlayer.replaceCurrentItem(with: nil)
        avPlayerViewController?.delegate = nil
    }
}

extension AVPlayerViewModel: AVPlayerViewControllerDelegate {
    nonisolated func playerViewController(_ playerViewController: AVPlayerViewController, willEndFullScreenPresentationWithAnimationCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        Task { @MainActor in
            reset()
        }
    }
}
