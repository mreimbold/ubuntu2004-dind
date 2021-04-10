# Ubuntu 20.04 based Docker Image
[![Docker Build](https://github.com/mreimbold/ubuntu-dind/actions/workflows/ci.yml/badge.svg)](https://github.com/mreimbold/ubuntu-dind/actions/workflows/ci.yml) [![Docker pulls](https://img.shields.io/docker/pulls/mreimbold/ubuntu2004-dind)](https://hub.docker.com/r/mreimbold/ubuntu2004-dind)

The main intent for this project is to use this container with Molecule to test Ansible roles that deploy Docker containers.

Python 3.x and sudo as a become method are preinstalled.

## Available tags

  - `latest`: Latest stable version of Docker
  - `20.10.5`: Docker Version 20.10.5
  - `19.03.15`: Docker Version 19.03.15

## How to use with molecule
To use the Docker image as a platform in Molecule, add the following to the `molecule/default/molecule.yml` file.

    platforms:
      - name: instance
        image: "mreimbold/ubuntu2004-dind:latest"
        command: ""
        privileged: true
        pre_build_image: true

To test your role in a more realistic way, a non-root user named ansible is available in the Docker image. To use this user, add the following to your `molecule/default/converge.yml` file. This means that no longer all tasks are executed with root permissions and the become keyword must be set explicitly.

    ---
    - name: Converge
      ...

      vars:
        ansible_user: ansible

## How to use locally

  1. [Install Docker](https://docs.docker.com/engine/installation/).
  2. Pull this image from Docker Hub: `docker pull mreimbold/ubuntu2004-dind:latest`.
  3. Run a container from the image: `docker run --detach --privileged --name docker mreimbold/ubuntu2004-dind:latest`
  4. Use Docker inside the container: `docker exec --tty docker docker --help`
