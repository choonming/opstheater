### How to contribute code for Elasticsearch, Kibana & Filebeat :

If you want to have a look at puppetised code for Elasticsearch, Kibana & Filebeat, you can check that on this git repository : *https://github.com/olindata/opscenter-control*

And if you think this excites you, then you can also contribute in the code.
Please follow the below steps for the same :

On your development machine (local machine) clone the opscenter control repository using command :
```sh
git clone git@github.com:olindata/opscenter-control.git
```
This will create a directory call opscenter-control on your current location.
You can contribute your code in this local directory and push it to a new branch
```sh
checkout -b <author>/[fixes|features]/<name>
```
Now you will be on a new branch that you have just create now, to check the same run command
```sh
git branch
```
Now once you have done with your code you will need to push it to the repository with following steps :
```sh
git add <file name>

git commit -m “ your comment about the changes getting committed ”

git push origin <branch name>
```
**Note : here branch name will be same as what you have create in earlier step.**

This step will push your changes to the repository superwebs-puppet on the branch you created.
Now you can request Walter to check your code and merge it with the original repository.

