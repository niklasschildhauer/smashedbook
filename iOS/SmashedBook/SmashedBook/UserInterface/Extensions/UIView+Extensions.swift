//
//  UIView+Extensions.swift
//  SmashedBook
//
//  Created by Niklas Schildhauer on 28.12.23.
//

import UIKit

/// Fade in and out animation
public extension UIView {
    func fadeIn(_ duration: TimeInterval? = 0.5, onCompletion: (() -> Void)? = nil) {
        if isHidden == true {
            self.alpha = 0
            self.isHidden = false
            UIView.animate(withDuration: duration!,
                           animations: { self.alpha = 1 },
                           completion: { (value: Bool) in
                if let complete = onCompletion { complete() }
            }
            )
        }
    }
    
    func fadeOut(_ duration: TimeInterval? = 0.5, onCompletion: (() -> Void)? = nil) {
        if isHidden == false {
            
            UIView.animate(withDuration: duration!,
                           animations: { self.alpha = 0 },
                           completion: { (value: Bool) in
                self.isHidden = true
                if let complete = onCompletion { complete() }
            }
            )
        }
    }
}

extension UIView {
    public func fadeTransition(_ duration:CFTimeInterval) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
                                                            CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.fade
        animation.duration = duration
        layer.add(animation, forKey: CATransitionType.fade.rawValue)
    }
}

extension UIView {
    public func anchor(height: CGFloat? = nil, width: CGFloat? = nil) {
        
        var constraints: [NSLayoutConstraint] = []
        if let height = height {
            constraints.append(heightAnchor.constraint(equalToConstant: height))
        }
        if let width = width {
            constraints.append(widthAnchor.constraint(equalToConstant: width))
        }
        
        NSLayoutConstraint.activate(constraints)
    }
    
    public func anchor(size: CGSize) {
        self.anchor(height: size.height,
                    width: size.width)
    }
    
    public func anchorToCentreOfSuperview(offset: UIOffset = .zero) {
        NSLayoutConstraint.activate([
            centerXAnchor.constraint(equalTo: superview!.centerXAnchor, constant: offset.horizontal),
            centerYAnchor.constraint(equalTo: superview!.centerYAnchor, constant: offset.vertical)
        ])
    }
    
    public func anchorToAllEdgesOfSafeArea(insets: UIEdgeInsets = .zero) {
        NSLayoutConstraint.activate([
            safeAreaLayoutGuide.leadingAnchor.constraint(equalTo: superview!.safeAreaLayoutGuide.leadingAnchor, constant: insets.left),
            safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: superview!.safeAreaLayoutGuide.trailingAnchor, constant: -insets.right),
            safeAreaLayoutGuide.topAnchor.constraint(equalTo: superview!.safeAreaLayoutGuide.topAnchor, constant: insets.top),
            safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: superview!.safeAreaLayoutGuide.bottomAnchor, constant: -insets.bottom)
        ])
    }
    
    public func anchorToAllEdgesOfSuperview(insets: UIEdgeInsets = .zero) {
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: superview!.leadingAnchor, constant: insets.left),
            trailingAnchor.constraint(equalTo: superview!.trailingAnchor, constant: -insets.right),
            topAnchor.constraint(equalTo: superview!.topAnchor, constant: insets.top),
            bottomAnchor.constraint(equalTo: superview!.bottomAnchor, constant: -insets.bottom)
        ])
    }
}

extension UIView {
    /// A helper function to add multiple subviews.
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach {
            addSubview($0)
        }
    }
}


