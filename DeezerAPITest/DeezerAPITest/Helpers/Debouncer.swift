//
//  Debouncer.swift
//  DeezerAPITest
//
//  Created by Emin Roblack on 08/02/2020.
//  Copyright © 2020 Emin Roblack. All rights reserved.
//

import Foundation

class Debouncer {

    init(timeInterval: TimeInterval) {
        self.timeInterval = timeInterval
    }

    typealias Handler = () -> Void

    var handler: Handler?

    private let timeInterval: TimeInterval
    private var timer: Timer?

    func renewInterval() {
        timer?.invalidate()
        // Begin a new timer from now
        timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: false, block: { [weak self] timer in
            self?.handleTimer(timer)
        })
    }

    private func handleTimer(_ timer: Timer) {
        guard timer.isValid else {
            return
        }
        handler?()
        handler = nil
    }

}
