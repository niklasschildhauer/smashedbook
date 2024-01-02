//
//  RecipeDetailViewController.swift
//  SmashedBook
//
//  Created by Niklas Schildhauer on 28.12.23.
//

import UIKit
import SwiftUI

class RecipeDetailViewController: UIViewController {
    private static let headerHeight = 500.0
    
    var presenter: RecipeDetailPresenting? {
        didSet {
            presenter?.view = self
        }
    }
    
    private var headerViewTopContraint: NSLayoutConstraint!

    private lazy var headerView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var headerImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "ExamplePicture")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var headerContentViewController: UIHostingController = {
        let hostingController = UIHostingController(rootView: RecipeDetailTitleView())
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        hostingController.view.backgroundColor = .clear
        return hostingController
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.delegate = self
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.alwaysBounceVertical = true
        return scrollView
    }()
    
    private lazy var containerStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = 0
        return view
    }()
    
    private let subView1: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 200).isActive = true
        view.backgroundColor = UIColor.blue
        return view
    }()
    
    private let subView2: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 300).isActive = true
        view.backgroundColor = UIColor.cyan
        return view
    }()
    
    private let subView3: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 400).isActive = true
        view.backgroundColor = UIColor.gray
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollAndContainerView()
        setupContentStackView()
        setupHeader()
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func setupScrollAndContainerView() {
        view.addSubview(scrollView)
        scrollView.anchorToAllEdgesOfSuperview()
    }
        
    private func setupHeader() {
        scrollView.addSubview(headerView)
        headerView.addSubview(headerImageView)
        // Since the updating of the constraints results into flaky behaviour at the left edge, the header view overlaps the scrollview.
        headerView.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor, constant: -5).isActive = true
        headerView.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor, constant: 5).isActive = true
        headerViewTopContraint = headerView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor)
        headerViewTopContraint.isActive = true
        let bottomConstraint = headerView.bottomAnchor.constraint(equalTo: containerStackView.topAnchor)
        bottomConstraint.priority = UILayoutPriority(900)
        bottomConstraint.isActive = true
        headerImageView.anchorToAllEdgesOfSuperview()
        
        guard let headerContentView = headerContentViewController.view else { return }
        addChild(headerContentViewController)
        headerView.addSubview(headerContentView)
        headerView.bottomAnchor.constraint(equalTo: headerContentView.bottomAnchor).isActive = true
        headerView.leadingAnchor.constraint(equalTo: headerContentView.leadingAnchor).isActive = true
        headerView.trailingAnchor.constraint(equalTo: headerContentView.trailingAnchor).isActive = true
        headerContentViewController.view.heightAnchor.constraint(equalToConstant: 300).isActive = true
        headerContentView.didMoveToSuperview()
        
    }
    
    private func setupContentStackView() {
        scrollView.addSubview(containerStackView)
        containerStackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: RecipeDetailViewController.headerHeight).isActive = true
        containerStackView.bottomAnchor.constraint(equalTo:  scrollView.contentLayoutGuide.bottomAnchor).isActive = true
        containerStackView.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor).isActive = true
        containerStackView.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor).isActive = true
        
        containerStackView.addArrangedSubview(subView1)
        containerStackView.addArrangedSubview(subView2)
        containerStackView.addArrangedSubview(subView3)
    }
        
 
    
    @objc func imageTapped(sender: UITapGestureRecognizer) {
        presenter?.didSelectAttachment(at: IndexPath(index: .zero))
    }
}

extension RecipeDetailViewController: RecipeDetailViewing {
    
}

extension RecipeDetailViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        if offset.y > 0.0 {
            let parallaxFactor: CGFloat = 0.8
            let prallaxedOffset = offset.y * parallaxFactor
            let transform = CATransform3DTranslate(CATransform3DIdentity, 0, prallaxedOffset, 0)
            headerImageView.layer.transform = transform
        } else {
            headerImageView.layer.transform = CATransform3DIdentity
        }
        
        if offset.y < 0.0 {
            self.headerViewTopContraint.constant = offset.y
        } else {
            self.headerViewTopContraint.constant = 0
        }
    }
}


