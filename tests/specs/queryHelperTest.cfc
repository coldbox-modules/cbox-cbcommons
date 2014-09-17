<!-----------------------------------------------------------------------
********************************************************************************
Copyright 2005-2007 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
www.coldbox.org | www.luismajano.com | www.ortussolutions.com
********************************************************************************

Author      :	Sana Ullah
Date        :	March 30 2008
Description :
	QueryHelper plugin test
----------------------------------------------------------------------->
<cfcomponent name="QueryHelperTest" extends="coldbox.system.testing.BaseModelTest" model="cbcommons.models.QueryHelper">

	<cffunction name="setUp" returntype="void" access="public" output="false">
		<cfscript>
		//Setup ColdBox Mappings For this Test
		/*setAppMapping("/coldbox/test-harness");
		setConfigMapping(ExpandPath(instance.AppMapping & "/config/Coldbox.cfc"));*/
		//Call the super setup method to setup the app.
		super.setup();
		</cfscript>

		<cfscript>
			variables.q1 = queryNew('idt,fname,lname,phone,location');
			variables.q2 = queryNew('idt,fname,lname,phone,location');
			variables.q3 = queryNew('idt,fname,lname,telephone,city');
		</cfscript>

		<cfloop from="1" to="10" index="i">
			<cfset queryAddRow(q1,1) />
			<cfset querySetCell(q1, 'idt', '#i#')>
			<cfset querySetCell(q1, 'fname', 'fname-q1-#chr(65 + i)#')>
			<cfset querySetCell(q1, 'lname', 'lname-q1-#chr(65 + i)#')>
			<cfset querySetCell(q1, 'phone', 'phone-q1-954-555-5555-#i#')>
			<cfset querySetCell(q1, 'location', 'location-q1-#chr(65 + i)#')>
		</cfloop>

		<cfloop from="11" to="20" index="i">
			<cfset queryAddRow(q2,1) />
			<cfset querySetCell(q2, 'idt', '#i#')>
			<cfset querySetCell(q2, 'fname', 'fname-q2-#chr(75 + i)#')>
			<cfset querySetCell(q2, 'lname', 'lname-q2-#chr(75 + i)#')>
			<cfset querySetCell(q2, 'phone', 'phone-q2-954-555-5555-#i#')>
			<cfset querySetCell(q2, 'location', 'location-q2-#chr(75 + i)#')>
		</cfloop>

		<cfloop from="6" to="15" index="i">
			<cfset queryAddRow(q3,1) />
			<cfset querySetCell(q3, 'idt', '#i#')>
			<cfset querySetCell(q3, 'fname', 'fname-q3-#chr(65 + i)#')>
			<cfset querySetCell(q3, 'lname', 'lname-q3-#chr(65 + i)#')>
			<cfset querySetCell(q3, 'telephone', 'phone-q3-954-555-5555-#i#')>
			<cfset querySetCell(q3, 'city', 'location-q3-#chr(65 + i)#')>
		</cfloop>
	</cffunction>

	<cffunction name="testmodel" access="public" returntype="void" output="false">
		<!--- Now test some events --->
		<cfscript>

			AssertTrue( isObject( model ) );
		</cfscript>
	</cffunction>

	<cffunction name="testMethods" access="public" returntype="void" output="false">
		<!--- Now test some events --->
		<cfscript>
			var jsonText = "{name:'luis',number:'23423'}";
			var local = structnew();

			assertTrue(isQuery(model.filterQuery(variables.q1, 'idt', '9', 'cf_sql_integer')), "Returned value is not query");

			assertTrue(isQuery(model.sortQuery(variables.q1, 'fname', 'DESC')), "Returned value is not query");

			assertTrue(isArray(model.getColumnArray(variables.q1, 'fname')), "Returned value is not Array");

			assertTrue(isValid('numeric',model.getCountDistinct(variables.q1, 'fname')), "Returned value is not number");

			assertTrue(isValid('numeric',model.getRowNumber(variables.q1, '8', 'idt')), "Returned value is not number");

			assertTrue(isValid('numeric',model.getRowNumber(variables.q3, '15', 'idt')), "Returned value is not number");

			assertTrue(isQuery(model.doInnerJoin(q1,q3,"idt","idt")), "Returned value is not query");

			assertTrue(isQuery(model.doLeftOuterJoin(q1,q3,"idt","idt")), "Returned value is not query");

			assertTrue(isQuery(model.doQueryAppend(q3,q1)), "Returned value is not query");

			assertTrue(isQuery(model.rotateQuery(q1)), "Returned value is not query");

			assertEquals(model.slugifyCol("Test Col Slug"),"test_col_slug", "Slugs did not match");

			var q = querySim("id,name
			1 | luis majano
			2 | jose majano");

			aResults = model.queryToArrayOfStructures( q );
			debug( aResults );
			assertTrue( isArray( aResults ) );
		</cfscript>
	</cffunction>

</cfcomponent>