# EXAMPLE DOCKER PULL IMAGE

Below is an example of doing a docker pull from the docker hub to 'pull' in a
copy of a previously created docker image.


```
student2@workshop-one:~$ docker pull hogihung/ubuntu-ruby-vim:1.0.0
1.0.0: Pulling from hogihung/ubuntu-ruby-vim
0bd639347642: Pull complete
15f827925d02: Pull complete
8d4e9883d6b5: Pull complete
c754e879539b: Pull complete
85f5abd03ce7: Pull complete
2ad1b37fe5e6: Pull complete
c8fe50e71f4f: Pull complete
bad4200d5f70: Pull complete
cf31ddd0e0e2: Pull complete
c158a7c74edb: Pull complete
8e0046ddf0d6: Pull complete
67acc560db01: Pull complete
Digest: sha256:4241b51ebd9b7d5c48f1da9a4e632fe5952bb5891b379a4946a8368ed33f4737
Status: Downloaded newer image for hogihung/ubuntu-ruby-vim:1.0.0
student2@workshop-one:~$
```

```
student4@workshop-one:~$ docker images
REPOSITORY                 TAG                 IMAGE ID            CREATED             SIZE
ubuntu-ruby-vim            1.0.1               d19723cc329c        2 minutes ago       917MB
ubuntu                     17.10               a8ad041f5225        9 days ago          96.8MB
hogihung/ubuntu-ruby-vim   1.0.0               92379827484f        5 weeks ago         915MB
student4@workshop-one:~$
```

