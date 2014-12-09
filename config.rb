require 'redcarpet'

set :markdown_engine, :redcarpet
set :markdown, :fenced_code_blocks => true, :smartypants => true
set :haml, { ugly: true }
set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'
set :images_dir, 'images'
set :fonts_dir,  "fonts-folder"

configure :development do
  activate :livereload
end
activate :syntax, :line_numbers => false
activate :directory_indexes
configure :build do
  activate :minify_css
  activate :minify_javascript
  activate :relative_assets
end



helpers do
  def nav_link(text, destination)
    link_cls = (current_page.path == destination ? 'active' : '')
    link_to text, destination, :class => link_cls
  end
end
