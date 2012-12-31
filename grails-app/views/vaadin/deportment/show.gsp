<%@ page import="vaadin.demo.Deportment" %>

<g:set var="entityName" value="${message(code: 'deportment.label', default: 'Deportment')}" />
<v:mainWindow caption="${message(code:'default.show.label', args:[entityName])}"/>
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
	<div id="show-deportment" class="content scaffold-show" role="main">
		<h1><g:message code="default.show.label" args="[entityName]"/></h1>
		<div>
			<v:verticalLayout>
				<v:form bean="${deportmentInstance}" writeThrough="false" invalidCommitted="true">
					
					<g:if test="${deportmentInstance?.name}">
					<v:field name="name" readOnly="true">
						<g:message code="deportment.name.label" default="Name"/>
					</v:field>
					</g:if>
				</v:form>
			</v:verticalLayout>
		</div>
	</div>
	<div class="buttons toolbar">
		<v:horizontalLayout spacing="false">
			<v:link icon="images/skin/database_edit.png" action="edit" id="${deportmentInstance?.id}"><g:message code="default.button.edit.label"/></v:link>
			<v:link icon="images/skin/database_delete.png" action="delete" id="${deportmentInstance?.id}" onclick="${v.confirm(message:message(code: 'default.button.delete.confirm.message', default: 'Are you sure?'))}"><g:message code="default.button.delete.label"/></v:link>
		</v:horizontalLayout>
	</div>
</v:location>
</v:layout>
