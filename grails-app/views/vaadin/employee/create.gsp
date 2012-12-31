<%@ page import="vaadin.demo.Employee" %>

<g:set var="entityName" value="${message(code: 'employee.label', default: 'Employee')}" />
<v:mainWindow caption="${message(code:'default.create.label', args:[entityName])}"/>
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
		</v:horizontalLayout>
	</div>
	<div id="list" class="content scaffold-create" role="main">
		<h1><g:message code="default.create.label" args="[entityName]"/></h1>
		<div>
			<v:verticalLayout>
				<v:form var="createForm" bean="${employeeInstance}" writeThrough="false" invalidCommitted="true">
					
					<v:date name="dateOfJoin" resolution="day"
						readOnly="false" required="true" requiredError="Please enter a Date Of Join" invalidCommitted="true"
						componentError="${employeeInstance?.errors?.hasFieldErrors('dateOfJoin') ? message(error:employeeInstance?.errors?.getFieldError('dateOfJoin'), args:[employeeInstance]) : null}">
						<g:message code="employee.dateOfJoin.label" default="Date Of Join"/>
					</v:date>
					<v:select name="deportment" itemEquals="id" from="${vaadin.demo.Deportment.list()}" class="many-to-one"
						readOnly="false" required="true" requiredError="Please enter a Deportment" invalidCommitted="true"
						componentError="${employeeInstance?.errors?.hasFieldErrors('deportment') ? message(error:employeeInstance?.errors?.getFieldError('deportment'), args:[employeeInstance]) : null}">
						<g:message code="employee.deportment.label" default="Deportment"/>
					</v:select>
					<v:field name="firstName"
						readOnly="false" required="false" requiredError="Please enter a First Name" invalidCommitted="true"
						componentError="${employeeInstance?.errors?.hasFieldErrors('firstName') ? message(error:employeeInstance?.errors?.getFieldError('firstName'), args:[employeeInstance]) : null}">
						<g:message code="employee.firstName.label" default="First Name"/>
					</v:field>
					<v:field name="lastName"
						readOnly="false" required="false" requiredError="Please enter a Last Name" invalidCommitted="true"
						componentError="${employeeInstance?.errors?.hasFieldErrors('lastName') ? message(error:employeeInstance?.errors?.getFieldError('lastName'), args:[employeeInstance]) : null}">
						<g:message code="employee.lastName.label" default="Last Name"/>
					</v:field>
					<v:field name="salary"
						readOnly="false" required="true" requiredError="Please enter a Salary" invalidCommitted="true"
						componentError="${employeeInstance?.errors?.hasFieldErrors('salary') ? message(error:employeeInstance?.errors?.getFieldError('salary'), args:[employeeInstance]) : null}">
						<g:message code="employee.salary.label" default="Salary"/>
					</v:field>
				</v:form>
			</v:verticalLayout>
		</div>
	</div>
	<div class="buttons toolbar">
		<v:horizontalLayout spacing="false">
			<v:link icon="images/skin/database_add.png" action="save" instance="${employeeInstance}" onclick="${v.commit(form:'createForm')}"><g:message code="default.button.create.label"/></v:link>
		</v:horizontalLayout>
	</div>
</v:location>
</v:layout>
