#!/bin/bash

#save current dir for later
cwd=$(pwd)

if [ -z $1 ]; then
  echo "Please enter the blog base directory location. Terminating script..."
  exit
else
  echo "The location you entered was:" $1
fi

blogpath=$1

read -p "Enter project name: " projname

#check for content/projects folder, make it if necessary
if [ -e "$blogpath/content/projects/" ]; then
  echo "$blogpath/content/projects/ exists."
else
  echo "Creating $blogpath/content/projects..."
  mkdir -p -v $blogpath/content/projects
fi

#copy entry .html file into projects folder, renaming it
cp -v *.html $blogpath/content/projects/$projname.html

#go to the folder
cd $blogpath/content/projects/

#add front matter
(echo "---
title: "\"$projname\""
date:" $(date '+%Y-%m-%dT%H:%M:%S-04:00') "
draft: true
author: \"\"
tags: [\"\"]
type: demo
layout: demo
---" && cat $projname.html) > filename1 && mv filename1 $projname.html

#check for demo layout
if [ -e "$blogpath/layouts/demo/" ]; then
  echo "$blogpath/layouts/demo/ exists."
else
  echo "Creating /layouts/demo/demo.html..."
  mkdir -p -v $blogpath/layouts/demo/
  (echo -e "<!--just display the project content and nothing else--> \n{{ .Content }}") > $blogpath/layouts/demo/demo.html
fi

#copy all the rest of the files to static directory
cd $cwd
mkdir -p -v $blogpath/static/demos/$projname/

#doesn't copy .git folder
cp * $blogpath/static/demos/$projname/

#go to new folder and remove readme
cd $blogpath/static/demos/$projname/
rm -rf README.md
rm -rf load.sh
