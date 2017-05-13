//
//  ViewController.swift
//  Ex1Table
//
//  Created by Vladislav Maltsev on 01.01.17.
//  Copyright © 2017 Shedward. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var textField: NSTextField!
    @IBOutlet weak var voicesTableView: NSTableView!
    
    @IBOutlet weak var speakButton: NSButton!
    @IBOutlet weak var stopButton: NSButton!
    
    let speechSyntetiser = NSSpeechSynthesizer()
    
    let voices = VoicesDataSource()
    
    var isStarted: Bool = false {
        didSet {
            updateButtons()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        isStarted = false
        configureTableView()
        speechSyntetiser.delegate = self
    }
    
    let columns: [VoicesDataSource.TableColumn] = [.name, .language]
    
    func configureTableView() {
        for column in columns {
            let tableColumn = NSTableColumn(identifier: column.rawValue)
            tableColumn.title = column.rawValue
                
            voicesTableView.addTableColumn(tableColumn)
        }
        
        voicesTableView.dataSource = voices
        voicesTableView.reloadData()
    }
    
    func updateButtons() {
        guard isViewLoaded else { return }
        
        self.speakButton.isEnabled = !isStarted
        self.stopButton.isEnabled = isStarted
    }

    func selectedVoice() -> String? {
        guard voicesTableView.selectedRow > 0 else { return nil }
        return voices.voice(index: voicesTableView.selectedRow)
    }
    
    @IBAction func speakDidSpeak(_ sender: NSButton) {
        speechSyntetiser.setVoice(selectedVoice())
        isStarted = true
        speechSyntetiser.startSpeaking(textField.stringValue)
    }

    @IBAction func stopDidPressed(_ sender: NSButton) {
        speechSyntetiser.stopSpeaking()
    }
}

extension ViewController: NSSpeechSynthesizerDelegate {
    func speechSynthesizer(_ sender: NSSpeechSynthesizer, didFinishSpeaking finishedSpeaking: Bool) {
        isStarted = false
    }
}



