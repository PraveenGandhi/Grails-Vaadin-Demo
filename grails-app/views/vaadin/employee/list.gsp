<%@ page import="vaadin.demo.Employee" %>
<%@ page import="com.vaadin.data.util.BeanItemContainer" %>

<g:set var="entityName" value="${message(code: 'employee.label', default: 'Employee')}" />
<v:mainWindow caption="${message(code:'default.list.label', args:[entityName])}"/>
<g:if test="${flash.message}">
	<v:warning>${flash.message}</v:warning>
</g:if>
<v:layout name="main">
<v:location name="body">
	<div class="navigation toolbar" role="navigation">
		<v:horizontalLayout spacing="false">
			<v:link icon="images/skin/house.png" controller="home"><g:message code="default.home.label"/></v:link>
			<v:link icon="images/skin/database_add.png" action="create"><g:message code="default.new.label" args="[entityName]"/></v:link>
		</v:horizontalLayout>
	</div>
	<div id="list-employee" class="content scaffold-list" role="main">
		<h1><g:message code="default.list.label" args="[entityName]"/></h1>
		<div>
			<v:verticalLayout>
				<v:table pageLength="${Math.min(employeeInstanceTotal, 10)}" containerDataSource="${new BeanItemContainer(Employee.class, employeeInstanceList)}">
		        
					<v:column name="dateOfJoin" generator="${{item->v.createLink(action:'show', class:'link', id:item.getItemProperty('id'), caption:item.getItemProperty('dateOfJoin'))}}"><g:message code="employee.dateOfJoin.label" default="Date Of Join"/></v:column>
                
					<v:column name="deportment"><g:message code="employee.deportment.label" default="Deportment"/></v:column>
		        
					<v:column name="firstName"><g:message code="employee.firstName.label" default="First Name"/></v:column>
		        
					<v:column name="lastName"><g:message code="employee.lastName.label" default="Last Name"/></v:column>
		        
					<v:column name="salary"><g:message code="employee.salary.label" default="Salary"/></v:column>
		        
				</v:table>
			</v:verticalLayout>
		</div>
	</div>
</v:location>
</v:layout>