---
description: Create a new PR for the current branch
agent: engineer
model: openai/gpt-5.5
---


Commit all changes, and push them to the remote repository,
with the branch as the same name as that of the current and local branch.

Then, check whether a PR already exists for the current branch. If it doesn't, create one. 
Use the PR template from this repo for the description.

For an existing PR, update the description to capture any significant changes made. 
Note: information in the existing PR description such as checkboxes checked, Jira issue links, etc. must be preserved.

Once pushed, check the PR mergeability status. If it's dirty with respect to its base branch, pull the base branch,
and then merge it into the current branch. Resolve any conflicts that arise appropriately. Push once done.
