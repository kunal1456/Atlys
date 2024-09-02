//
//  ViewController.swift
//  Atlys
//
//  Created by Kunal Goswami on 01/09/24.
//

import UIKit

class ViewController:  UIViewController {
    
    var imageViews: [UIImageView] = []
    var currentIndex: Int = 0
    var nextIndex: Int = 0
    var previousIndex: Int = 0
    let imageNames = ["1", "2", "3","4","5","6","7"]

    override func viewDidLoad() {
        super.viewDidLoad()
        let containerView = UIView(frame: CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y, width: self.view.frame.width, height: self.view.frame.height - 200.0))
        self.view.addSubview(containerView)
        for imageName in imageNames {
            let imageView = UIImageView(image: UIImage(named: imageName))
            imageView.contentMode = .scaleAspectFit
            imageView.frame = containerView.bounds
            imageView.transform = CGAffineTransform(translationX: containerView.bounds.width, y: 0)
            containerView.addSubview(imageView)
            imageViews.append(imageView)
        }
        viewPostion(centerIndex: 1, NextIndex: 2, PreviousIndex: 0)
    }
    
    func animateCarouselNext() {
        guard imageViews.count > 1 else { return }
        nextIndex = (currentIndex + 1) % imageViews.count
        previousIndex = (currentIndex - 1 + imageViews.count) % imageViews.count
        // Animate the next image into the center
        UIView.animate(withDuration: 1.0, delay: 0.0, options: [], animations: {
            self.imageViews[self.nextIndex].transform = .identity
        }) { _ in
            self.currentIndex = self.nextIndex
        }
        UIView.animate(withDuration: 1.0, animations: {
            self.viewPostion(centerIndex: self.currentIndex, NextIndex: self.nextIndex, PreviousIndex: self.previousIndex)
        }) { _ in
        }
    }
    
    
    
    
    func animateCarouselBack() {
        guard imageViews.count > 1 else { return }
        nextIndex = (currentIndex + 1) % imageViews.count
        previousIndex = (currentIndex - 1 + imageViews.count) % imageViews.count
        UIView.animate(withDuration: 1.0, delay: 0.0, options: [], animations: {
            self.imageViews[self.previousIndex].transform = .identity
        }) { _ in
            self.currentIndex = self.previousIndex
        }
        UIView.animate(withDuration: 1.0, animations: {
            self.viewPostion(centerIndex: self.currentIndex, NextIndex: self.nextIndex, PreviousIndex: self.previousIndex)
        }) { _ in
            // Reset the current image to the right side, off-screen
        }
    }
    
    func viewPostion(centerIndex: Int, NextIndex: Int, PreviousIndex: Int) {
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        let viewWidth = screenWidth * 0.7
        let viewHeight = screenHeight * 0.5
        
        let originX = (screenWidth - viewWidth) / 2
        let originY = (screenHeight - viewHeight) / 2
        
        let secondImageView =  imageViews[previousIndex]
        let preCenteredRect = CGRect(x: originX - (viewWidth - 40), y: originY + 20, width: viewWidth, height: viewHeight)
        secondImageView.transform = .identity
        secondImageView.frame = preCenteredRect
        
        let thirdImageView =  imageViews[nextIndex]
        let nexCenteredRect = CGRect(x: originX + (viewWidth - 40), y: originY + 20, width: viewWidth, height: viewHeight)
        thirdImageView.transform = .identity
        thirdImageView.frame = nexCenteredRect
        
        let centerImageView = imageViews[centerIndex]
        let centeredRect = CGRect(x: originX, y: originY, width: viewWidth, height: viewHeight)
        centerImageView.transform = .identity
        centerImageView.frame = centeredRect
        
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        animateCarouselNext()
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        animateCarouselBack()
    }
}

