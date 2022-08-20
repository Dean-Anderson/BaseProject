//
//  TestView.swift
//  BaseProject
//
//  Created by dean.anderson on 2022/08/20.
//

import SwiftUI

struct Grid: Identifiable {
    
    var id = UUID().uuidString
    var gridText: String
}

class GridViewModel: ObservableObject{
    @Published var gridItems = [
        Grid(gridText: "Grid 1"),
        Grid(gridText: "grid 2"),
        Grid(gridText: "grid 3"),
        Grid(gridText: "grid 4"),
        Grid(gridText: "grid 5"),
        Grid(gridText: "grid 6"),
        Grid(gridText: "grid 7"),
        Grid(gridText: "grid 8"),
        Grid(gridText: "grid 9"),
        Grid(gridText: "grid 10"),
        Grid(gridText: "grid 11"),
    ]

    var currentGrid: Grid?
}

struct DropViewDelegate: DropDelegate {
    
    var grid: Grid
    var gridData: GridViewModel
    
    init(grid: Grid, gridData: GridViewModel) {
        self.grid = grid
        self.gridData = gridData
        print("grid == \(grid.gridText)")
    }
    
    func performDrop(info: DropInfo) -> Bool {
        ///To never disappear drag item when dropped outside
        //gridData.currentGrid = nil
        print("performDrop")
        return true
    }
    
    func dropEntered(info: DropInfo) {
        print("dropEntered")
        let fromIndex = gridData.gridItems.firstIndex { (grid) -> Bool in
            return grid.id == gridData.currentGrid?.id
        } ?? 0
        
        let toIndex = gridData.gridItems.firstIndex { (grid) -> Bool in
            return grid.id == self.grid.id
        } ?? 0
        
        if fromIndex != toIndex{
            withAnimation(.default){
                let fromGrid = gridData.gridItems[fromIndex]
                gridData.gridItems[fromIndex] = gridData.gridItems[toIndex]
                gridData.gridItems[toIndex] = fromGrid
            }
        }
    }
    
    // setting Action as Move...
    func dropUpdated(info: DropInfo) -> DropProposal? {
        print("dropUpdated")
        return DropProposal(operation: .move)
    }
}

struct TestView: View {
    
    @StateObject var gridData = GridViewModel()
    
    let columns = Array(repeating: GridItem(.flexible(), spacing: 10), count: 2)
    
    var body: some View {
        VStack{
            ScrollView{
                LazyVGrid(columns: columns,spacing: 20, content: {
                    ForEach(gridData.gridItems){ grid in
                        ZStack {
                            Color.secondary
                            Text(grid.gridText)
                        }
                            .frame(height: 150)
                            .cornerRadius(15)
                            .onDrag({
                                gridData.currentGrid = grid
                                return NSItemProvider(object: String(grid.gridText) as NSString)
                            })
                            .onDrop(of: [.text], delegate: DropViewDelegate(grid: grid, gridData: gridData))
                    }
                })
                .padding()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.ignoresSafeArea(.all, edges: .all))
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
