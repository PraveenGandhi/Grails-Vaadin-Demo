<%@ page import="vaadin.demo.Employee" %>

<g:set var="entityName" value="${message(code: 'employee.label', default: 'Employee')}" />
<v:mainWindow caption="${message(code:'default.show.label', args:[entityName])}"/>
<g:if test="${flash.message}">
	<v:warning>${flash.message}</v:warning>
</g:if>
<g:hasErrors bean="${employeeInstance}">
	<v:error>
		<ul class="errors" role="alert">
			<g:eachError bean="${employeeInstance}" var="error">
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
	<div id="show-employee" class="content scaffold-show" role="main">
		<h1><g:message code="default.show.label" args="[entityName]"/></h1>
		<div>
			<v:verticalLayout>
				<v:form bean="${employeeInstance}" writeThrough="false" invalidCommitted="true">
					
					<g:if test="${employeeInstance?.dateOfJoin}">
					<v:date name="dateOfJoin" readOnly="true" resolution="day">
						<g:message code="employee.dateOfJoin.label" default="Date Of Join"/>
					</v:date>
					</g:if>
					<g:if test="${employeeInstance?.deportment}">
					<v:customField name="deportment" caption="${message(code:'employee.deportment.label', default:'Deportment')}">
						<v:link class="link" controller="deportment" action="show" id="${employeeInstance?.deportment.id}">${employeeInstance?.deportment?.encodeAsHTML()}</v:link>
					</v:customField>
					</g:if>
					<g:if test="${employeeInstance?.firstName}">
					<v:field name="firstName" readOnly="true">
						<g:message code="employee.firstName.label" default="First Name"/>
					</v:field>
					</g:if>
					<g:if test="${employeeInstance?.lastName}">
					<v:field name="lastName" readOnly="true">
						<g:message code="employee.lastName.label" default="Last Name"/>
					</v:field>
					</g:if>
					<g:if test="${employeeInstance?.salary}">
					<v:field name="salary" readOnly="true">
						<g:message code="employee.salary.label" default="Salary"/>
					</v:field>
					</g:if>
				</v:form>
			</v:verticalLayout>
		</div>
	</div>
	<div class="buttons toolbar">
		<v:horizontalLayout spacing="false">
			<v:link icon="images/skin/database_edit.png" action="edit" id="${employeeInstance?.id}"><g:message code="default.button.edit.label"/></v:link>
			<v:link icon="images/skin/database_delete.png" action="delete" id="${employeeInstance?.id}" onclick="${v.confirm(message:message(code: 'default.button.delete.confirm.message', default: 'Are you sure?'))}"><g:message code="default.button.delete.label"/></v:link>
		</v:horizontalLayout>
	</div>
</v:location>
</v:layout>
