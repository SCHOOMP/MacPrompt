import Foundation

class FileManagerHelper {
    func createTextFile() {
        guard let downloadDirectroy = FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask).first else {
            print("Could not find Downloads directory")
            return
        }
        
        let filePath = downloadDirectroy.appendingPathComponent("test.txt").path
        
        if FileManager.default.createFile(atPath: filePath, contents: nil, attributes: nil) {
            
            print("File created successfully at: \(filePath)")
        } else {
            print("File not created.")
            print("Downloads directory: \(downloadDirectroy.path)")
            print("Attempted file path: \(filePath)")
        }
    }

}
