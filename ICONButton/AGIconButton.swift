
// The MIT License
//
//  Copyright (c) (c) 2017 Alex Gibson(oakmonttech@gmail.com)

// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit

@IBDesignable class AGIconButton: UIControl {
    
    private var iconImageView : UIImageView!
    private var iconLabel : UILabel!
    private var mainSpacer : UIView!
    private var highlightView:UIView!
    private var widthContraint : NSLayoutConstraint!
    var padding : CGFloat = 5


    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
        addTarget(self, action: #selector(AGIconButton.userDidTouchDown), for: .touchDown)
        addTarget(self, action: #selector(AGIconButton.userDidTouchUp), for: .touchUpInside)
        addTarget(self, action: #selector(AGIconButton.userDidTouchUpOutside), for: .touchUpOutside)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpView()
        addTarget(self, action: #selector(AGIconButton.userDidTouchDown), for: .touchDown)
        addTarget(self, action: #selector(AGIconButton.userDidTouchUp), for: .touchUpInside)
        addTarget(self, action: #selector(AGIconButton.userDidTouchUpOutside), for: .touchUpOutside)
        

    }
    
    //only called at design time
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setUpView()
        addTarget(self, action: #selector(AGIconButton.userDidTouchDown), for: .touchDown)
        addTarget(self, action: #selector(AGIconButton.userDidTouchUp), for: .touchUpInside)
        addTarget(self, action: #selector(AGIconButton.userDidTouchUpOutside), for: .touchUpOutside)
        
    }
    
  
    
    
    @IBInspectable var iconImage: UIImage = UIImage() {
        didSet {
            iconImageView.image = iconImage
        }
    }
    
    
    @IBInspectable var imageSize: CGFloat = 40 {
        didSet {
             setUpView()
        }
    }
    
    
    @IBInspectable var imagePadding: CGFloat = 10 {
        didSet {
               setUpView()
        }
    }
    
    @IBInspectable var iconText: String = "Icon Button Time" {
        didSet {
              setUpView()
        }
    }
    
    @IBInspectable var iconTextSize: CGFloat = 15 {
        didSet {
              setUpView()
        }
    }
    
    @IBInspectable var iconTextColor: UIColor = UIColor.black {
        didSet {
            setUpView()
        }
    }
    
    @IBInspectable var alignment: Int = 1 {
        didSet {
            setUpView()
        }
    }
    
    
    override var intrinsicContentSize: CGSize {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: iconTextSize)
        label.text = iconText
        label.sizeToFit()
        return CGSize(width: imageSize + label.frame.width + imagePadding + (padding * 2), height: CGFloat(max(label.frame.height, imageSize) + padding * 2))
    }
    
    
    @IBInspectable var highLightColor: UIColor = UIColor.lightGray {
        didSet {
             setUpView()
        }
    }
    
    @IBInspectable var shouldBounce: Bool = true
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    private func setUpView(){
        
        if highlightView == nil{
            highlightView = UIView(frame: self.bounds)
            highlightView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
            highlightView.alpha = 0
            highlightView.isUserInteractionEnabled = false
            self.addSubview(highlightView)
        }
        highlightView.backgroundColor = highLightColor

        if iconImageView == nil{
            iconImageView = UIImageView(image: iconImage)
            iconImageView.contentMode = .scaleAspectFit
            iconImageView.isUserInteractionEnabled = false
            self.addSubview(iconImageView)
            
        }

        if mainSpacer == nil{
            mainSpacer = UIView(frame: CGRect(x: 0, y: 0, width: imagePadding, height: self.bounds.height))
            mainSpacer.isUserInteractionEnabled = false
            self.addSubview(mainSpacer)
        }

        

        if iconLabel == nil{
            iconLabel = UILabel()
            iconLabel.isUserInteractionEnabled = false
            self.addSubview(iconLabel)
            
        }
       
        iconLabel.font = UIFont.systemFont(ofSize: iconTextSize)
        iconLabel.text = iconText
        iconLabel.textColor = iconTextColor
        iconLabel.sizeToFit()
        
        
        var usedWidth : CGFloat = self.intrinsicContentSize.width
        
        if bounds.width < usedWidth{
            usedWidth = bounds.width
        }
        
        let maxImageHeight = min(self.bounds.height - padding, imageSize)
        
        //resize iconlabel if we have to
        if maxImageHeight + imagePadding + iconLabel.bounds.width + padding * 2 > usedWidth{
            iconLabel.frame = CGRect(x: 0, y: 0, width: self.bounds.width - iconImageView.bounds.width - imagePadding - padding * 2, height: iconLabel.bounds.height)
            iconLabel.fitFontForSize(minFontSize: 1, maxFontSize: iconTextSize, accuracy: 1.0)
       
        }

        let maxWidth = (self.bounds.width - iconLabel.bounds.width - maxImageHeight - imagePadding) / 2
        
        switch alignment {
        case 0:
            //intrinsic left
            iconImageView.frame = CGRect(x:padding, y: self.bounds.midY - maxImageHeight/2,width:maxImageHeight, height: maxImageHeight)
            mainSpacer.frame = CGRect(x: maxImageHeight + padding, y: 0, width: imagePadding, height: self.bounds.height)
            iconLabel.frame = CGRect(x: maxImageHeight + imagePadding + padding, y: 0, width: iconLabel.frame.width, height: bounds.height)

            break
        case 1:
            //intrinsic center
            iconImageView.frame = CGRect(x: maxWidth, y: self.bounds.midY - maxImageHeight/2,width:maxImageHeight, height: maxImageHeight)
            mainSpacer.frame = CGRect(x: maxWidth + maxImageHeight, y: 0, width: imagePadding, height: self.bounds.height)
            iconLabel.frame = CGRect(x: maxWidth + maxImageHeight + imagePadding, y: 0, width: iconLabel.frame.width, height: self.bounds.height)
            break
        case 2:
            //intrinsic icon right text aligned right
            iconLabel.frame = CGRect(x: maxWidth, y: 0, width: iconLabel.frame.width, height: self.bounds.height)
            iconLabel.textAlignment = .right
            mainSpacer.frame = CGRect(x: iconLabel.frame.width + maxWidth, y: 0, width: imagePadding, height: self.bounds.height)
            iconImageView.frame = CGRect(x: iconLabel.frame.width + imagePadding + maxWidth, y: self.bounds.midY - maxImageHeight/2,width:maxImageHeight, height: maxImageHeight)
            break
        case 3:
            //intrinsic center invert icon
            iconLabel.frame = CGRect(x:maxWidth, y: 0, width: iconLabel.frame.width, height: self.bounds.height)
            mainSpacer.frame = CGRect(x: maxWidth + iconLabel.bounds.width, y: 0, width: imagePadding, height: self.bounds.height)
            iconImageView.frame = CGRect(x: maxWidth + iconLabel.bounds.width + imagePadding, y: self.bounds.midY - maxImageHeight/2,width:maxImageHeight, height: maxImageHeight)
            
            break
            
        default:
            //intrinsic center
            iconImageView.frame = CGRect(x: maxWidth, y: self.bounds.midY - maxImageHeight/2,width:maxImageHeight, height: maxImageHeight)
            mainSpacer.frame = CGRect(x: maxWidth + maxImageHeight, y: 0, width: imagePadding, height: self.bounds.height)
            iconLabel.frame = CGRect(x: maxWidth + maxImageHeight + imagePadding, y: 0, width: iconLabel.frame.width, height: self.bounds.height)
        }
        self.bringSubview(toFront: highlightView)

    }
    
 
    //layout subviews
    override func layoutSubviews() {
        super.layoutSubviews()
        setUpView()
    }

    
    //MARK: Touch Events
    //TODO: run on timer to simulate a real press
    func userDidTouchDown(){
        if shouldBounce == true{
            animateBouncyDown()
        }else{
            self.animateHighlightTo(alpha: 0.3)
        }
        
    }

    
    func userDidTouchUp(){
        if shouldBounce == true{
            animateBouncyUp()
        }else{
            self.animateHighlightTo(alpha: 0)
        }
    }
    
    func userDidTouchUpOutside(){
        if shouldBounce == true{
            animateBouncyUp()
        }else{
            self.animateHighlightTo(alpha: 0)
        }
    }
    
    func animateHighlightTo(alpha:CGFloat){
        UIView.animate(withDuration: 0.2, animations: {  [weak self] in
            self?.highlightView.alpha = alpha
        })
        
    }
    
    func animateBouncyDown(){
        self.transform = CGAffineTransform.identity
        UIView.animate(withDuration: 0.15, animations: { [weak self] in
            self?.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)
        })
    }
    
    func animateBouncyUp(){
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: .curveEaseInOut, animations: {[weak self] in
            if self != nil{
                self?.transform = CGAffineTransform.identity
            }
        }, completion: nil)
    }
}

extension UILabel {
    
    func fitFontForSize( minFontSize : CGFloat = 1.0, maxFontSize : CGFloat = 300.0, accuracy : CGFloat = 1.0) {
        var maxFontSize = maxFontSize
        var minFontSize = minFontSize
        assert(maxFontSize > minFontSize)
        layoutIfNeeded() // Can be removed at your own discretion
        let constrainedSize = bounds.size
        while maxFontSize - minFontSize > accuracy {
            let midFontSize : CGFloat = ((minFontSize + maxFontSize) / 2)
            font = font.withSize(midFontSize)
            sizeToFit()
            let checkSize : CGSize = bounds.size
            if  checkSize.height < constrainedSize.height && checkSize.width < constrainedSize.width {
                minFontSize = midFontSize
            } else {
                maxFontSize = midFontSize
            }
        }
        font = font.withSize(minFontSize)
        sizeToFit()
        layoutIfNeeded()
    }
}


