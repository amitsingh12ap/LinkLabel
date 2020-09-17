//
//  ClickableLabel.swift
//  LinkLabel
//
//  Created by 13216146 on 17/09/20.
//  Copyright © 2020 13216146. All rights reserved.
//

import UIKit
protocol ClickableLableProtocol: class {
    func handleTap(_ urlString: String)
}
protocol ClickableLabelInfoProtocol {
    var fullText:String {get set}
    var clickableText:String {get set}
    var urlString: String {get set}
    
    var linkColor: UIColor {get set}
    var fullTextColor: UIColor {get set}
    
}
class ClickableLabel: UILabel {
    weak var delegate: ClickableLableProtocol?
    private var clicableTxt:String?
    private var fullText:String?
    private var urlString: String?
    
    func configureLable(with labelInfo: ClickableLabelInfoProtocol, withFont font: UIFont) {
        let formattedText = self.format(strings: [labelInfo.clickableText],
                                            boldFont: font,
                                            boldColor: labelInfo.linkColor,
                                            inString: labelInfo.fullText,
                                            font: font,
                                            color: self.textColor)
        self.attributedText = formattedText
        self.fullText = labelInfo.fullText
        self.clicableTxt = labelInfo.clickableText
        self.urlString = labelInfo.urlString
        self.addClickableEvent()
    }
}
extension ClickableLabel {
    private func addClickableEvent() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTermTapped))
        self.addGestureRecognizer(tap)
        self.isUserInteractionEnabled = true
    }
    
    @objc private func handleTermTapped(gesture: UITapGestureRecognizer) {
        if let termsTxt = fullText, let term = clicableTxt {
            let termString = termsTxt as NSString
            let termRange = termString.range(of: term)
            
            
            let tapLocation = gesture.location(in: self)
            let index = self.indexOfAttributedTextCharacterAtPoint(point: tapLocation)
            
            if checkRange(termRange, contain: index) == true {
                self.delegate?.handleTap(self.urlString ?? "")
                return
            }
            
        }
    }
    
    private func checkRange(_ range: NSRange, contain index: Int) -> Bool {
        return index > range.location && index < range.location + range.length
    }
    
    private func indexOfAttributedTextCharacterAtPoint(point: CGPoint) -> Int {
           assert(self.attributedText != nil, "This method is developed for attributed string")
           let textStorage = NSTextStorage(attributedString: self.attributedText!)
           let layoutManager = NSLayoutManager()
           textStorage.addLayoutManager(layoutManager)
           let textContainer = NSTextContainer(size: self.frame.size)
           textContainer.lineFragmentPadding = 0
           textContainer.maximumNumberOfLines = self.numberOfLines
           textContainer.lineBreakMode = self.lineBreakMode
           layoutManager.addTextContainer(textContainer)

           let index = layoutManager.characterIndex(for: point, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
           return index
       }
    private func format(strings: [String],
                    boldFont: UIFont = UIFont.boldSystemFont(ofSize: 8),
                    boldColor: UIColor,
                    inString string: String,
                    font: UIFont = UIFont.systemFont(ofSize: 8),
                    color: UIColor) -> NSAttributedString {
        let attributedString =
            NSMutableAttributedString(string: string,
                                    attributes: [
                                        NSAttributedString.Key.font: font,
                                        NSAttributedString.Key.foregroundColor: color])
        let boldFontAttribute = [NSAttributedString.Key.font: boldFont, NSAttributedString.Key.foregroundColor: boldColor]
        for bold in strings {
            attributedString.addAttributes(boldFontAttribute, range: (string as NSString).range(of: bold))
        }
        return attributedString
    }
}

