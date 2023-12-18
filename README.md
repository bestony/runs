# Docked Rails CLI(runs)

Setting up Rails for the first time with all the dependencies necessary can be daunting for beginners. Docked Rails CLI uses a Docker image to make it much easier, requiring only Docker to be installed.

Install [Docker](https://www.docker.com/products/docker-desktop/) (and [WSL](https://learn.microsoft.com/en-us/windows/wsl/install) on Windows). Then copy'n'paste into your terminal:

```bash
docker volume create ruby-bundle-cache
alias runs='docker run --rm -it -v ${PWD}:/rails -v ruby-bundle-cache:/bundle -p 3000:3000 ghcr.io/bestony/runs'
```

Then create your Rails app:

```bash
runs rails new weblog
cd weblog
runs rails generate scaffold post title:string body:text
runs rails db:migrate
runs rails server
```

That's it! Your Rails app is running on `http://localhost:3000/posts`.

## Sidenote

`runs` is not intended to replace a full development setup. It is merely a way for newcomers to quickly get started with Rails. The included dependencies stick to what you need when running `rails new` without additional options. It does not include dependencies for running with PostgreSQL or Redis for example.

## Credit
Forked from rails/docked
