<%@ page import="vaadin.demo.Deportment" %>
<%@ page import="com.vaadin.data.util.BeanItemContainer" %>

<g:set var="entityName" value="${message(code: 'deportment.label', default: 'Deportment')}" />
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
	<div id="list-deportment" class="content scaffold-list" role="main">
		<h1><g:message code="default.list.label" args="[entityName]"/></h1>
		<div>
			<v:verticalLayout>
				<v:table sizeFull="true" pageLength="${Math.min(deportmentInstanceTotal, 10)}" containerDataSource="${new BeanItemContainer(Deportment.class, deportmentInstanceList)}">
		        
					<v:column name="name" generator="${{item->v.createLink(action:'show', class:'link', id:item.getItemProperty('id'), caption:item.getItemProperty('name'))}}"><g:message code="deportment.name.label" default="Name"/></v:column>
                
				</v:table>
			</v:verticalLayout>
		</div>
	</div>
</v:location>
</v:layout>