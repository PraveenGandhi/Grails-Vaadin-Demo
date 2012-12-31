package vaadin.demo

import org.springframework.dao.DataIntegrityViolationException

class DeportmentVaadinController {
    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        [deportmentInstanceList: Deportment.list(params), deportmentInstanceTotal: Deportment.count()]
    }

    def create() {
        [deportmentInstance: new Deportment(params)]
    }

    def save() {
        def deportmentInstance = params.instance
        if (! (deportmentInstance instanceof Deportment)) {
            redirect(action:"create")
            return
        }

        if (!deportmentInstance.save(flush: true)) {
            render(view: "create", model: [deportmentInstance: deportmentInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'deportment.label', default: 'Deportment'), deportmentInstance.id])
        redirect(action: "show", id: deportmentInstance.id)
    }

    def show() {
        def deportmentInstance = Deportment.get(params.id)
        if (!deportmentInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'deportment.label', default: 'Deportment'), params.id])
            redirect(action: "list")
            return
        }

        [deportmentInstance: deportmentInstance]
    }

    def edit() {
        def deportmentInstance = Deportment.get(params.id)
        if (!deportmentInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'deportment.label', default: 'Deportment'), params.id])
            redirect(action: "list")
            return
        }

        [deportmentInstance: deportmentInstance]
    }

    def update() {
        if (! (params.instance instanceof Deportment)) {
            redirect(action:"show", params:params)
            return
        }
        
        // Attempt to merge Deportment instance into new persistence context
        def mergedAndValidated = params.instance.merge()
        if (!mergedAndValidated) {
            render(view: "edit", model: [deportmentInstance: params.instance])
            return
        }
        params.instance = mergedAndValidated
        
        def deportmentInstance = Deportment.get(params.instance.id)
        if (!deportmentInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'deportment.label', default: 'Deportment'), params.instance.id])
            redirect(action: "list")
            return
        }

        if (deportmentInstance.version > params.instance.version) {
            deportmentInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                      [message(code: 'deportment.label', default: 'Deportment')] as Object[],
                      "Another user has updated this Deportment while you were editing")
            render(view: "edit", model: [deportmentInstance: deportmentInstance])
            return
        }

        deportmentInstance.properties = params.instance.properties

        if (!deportmentInstance.save(flush: true)) {
            render(view: "edit", model: [deportmentInstance: deportmentInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'deportment.label', default: 'Deportment'), deportmentInstance.id])
        redirect(action: "show", id: deportmentInstance.id)
    }

    def delete() {
        def deportmentInstance = Deportment.get(params.id)
        if (!deportmentInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'deportment.label', default: 'Deportment'), params.id])
            redirect(action: "list")
            return
        }

        try {
            deportmentInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'deportment.label', default: 'Deportment'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'deportment.label', default: 'Deportment'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
}
