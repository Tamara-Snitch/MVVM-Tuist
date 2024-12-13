//
//  LoaderLineView.swift
//  UIComponents
//
//  Created by Prokoptsov on 02.10.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import Common
import Lottie
import SwiftUI

public struct LoaderLineView: View {
	
	// MARK: - Private properties
	
	@State private var playbackMode: LottiePlaybackMode = .paused(at: .frame(54.0))
	//	@State private var currentAnimationProgress: CGFloat = .zero
	@Binding private var isLoading: Bool
	@Environment(\.animationName) private var animationName: String
	@State private var currentAnimationFrametime: AnimationFrameTime = 54.0
	
	// MARK: - Init
	
	public init(isLoading: Binding<Bool>) {
		self._isLoading = isLoading
	}
	
	// MARK: - Body
	
	final class AAAA {}
	
	public var body: some View {
		LottieView(animation: .named(animationName))
			.playbackMode(playbackMode)
			.getRealtimeAnimationFrame($currentAnimationFrametime)
			.onChange(of: isLoading) { isLoading in
				print("@@ current \(currentAnimationFrametime)")
				if isLoading {
					print("@@ is loading now")
				} else {
					print("@@ is not loading now")
				}
			}
	}
}

/*
 @State private var endProgress: CGFloat = 1.0
 @State private var currentProgress: CGFloat = 0.0
 @State private var playMode = LottiePlaybackMode.paused(at: .progress(0))
 @State private var timer: Timer?

 //		LottieView {
 //			let bundle = /*Bundle(for: AAAA.self)*/ Bundle.module
 //			do {
 //				bundle.load()
 //			} catch {
 //				print(error)
 //			}
 //			print("@@ bundle main \(bundle)")
 //			guard let file = bundle.url(forResource: animationName, withExtension: nil) else {
 //				fatalError("no file")
 //			}
 //			guard let data = try? Data(contentsOf: file) else {
 //				fatalError("no data")
 //			}
 //
 //			guard let result = try? LottieAnimation.from(data: data) else {
 //				fatalError("no result")
 //			}
 //
 //			return result
 //		}


 func startProgressUpdate() {
		 timer?.invalidate() // Останавливаем старый таймер, если он был
		 timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
				 withAnimation {
					 print("@@ test")
					 if currentProgress < endProgress {
						 currentProgress += 0.1 // Увеличиваем значение прогресса
					 } else {
						 currentProgress = 0.0
						 }
				 }
		 }
 }

 func stopProgressUpdate() {
		 timer?.invalidate() // Останавливаем таймер
 }


 .onChange(of: viewModel.state.isLoading) { newValue in
	 if newValue {
		 startProgressUpdate() // Запускаем таймер для обновления currentProgress
		 playMode = .playing(.fromProgress(currentProgress, toProgress: endProgress, loopMode: .loop))
	 } else {
		 stopProgressUpdate() // Останавливаем таймер

		 if currentProgress == endProgress || currentProgress == 0.0 {
			 playMode = .paused(at: .progress(currentProgress))
		 } else {
			 if currentProgress > 0.5 {
				 playMode = .playing(.fromProgress(currentProgress, toProgress: endProgress, loopMode: .playOnce))
				 currentProgress = endProgress
			 } else {
				 playMode = .playing(.fromProgress(currentProgress, toProgress: 0.0, loopMode: .playOnce))
				 currentProgress = 0.0
			 }
		 }
	 }
 }
 */
