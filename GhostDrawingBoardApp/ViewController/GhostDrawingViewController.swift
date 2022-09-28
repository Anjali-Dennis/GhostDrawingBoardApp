//
//  GhostDrawingViewController.swift
//  GhostDrawingBoardApp
//
//  Created by Anjali Dennis on 2022-09-25.
//

import UIKit
import PencilKit

class GhostDrawingViewController: UIViewController {
    
    // MARK: Instance Variables
    
    @IBOutlet weak var drawingCanvasView: PKGhostCanvas!
    @IBOutlet weak var colorButtonsStackView: UIStackView!
    @IBOutlet weak var drawingToolButton: UIButton!
    @IBOutlet weak var eraserToolButton: UIButton!
    
    var eraserTool = PKEraserTool(.bitmap)
    let defaultDrawingTool = PKInkingTool(.pen, color: .white, width: 30)
    var drawingTool: PKInkingTool!

    let delegate = PKGhostCanvas()
    
    // MARK: Lifecylce Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupCanvasView()
        self.setupColorButttons()
    }
    
    func setupCanvasView() {
        self.drawingCanvasView.delegate = self.delegate
        self.drawingCanvasView.drawing = PKDrawing()
        self.drawingTool = self.defaultDrawingTool
        self.drawingCanvasView.alwaysBounceVertical = false
        self.drawingCanvasView.drawingPolicy = .anyInput
        self.drawingCanvasView.tool = self.drawingTool
        self.drawingCanvasView.becomeFirstResponder()
        self.drawingToolButton.isSelected = true
    }
    
    override func viewDidLayoutSubviews() {
        for button in self.colorButtonsStackView.arrangedSubviews
        {
            button.layer.borderWidth = 1.0
            button.layer.borderColor = UIColor.black.cgColor
            button.layer.cornerRadius = (button.frame.size.width)/2.0
        }
        self.view.setNeedsLayout()
    }
    
    @IBAction func eraserToolEnabled(_ sender: UIButton) {
        self.drawingCanvasView.tool = self.eraserTool
        sender.isSelected = true
        if self.drawingToolButton.isSelected {
            self.drawingToolButton.isSelected.toggle()
        }
    }
    
    @IBAction func drawingToolEnabled(_ sender: UIButton) {
        self.drawingCanvasView.tool = self.drawingTool
        sender.isSelected = true
        if self.eraserToolButton.isSelected {
            self.eraserToolButton.isSelected.toggle()
        }
    }
    
    
    @objc func updatePens(sender: Any?) {
        if let colorButton = sender as? UIButton,
           let selectedColor = Colors(rawValue: colorButton.tag)?.getColor() {
            self.delegate.currentSelectedColor = selectedColor
            if let _ = self.drawingCanvasView.tool as? PKInkingTool {
                self.drawingCanvasView.tool = self.defaultDrawingTool
            }
        }
    }
    
    
    func setupColorButttons () {
        for button in self.colorButtonsStackView.arrangedSubviews
        {
            let colorButton: UIButton = button as! UIButton
            if colorButton.tag == 1
            {
                colorButton.isSelected = true
            }
            colorButton.addTarget(self, action: #selector(updatePens(sender:)), for: .touchUpInside)
        }
    }
    
    
    @IBAction func eraserTypeSelected(_ sender: Any) {
        let eraserTypeSegmentedContol = sender as! UISegmentedControl
        switch eraserTypeSegmentedContol.selectedSegmentIndex
        {
        case 0:
            self.eraserTool.eraserType = .bitmap
        case 1:
            self.eraserTool.eraserType = .vector
        default:
            break
        }
        
        if let _ = self.drawingCanvasView.tool as? PKEraserTool {
            self.drawingCanvasView.tool = self.eraserTool
        }
        
    }
}

