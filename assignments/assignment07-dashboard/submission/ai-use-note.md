**AI USE:**

AI Use: Locate the caption in the dashboard.qmd file
AI prompt: Locate the "caption" section for the graph in the dashboard.qmd file
Verified: The caption for graph was under ## Visualization.

AI Use: To help determine which part of the dashboard is control. 
AI prompt: Search for `^## Control|selected_income <-|available_income_groups`
The control is the **Control** section, especially the line `selected_income`. It sets which income group the summary and plot use. Change its value (for example, to `"Middle Income"`) and render again.
It’s a manual setting in this static dashboard, not an interactive dropdown.
Verified: Changed the selected_income to "Middle Income" and that changed the output for the dashboard when rendered

AI Use: Help produce the reproducibiltiy for reproducibiltiy-note
AI: 1. Use the same repository version and the committed NHANES classroom data: `nhanes_equity_v6.csv`.
2. Open the project in its Codespace, which provides the course’s pinned R and Quarto setup. The package list is in `install-packages.sh`.
3. From the repository root, run:
quarto render assignments/assignment07-dashboard/submission/dashboard.qmd
4. To reproduce a different income-group result, change `selected_income` in the `control section` to a valid group, then render again.
The HTML embeds its resources, so you can share the rendered file without separate plot assets. The output is `assignments/assignment07-dashboard/submission/dashboard.html`.
Verified: Checked the output of AI and confimed.

