#!/bin/bash
input="n"

while [ "$input" == "n" ] || [ "$input" == "N" ]
do

  #get blog location
  read -p "Enter Hugo blog base directory: " blogpath
  until [ -e $blogpath ];
  do
    echo "$blogpath doesn't exist. Please enter Hugo blog base directory: "
    read blogpath
  done

  #get project to import location
  read -p "Enter project directory: " projpath
  until [ -e $projpath ];
  do
    echo "$projpath doesn't exist. Please enter project directory: "
    read projpath
  done

  #confirm directories
  until [ "$input" == "y" ] || [ "$input" == "Y" ] 
  do
    echo -e "\nBlog location: $blogpath"
    echo "Project to side load: $projpath"
    read -p "Is this correct? [Yes/No/eXit] " input

    case "$input" in
      y|Y ) echo "yes";;
      n|N ) echo "no" && break;;
      x|X ) echo "Exiting..." && exit;;
      * ) echo "invalid";;
    esac
  done
done

read -p "Enter project name: " projname

#check for content/projects folder, make it if necessary
if [ -e "$blogpath/content/projects/" ]; then
  echo "$blogpath/content/projects/ exists."
else
  echo "Creating $blogpath/content/projects..."
  mkdir -p -v $blogpath/content/projects
fi

#copy entry .html file into projects folder, renaming it
cp -v $projpath/*.html $blogpath/content/projects/$projname.html

#add front matter
(echo "---
title: "\"$projname\""
date:" $(date '+%Y-%m-%dT%H:%M:%S-04:00') "
draft: true
author: \"\"
tags: [\"\"]
type: demo
layout: demo
---" && cat $blogpath/content/projects/$projname.html) > filename1 && mv filename1 $blogpath/content/projects/$projname.html

#check for demo layout
if [ -e "$blogpath/layouts/demo/" ]; then
  echo "$blogpath/layouts/demo/ exists."
else
  echo "Creating /layouts/demo/demo.html..."
  mkdir -p -v $blogpath/layouts/demo/
  (echo -e "<!--just display the project content and nothing else--> \n{{ .Content }}") > $blogpath/layouts/demo/demo.html
fi

#copy all the rest of the files to static directory
mkdir -p -v $blogpath/static/demos/$projname/

#doesn't copy .git folder
cp $projpath/* $blogpath/static/demos/$projname/

#go to new folder and remove readme
cd $blogpath/static/demos/$projname/
rm -rf README.md
rm -rf load.sh
rm -rf index.html
