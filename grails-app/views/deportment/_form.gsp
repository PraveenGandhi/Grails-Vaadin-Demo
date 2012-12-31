<%@ page import="vaadin.demo.Deportment" %>



<div class="fieldcontain ${hasErrors(bean: deportmentInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="deportment.name.label" default="Name" />
		
	</label>
	<g:textField name="name" value="${deportmentInstance?.name}"/>
</div>

