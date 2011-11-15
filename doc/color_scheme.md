Throughout Ideas, I've tried to coordinate the use of colors, so that the same colors present the same meanings. I've tried to keep things relatively intuitive, but it seemed worth documenting what everything means, so we can keep those meanings consistent across different screens as the application develops.

* Pale blue (typically #f0f8ff)
  **Neutral page elements.** This is used sparingly when color is needed to help unify part of the page -- for example, in the navigation tabs, or to highlight the table row under the mouse cursor. It should only be used when you *don't* wish to imply anything about the data it highlights.
* Red
  **Slow or underperforming.** This is used to indicate data that is worse than expected: a week with low throughput, a story that was underestimated, etc. Data highlighted in red should be both *unexpected* and *undesirable*. If it is expected, it probably shouldn't be highlighted. If it is desirable, consider yellow or green, as described below.
* Green
  **Fast or successful.** Unusually good data: e.g. a week with high throughput
* Yellow
  **Unusual, without judgment.** Use yellow if data is outside of the normal or expected range, but you don't want to highlight this as necessarily good or bad. For example, we use yellow instead of green for badly overestimated stories: the story went faster than expected, but the estimate was still wrong. Also used to highlight outliers in sparklines.