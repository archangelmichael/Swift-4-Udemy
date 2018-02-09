//
//  ViewController.swift
//  SwiftFileApp
//
//  Created by Radi Shikerov on 7.02.18.
//  Copyright © 2018 Radi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var wvFile: UIWebView!
    
    private let fullfilename = "sample.pdf";
    private var filename : String? {
        get {
            return fullfilename.components(separatedBy: ".").first
        }
    }
    
    private var filetype : String? {
        get {
            return fullfilename.components(separatedBy: ".").last
        }
    }
    
    private var localUrlPath : URL? {
        get {
            if let filepath = Bundle.main.path(forResource: filename, ofType: filetype) {
                let fileUrl = URL(fileURLWithPath: filepath)
                return fileUrl
            }
            
            return nil
        }
    }
    
    private var documentsPDFsUrlPath : URL? {
        get {
            if let filepath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                let fileUrl = (filepath.appendingPathComponent("PDFs"))
                return fileUrl
            }
            
            return nil
        }
    }
    
    private var documentsHiddenUrlPath : URL? {
        get {
            if let filepath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                let fileUrl = (filepath.appendingPathComponent("Hidden"))
                return fileUrl
            }
            
            return nil
        }
    }
    
    private func getDocumentsFileUrlPath(subdir: URL?) -> URL? {
        if let dirpath = subdir {
            let fileUrl = dirpath.appendingPathComponent(fullfilename)
            return fileUrl
        }
            
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.wvFile.delegate = self
    }
    
    @IBAction func onLoadLocalFile(_ sender: Any) {
        if let fileUrl = localUrlPath {
            let fileReq = URLRequest(url: fileUrl)
            self.wvFile.loadRequest(fileReq)
        }
        else {
            print("Invalid local file url")
        }
    }
    
    @IBAction func onStoreLocalfile(_ sender: Any) {
        if
            let dirPDFsUrl = documentsPDFsUrlPath,
            let filePDFUrl = getDocumentsFileUrlPath(subdir: dirPDFsUrl),
            let dirHiddenUrl = documentsHiddenUrlPath,
            let fileHiddenUrl = getDocumentsFileUrlPath(subdir: dirHiddenUrl),
            let fileData = getLocalFileData() {
            do {
                try FileManager.default.createDirectory(at: dirPDFsUrl, withIntermediateDirectories: true, attributes: nil)
                try fileData.write(to: filePDFUrl)
                print("File storing at PDFs completed")
                try FileManager.default.createDirectory(at: dirHiddenUrl, withIntermediateDirectories: true, attributes: nil)
                try fileData.write(to: fileHiddenUrl)
                print("File storing at Hidden completed")
            }
            catch let error {
                print("Error storing local file : \(error.localizedDescription)")
            }
        }
        else {
            print("Invalid local file url")
        }
    }
    
    @IBAction func onLoadStoredFile(_ sender: Any) {
        if let fileUrl = getDocumentsFileUrlPath(subdir: documentsPDFsUrlPath) {
            let fileReq = URLRequest(url: fileUrl)
            self.wvFile.loadRequest(fileReq)
        }
        else {
            print("Invalid local file url")
        }
    }
    
    @IBAction func onCheckForStoredFile(_ sender: Any) {
        if let hiddenDirPath = documentsHiddenUrlPath {
            let fileManager = FileManager.default
            var isDir : ObjCBool = false
            let fileExists = fileManager.fileExists(atPath: hiddenDirPath.path, isDirectory: &isDir)
            if fileExists {
                if isDir.boolValue {
                    print("Hidden dir exists")
                }
                else {
                    print("Hidden is not directory")
                }
            }
            else {
                print("File or dir does not exist")
            }
        }
    }
    
    @IBAction func onExcludeHiddenDir(_ sender: Any) {
        var hiddenDirPath = documentsHiddenUrlPath
        if hiddenDirPath != nil {
            let fileManager = FileManager.default
            var isDir : ObjCBool = false
            let fileExists = fileManager.fileExists(atPath: (hiddenDirPath?.path)!, isDirectory: &isDir)
            if fileExists {
                if isDir.boolValue {
                    print("Hidden dir exists")
                    do {
                        var resourceValues = URLResourceValues()
                        resourceValues.isExcludedFromBackup = true
                        resourceValues.isHidden = true
                        try hiddenDirPath?.setResourceValues(resourceValues)
                        print("\(hiddenDirPath!.lastPathComponent) is excluded from backup")
                    } catch let error as NSError {
                        print("Error excluding \(hiddenDirPath!.lastPathComponent) from backup \(error)");
                    }
                }
                else {
                    print("Hidden is not directory")
                }
            }
            else {
                print("File or dir does not exist")
            }
        }
    }
    
    private func getLocalFileData() -> Data? {
        do {
            if let fileUrl = localUrlPath {
                let fileData = try? Data.init(contentsOf: fileUrl)
                return fileData
            }
            
            print("Local file data error")
            return nil
        }
        catch let error {
            print("Local file load error : \(error.localizedDescription)")
            return nil
        }
    }
    
    private func getStoredFileData(path: URL) -> Data? {
        do {
            if let fileUrl = getDocumentsFileUrlPath(subdir: path) {
                let fileData = try? Data.init(contentsOf: fileUrl)
                return fileData
            }
            
            print("Stored file data error")
            return nil
        }
        catch let error {
            print("Stored file load error : \(error.localizedDescription)")
            return nil
        }
    }
}
extension ViewController : UIWebViewDelegate {
    func webViewDidFinishLoad(_ webView: UIWebView) {
        print("Content loaded")
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        print("Loading content failed \(error.localizedDescription)")
    }
}

