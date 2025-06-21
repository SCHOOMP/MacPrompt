import AppKit

class StatusBarManager {
    var statusItem: NSStatusItem?
    
    func updateDisplay(isAwake: Bool, endTime: Date?) {
        guard let button = statusItem?.button else { return }
        
        let iconName = isAwake ? "cup.and.saucer" : "cup.and.saucer.fill"
        let icon = NSImage(systemSymbolName: iconName, accessibilityDescription: isAwake ? "Stay Awake Active" : "Sleep Enabled")
        
        if isAwake {
            if let endTime = endTime {
                // Timed mode - show countdown
                let timeRemaining = endTime.timeIntervalSinceNow
                if timeRemaining > 0 {
                    let timeString = formatTimeRemaining(timeRemaining)
                    
                    // Create attributed string with icon and time
                    let attributedString = NSMutableAttributedString()
                    
                    // Add icon
                    let iconAttachment = NSTextAttachment()
                    iconAttachment.image = icon
                    if let image = iconAttachment.image {
                        iconAttachment.bounds = CGRect(x: 0, y: -2, width: image.size.width, height: image.size.height)
                    }
                    attributedString.append(NSAttributedString(attachment: iconAttachment))
                    
                    // Add space and time
                    attributedString.append(NSAttributedString(string: " \(timeString)"))
                    
                    button.attributedTitle = attributedString
                    button.image = nil
                    button.imagePosition = .noImage
                }
            } else {
                // Indefinite mode - show infinity symbol
                let attributedString = NSMutableAttributedString()
                
                let iconAttachment = NSTextAttachment()
                iconAttachment.image = icon
                if let image = iconAttachment.image {
                    iconAttachment.bounds = CGRect(x: 0, y: -2, width: image.size.width, height: image.size.height)
                }
                attributedString.append(NSAttributedString(attachment: iconAttachment))
                
                // Add space and infinity symbol
                attributedString.append(NSAttributedString(string: " ∞"))
                
                button.attributedTitle = attributedString
                button.image = nil
                button.imagePosition = .noImage
            }
        } else {
            // Not awake - just show icon
            button.image = icon
            button.attributedTitle = NSAttributedString(string: "")
            button.imagePosition = .imageOnly
        }
    }
    
    private func formatTimeRemaining(_ timeRemaining: TimeInterval) -> String {
        let totalSeconds = Int(timeRemaining)
        let hours = totalSeconds / 3600
        let minutes = (totalSeconds % 3600) / 60
        let seconds = totalSeconds % 60
        
        if hours > 0 {
            return String(format: "%d:%02d:%02d", hours, minutes, seconds)
        } else {
            return String(format: "%d:%02d", minutes, seconds)
        }
    }
}
