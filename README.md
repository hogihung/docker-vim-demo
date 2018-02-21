# README

This repository contains files that were used for the February 22, 2018 RubyJax+
Meetup - Intro To Vim Configuration With A Splash Of Docker.  The meetup includes
a presentation and workshop illustrating how one can use Docker as a playground
for testing out a useful Vim configuration, with a primary focus on the Ruby
developer.

During the workshop, participants can either use Docker on their own computer where
they can build the docker image used during the workshop, or they can pull the image
from the Docker Hub.

For those participants that do not have Docker on their computer, a student login
will be provided to access a Vultr hosted server which has Docker and the image
used for the workshop.

Even if you will be using the remote Vultr host, this repo may still be good to
clone on your local computer.


## Clone the repo

```
cd /path/to/your/projects
git clone https://github.com/hogihung/docker-vim-demo.git 
cd docker-vim-demo
```


## Play The Asciinema Videos

The following asciinema files can be played back as a review of what we have done during the workshop.

Asciinema:  https://asciinema.org/docs/usage


1.  vim\_demo\_ssh\_workshop.json

2.  workshop\_clone\_repo.json

3.  docker\_pull\_image.json

4.  docker\_run\_container.json

5.  vim\_demo\_install\_vundle.json

6.  vim\_config\_step\_one.json

7.  vim\_config\_step\_two.json

8.  vim\_config\_step\_three.json

9.  vim\_config\_step\_four.json

10. vim\_config\_step\_five.json

11. vim\_config\_add\_vundle.json

12. vim\_config\_step\_seven.json

13. vim\_config\_step\_eight.json

14. vim\_config\_step\_nine.json

```
# Use the syntax
asciinema play /path/to/file.json
```

*NOTE:*  If you do not have asciicenma installed on your computer, you can either 
         install it if you are using OS X or Linux, or you can use docker:

         https://asciinema.org/docs/installation#running-in-docker-container

