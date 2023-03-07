split into projects and subproject pages

Index Jekyll Website Note

Ruby 3.1 failed, so I install rbenv and downgraded to 2.7.7 and it was fine

- set an index for order of posts
- removed "Blog" 
- added Jekyll relative links for posting from obsidian (this allows us to write `[Page Name](page.md)` in markdown and the html created link just works 
- changed permalink for projects to just `/:slug` which is the `title` field slugified into a url-compatible string (e.g. "My Awesome Project" ;→ "my-awesome-project")

Obsidian Formatting
- all links as markdown (not wiki) 
- cant have spaces in file names -> 

Example Link Processing
- `[Thanks and Gratitude](Thanks-Gratitude.md)` → `[Thanks and Gratitude](Thanks-Gratitude)` → `<a href="/thanks-gratitude">Thanks-Gratitude</a>`


Improvements
- the `title` field as defined in the page front matter is not reverse-substituted into the alt-text as it would be if you were using the liquid `link` or `post_url` tags
- automatically convert text on line under photos to caption


Image processing (wxh)
- mobile: 600px width
- desktop: 1200px

Automation
- python script to watch and copy