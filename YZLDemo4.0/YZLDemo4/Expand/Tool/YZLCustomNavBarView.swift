//
//  YZLCustomNavBarView.swift
//  YZLOnlineSchoolDemo
//
//  Created by Xu Chen on 2018/8/21.
//  Copyright © 2018年 xu.yzl. All rights reserved.
//

import UIKit

/// 自定义导航栏
class YZLCustomNavBarView: UIView {

    /// 标题
    var title: String? {
        didSet {
            guard let titleString = title else { return }
            
            titleLabel.text = titleString
            titleLabel.isHidden = false
        }
    }
    /// 标题文字颜色
    var titleLabelColor: UIColor? {
        didSet {
            titleLabel.textColor = titleLabelColor
        }
    }
    /// 标题字体
    var titleLabelFont: UIFont? {
        didSet {
            titleLabel.font = titleLabelFont
        }
    }
    /// 背景颜色
    var barBackgroundColor: UIColor? {
        didSet {
            // 隐藏背景图片，显示背景图
            backgroundImageView.isHidden = true
            backgroundView.isHidden = false
            
            backgroundView.backgroundColor = barBackgroundColor
        }
    }
    /// 背景图片
    var barBackgroundImage: UIImage? {
        didSet {
            // 隐藏背景视图，显示背景图片
            backgroundView.isHidden = true
            backgroundImageView.isHidden = false
            
            backgroundImageView.image = barBackgroundImage
        }
    }
    
    // 控件
    private lazy var backgroundView: UIView = UIView()
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isHidden = true
        return imageView
    }()
    private lazy var bottomLine: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor(red: 218.0/255.0, green: 218.0/255.0, blue: 218.0/255.0, alpha: 1)
        return line
    }()
    private lazy var rightButton: UIButton = {
        let button = UIButton()
        button.imageView?.contentMode = UIView.ContentMode.center
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.titleLabel?.textColor = UIColor.white
        button.addTarget(self, action: #selector(rightButtonDidSelected), for: .touchUpInside)
        button.isHidden = true
        
        return button
    }()
    private lazy var leftButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.titleLabel?.textColor = UIColor.white
        button.imageView?.contentMode = UIView.ContentMode.center
        button.addTarget(self, action: #selector(leftButtonDidSelected), for: .touchUpInside)
        button.isHidden = true
        
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = kDefaultTitleColor
        label.font = UIFont.systemFont(ofSize: kDefaultTitleSize)
        label.textAlignment = NSTextAlignment.center
        label.isHidden = true
        
        return label
    }()
    
    /// 左边按钮点击回调
    var leftButtonDidSelectedClosure: ((_ btn: UIButton)->())?
    /// 右边按钮点击回调
    var rightButtonDidSelectedClosure: (()->())?
    
    /// 默认值
    private let kDefaultTitleSize:CGFloat = 18.0
    private let kDefaultTitleColor = UIColor.black
    private let kDefaultBackgroundColor = UIColor.white
    private let kScreenWidths = UIScreen.main.bounds.width
    
    /// 单例
    static let shared = YZLCustomNavBarView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: (44 + UIApplication.shared.statusBarFrame.width)))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

private extension YZLCustomNavBarView {
    
    func setupUI() {
        addSubview(backgroundView)
        addSubview(backgroundImageView)
        addSubview(leftButton)
        addSubview(rightButton)
        addSubview(titleLabel)
        addSubview(bottomLine)
        
        updateFrames()
        
        backgroundView.backgroundColor = kDefaultBackgroundColor
    }
    
    /// 设置控件 frame
    func updateFrames() {
        let topMargin = Int(UIApplication.shared.statusBarFrame.height)
        let margin = 5
        let buttonHeight = 44
        let buttonWidth = 44
        let titleLabelHeight = 44
        let titleLabelWidth = 180
        
        backgroundView.frame = self.bounds
        backgroundImageView.frame = self.bounds
        leftButton.frame = CGRect(x: margin, y: topMargin, width: buttonWidth, height: buttonHeight)
        rightButton.frame = CGRect(x: (Int(kScreenWidths) - buttonWidth - margin), y: topMargin, width: buttonWidth, height: buttonHeight)
        titleLabel.frame = CGRect(x: (Int(kScreenWidths) - titleLabelWidth) / 2, y: topMargin, width: titleLabelWidth, height: titleLabelHeight)
        bottomLine.frame = CGRect(x: 0, y: (self.bounds.height - 0.5), width: kScreenWidths, height: 0.5)
    }
    
}

// MARK: - 按钮点击事件
private extension YZLCustomNavBarView {
    
    @objc func rightButtonDidSelected()  {
        self.rightButtonDidSelectedClosure?()
    }
    
    @objc func leftButtonDidSelected(button: UIButton) {
        self.leftButtonDidSelectedClosure?(button)
    }
}

// MARK: - 按钮自定义
extension YZLCustomNavBarView {
    
    /// 是否显示底部分割线
    ///
    /// - Parameter isHidden: isHidden
    func setBottomLineHidden(isHidden: Bool) {
        bottomLine.isHidden = isHidden
    }
    
    /// 修改控件透明度
    ///
    /// - Parameter alpha: alpha
    func setBackgroundAlpha(alpha: CGFloat) {
        backgroundView.alpha = alpha
        backgroundImageView.alpha = alpha
        bottomLine.alpha = alpha
    }
    
    /// 设置文字颜色
    ///
    /// - Parameter color: UIColor
    func setTintColor(color: UIColor) {
        leftButton.setTitleColor(color, for: .normal)
        rightButton.setTitleColor(color, for: .normal)
        titleLabel.textColor = color
    }
    
    // MARK: - 左侧按钮
    func setLeftButton(withNormal normal: UIImage,
                       highlighted: UIImage) {
        configureLeftButton(withNormal: normal, highlighted: highlighted, title: nil, titleColor: nil)
    }
    
    func setLeftButton(withImage image: UIImage) {
        configureLeftButton(withNormal: image, highlighted: image, title: nil, titleColor: nil)
    }
    
    func setLeftButton(withTitle title: String, titleColor: UIColor) {
        configureLeftButton(withNormal: nil, highlighted: nil, title: title, titleColor: titleColor)
    }
    
    /// 设置左侧按钮
    ///
    /// - Parameters:
    ///   - normal: 正常状态下图片
    ///   - highlighted: 高亮状态下图片
    ///   - title: 标题
    ///   - titleColor: 标题颜色
    func configureLeftButton(withNormal normal: UIImage?,
                       highlighted: UIImage?,
                       title: String?,
                       titleColor: UIColor?) {
        leftButton.isHidden = false
        
        if let normal = normal {
            leftButton.setImage(normal, for: .normal)
        }
        if let highlighted = highlighted {
            leftButton.setImage(highlighted, for: .highlighted)
        }
        if let title = title {
            leftButton.setTitle(title, for: .normal)
        }
        if let titleColor = titleColor {
            leftButton.setTitleColor(titleColor, for: .normal)
        }
    }
    
    // MARK: - 右侧按钮
    func setRightButton(withNormal normal: UIImage,
                       highlighted: UIImage) {
        configureRightButton(withNormal: normal, highlighted: highlighted, title: nil, titleColor: nil)
    }
    
    func setRightButton(withImage image: UIImage) {
        configureRightButton(withNormal: image, highlighted: image, title: nil, titleColor: nil)
    }
    
    func setRightButton(withTitle title: String, titleColor: UIColor) {
        configureRightButton(withNormal: nil, highlighted: nil, title: title, titleColor: titleColor)
    }
    
    /// 设置右侧按钮
    ///
    /// - Parameters:
    ///   - normal: 正常状态下图片
    ///   - highlighted: 高亮状态下图片
    ///   - title: 标题
    ///   - titleColor: 标题颜色
    func configureRightButton(withNormal normal: UIImage?,
                             highlighted: UIImage?,
                             title: String?,
                             titleColor: UIColor?) {
        rightButton.isHidden = false
        
        if let normal = normal {
            rightButton.setImage(normal, for: .normal)
        }
        if let highlighted = highlighted {
            rightButton.setImage(highlighted, for: .highlighted)
        }
        if let title = title {
            rightButton.setTitle(title, for: .normal)
        }
        if let titleColor = titleColor {
            rightButton.setTitleColor(titleColor, for: .normal)
        }
    }
}



