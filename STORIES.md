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

WIP
---

TODO
----
* Easily set started and finished dates for stories.
* Import and export data in new standard format.
* Make throughput page faster when there is a long history. Paginate, maybe?
* Scroll to the right to see more stories in the estimation view.

PRODUCTIZATION
--------------
* Migrate to Postgres.
* Deploy on Heroku.
* Show something useful (and don't bomb) for new projects without any stories defined.
* Multiple users.
* The website should show something to people who aren't logged in, to convince them to join.

SOMEDAY/MAYBE
-------------
* Estimate the remaining work in a tag, or set of tags.
* Drop tracking of teams.
* Some sort of kaizen view? Or just in general reorganize along kaizen-y lines?
* Make a nicer printable version of the estimation reference story list.
* "Work In Progress" view.
* Show statistics on groups of stories by tag.
* Flag stories that had long or short cycle times compared to hours worked.
* Leave a comment summing up each completed story and how it went.
* Track code quality metrics.
* Group averages by tags rather than estimates.
* Show me when I have enough data for a statistically significant sample.
* Reorder upcoming stories.
* Compact estimation view.
* Upgrade to Rails 3.
* Migrate to Rspec.
* Introduce end-to-end testing.
* Multiple projects.
* Export all data for a project.
* More flexible import.
* Track states other than started and finished.
* Estimation view based on cycle time, so that people don't have to enter hours.
* Option to turn off estimates and recording of hours worked.
* Show wider margin of error for averages with fewer data points.
* Show stories in a consistent order across different screens.
* Include stories without estimates in "Burn Rate" view (comparing against overall typical hours worked).