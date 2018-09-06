# UMD Lib Style

Gem containing the common UMD Libraries Rails application layout and styles. Built on Bootstrap 3.3.6.

## Git Tagging

When a new version of this gem is created, be sure to update the version
number in the lib/umd_style/version.rb to match the Git tag.

## Usage

In your app's Gemfile:

```ruby
gem 'umd_lib_style', github: 'umd-lib/umd_lib_style', branch: 'develop'
```

to use the "develop" branch version of the gem, or

```ruby
gem 'umd_lib_style', github: 'umd-lib/umd_lib_style', ref: '<GIT_TAG>'
```

where <GIT_TAG> is the Git tag of the version to use. For example, to use
the Git tagged "1.0.1" version, use:

```ruby
gem 'umd_lib_style', github: 'umd-lib/umd_lib_style', ref: '1.0.1'
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

## Bootstrap Notes

This gem uses [Bootstrap SASS version 3.3.6][1]. The Bootstrap assets are copied directly into the [vendor/assets](vendor/assets) directory.

If you are starting from an app that already loaded Bootstrap directly into your CSS or Javascript, you must *replace* the relevant `require` or `@import` statements with the ones to load `umd_lib` listed above.

In addition, your app will no longer need the `bootstrap-sass` gem and you can remove it from your Gemfile.

## Scaffolding CSS

If you generated your app with Rails scaffolding, you should remove the *app/assets/stylesheets/scaffold.css.scss* file, to remove any potential conflicts with the Bootstrap styles.

## content_for blocks

The "content_for" block allows for additions/customization of particular sections of the layout.

### Additional "head" content - additional_head_content

Enables additional directives to be added into the "head" section of the HTML
page.

#### Sample Usage

In Rails 5.2, an additional "csp_meta" tag is added into the "head" section of
the layouts/application.html.erb file. To include this tag into a Rails
application using this gem, add a `content_for` block to your
*app/views/layout/application.html.erb* file

```erb
<% content_for :additional_head_content do %>
  <%= csp_meta_tag %>
<% end %>
```

### Custom Navbar - navbar

This gem provides a fixed full page width navigation bar at the top of the page, containing the application name and a set of drop-down menus.

#### Sample Usage

The application name is set using a "app_name" block. To include your own custom markup in the navbar, add a `content_for` block to your *app/views/layout/application.html.erb* file.

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

### Custom Nav Banner - "navbar_banner"

Displays a full page width banner directly below the navbar, which will not scroll off the screen. Used by the Annual Staffing Request application to show a banner when impersonating another user.

#### Sample Usage

```erb
<% content_for :navbar_banner do %>
  <%= render 'layouts/impersonate' %>
<% end %>
```

### Environment Banner

In keeping with [SSDR policy][2], an "environment banner" will be displayed at the top of each page when running on non-production servers, indicating whether the application is running on a "Local", "Development", or "Staging" server. This banner does _not_ appear on production systems.

The environment banner will attempt to auto-detect the correct environment. To override this auto-detection functionality (or to modify it for testing), an "ENVIRONMENT_BANNER" environment banner can be used with any of the following values (which are case-insensitive):

 * "Local"
 * "Development"
 * "Staging"
 * "Production" - This is only needed to force the "production" setting (i.e., not show the banner) on a server that would otherwise show some other value. Production systems do _not_ need to set this value.

### Page Content Container class

 By default, the content of the page is placed in a \<div> using the Bootstrap "container" class. Applications (such as Annual Staffing Request) may wish to override this setting to use some other class, such as "container-fluid". To do so, add the following "provide" line to your *app/views/layout/application.html.erb* file:

```erb
<% provide :container_class, "container-fluid" %>
```

### Footer - "application_footer"

Per UMD policy, a footer containing a "Web Accessibility" link is provided by
default. Applications wishing to override the default footer can do so by
defining a "content_for" block to your *app/views/layout/application.html.erb*
file.

#### Sample Usage

```erb
<% content_for :application_footer do %>
  <footer class="footer">
    <p>Custom footer</p>
  </footer>
<% end %>
```

[1]: https://github.com/twbs/bootstrap-sass/archive/v3.3.6.tar.gz
[2]: https://confluence.umd.edu/display/LIB/Create+Environment+Banners
