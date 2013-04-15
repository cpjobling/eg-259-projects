# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

@description = <<-EOS
<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent accumsan, 
felis nec euismod bibendum, tellus mi hendrerit risus, vitae luctus lorem dolor 
eu libero. Morbi a hendrerit libero. Nullam ac pharetra ante. Nam accumsan eros 
vitae enim bibendum egestas. Proin malesuada diam et augue ultricies a accumsan 
quam lacinia. Integer non nulla id purus pretium ultrices. Praesent non magna ac 
ante consequat convallis. Morbi elementum velit sit amet diam interdum quis egestas 
felis porta. Nullam et nisi massa. Donec ut tellus erat, quis aliquam dui. Class 
aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. 
Phasellus viverra tempus venenatis. Aenean euismod mollis leo, a ultricies lacus 
euismod sed. Nunc hendrerit dui non mauris pellentesque vitae eleifend nunc elementum. 
Praesent viverra euismod mauris vel mollis. Sed vel est est.</p><p>Mauris scelerisque 
dapibus nisi. Fusce ut mi eget leo tincidunt fermentum. Sed dapibus consequat tortor, 
quis dapibus purus tincidunt quis. Nulla vitae felis dignissim nisl ultricies ornare 
vitae eu purus. Integer nec sapien sed metus mollis cursus sed tincidunt tortor. 
Curabitur sagittis, augue eu tristique ultricies, magna velit elementum nibh, in 
rhoncus diam mi at sapien. Nam sed diam ut lorem feugiat malesuada. Nunc porta 
ullamcorper erat vitae faucibus. Sed vehicula ipsum et lectus sagittis vel lacinia 
neque mattis. Maecenas consectetur dui eu nisi auctor pharetra. Donec lobortis enim 
et sem pulvinar quis blandit nisl consequat. Quisque ligula tellus, sagittis vel 
accumsan vulputate, congue sit amet nulla. Proin mattis, purus ultrices molestie 
faucibus, ante quam venenatis turpis, vel porta turpis nisl sit amet arcu. 
Sed ullamcorper hendrerit faucibus. Pellentesque et est eu elit euismod varius. 
Proin adipiscing dolor non mi consequat lacinia dictum mauris scelerisque.</p>
EOS


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
        description: @description
    },
    #   We have provided thirteen of them!
    {
        title: 'Project 2',
        discipline: 'ICCT',
        supervisor: 'Dr Chris P. Jobling',
        research_centre: 'Multidisciplinary Nanotechnology Centre',
        description: @description
    },
    {
        title: 'Project 3',
        discipline: 'ICCT',
        supervisor: 'Dr Chris P. Jobling',
        research_centre: 'Multidisciplinary Nanotechnology Centre',
        description: @description
    },
    {
        title: 'Project 5',
        discipline: 'ICCT',
        supervisor: 'Dr Chris P. Jobling',
        research_centre: 'Multidisciplinary Nanotechnology Centre',
        description: @description
    },
    {
        title: 'Project 6',
        discipline: 'ICCT',
        supervisor: 'Prof. Tom Chen',
        research_centre: 'Multidisciplinary Nanotechnology Centre',
        description: @description
    },
    {
        title: 'Project 7',
        discipline: 'ICCT',
        supervisor: 'Prof. Tom Chen',
        research_centre: 'Multidisciplinary Nanotechnology Centre',
        description: @description
    },
    {
        title: 'Project 8',
        discipline: 'ICCT',
        supervisor: 'Prof. Tom Chen',
        research_centre: 'Multidisciplinary Nanotechnology Centre',
        description: @description
    },
    {
        title: 'Project 9',
        discipline: 'ICCT',
        supervisor: 'Prof. Tom Chen',
        research_centre: 'Multidisciplinary Nanotechnology Centre',
        description: @description
    },
    {
        title: 'Project 10',
        discipline: 'ICCT',
        supervisor: 'Prof. Tom Chen',
        research_centre: 'Multidisciplinary Nanotechnology Centre',
        description: @description
    },
    {
        title: 'Project 11',
        discipline: 'ICCT',
        supervisor: 'Dr Jason Jones',
        research_centre: 'Civil and Computational Engineering Centre',
        description: @description
    },
    {
        title: 'Project 12',
        discipline: 'ICCT',
        supervisor: 'Dr Jason Jones',
        research_centre: 'Civil and Computational Engineering Centre',
        description: @description
    },
    {
        title: 'Project 13',
        discipline: 'ICCT',
        supervisor: 'Dr K.S. (Joseph) Kim',
        research_centre: 'Multidisciplinary Nanotechnology Centre',
        description: @description
    }
  ]
)