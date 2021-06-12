# Shyftplan Domain Case Study

Case Study for Shyftplan interview process. It has been done as an API.

## Versions
* Ruby version
2.6.3

* Rails version
6.0.3

## Run tests and linters

```shell
  bundle exec rspec
  bundle exec rubocop
```

## Routes
### GET
* /companies - Get a list of all companies
* /companies_without_required_employees - Get a list of all companies where the amount of employees is less than required
* /companies/:id - Get a specific company
* /employees/:id - Get an specific employee

### POST
* /companies - Add a company
* /employees - Add an employee
### PUT/PATCH
* /companies/:id - Edit a company
* /employees/:id - Edit an employee

### DELETE
* /companies/:id - Delete a company
* /employees/:id - Delete an employee


For the body of the requests, it is necessary to explicit the model, as in:

```json
{
 "company":
 	{
		"area_of_practice": "country",
		"required_employees_amount": 12,
		"parent_company_id": "c419cebb-eb82-4742-84de-7c52d7070f1a"
	}
}
```

It is important to note that all ids are UUIDs