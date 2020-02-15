//
// Created by Kelvin Harron on 12/02/2020.
// Copyright (c) 2020 Matthew Wilson. All rights reserved.
//

import Foundation
import Cocoa
import SwiftUI

class OverviewViewController: NSViewController {

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func loadView() {
        view = NSView()

        preferredContentSize = NSSize(width: 400, height: 240)

        let contentView = ContentView()
        let hostingController = NSHostingController(rootView: contentView)

        addChild(hostingController)
        hostingController.view.autoresizingMask = [.width, .height]
        hostingController.view.frame = view.bounds
        view.addSubview(hostingController.view)
    }
}
