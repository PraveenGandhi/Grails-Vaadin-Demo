package vaadin.demo

import org.springframework.dao.DataIntegrityViolationException

class EmployeeVaadinController {
    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        [employeeInstanceList: Employee.list(params), employeeInstanceTotal: Employee.count()]
    }

    def create() {
        [employeeInstance: new Employee(params)]
    }

    def save() {
        def employeeInstance = params.instance
        if (! (employeeInstance instanceof Employee)) {
            redirect(action:"create")
            return
        }

        if (!employeeInstance.save(flush: true)) {
            render(view: "create", model: [employeeInstance: employeeInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'employee.label', default: 'Employee'), employeeInstance.id])
        redirect(action: "show", id: employeeInstance.id)
    }

    def show() {
        def employeeInstance = Employee.get(params.id)
        if (!employeeInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'employee.label', default: 'Employee'), params.id])
            redirect(action: "list")
            return
        }

        [employeeInstance: employeeInstance]
    }

    def edit() {
        def employeeInstance = Employee.get(params.id)
        if (!employeeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'employee.label', default: 'Employee'), params.id])
            redirect(action: "list")
            return
        }

        [employeeInstance: employeeInstance]
    }

    def update() {
        if (! (params.instance instanceof Employee)) {
            redirect(action:"show", params:params)
            return
        }
        
        // Attempt to merge Employee instance into new persistence context
        def mergedAndValidated = params.instance.merge()
        if (!mergedAndValidated) {
            render(view: "edit", model: [employeeInstance: params.instance])
            return
        }
        params.instance = mergedAndValidated
        
        def employeeInstance = Employee.get(params.instance.id)
        if (!employeeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'employee.label', default: 'Employee'), params.instance.id])
            redirect(action: "list")
            return
        }

        if (employeeInstance.version > params.instance.version) {
            employeeInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                      [message(code: 'employee.label', default: 'Employee')] as Object[],
                      "Another user has updated this Employee while you were editing")
            render(view: "edit", model: [employeeInstance: employeeInstance])
            return
        }

        employeeInstance.properties = params.instance.properties

        if (!employeeInstance.save(flush: true)) {
            render(view: "edit", model: [employeeInstance: employeeInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'employee.label', default: 'Employee'), employeeInstance.id])
        redirect(action: "show", id: employeeInstance.id)
    }

    def delete() {
        def employeeInstance = Employee.get(params.id)
        if (!employeeInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'employee.label', default: 'Employee'), params.id])
            redirect(action: "list")
            return
        }

        try {
            employeeInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'employee.label', default: 'Employee'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'employee.label', default: 'Employee'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
}
