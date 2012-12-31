package vaadin.demo

import com.vaadin.ui.Window
import org.grails.plugin.vaadin.GrailsVaadinApplication

class DemoApp extends GrailsVaadinApplication {
    /**
     * Entry point for application
     */
    void init() {
        // CSS Styling
        setTheme("trans")
        
        // Attach top-level window
        this.mainWindow = new Window("Grails")
        this.mainWindow.content.setMargin(false)
    }
}
