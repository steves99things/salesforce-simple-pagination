@isTest
private class test_ui_simple_pagination {

	
	
	@isTest static void test_method_one() {

		Account[] lstAcc = new Account[]{};

		for(integer i = 0; i < 200; i++) {
			//you'll need to make sure to include all required fields for your org here.  By default, only name is required
			Account objAcc = new Account(
				name = 'Big Bob Building Company '+i
			);
			lstAcc.add(objAcc);
		}
		insert lstAcc;

		//make sure the accounts inserted
		Account[] assertLstAcc = [select id from Account where id in: lstAcc];
		system.assertEquals(lstAcc.size(),assertLstAcc.size());
		ui_simple_pagination testCon = new ui_simple_pagination();

		//run the queries to select the records
		testCon.runQueries();

		testCon.getDisablePrevious();
		//disable previous should be true with our data set
		system.assert(testCon.getDisablePrevious());
		
		testCon.getDisableNext();
		//disable next should be false with our data set
		system.assert(!testCon.getDisableNext());
		
		testCon.next();

		testCon.getDisablePrevious();
		//disable previous should be false with our dataset
		system.assert(!testCon.getDisablePrevious());
		testCon.previous();
	}

	//initialize with a smaller list of accounts to test disable next functionality
	@isTest static void test_method_two() {
		Account[] lstAcc = new Account[]{};
		for(integer i = 0; i < 1; i++) {
			Account objAcc = new Account(
				name = 'Big Bob Building Company '+i
			);
			lstAcc.add(objAcc);
		}
		insert lstAcc;

		//make sure the accounts inserted
		Account[] assertLstAcc = [select id from Account where id in: lstAcc];
		system.assertEquals(lstAcc.size(),assertLstAcc.size());
		ui_simple_pagination testCon = new ui_simple_pagination();

		//run the queries to select the records
		testCon.runQueries();

		testCon.getDisableNext();
		system.assert(testCon.getDisableNext());
	}
		
	
}