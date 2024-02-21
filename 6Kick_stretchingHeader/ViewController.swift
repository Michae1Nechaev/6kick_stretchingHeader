//
//  ViewController.swift
//  6Kick_stretchingHeader
//
//  Created by Нечаев Михаил on 19.02.2024.
//

import UIKit

class ViewController: UIViewController {
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let headerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "forest")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var contentViewTopAnchor: NSLayoutConstraint!
    var headerViewHeightAnchor: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        scrollView.contentSize = CGSize(
            width: UIScreen.main.bounds.size.width,
            height: 1000
        )

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(headerImageView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.widthAnchor.constraint(equalToConstant: scrollView.contentSize.width),
            contentView.heightAnchor.constraint(equalToConstant: scrollView.contentSize.height),
        ])
        contentViewTopAnchor = contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: 0)
        contentViewTopAnchor.isActive = true
        
        NSLayoutConstraint.activate([
            headerImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            headerImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            headerImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        headerViewHeightAnchor = headerImageView.heightAnchor.constraint(equalToConstant: 270)
        headerViewHeightAnchor.isActive = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scrollView.scrollIndicatorInsets = UIEdgeInsets(
            top: 270 - view.safeAreaInsets.top,
            left: 0,
            bottom: 0,
            right: 0
        )
    }
    
}

extension ViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        
        if offset < 0 {
            contentViewTopAnchor.constant = offset
            headerViewHeightAnchor.constant = 270 - offset
            
            scrollView.scrollIndicatorInsets = UIEdgeInsets(
                top: 270 - view.safeAreaInsets.top - offset,
                left: 0,
                bottom: 0,
                right: 0
            )
        }
    }

}
