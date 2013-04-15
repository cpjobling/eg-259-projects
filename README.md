# Live "Ruby on Rails" Demo


These are the steps performed live in [Contact Hour
22](http://www.cpjobling.me/dokuwiki/eg-259:lecture20). I have shown the steps based on a Windows installation. To install
Rails on Windows you are recommended to use
[RailsInstaller](http://railsinstaller.org/). 

The Macintosh comes with Ruby pre-installed and to install rails you
just need to follow these steps((Adapted from Sam Ruby, Dave Thomas and
David Heinermeier Hansson, //Agile Web Development with Rails//, 4th
Edition, 2011)):

    sudo gem update --system
    sudo gem uninstall ruby-gems-update
    sudo gem install rails
    sudo gem install sqlite3 

In action, the Mac, being a Unix system, has a different command line
interface as you will have seen from the recording of the session.


## 1. Create the rails application 

<note>If you want to run Rails using a virtual machine, you can skip the
next step and instead go to GitHub and clone the project
[[https://github.com/cpjobling/eg-259-rails|github.com/cpjobling/eg-259-rails]].
You then need to go through the configuration steps detailed in the
[[https://github.com/cpjobling/eg-259-rails/blob/master/README.md|README.md]]
file to install ruby and install the dependencies that will enable the
Rails project to be run inside a virtual Ubuntu server.

It will take longer, but you'll get some insight into the environment
that Rails runs in inside a production server.</note>

<cli prompt=">">
C:\Users\cpjobling>rails new eg-259-rails
</cli>





===== 2. Start rails application and show default page =====

<cli prompt=">">
C:\Users\cpjobling>cd eg-259-rails
C:\Users\cpjobling\eg-259-rails> bundle install
C:\Users\cpjobling\eg-259-rails> bundle exec rails server
</cli>

Open http://localhost:3000/ in browser.




===== 3. Configure database =====
 
  * Rails comes preconfigured to use a lightweight, open-source SQL
    database called [[http://www.sqlite.org/|SQLite3]]((I discovered
yesterday that PHP 5 includes SQLite3 too.)). The configuration file is
''..\eg-259-rails\config\database.yml'':
<code yaml>
# SQLite version 3.x
#   gem install sqlite3
development:
  adapter: sqlite3
  database: db/development.sqlite3
  pool: 5
  timeout: 5000

# Warning: The database defined as "test" will be erased and
# re-generated from your development database when you run "rake".
# Do not set this db to the same as development or production.
test:
  adapter: sqlite3
  database: db/test.sqlite3
  pool: 5
  timeout: 5000

production:
  adapter: sqlite3
  database: db/production.sqlite3
  pool: 5
  timeout: 5000
</code>
To run rails with these defaults, you need do no more to configure your
databases.

It's a good idea to stick with SQLite3 for development and testing, but
for deployment you may need a more capable database engine. Luckily, you
can also configure Rails to use MySQL in deployment, in which case you'd
edit the last entry of the configuration file to read: 
<code yaml>
deployment:
  adapter: mysql
  encoding: utf8
  database: projects_production
  username: root
  password:
  host: localhost
</code>
You would then need to use //phpMyAdmin// or the //mysql// command to
create the database //songs_production// and set up suitable user
permissions((The example assumes MySQL in its default state with no root
password, which of course you should never use in a live deployment!)).




===== 4. Create a projects model and a projects controller =====


Stop (<key>C - c</key>) the web application then create a model to
represent the for the songs table and its associated controller and
views.
<cli prompt=">">
C:\Users\cpjobling\eg-259-rails>rails generate scaffold project
title:string description:text discipline:string supervisor:string
research_centre:string
</cli>
Examine the generated files for the model
''..\eg-259-rails\app\models\project.rb'':
<code ruby>
class Project < ActiveRecord::Base
  attr_accessible :description, :discipline, :research_centre,
:supervisor, :title
end
</code>
Note that most of the default behaviour for the model is abstracted into
the superclass ''ActiveRecord::Base''. We only need to define
specialisms, most of the behaviour is inherited. This is another example
of //DRY// and //Convention over Configuration//. 

The (page) controller
''..\eg-259-rails\app\controllers\projects_controller.rb'' is a little
more complex:
<code ruby>
class ProjectsController < ApplicationController
  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @projects }
    end
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @project = Project.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @project }
    end
  end

  # GET /projects/new
  # GET /projects/new.json
  def new
    @project = Project.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @project }
    end
  end

  # GET /projects/1/edit
  def edit
    @project = Project.find(params[:id])
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(params[:project])

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was
successfully created.' }
        format.json { render json: @project, status: :created, location:
@project }
      else
        format.html { render action: "new" }
        format.json { render json: @project.errors, status:
:unprocessable_entity }
      end
    end
  end

  # PUT /projects/1
  # PUT /projects/1.json
  def update
    @project = Project.find(params[:id])

    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to @project, notice: 'Project was
successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @project.errors, status:
:unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url }
      format.json { head :no_content }
    end
  end
end
</code>
The apparent complexity is because methods have been provided to support
the so-called //RESTful interface// that Rails provides. It is another
example of //convention over configuration//. In fact when you look at
the code, there are 7 methods which the controller implements:
  - show the list of projects (//index//)
  - display an individual project (//show//)
  - create a new project (//new//) ...
  - and add it to the database (//create//)
  - change an existing project (//edit//) and ...
  - store the changed project in the database (//update//), and
  - delete a project from the database (//destroy//).
  
Note the use of the HTML verbs GET, PUT, POST, DELETE in each of these
cases, the URLs that are associated with each action, and also note that
both HTML (the default) and XML are supported resource
types((JavaScript, e.g. for Ajax with JSON can also be used)).

The //scaffolding// command that was added to the ''rails generate''
instruction has also created suitable HTML code to allow the data to be
displayed in the web application. The views (examples of the //Template
View// pattern) are stored in ''..\eg-259-rails\app\views\projects'' and
there is a view for each of the browser actions //edit//, //index//,
//new// and //show//. 

For example the //new// view is:
<code html>
<h1>New project</h1>

<%= render 'form' %>

<%= link_to 'Back', projects_path %>
</code>
and the form is
<code html>
<%= form_for(@project) do |f| %>
  <% if @project.errors.any? %>
    <div id="error_explanation">
      <h2><%= pluralize(@project.errors.count, "error") %> prohibited
this project from being saved:</h2>

      <ul>
      <% @project.errors.full_messages.each do |msg| %>
        <li><%= msg %></li>
      <% end %>
      </ul>
    </div>
  <% end %>

  <div class="field">
    <%= f.label :title %><br />
    <%= f.text_field :title %>
  </div>
  <div class="field">
    <%= f.label :description %><br />
    <%= f.text_area :description %>
  </div>
  <div class="field">
    <%= f.label :discipline %><br />
    <%= f.text_field :discipline %>
  </div>
  <div class="field">
    <%= f.label :supervisor %><br />
    <%= f.text_field :supervisor %>
  </div>
  <div class="field">
    <%= f.label :research_centre %><br />
    <%= f.text_field :research_centre %>
  </div>
  <div class="actions">
    <%= f.submit %>
  </div>
<% end %>
</code>

Finally, the ''rails generate'' command created a database //migration//
file:
<code ruby>
class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title
      t.text :description
      t.string :discipline
      t.string :supervisor
      t.string :research_centre

      t.timestamps
    end
  end
end
</code>
which uses ruby to provide a database agnostic way of creating and
updating the database. We use the migration to create the database by
running
<cli prompt=">">
C:\Users\cpjobling\eg-259-rails>rake db:migrate
</cli>
The file naming convention, e.g.  ''20130414145709_create_projects'',
includes a time-stamp to ensure that migrations are applied in the
correct order.

If you use test-driven development (and Rails strongly encourages you to
do so) you would also prepare the test database by executing:
<cli prompt=">">
C:\Users\cpjobling\eg-259-rails>rake db:test:prepare
</cli>
===== 5. Use a seed file to populate the database with some initial data
=====

The ''rails new'' command also creates a ruby file
''..\eg-259-rails\db\seeds.rb'' that can be used to populate the
database with some initial data:
<cli prompt=">">
C:\Users\cpjobling> rake db:seed
</cli>
We edit this file to add some data. In Rails, we can create a new data
record using:
<code ruby>
Project.create(title: "Project 1", 
  supervisor: "Prof. Good Teacher", 
  research_centre: "Materials Research Centre",
  discipline: "ICCT",
  description: "<p>Some HTML</p>")
</code>
This makes use of the //Project// constructor((Actually the
//ActiveRecord// constructor.)) as a generator for a new record. After
editing, the complete migration is:
<code ruby>
# This file should contain all the record creation needed to seed the
database with its default values.
# The data can then be loaded with the rake db:seed (or created
alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

description <<-END
<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent
accumsan, 
felis nec euismod bibendum, tellus mi hendrerit risus, vitae luctus
lorem dolor 
eu libero. Morbi a hendrerit libero. Nullam ac pharetra ante. Nam
accumsan eros 
vitae enim bibendum egestas. Proin malesuada diam et augue ultricies a
accumsan 
quam lacinia. Integer non nulla id purus pretium ultrices. Praesent non
magna ac 
ante consequat convallis. Morbi elementum velit sit amet diam interdum
quis egestas 
felis porta. Nullam et nisi massa. Donec ut tellus erat, quis aliquam
dui. Class 
aptent taciti sociosqu ad litora torquent per conubia nostra, per
inceptos himenaeos. 
Phasellus viverra tempus venenatis. Aenean euismod mollis leo, a
ultricies lacus 
euismod sed. Nunc hendrerit dui non mauris pellentesque vitae eleifend
nunc elementum. 
Praesent viverra euismod mauris vel mollis. Sed vel est
est.</p><p>Mauris scelerisque 
dapibus nisi. Fusce ut mi eget leo tincidunt fermentum. Sed dapibus
consequat tortor, 
quis dapibus purus tincidunt quis. Nulla vitae felis dignissim nisl
ultricies ornare 
vitae eu purus. Integer nec sapien sed metus mollis cursus sed tincidunt
tortor. 
Curabitur sagittis, augue eu tristique ultricies, magna velit elementum
nibh, in 
rhoncus diam mi at sapien. Nam sed diam ut lorem feugiat malesuada. Nunc
porta 
ullamcorper erat vitae faucibus. Sed vehicula ipsum et lectus sagittis
vel lacinia 
neque mattis. Maecenas consectetur dui eu nisi auctor pharetra. Donec
lobortis enim 
et sem pulvinar quis blandit nisl consequat. Quisque ligula tellus,
sagittis vel 
accumsan vulputate, congue sit amet nulla. Proin mattis, purus ultrices
molestie 
faucibus, ante quam venenatis turpis, vel porta turpis nisl sit amet
arcu. 
Sed ullamcorper hendrerit faucibus. Pellentesque et est eu elit euismod
varius. 
Proin adipiscing dolor non mi consequat lacinia dictum mauris
scelerisque.</p>
END


projects = Project.create(
  [
  # The array `data` is an array of *projects*.
  # Each project has an `id`, `title`, `discipline`, `supervisor`
  # research centre, and a `description`.
    {
        title: 'Project 1',
        discipline: 'ICCT',
        supervisor: 'Dr Chris P. Jobling',
        research_centre: 'Multidisciplinary Nanotechnology Centre',
        description: description
    },
    #   We have provided thirteen of them!
    {
        title: 'Project 2',
        discipline: 'ICCT',
        supervisor: 'Dr Chris P. Jobling',
        research_centre: 'Multidisciplinary Nanotechnology Centre',
        description: description
    },
    {
        title: 'Project 3',
        discipline: 'ICCT',
        supervisor: 'Dr Chris P. Jobling',
        research_centre: 'Multidisciplinary Nanotechnology Centre',
        description: description
    },
    {
        title: 'Project 5',
        discipline: 'ICCT',
        supervisor: 'Dr Chris P. Jobling',
        research_centre: 'Multidisciplinary Nanotechnology Centre',
        description: description
    },
    {
        title: 'Project 6',
        discipline: 'ICCT',
        supervisor: 'Prof. Tom Chen',
        research_centre: 'Multidisciplinary Nanotechnology Centre',
        description: description
    },
    {
        title: 'Project 7',
        discipline: 'ICCT',
        supervisor: 'Prof. Tom Chen',
        research_centre: 'Multidisciplinary Nanotechnology Centre',
        description: description
    },
    {
        title: 'Project 8',
        discipline: 'ICCT',
        supervisor: 'Prof. Tom Chen',
        research_centre: 'Multidisciplinary Nanotechnology Centre',
        description: description
    },
    {
        title: 'Project 9',
        discipline: 'ICCT',
        supervisor: 'Prof. Tom Chen',
        research_centre: 'Multidisciplinary Nanotechnology Centre',
        description: description
    },
    {
        title: 'Project 10',
        discipline: 'ICCT',
        supervisor: 'Prof. Tom Chen',
        research_centre: 'Multidisciplinary Nanotechnology Centre',
        description: description
    },
    {
        title: 'Project 11',
        discipline: 'ICCT',
        supervisor: 'Dr Jason Jones',
        research_centre: 'Civil and Computational Engineering Centre',
        description: description
    },
    {
        title: 'Project 12',
        discipline: 'ICCT',
        supervisor: 'Dr Jason Jones',
        research_centre: 'Civil and Computational Engineering Centre',
        description: description
    },
    {
        title: 'Project 13',
        discipline: 'ICCT',
        supervisor: 'Dr K.S. (Joseph) Kim',
        research_centre: 'Multidisciplinary Nanotechnology Centre',
        description: description
    }
  ]
)
</code>

<note>If you look at the code in the ''projects_controller'' you'll see
that the ''create'' action is used like this:
<code ruby>
@project = Project.new(params[:project])
</code>
This takes the ''parameter'' variable((A //hash// or //dictionary//))
from the web browser (equivalent to ''$_POST'' in PHP) to populate the
data record.</note>
===== 6. Demonstrate the CRUD behaviour =====

Restart the application web server:
<cli prompt=">">
C:\Users\cpjobling\eg-259-rails>bundle exec rails server
</cli>

Open a web browser and browse to http://localhost:3000/projects/

Create a new project, list projects, update projects, delete a project:
i.e. demonstrate Create Retrieve Update Delete (CRUD) interface that is
typical for many web-fronted database applications. Observe the URIs for
each case.

Note that all the behaviour (mapping URIs to model methods and
parameters) is inherited from ''ActionController'' and all the
presentation (HTML views) were created by the ''scaffolding'' option
used when the model was created.
===== 7. Validate the form data =====

Add validation to a field of the model:
<code ruby>
class Project < ActiveRecord::Base
  attr_accessible :description, :discipline, :research_centre,
:supervisor, :title
  
  validates :description, :title, :discipline, :presence => true
end

</code>
Create a new song or edit an existing one to show that the validator
works.

===== 8. Examine "scaffold" code =====

In addition to creating the controller and the migration file, the
scaffold command
created a view for each default action in the controller (i.e.
//index//, //new//, //edit//, //show//). Examine and edit the view
templates (located in ''..\eg-259-rails\app\views\projects\''). This is
''..\eg-259-rails\app\views\projects\index.html.erb'':
<code html>
<h1>Listing projects</h1>

<table>
  <tr>
    <th>Title</th>
    <th>Description</th>
    <th>Discipline</th>
    <th>Supervisor</th>
    <th>Research centre</th>
    <th></th>
    <th></th>
    <th></th>
  </tr>

<% @projects.each do |project| %>
  <tr>
    <td><%= project.title %></td>
    <td><%= project.description %></td>
    <td><%= project.discipline %></td>
    <td><%= project.supervisor %></td>
    <td><%= project.research_centre %></td>
    <td><%= link_to 'Show', project %></td>
    <td><%= link_to 'Edit', edit_project_path(project) %></td>
    <td><%= link_to 'Destroy', project, method: :delete, data: {
confirm: 'Are you sure?' } %></td>
  </tr>
<% end %>
</table>

<br />

<%= link_to 'New Project', new_project_path %>
</code>

The things to note about this is that the code is HTML with ruby
embedded between template marker tags ''<% .. %>''. The code is
relatively easy to understand. Also note that this template can be
embedded at run time into a template defined in
''..\eg-259-rails\app\views\layouts''. This is where you would create a
wrapper file that was valid HTML 5 and loaded the required stylesheets
and client-side JavaScript libraries((Although Rails has it's own
conventions for this that makes use off the //Assets Pipeline//.)).
 

