//
//  ZoomableScrollView.swift
//  SmashedBook
//
//  Created by Niklas Schildhauer on 25.12.23.
//

import SwiftUI

struct ZoomableScrollView<Content: View>: UIViewRepresentable {
    private var content: Content
    private let coordinator: Coordinator
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
        self.coordinator = Coordinator(hostingController: UIHostingController(rootView: self.content))
    }
    
    func makeUIView(context: Context) -> UIScrollView {
        return coordinator.scrollView
    }
    
    func makeCoordinator() -> Coordinator {
        return coordinator
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        context.coordinator.hostingController.rootView = self.content
        assert(context.coordinator.hostingController.view.superview == uiView)
    }
        
    class Coordinator: NSObject, UIScrollViewDelegate {
        private let maxZoomValue = 20.0
        
        var hostingController: UIHostingController<Content>
        
        private var doubleTapGesture: UITapGestureRecognizer?
        
        lazy var scrollView = {
            let scrollView = UIScrollView()
            scrollView.delegate = self
            scrollView.maximumZoomScale = maxZoomValue
            scrollView.minimumZoomScale = 1
            scrollView.bouncesZoom = true
            
            let hostedView = hostingController.view!
            hostedView.translatesAutoresizingMaskIntoConstraints = true
            hostedView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            hostedView.frame = scrollView.bounds
            scrollView.addSubview(hostedView)
            
            return scrollView
        }()
        
        init(hostingController: UIHostingController<Content>) {
            self.hostingController = hostingController
            super.init()
            
            let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(didDoubleTap))
           
            doubleTapGesture.numberOfTapsRequired = 2
            hostingController.view.addGestureRecognizer(doubleTapGesture)
            self.doubleTapGesture = doubleTapGesture
        }
        
        func viewForZooming(in scrollView: UIScrollView) -> UIView? {
            return hostingController.view
        }
        
        @objc func didDoubleTap() {        
            guard let doubleTapGesture = doubleTapGesture else {
                print("There went something wrong")
                return
            }
            
            let zoomRect = zoomRectForScale(scale: maxZoomValue / 5.0, center: doubleTapGesture.location(in: doubleTapGesture.view))
            scrollView.zoom(to: zoomRect, animated: true)
        }
        
        func zoomRectForScale(scale : CGFloat, center : CGPoint) -> CGRect {
            var zoomRect = CGRect.zero
            if let imageV = self.hostingController.view {
                zoomRect.size.height = imageV.frame.size.height / scale;
                zoomRect.size.width  = imageV.frame.size.width / scale;
                zoomRect.origin.x = center.x - ((zoomRect.size.width / 2.0));
                zoomRect.origin.y = center.y - ((zoomRect.size.height / 2.0));
            }
            return zoomRect;
        }
    }
}

