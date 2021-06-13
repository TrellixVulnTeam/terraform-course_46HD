***

 <div align="center">
    <img src="images/devops.JPG" width="700" />
</div>

***

### __Inicialize Repo__
git init

git config user.name \<username\>

git config user.email \<user@domain\>

* __For ssh login use following config and as credentials keypair__
git remote set-url origin git@github.com:inecsoft/terraform-course.git

* __For https login use following config and as credentials user + access tocken__  
git remote set-url origin https://github.com/inecsoft/terraform-course.git

ssh -T git@github.com

git add .

git commit -m "first commit"

git push

### __Add the public key on the repo__
git remote remove origin

git remote show origin

git config -l

git remote add origin git@github.com:inecsoft/terraform-course.git

git push -u origin master


### __Review your work__

* List commit history of current branch. -n count limits list to last n commits.
```
git log [-n count]
```
* An overview with reference labels and history graph. One commit per line.
```
git log --oneline --graph --decorate
```
* List commits that are present on the current branch and not merged into ref. A ref can be a branch name or a tag name.
```
git log ref..
```
* List commit that are present on ref and not merged into current branch.
```
git log ..ref
```
* List operations (e.g. checkouts or commits) made on local repository
```
git reflog 
```

### __To remove file from remote repo__
git checkout master

git rm -r folder-name

git commit -m "folder-name deleted"

git push origin master

### __Undo removed files locally without commit__

git ls-files --deleted | xargs git checkout 

### __If you haven't committed the deletion, yet__
git checkout HEAD \<filename\>  

### __Undo commits__
git log --oneline
* #### _The savest way to do it_
git checkout \<commit\>
* #### _Undo a commit_
git revert \<commit\>
* #### _Undoes all commits after \<commits\>, preserving changes locally_
git reset \<commit\>
* #### _Discards all history and changes back to the specified commit_
git reset --hard \<commit\>

git checkout master

### __Navigation branch__
git log --pretty=oneline --abbrev-commit
#### To rollback to previos commit 
git reset HEAD\~1

git rebase -i HEAD\~6
#### Delete the line of the commit that you want to delete
git push

git pull

git push

### __Manage Branches__
* #### _Create branch_
git branch \<name of branch\>
* #### _Show branches_
git branch -a
* #### _Go to the a branch_
git checkout \<branch name\>
* #### _Get back to master branch_
git checkout master
* #### _Creates branh and select it (best practice)_
git checkout -b \<branch name\>
* #### _Delete branch when merged_
git branch -d \<branch name\>
* #### _Delete branch when branch is not merged with master_
git branch -D \<branch name\>

### __Merge into master__
git checkout master
* #### _Show content differences between two branches_
git diff \<first-branch\>...\<second-branch\>

git merge \<branch name\>
#### If error edit what you want to change and save
git add .

git add \<file name\>

git commit -am "comments"

### __Manage credentials__
* #### _Helper to store password disk_
git config credential.helper store

* #### _Helper to temporaly (2hours) store password in memory_
git config --global credential.helper 'cache --timeout=7200'
* #### _Helper to temporaly store credential in memory locally_
git config --local credential.helper ""
* #### _Edit the account in .gitconfig_
git config --global --list

git config --global -e

### __Colaboration__
git clone \<your fork url\>  
git push origin \<branch name\>  
git remote add upstream \<URL master git repo\>  
git push upstream master  

### __Configuration file to manage git repos using custom ssh key pair__
ssh-keygen -t rsa -t 2048 -f github  
vim ~/.ssh/config  

```
Host your.hostname.com
    HostName github.com
    User username
    IdentityFile C:\Users\Ivan\.ssh\github
```

```
git config -e
```

```
# .git/config
[remote "origin"]
    url = git@your.hostname.com:username/reponame.git
```

git clone <repo URL>  
git add .  
git commit -am "message"  
ssh-agent bash  
ssh-add -k github  
git push  

***

### __Working with local version of the module__

module "staging_vpc" {  
    #tag to be uppded to 1.4.20 once prod migration is complete"  
    source = "../../terraform-modules/template"
    #source                   = "github.com/inecsoft/terraform-modules.git//template?ref=branchname"

```
terraform get --update terraform plan
terraform apply -lock-timeout=120m
```
***
### __Precommit tool__
```
curl https://pre-commit.com/install-local.py | python -
echo 'export PATH=$PATH:~/bin' >>/.bashrc
source ~/.bashrc 
pre-commit --version
```
```
vim ~/.pre-commit-config.yaml
repos:
- repo: git://github.com/antonbabenko/pre-commit-terraform
  rev: v1.45.0
  hooks:
    - id: terraform_fmt
    - id: terraform_validate
    - id: terraform_tflint
    #- id: terraform_tfsec
    - id: terraform_docs
```
### __Install the git hook scripts__
```
pre-commit install
```
***