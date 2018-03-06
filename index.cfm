<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>Random Order Generator</title>
		<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
		<style>
			.list-group-item {display: list-item;}
		</style>
	</head>
	<body>
		<cftry>
			<cfparam name="form.teams" default="">
			<cfset teams = []>
			<cfset teamsEntered = len(trim(form.teams))>
			<cfif teamsEntered>
				<cfloop list="#form.teams#" delimiters="#chr(13)#" index="team">
					<cfif len(trim(team))>
						<cfset arrayAppend(teams, team)>
					</cfif>
				</cfloop>
				<cfset teamCount = arrayLen(teams)>
				<cfset createObject("java", "java.util.Collections").Shuffle(teams)>
			</cfif>
			<cfoutput>
				<div class="container">
					<div class="panel panel-default">
						<cfif teamsEntered>
							<h1 class="panel-heading">You entered #teamCount# items. Here is your randomly ordered list.</h1>
							<h5 class="panel-heading">Have another list? <a href=".">Start over</a></h5>
							<ol>
								<cfloop array="#teams#" index="team"><li>#trim(team)#</li></cfloop>
							</ol>
						<cfelse>
							<h1 class="panel-heading">Enter a list to generate a random order</h1>
							<div class="panel-body">
								<form method="post">
									<div class="form-group">
										<label for="teams">Items</label>
										<textarea id="teams" name="teams" placeholder="Enter items separated by a line break" rows="5" class="form-control">#arrayToList(teams, chr(13))#</textarea>
									</div>
									<button type="submit" class="btn btn-default">Submit</button>
								</form>
							</div>
						</cfif>
					</div>
				</div>
			</cfoutput>
			<cfcatch>
				<cfmail to="" from="" subject="Error on Random/index.cfm" type="html">
					There was a problem
					#cfcatch#
				</cfmail>
			</cfcatch>
		</cftry>
	</body>
</html>
