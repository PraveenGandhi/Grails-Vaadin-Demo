package vaadin.demo

class Employee {

	String firstName
	String lastName
	Date dateOfJoin
	double salary
	Deportment deportment
	List<Email> emails=new ArrayList<Email>()
	static hasMany = {emails:Email}
	static constraints = { emails cascade:"all-delete-orphan" }
}
