import Foundation

class FileManagerHelper {
    func createTextFile() {
        let filePath = NSHomeDirectory() + "/Desktop/" + "test.txt"
        if Foundation.FileManager.default.createFile(atPath: filePath, contents: nil, attributes: nil) {
            print("File created successfully.")
        } else {
            print("File not created.")
            let urls = Foundation.FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask)
            print(urls.first ?? "No desktop directory found")
        }
    }
}
