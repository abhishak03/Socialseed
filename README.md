# socialseed

Final Year project

## Branches

- ***Main Branch (master):*** This branch represents the `Production-ready` code. It should only contain stable and tested code. You deploy your app from this branch.

- ***Develop Branch:*** This branch is where all the `development` work takes place. It contains the latest features and changes that are being worked on by your team.

- ***Feature Branches:*** For each new `feature` or task, you can create a feature branch from the develop branch. Work on the feature in this branch, and once it's completed and tested, merge it back into the develop branch.

- ***Release Branches:*** When you're preparing for a new `release`, you can create a release branch from the develop branch. This allows you to stabilize the code for the upcoming release without introducing new features.

- ***Hotfix Branches:*** If there's a `critical` issue in production that needs to be fixed immediately, you can create a hotfix branch from the main branch, fix the issue, and then merge it back into both the main and develop branches.

## Sequence

- `Feature` -> `Develop` (***Only Developers***)
- `Develop` -> `Release` (***Team Leader***)
- `Release` -> `Production`(***Team Leader***)

- `production` -> `HotFix` (Optional)

## Getting Started

 1. `Fork` the Feature Branch

 2. `Clone` the repo
    
 ```
  git clone https://github.com/{@YourGitHubUserID}/Socialseed.git
 ```

