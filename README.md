# UMD Lib Style

Gem containing the common UMD Libraries Rails application layout and styles. Built on Bootstrap 3.3.6.

## Usage

In your app's Gemfile:

```ruby
gem 'umd_lib_style', github: 'umd-lib/umd_lib_style', branch: 'develop'
```

Then run the usual:

```
$ bundle install
```

Finally, edit your app's application files to use the scripts, styles, and layouts:

1. Add `//= require umd_lib` to *app/assets/javascripts/application.js*
2. Rename *app/assets/stylesheets/application.css* to *application.scss*
3. Add `@import "umd_lib";` to *app/assets/stylesheets/application.scss*
4. Change the contents of *app/views/layouts/application.html.erb* to the following:

    ```erb
    <% provide :app_name, 'My UMD Libraries App' %>
    <%= render 'layouts/umd_lib' %>
    ```

## Custom Navbar

To include your own custom markup in the navbar, add a `content_for` block to your *app/views/layout/application.html.erb* file. For example:

```erb
<% provide :app_name, 'Autonumber Service' %>

<% content_for :navbar do %>
  <ul class="nav navbar-nav">
    <li><%= link_to 'Auto Numbers', auto_numbers_path %></li>
    <li><%= link_to 'Names', names_path %></li>
    <li><%= link_to 'Repositories', repositories_path %></li>
  </ul>
<% end %>

<%= render 'layouts/umd_lib' %>
```
