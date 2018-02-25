#!/bin/bash
echo "Creating new GitLab Repository $repository..."

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

git clone https://gitlab.com/$username/$repository.git
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
