/*******************************************************************************
Copyright (K), 2020 - ~, ╰莪呮想好好宠Nǐつ

Author:        ╰莪呮想好好宠Nǐつ 
E-mail:        1091676312@qq.com
GitHub:        https://github.com/yijingKing
********************************************************************************/

import Foundation
import UIKit

open class YEXBlockPan: UIPanGestureRecognizer {
    private var panAction: ((UIPanGestureRecognizer) -> Void)?

    override init(target: Any?, action: Selector?) {
        super.init(target: target, action: action)
    }

    convenience init (action: ((UIPanGestureRecognizer) -> Void)?) {
        self.init()
        self.panAction = action
        self.addTarget(self, action: #selector(YEXBlockPan.didPan(_:)))
    }

    @objc open func didPan (_ pan: UIPanGestureRecognizer) {
        panAction? (pan)
    }
}
open class YEXBlockPinch: UIPinchGestureRecognizer {
    private var pinchAction: ((UIPinchGestureRecognizer) -> Void)?

    override init(target: Any?, action: Selector?) {
        super.init(target: target, action: action)
    }

    convenience init (action: ((UIPinchGestureRecognizer) -> Void)?) {
        self.init()
        self.pinchAction = action
        self.addTarget(self, action: #selector(YEXBlockPinch.didPinch(_:)))
    }

    @objc open func didPinch (_ pinch: UIPinchGestureRecognizer) {
        pinchAction? (pinch)
    }
}
open class YEXBlockSwipe: UISwipeGestureRecognizer {
    private var swipeAction: ((UISwipeGestureRecognizer) -> Void)?

    override init(target: Any?, action: Selector?) {
        super.init(target: target, action: action)
    }

    convenience init (
        direction: UISwipeGestureRecognizer.Direction,
        fingerCount: Int = 1,
        action: ((UISwipeGestureRecognizer) -> Void)?) {
            self.init()
            self.direction = direction
            
            swipeAction = action
            addTarget(self, action: #selector(YEXBlockSwipe.didSwipe(_:)))
    }

    @objc open func didSwipe (_ swipe: UISwipeGestureRecognizer) {
        swipeAction? (swipe)
    }
}
open class YEXBlockTap: UITapGestureRecognizer {
    private var tapAction: ((UITapGestureRecognizer) -> Void)?

    override init(target: Any?, action: Selector?) {
        super.init(target: target, action: action)
    }

    convenience init (
        tapCount: Int = 1,
        fingerCount: Int = 1,
        action: ((UITapGestureRecognizer) -> Void)?) {
            self.init()
            self.numberOfTapsRequired = tapCount
            self.tapAction = action
            self.addTarget(self, action: #selector(YEXBlockTap.didTap(_:)))
    }

    @objc open func didTap (_ tap: UITapGestureRecognizer) {
        tapAction? (tap)
    }
}
open class YEXBlockLongPress: UILongPressGestureRecognizer {
    private var longPressAction: ((UILongPressGestureRecognizer) -> Void)?

    override init(target: Any?, action: Selector?) {
        super.init(target: target, action: action)
    }

    convenience init (action: ((UILongPressGestureRecognizer) -> Void)?) {
        self.init()
        longPressAction = action
        addTarget(self, action: #selector(YEXBlockLongPress.didLongPressed(_:)))
    }

    @objc open func didLongPressed(_ longPress: UILongPressGestureRecognizer) {
        if longPress.state == UIGestureRecognizer.State.began {
            longPressAction?(longPress)
        }
    }
}
