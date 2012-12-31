<%@ page import="vaadin.demo.Deportment" %>

<g:set var="entityName" value="${message(code: 'deportment.label', default: 'Deportment')}" />
<v:mainWindow caption="${message(code:'default.edit.label', args:[entityName])}"/>
<g:if test="${flash.message}">
	<v:warning>${flash.message}</v:warning>
</g:if>
<g:hasErrors bean="${deportmentInstance}">
	<v:error>
		<ul class="errors" role="alert">
			<g:eachError bean="${deportmentInstance}" var="error">
			<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
			</g:eachError>
		</ul>
	</v:error>
</g:hasErrors>
<v:layout name="main">
<v:location name="body">
	<div class="navigation toolbar" role="navigation">
		<v:horizontalLayout spacing="false">
			<v:link icon="images/skin/house.png" controller="home"><g:message code="default.home.label"/></v:link>
			<v:link icon="images/skin/database_table.png" action="list"><g:message code="default.list.label" args="[entityName]"/></v:link>
			<v:link icon="images/skin/database_add.png" action="create"><g:message code="default.new.label" args="[entityName]"/></v:link>
		</v:horizontalLayout>
	</div>
	<div id="edit-deportment" class="content scaffold-edit" role="main">
		<h1><g:message code="default.edit.label" args="[entityName]"/></h1>
		<div>
			<v:verticalLayout>
				<v:form var="editForm" bean="${deportmentInstance}" writeThrough="false" invalidCommitted="true">
					
					<v:field name="name"
						readOnly="false" required="false" requiredError="Please enter a Name" invalidCommitted="true"
						componentError="${deportmentInstance?.errors?.hasFieldErrors('name') ? message(error:deportmentInstance?.errors?.getFieldError('name'), args:[deportmentInstance]) : null}">
						<g:message code="deportment.name.label" default="Name"/>
					</v:field>
				</v:form>
			</v:verticalLayout>
		</div>
	</div>
	<div class="buttons toolbar">
		<v:horizontalLayout spacing="false">
			<v:link icon="images/skin/database_save.png" action="update" instance="${deportmentInstance}" onclick="${v.commit(form:'editForm')}"><g:message code="default.button.update.label"/></v:link>
			<v:link icon="images/skin/database_delete.png" action="delete" id="${deportmentInstance?.id}" onclick="${v.confirm(message:message(code: 'default.button.delete.confirm.message', default: 'Are you sure?'))}"><g:message code="default.button.delete.label"/></v:link>
		</v:horizontalLayout>
	</div>
</v:location>
</v:layout>
