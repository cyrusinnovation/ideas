DONE
----
* Calculate cycle times for a list of stories.
* Show points completed in the past three weeks.
* Import from a CSV file.
* Show cumulative cycle times.
* Show throughput and cycle times per team.
* Load the cycle time page for 200 stories in less than 1/10 of a second.
* Track hours billed per story.
* Show hours/point statistics.
* Show hours/estimate group statistics.
* Import burn rate.
* Show unscaled hours/story by estimate group, rather than always scaling per point.
* "Outliers view" of stories with estimates or cycle times very different from the norm for their group.
* "Card view" of actual times for recently completed stories.
* "Dashboard" or "Information Radiator" view with a few key statistics.
* Show average cycle times per estimate group, and highlight outliers.
* Apply holidays when measuring throughput.
* Show a + in Hours Vs. Average when story is over average.
* Estimation view based on fixed time per point, rather than on past averages.
* Prefer recent stories in the estimation view.
* Show more than three stories in estimation view.
* Drop tracking of teams.

WIP
---
* Compact/printable estimation view.

TODO
----
* Keyword search in estimation view.
* Group stories into projects.
* Mark projects closed.
* Keep track of upcoming stories in a project.
* Export a project to Rabu.
* Show a detailed "kaizen" view of what happened over the past three weeks.
* Make throughput page faster when there is a long history. Paginate, maybe?

SOMEDAY/MAYBE
-------------
* Migrate to Postgres and deploy on Heroku.
* Have a way for a new user to start using Pointilist.
* Leave a comment summing up each completed story and how it went.
* Leave notes on particular days summing up how they went or why they were weird.
* Easily set started and finished dates for stories.
* Show statistics on groups of stories by tag.
* Import and export data in new standard format.
* Scroll to the right to see more stories in the estimation view.
* Flag stories that had long or short cycle times compared to hours worked.
* Track code quality metrics.
* Group averages by tags rather than estimates.
* Upgrade to Rails 3.
* Migrate to Rspec.
* Multiple projects.
* Export all data for a project.
* More flexible import.
* Track states other than started and finished.
* Estimation view based on cycle time, so that people don't have to enter hours.
* Option to turn off estimates and recording of hours worked.
* Show stories in a consistent order across different screens.
* Include stories without estimates in "Burn Rate" view (comparing against overall typical hours worked).