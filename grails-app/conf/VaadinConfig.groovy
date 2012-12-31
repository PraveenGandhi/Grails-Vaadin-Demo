vaadin {

	//Your Vaadin application class that extends com.vaadin.Application:
	applicationClass = 'vaadin.demo.DemoApp'

	//the context relative path where you want to access your Vaadin UI.  Default to the context root.
	contextRelativePath = '/vaadin'

	productionMode = false

	googleAppEngineMode = false
}

environments {
	production {
		vaadin { productionMode = true }
	}
}
