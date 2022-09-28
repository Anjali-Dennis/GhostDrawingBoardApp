//
//  PKGhostCanvas.swift
//  GhostDrawingBoardApp
//
//  Created by Anjali Dennis on 2022-09-26.
//

import Foundation
import PencilKit

class PKGhostCanvas: PKCanvasView {
    var drawingData: Data!
    var currentSelectedColor = UIColor.red
    var didEndUsingDrawingTool = false
    var didEndUsingEraserTool = false
}

extension PKGhostCanvas: PKCanvasViewDelegate {
    
    // MARK: - PKCanvasViewDelegate
    
    func canvasViewDidBeginUsingTool(_ canvasView: PKCanvasView) {
        print("canvasViewDidBeginUsingTool")
    }
    
    func canvasViewDidEndUsingTool(_ canvasView: PKCanvasView) {
        print("canvasViewDidEndUsingTool")
        
        if let _ = canvasView.tool as? PKInkingTool {
            self.didEndUsingDrawingTool = true
        }
        else {
            self.didEndUsingEraserTool = true
        }
        
    }
    
    func canvasViewDidFinishRendering(_ canvasView: PKCanvasView) {
        print("canvasViewDidFinishRendering")
    }
    
    func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
        print("canvasViewDrawingDidChange")
        if didEndUsingDrawingTool {
            didEndUsingDrawingTool = false
            self.saveGhostDrawing(canvasView)
            self.renderDrawing(canvasView)
        }
        if didEndUsingEraserTool {
            self.didEndUsingEraserTool = false
        }
    }
}


extension PKGhostCanvas {
    func saveGhostDrawing(_ canvasView: PKCanvasView) {
        self.drawingData = nil
        self.drawingData = canvasView.drawing.dataRepresentation()
    }
    
    func renderDrawing(_ canvasView: PKCanvasView) {
        do {
            if let _ =  self.drawingData {
                
                let testDrawing = try PKDrawing.init(data: self.drawingData)
                
                var newDrawingStrokes: [PKStroke] = []
                for stroke in testDrawing.strokes {
                    let strokeColor = stroke.ink.color
                    var newPoints: [PKStrokePoint] = []
                    stroke.path.forEach { (point) in
                        let newPoint = PKStrokePoint(
                            location: point.location,
                            timeOffset: point.timeOffset,
                            size: point.size,
                            opacity: point.opacity,
                            force: point.force,
                            azimuth: point.azimuth,
                            altitude: point.altitude
                        )
                        newPoints.append(newPoint)
                    }
                    
                    let newPath = PKStrokePath(controlPoints: newPoints, creationDate: Date())
                    let whiteColorForComparision = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
                    newDrawingStrokes.append(PKStroke(ink: PKInk(.pen, color: strokeColor == whiteColorForComparision ? self.currentSelectedColor : strokeColor), path: newPath))
                }
                let newDrawing = PKDrawing(strokes: newDrawingStrokes)
                
                let delay = setGhostDelay()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                    canvasView.drawing = newDrawing
                    canvasView.tool = PKInkingTool(.pen, color: .white, width: 30)
                }
            }
        }
        catch {
            print(error)
        }
    }
    
    func setGhostDelay() -> Double {
        switch(self.currentSelectedColor) {
        case UIColor(red: 1, green: 0, blue: 0, alpha: 1):
            return 1.0
        case UIColor(red: 0, green: 1, blue: 0, alpha: 1):
            return 5.0
        case UIColor(red: 0, green: 0, blue: 1, alpha: 1):
            return 3.0
        default:
            return 2.0
        }
    }
}
