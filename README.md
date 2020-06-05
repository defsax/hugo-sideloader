# hugo-sideloader
A bash script for combining a single page html/css/js project with Hugo static site generator

STEPS:
- adds (html, with accompanying js and css) projects to hugo 
- put script in folder where files are to be added
- give executable privileges
- enter ./load.sh <path-to-blog-file> (include path to base hugo dir)
- script will ask user for project name


WHAT IT DOES:
- gets blog-path
- gets project title
- copies .html main page from project, puts into blog-path/content/projects
- adds front matter to top of .html file
- checks if blog-path/layouts/demo/demo.html exists, if not, makes demo/demo.html
- copies everything else (exceptions: load.sh script, README.md, .git folder) into blog-path/static/demos/project-title

WHAT IT DOESN't DO (yet):
- replaces link paths in .html with new correct paths relative to hugo folder structure
