#!/bin/bash
echo "Clone-Commit-Push GIT Repository..."

# choose git repository
echo -e "choose repository management service: \n 1. GitLab (1) \n 2. GitHub (2) \n 3. Bitbucket (3)" 

while :
do
  read selectionVCS
  case $selectionVCS in
	1)
		vcs="https://gitlab.com"
		break
		;;
	2)
		vcs="https://github.com"
		break
		;;
	3)
		vcs="https://bitbucket.org"
		break
		;;
	*)
		echo "Please make a valid selection (1-3)"
		;;
  esac
done

# read variables
echo -n "username: " 
read username

echo -n "repository: "
read repository

echo -n "Would you like to add .gitignore file? (Y/n) "
read hasGitignore

# gitignore file
if [ "$hasGitignore" = "Y" ]
then
	echo -n "gitignore file: "
	read gitignore
fi

git clone $vcs/$username/$repository.git
cd $repository

# readme file
touch README.md
echo $repository >> README.md
git add README.md
git commit -m "add README"

if [ "$hasGitignore" = "Y" ]
then
	# copy .gitignore into repo
        cp $gitignore ./.gitignore

	git add .gitignore
	git commit -m "add .gitignore"
fi

git push -u origin master
