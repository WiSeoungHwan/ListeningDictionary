//
//  DetailPageViewController.swift
//  ListeningDictionary
//
//  Created by Wi on 11/08/2019.
//  Copyright © 2019 Wi. All rights reserved.
//

import UIKit

class DetailPageViewController: UIViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource{
    
    
    // MARK: - Properties
    
    var searchResults = [Caption]()
    var pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    var controllers: [UIViewController]?

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // MARK: - Methods
    
    private func configure(){
        pageViewController.dataSource = self
        pageViewController.delegate = self
        view.addSubview(pageViewController.view)
        controllers = searchResults.map{
            let detailVC  = DetailViewController()
            detailVC.caption = $0
            return detailVC
        }
        guard let controllers = controllers else {return}
        pageViewController.setViewControllers([controllers[0]], direction: .forward, animated: true, completion: nil)
        
    }

    // MARK: - PageViewController DataSource
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllers = controllers else {return nil}
        if let index = viewControllers.firstIndex(of: viewController) {
            if index > 0 {
                return viewControllers[index - 1]
            } else {
                return nil
            }
        }
        
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllers = controllers else {return nil}
        if let index = viewControllers.firstIndex(of: viewController) {
            if index < viewControllers.count - 1 {
                return viewControllers[index + 1]
            } else {
                return nil
            }
        }
        
        return nil
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return searchResults.count
    }
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    

}
