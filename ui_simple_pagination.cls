public with sharing class ui_simple_pagination {

	private integer queryLimit {get;set;}
	private integer queryLimitHelper {get;set;}
	private integer queryOffset {get;set;}
	private integer querySize {get;set;}

	public Account[] lstAccount {get;set;}


	public ui_simple_pagination() {
		initialize();
		runQueries();
	}

	public void initialize() {
		//the query limit will end up being the amount of results displayed on our page at a time
		queryLimit = 10;
		queryLimitHelper = queryLimit + 1;

		//query offset tells us which result to start at when displaying our query.  
		//If it's 50, for example, it will start at the 50th result.
		queryOffset = 0;

		//set our default query Size to 0
		querySize = 0;
	}


	//run a simple query on the Account object to retrieve records and display them on the page
	public pageReference runQueries() {

		//this query looks ahead by 1 record to see if there will be additional records beyond the current page
		lstAccount = [select id, name from Account limit :queryLimitHelper offset :queryOffset];

		//remove the additional record from the list so it doesn't display to the user
		querySize = lstAccount.size();
		if(lstAccount.size() == queryLimitHelper) 
			lstAccount.remove(queryLimit);

		return null;
	}

	//actions for pagination
	public boolean getDisablePrevious() {
		return queryOffset - queryLimit < 0;
	}

	public boolean getDisableNext() {
		return querySize <= queryLimit;
	}

	public pageReference next() {
		queryOffset += queryLimit;
		runQueries();
		return null;
	}

	public pageReference previous() {
		queryOffset -= queryLimit;
		runQueries();
		return null;
	}
}