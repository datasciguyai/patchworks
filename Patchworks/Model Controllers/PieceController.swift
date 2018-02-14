//
//  PieceController.swift
//  Patchworks
//
//  Created by Jeremy Reynolds on 1/3/18.
//  Copyright © 2018 Jeremiah Reynolds. All rights reserved.
//

import CoreData

class PieceController {
    
    static let shared = PieceController()
    
    // MARK: - C.R.U.D.
    
    // MARK: - Create
    
    func createPieceWith(pieceImageData: Data? = nil, rawRect: String, rotationAngle: Float, shape: Int16, block: Block) {
        
        guard let pieceImagesDirectoryURL = pieceImagesDirectoryURL else { return }
        
        let imageFileName = "\(UUID().uuidString).jpeg"
        
        try? pieceImageData?.write(to: pieceImagesDirectoryURL.appendingPathComponent(imageFileName))
        
        Piece(rawRect: rawRect, rotationAngle: rotationAngle, imageFileName: imageFileName, shape: shape, block: block)
        
    }
    
    // MARK: - Retrieve
    
    // MARK: - Update
    
    func update(piece: Piece, imageData: Data?) {
        guard let imageData = imageData else {
            if let fileName = piece.imageFileName {
                deletePieceImage(fileName: fileName)
                piece.imageFileName = nil
            }
            return
        }
        
        guard let pieceImagesDirectoryURL = pieceImagesDirectoryURL else { return }
        
        if piece.imageFileName == nil {
            piece.imageFileName = "\(UUID().uuidString).jpeg"
        }
        
        guard let fileName = piece.imageFileName else { return }
        
            try? imageData.write(to: pieceImagesDirectoryURL.appendingPathComponent(fileName))
    }
    
    func deletePieceImage(fileName: String) {
        guard let pieceImagesDirectoryURL = pieceImagesDirectoryURL else { return }
        try? FileManager.default.removeItem(at: pieceImagesDirectoryURL.appendingPathComponent(fileName))
    }
    
    // MARK: - Delete
    
    //    func deletePiece() {
    //        Future use
    //    }
    
    var pieceImagesDirectoryURL: URL? {
        guard let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        let pieceImagesDirectoryURL = documentsDirectoryURL.appendingPathComponent("PieceImages", isDirectory: true)
        
        var objcBool: ObjCBool = true
        let directoryExists = FileManager.default.fileExists(atPath: pieceImagesDirectoryURL.path, isDirectory: &objcBool)
        if !directoryExists {
            do {
                try FileManager.default.createDirectory(atPath: pieceImagesDirectoryURL.path, withIntermediateDirectories: false, attributes: nil)
            } catch {
                print(error)
            }
        }
        return pieceImagesDirectoryURL
    }
}
