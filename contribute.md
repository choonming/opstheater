# Contributing

OpsTheater is an open-source project that's licensed under the GNU Lesser Public License version 3.
Contributions of all types are gladly accepted!

## Code-related contributions

These types of tasks generally require a familiarity with Ruby (on Rails) development or RPM/Debian packaging. If you are still new to Rails, community members can help you if you get stuck with something or have any other questions.

You will need to download a copy of the current development-code. [The official code repository](https://github.com/opstheater/opstheater) is located on Github.

Please note that there are two important branches:

* production - latest stable release code
* develop - new features and bug fixes

production is frozen between major releases.

### Setup development environment
* Fork [opstheater/opstheater](https://github.com/opstheater/opstheater) to a personal GitHub account. This will create a "opstheater" repo under your GitHub username.
* Clone the fork you just created to your development system:

```
git clone https://github.com/<username>/opstheater.git
```

* Reference opstheater/opstheater as upstream:

```
cd opstheater
git remote add upstream https://github.com/opstheater/opstheater.git
git fetch upstream
```

### Setup test environment
TODO

### Startup opstheater
TODO

### Submit Patches
First, make sure you are a member of the [OpsTheater](https://groups.google.com/forum/#!forum/opstheater) mailing list.

Patches to fix bugs or add new features are always appreciated. If you are going to work on a specific issue, make a note in the issue details so the developers will know what you're working on.

We try to keep a one commit per bug/feature policy, please try to create an issue which is specific for your patch details.

Please make sure there is a [GitHub issue](https://github.com/opstheater/opstheater/issues) open for the change you are going to submit, as you will want to reference it in your commit message; this is very helpful when generating release notes.

* Create a feature/topic branch

```
git checkout -b <branchName> # Example: git checkout -b 1656-add_TB_support
```

*  Make changes and commit. Please reference the Redmine issue this commit
addresses via "Refs" or "Fixes" in the commit message. See [Coding
Standards](handbook.html#Codingstandards) guide for more details.

```
git add <modifiedFile(s)>
git commit -m 'Fixes #<bug> - <message>'
```

* Push topic branch to your fork:

```
git push origin <branchName> # Example: git push origin 2-add_fail2ban
```

* [Issue a pull request](https://help.github.com/articles/using-pull-requests)

**Once you have followed this process once, it becomes much simpler to add future patches!**

Merge upstream develop to local develop

```
git fetch upstream
git checkout develop
git merge upstream/develop develop
git push origin develop
```

Now follow step 4 to the end from above.

## Non-code related contributions
These don't require any software development experience, just some time and the desire to help.

### User support
Helping out other users in the "Forums" is always useful. Frequent problems or questions should be brought up so the wiki can be updated to help future users.

Testing is also *very* welcome, for any issue encountered, please open a bug / feature request.

### Bug reporting
Even the simplest of bugs reported helps us make the project better. The issue tracker is located at [https://github.com/opstheater/opstheater/issues](https://github.com/opstheater/opstheater/issues), and you should follow these guidelines:

* Use an understandable, descriptive title, e.g. "Clicking the Template review button gives a 500 server error" rather than "Template review is broken"
* Provide whatever context you can - your host operating system, Foreman version(s), ruby version, etc
* State what you were trying to achieve - provide steps to reproduce your problem where possible
* State what happened in more detail than the title - provide logs where possible
* State what you expected to happen - this helps us correct misinterpretations of features

#### Feature requests
If you're submitting a feature request or user story, please provide the context for the feature, especially the problem you're trying to solve, and your preferred implementation (if you have one). This will lead to a clear record of the discussion and eventual decision.

It's acceptable to head over to the [OpsTheater mailing list](https://groups.google.com/forum/#!forum/opstheater) to start a discussion if you have an idea you'd like more input on, before submitting tickets. Be sure to mention the appropriate thread in the ticket, so the context can be found in the future.

### Issue triage
Sometimes issues are reported without all the above information needed. Getting the details of the bug or feature from the reporter and the community will help everyone understand what is needed. Our issue tracker can be found here: [https://github.com/opstheater/opstheater/issues](https://github.com/opstheater/opstheater/issues), and see the above section for issue guidelines.
