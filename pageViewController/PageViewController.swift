//
//  PageViewController.swift
//  pageViewController
//
//  Created by Appinventiv on 04/03/17.
//  Copyright © 2017 Appinventiv. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController , UIPageViewControllerDelegate , UIPageViewControllerDataSource {
    
    // CREATING AN ARRAY OF THE INSTANTIATED PAGE VIEW CONTROLLERS THAT ARE TO BE KEPT INSIDE THE PAGE VIEW CONTROLLER
    
   lazy var VCArray: [UIViewController] = {
    return [self.VCInstance(name: "FirstVCViewControllerID"),
           self.VCInstance(name: "SecondVCViewControllerID"),
           self.VCInstance(name: "ThirdVCViewControllerID")]
    }()

    // MARK: VIEW LIFECYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.dataSource  = self
        
        // SHOWING THE FIRST VIEW CONTROLLER AS THE INITIAL PAGE CONTROLLER PAGE
        
        if let firstVC = VCArray.first{
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
        
    }
    
    // SETTING THE BACKGROUND COLOR OF THE PAGECONTROL AS CLEAR
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        for view in self.view.subviews
        {
            if view is UIScrollView
            {
                view.frame = UIScreen.main.bounds
            }
            
            else if view is UIPageControl
                {
                    view.backgroundColor = UIColor.clear
                }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController?{
        
        guard let viewControllerIndex = VCArray.index(of: viewController) else
        {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else{
            
            return VCArray.last
        }
        
        guard VCArray.count > previousIndex else{
            return nil
        }
        
        return VCArray[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = VCArray.index(of: viewController) else
        {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        
        guard nextIndex < VCArray.count  else{
            return VCArray.first
        }
        
        guard VCArray.count > nextIndex else{
            return nil
        }
        
        return VCArray[nextIndex]

        }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        
        return VCArray.count
        
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        
        guard let firstViewController = viewControllers?.first ,
            let firstViewControllerIndex = VCArray.index(of: firstViewController) else{
                return 0
        }
        
        return firstViewControllerIndex
        
    }

    private func VCInstance(name : String) -> UIViewController
    {
       return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: name)
    }

}
