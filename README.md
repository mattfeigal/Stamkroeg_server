# StamKroeg Server

Server backend for the [StamKroeg App].

## Requirements

### Ruby

You need ruby 1.9.2 or higher to run the server.

Check [RVM] if you need to install ruby on your machines.

### MongoDB

You need [MondoDB] installed and running on your machine.

If you don't have [MongoDB] installed we advice to use [Homebrew].

```sh
%> brew install mongodb
```

## Usage

Clone the repository and `cd` into the root.

Install the dependencies:

```sh
%> bundle install
```

And run the server

```
%> foreman start
```

[StamKroeg App]:https://github.com/mattfeigal/Stamkroeg-iPhone-Client
[MongoDB]:http://www.mongodb.org/
[RVM]:https://rvm.io
[Homebrew]:http://mxcl.github.com/homebrew/

