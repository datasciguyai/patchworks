//
//  BlockController.swift
//  Patchworks
//
//  Created by Jeremy Reynolds on 12/15/17.
//  Copyright © 2017 Jeremy Reynolds. All rights reserved.
//

import CoreData

struct BlockController {
    
    static var blocks = [Block]()
        var mockBlocks: [Block] {
            let block1 = Block(blockView: BlockView(blockStyle: .basketWeave), previewImage: #imageLiteral(resourceName: "BasketWeave"))
            let block2 = Block(blockView: BlockView(blockStyle: .churnDash), previewImage: #imageLiteral(resourceName: "ChurnDash"))
            let block3 = Block(blockView: BlockView(blockStyle: .logCabin), previewImage: #imageLiteral(resourceName: "LogCabin"))
            return [block1, block2, block3]
        }
    
    
    
        init() {
            BlockController.blocks = mockBlocks
//            tasks = fetchTasks()
        }
    
//    func add(blockView: BlockView) {
//        guard let notes = notes, let due = due else { return }
//        tasks.append(Task(name: name, notes: notes, due: due))
//        saveToPersistentStore()
//        tasks = fetchTasks()
//    }
    
//    func update(blockView: BlockView) {
////        guard let taskIndex = tasks.index(of: task), let due = due else { return }
//        tasks[taskIndex].name = name
//        saveToPersistentStore()
//        blocks = fetchTasks()
//    }
    
//    func remove(task: Task) {
//        guard let taskIndex = tasks.index(of: task) else { return }
//        tasks.remove(at: taskIndex)
//        saveToPersistentStore()
//        tasks = fetchTasks()
//    }
    
    func saveToPersistentStore() {
        do {
            try CoreDataStack.context.save()
        } catch let error {
            print("There was a problem saving to the peristent store: \(error)")
        }
    }
    
    func fetchBlocks() -> [Block] {
        let request: NSFetchRequest<Block> = Block.fetchRequest()
        do {
            return try CoreDataStack.context.fetch(request)
        } catch let error {
            print("error \(error)")
        }
        return []
    }
}
