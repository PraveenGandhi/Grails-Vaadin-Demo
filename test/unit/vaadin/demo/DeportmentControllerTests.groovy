package vaadin.demo



import org.junit.*
import grails.test.mixin.*

@TestFor(DeportmentController)
@Mock(Deportment)
class DeportmentControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/deportment/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.deportmentInstanceList.size() == 0
        assert model.deportmentInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.deportmentInstance != null
    }

    void testSave() {
        controller.save()

        assert model.deportmentInstance != null
        assert view == '/deportment/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/deportment/show/1'
        assert controller.flash.message != null
        assert Deportment.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/deportment/list'

        populateValidParams(params)
        def deportment = new Deportment(params)

        assert deportment.save() != null

        params.id = deportment.id

        def model = controller.show()

        assert model.deportmentInstance == deportment
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/deportment/list'

        populateValidParams(params)
        def deportment = new Deportment(params)

        assert deportment.save() != null

        params.id = deportment.id

        def model = controller.edit()

        assert model.deportmentInstance == deportment
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/deportment/list'

        response.reset()

        populateValidParams(params)
        def deportment = new Deportment(params)

        assert deportment.save() != null

        // test invalid parameters in update
        params.id = deportment.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/deportment/edit"
        assert model.deportmentInstance != null

        deportment.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/deportment/show/$deportment.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        deportment.clearErrors()

        populateValidParams(params)
        params.id = deportment.id
        params.version = -1
        controller.update()

        assert view == "/deportment/edit"
        assert model.deportmentInstance != null
        assert model.deportmentInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/deportment/list'

        response.reset()

        populateValidParams(params)
        def deportment = new Deportment(params)

        assert deportment.save() != null
        assert Deportment.count() == 1

        params.id = deportment.id

        controller.delete()

        assert Deportment.count() == 0
        assert Deportment.get(deportment.id) == null
        assert response.redirectedUrl == '/deportment/list'
    }
}
