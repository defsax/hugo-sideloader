# hugo-sideloader
A bash script for combining a single page html/css/js project with Hugo static site generator

Steps:
- give executable privileges
- run with ./load.sh
- enter base directory of hugo blog
- enter project directory to load
- enter project name


What It Does:
- gets \<blog-path\>
- gets \<project-path\>
- gets project title
- copies .html main page from project, puts into blog-path/content/projects
- adds front matter to top of .html file
- checks if blog-path/layouts/demo/demo.html exists, if not, makes demo/demo.html
- copies everything else (exceptions: index.html, README.md, .git folder) into blog-path/static/demos/project-title

What It Doesn't Do (Yet):
- replaces link paths in .html with new correct paths relative to hugo folder structure
