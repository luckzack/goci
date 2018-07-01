A CI Flow builder for Go applications based on yourdomain's repository.
=====================================

## Install

```
bash <(curl -s http://agent.ops.yourdomain.com/static/goci/install.sh)
```

## Usage

### Step 1. Create your project 

```
goci <Project Name> <App Name> <Author>
```

Specify your project's, application's and author's name explicitly.

```
goci <Project Name> <App Name>
```

Author defaults to the logined account's name, `whoami` 

```
goci <App Name>
```

Set project's name to app's name. 


**e.g.**

```
goci demo HelloWorld yourname
```


That will create a folder `./HelloWorld` contains a new go project named `HelloWorld` and expected to be pushed into `hub.yourdomain.com/demo/HelloWorld`,

Naturally the image's creator is `yourname`.

Furthermore, this project will generate a rancher catalog template named `demo`,

### Step 2. Push to Gitlab

Before this, you should have an empty repository existed for your project.

Use below command to push this project to your gitlab repository:

```
make git
```

The repository's address defaults to `git@code.yourdomain.com:<Author>/<App Name>.git`.
So in the above case, your project will be pushed to `git@code.yourdomain.com:yourname/Helloworld.git`.


### Step 3. Create a project at Jenkins

Add this command:
```
make ci
``` 
in the `Excute shell` input text of your project settings.

Once a push event happening in the gitlab repository, Jenkins will trigger a build to the project. 

### Step 4. Push your project-template into your rancher catalog

Once you launch a stack via this project's catalog template, the stack's name is `demo` (Project Name), and the service's name is `HelloWorld` (App Name).


## CI Flow

Including:

- [x] godep
- [x] test
- [x] review
- [x] build
- [x] pack
- [x] rancherize

## Architecture

![goci](http://ww1.sinaimg.cn/large/007bRB9vgy1fsubny2jhcj30t40rqta7.jpg)

## Dependencies

- golang
- [golang dep](https://github.com/golang/dep)
- [gometalinter](https://github.com/alecthomas/gometalinter)
- docker
- git [optional]


## Specs

1. Use [golang dep](https://github.com/golang/dep) to manage dependencies 
2. [SemVer](http://semver.org/)

## Terms
![goci-terms](http://ww1.sinaimg.cn/large/49e65d94gy1fjoxowm8qvj21hc0u0afa.jpg)

## Rancher Catalog

Todo