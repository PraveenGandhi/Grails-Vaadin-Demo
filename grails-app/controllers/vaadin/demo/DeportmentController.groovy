package vaadin.demo

import org.springframework.dao.DataIntegrityViolationException

class DeportmentController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [deportmentInstanceList: Deportment.list(params), deportmentInstanceTotal: Deportment.count()]
    }

    def create() {
        [deportmentInstance: new Deportment(params)]
    }

    def save() {
        def deportmentInstance = new Deportment(params)
        if (!deportmentInstance.save(flush: true)) {
            render(view: "create", model: [deportmentInstance: deportmentInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'deportment.label', default: 'Deportment'), deportmentInstance.id])
        redirect(action: "show", id: deportmentInstance.id)
    }

    def show(Long id) {
        def deportmentInstance = Deportment.get(id)
        if (!deportmentInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'deportment.label', default: 'Deportment'), id])
            redirect(action: "list")
            return
        }

        [deportmentInstance: deportmentInstance]
    }

    def edit(Long id) {
        def deportmentInstance = Deportment.get(id)
        if (!deportmentInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'deportment.label', default: 'Deportment'), id])
            redirect(action: "list")
            return
        }

        [deportmentInstance: deportmentInstance]
    }

    def update(Long id, Long version) {
        def deportmentInstance = Deportment.get(id)
        if (!deportmentInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'deportment.label', default: 'Deportment'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (deportmentInstance.version > version) {
                deportmentInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'deportment.label', default: 'Deportment')] as Object[],
                          "Another user has updated this Deportment while you were editing")
                render(view: "edit", model: [deportmentInstance: deportmentInstance])
                return
            }
        }

        deportmentInstance.properties = params

        if (!deportmentInstance.save(flush: true)) {
            render(view: "edit", model: [deportmentInstance: deportmentInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'deportment.label', default: 'Deportment'), deportmentInstance.id])
        redirect(action: "show", id: deportmentInstance.id)
    }

    def delete(Long id) {
        def deportmentInstance = Deportment.get(id)
        if (!deportmentInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'deportment.label', default: 'Deportment'), id])
            redirect(action: "list")
            return
        }

        try {
            deportmentInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'deportment.label', default: 'Deportment'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'deportment.label', default: 'Deportment'), id])
            redirect(action: "show", id: id)
        }
    }
}
