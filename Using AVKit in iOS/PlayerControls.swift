//
//  PlayerControls.swift
//  Using AVKit in iOS
//
//  Created by Vladimír Horký on 07/12/22.
//  Copyright © 2022 Apple. All rights reserved.
//

import UIKit
import AVKit

class PlayerControls: UIView {
    let kCONTENT_XIB_NAME = "PlayerControls"
    weak var playerViewController: AVPlayerViewController?

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var bwwContainer: UIView!

    @IBAction func playpause(_ sender: Any) {
        if playerViewController?.player?.timeControlStatus == .paused {
            playerViewController?.player?.play()
        } else {
            playerViewController?.player?.pause()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    func commonInit() {
        Bundle.main.loadNibNamed(kCONTENT_XIB_NAME, owner: self, options: nil)
        contentView.setupViewIn(self)
        addGestures()
    }


    func addGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        contentView.addGestureRecognizer(tapGesture)

        let swipeUpGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeUp))
        swipeUpGesture.direction = .up
        contentView.addGestureRecognizer(swipeUpGesture)

        let swipeDownGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeDown))
        swipeDownGesture.direction = .down
        contentView.addGestureRecognizer(swipeDownGesture)
    }

    @IBAction func handleTap(_ gestureRecognizer : UITapGestureRecognizer ) {
       guard gestureRecognizer.view != nil else { return }

       if gestureRecognizer.state == .ended {
           playPauseButton.isHidden.toggle()
       }

    }

    @IBAction func handleSwipeUp(_ gestureRecognizer : UISwipeGestureRecognizer ) {
       guard gestureRecognizer.view != nil else { return }

       if gestureRecognizer.state == .ended {
           bwwContainer.isHidden = false
       }
    }

    @IBAction func handleSwipeDown(_ gestureRecognizer : UISwipeGestureRecognizer ) {
       guard gestureRecognizer.view != nil else { return }

       if gestureRecognizer.state == .ended {
           bwwContainer.isHidden = true
       }
    }

}

extension UIView
{
    func setupViewIn(_ container: UIView!) -> Void {
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.frame = container.frame;
        container.addSubview(self);
        NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: container, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: container, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: container, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
    }
}
