# UMD Lib Style

Gem containing the common UMD Libraries Rails application layout and styles.
Built on Bootstrap 3.4.1, and designed to support Rails 6.1 and webpacker.

## Changelog

See [CHANGELOG.md](CHANGELOG.md) for information about changes to this gem.

## Git Tagging

When a new version of this gem is created, be sure to update the version
number in the lib/umd_style/version.rb to match the Git tag.

## Usage

Make the following changes in your Rails project:

### Gemfile

Add the "umd_lib_style" gem. To use the "develop" branch version:

```ruby
gem 'umd_lib_style', github: 'umd-lib/umd_lib_style', branch: 'develop'
```

or to use a specific version:

```ruby
gem 'umd_lib_style', github: 'umd-lib/umd_lib_style', ref: '<GIT_TAG>'
```

where <GIT_TAG> is the Git tag of the version to use. For example, to use
the Git tagged "3.0.0" version, use:

```ruby
gem 'umd_lib_style', github: 'umd-lib/umd_lib_style', ref: '3.0.0'
```

### package.json

Add the following lines:

```json
    "bootstrap": "3.4.1",
    "jquery": "3.6.0",
```

Note: The versions should match the respective versions in the
"package.json" file of the "umd_lib_style" version you are using.

### app/assets/stylesheets/application.scss

If necessary, rename the "app/assets/stylesheets/application.css" file to
"app/assets/stylesheets/application.scss" and add the following line:

```javascript
@import "umd_lib";
```

### app/javascript/packs/application.js

Add the following line:

```javascript
import 'bootstrap/dist/js/bootstrap';
```

### config/webpack/environment.js

Add the following lines:

```javascript
const webpack = require('webpack')

environment.plugins.append('Provide', new webpack.ProvidePlugin({
  $: 'jquery/src/jquery',
  jQuery: 'jquery/src/jquery'
}));
```

### app/views/layouts/application.html.erb

Remove the existing comnent and replace with the following:

```erb
<% provide :app_name, 'APP_NAME' %>
<%= render 'layouts/umd_lib' %>
```

changing "APP_NAME" to your application name.

After making the above changes, run:

```bash
$ bundle install
$ yarn
```

## Upgrading from v2 to v3

Applications that use version 2.x of "umd_lib_style" (such as the
[umd-handle](https://github.com/umd-lib/umd-handle)) will require the
following changes for v3:

1) Application must be upgraded to Rails 6.1

2) Application must use Ruby 2.7.5 (or later)

3) The "app/views/layouts/_umd_lib.html.erb" file in "umd_lib_style" now
uses the "javascript_pack_tag" tag, so any custom
"app/views/layouts/_umd_lib.html.erb" file in the application can be removed.

## Scaffolding CSS

If you generated your app with Rails scaffolding, you should remove the
*app/assets/stylesheets/scaffold.css.scss* file, to remove any potential
conflicts with the Bootstrap styles.

## content_for blocks

The "content_for" block allows for additions/customization of particular
sections of the layout.

### Additional "head" content - additional_head_content

Enables additional directives to be added into the "head" section of the HTML
page.

#### Additional "head" content - Sample Usage

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

This gem provides a fixed full page width navigation bar at the top of the page,
containing the application name and a set of drop-down menus.

#### Custom Navbar - Sample Usage

The application name is set using a "app_name" block. To include your own custom
markup in the navbar, add a `content_for` block to your
*app/views/layout/application.html.erb* file.

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

Displays a full page width banner directly below the navbar, which will not
scroll off the screen. Used by the Annual Staffing Request application to show a
banner when impersonating another user.

#### Custom Nav Banner - Sample Usage

```erb
<% content_for :navbar_banner do %>
  <%= render 'layouts/impersonate' %>
<% end %>
```

### Environment Banner

In keeping with [SSDR policy][1], an "environment banner" will be displayed at
the top of each page when running on non-production servers.

By default, in the local development environment (determined by
`Rails.env.development?` returning `true`), a "Local Environment" banner will be
displayed.

On non-production servers, the environment banner can be configured using the
following environment variables:

* ENVIRONMENT_BANNER - the text to display in the banner
* ENVIRONMENT_BANNER_FOREGROUND - the foreground color for the banner, as a CSS
  color
* ENVIRONMENT_BANNER_BACKGROUND - the background color for the banner, as a CSS
  color
* ENVIRONMENT_BANNER_ENABLED - (optional) "false" (case-sensitive) disables the
  banner. Anything else (including blank, or not providing the variable) enables
  the banner.

### Page Content Container class

 By default, the content of the page is placed in a \<div> using the Bootstrap
 "container" class. Applications (such as Annual Staffing Request) may wish to
 override this setting to use some other class, such as "container-fluid". To do
 so, add the following "provide" line to your
 *app/views/layout/application.html.erb* file:

```erb
<% provide :container_class, "container-fluid" %>
```

### Footer - "application_footer"

Per UMD policy, a footer containing a "Web Accessibility" link is provided by
default. Applications wishing to override the default footer can do so by
defining a "content_for" block to your *app/views/layout/application.html.erb*
file.

#### Footer - Sample Usage

```erb
<% content_for :application_footer do %>
  <footer class="footer">
    <p>Custom footer</p>
  </footer>
<% end %>
```

## umd_lib_style Development

Unit tests can be run using the following command:

```bash
$ bundle install
$ yarn
$ rails test
```

[1]: https://confluence.umd.edu/display/LIB/Create+Environment+Banners
