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

WIP
---

TODO
----
* "Dashboard" or "Information Radiator" view with a few key statistics.
* Apply holidays when measuring throughput.
* Show average cycle times per estimate group.
* Group stories into projects.
* Estimate the remaining work in a project.
* Show stories as outliers if their actual times ran closer to another estimate group.
* Show average cycle times, and highlight outliers.

SOMEDAY/MAYBE
-------------
* Estimation view based on fixed time per point, rather than on past averages.
* Compact estimation view.
* Estimation view based on cycle time.
* Migrate to Rspec.
* Adjust size of estimate example groups.
* Better measuring of cumulative cycle times when multiple stories start or end on the same day.
* Estimation view by team.
* Show mostly recent stories in estimation view, while still using long-term averages.
* Don't have overlapping average groups in estimate view. (i.e. 18 shouldn't count as both a 1/2 and a 1)
* Show a + in Hours Vs. Average when story is over average.
* Define additional estimate groups.
* "Work In Progress" view.
* Show average throughput.
* Manage teams.
* Generate cumulative flow diagrams.
* Make a much better date entry control, with an easy way to select today's date.
* Some sort of legitimate user authentication.
* Multiple users?
* Record today as started or finished date for a story in one click.
* Track states other than started and finished.
* Show me when I have enough data for a statistically significant sample.
* Flag stories that had long cycle times compared to hours worked.
* Flag stories that had exceptionally short cycle times to hours worked. (Yay! Efficiency!)
* Migrate to Postgres.
* Deploy on Heroku.
* Split Cycle Time and Lead Time views.
* Make a nicer printable version of the estimation reference story list.