
# Experitest - Ansible Deployments Guide

Experitest is a **private company**, creating software to manage enterprise level Mobile Device Lab - for automating mobile application and web testing.

```md
# NOTE: 
Please read carefully before implementing. 
Using ansible to deploy can get technical. 
Avoid the pitfalls by reading this documntation. 
```

This repo contains **examples**, **best practices**, and **guidelines** for using ansible to deploy experitest products:

- [Prerequisites](./prerequisites) \
All the steps one need to perform before automating deployment using ansible

- [Security guidelines and best practices](./best-practices/security)

- [Migration guide](./migrating-from-install4j) \
Guide for our existing customers, used to install the lab using (install4j based) installer

- [Dev setup example](./examples/local) \
Install all components on a single host. \
Useful for testing \ development.

- [Complete example](./examples/complete) \
Deploying the entire stack in multi host environment


- [Onpremise deployment](./onpremise-deploy-without-internet) \
Install ansible to onpremise systems without internet.

- [OS Support Matrix](./compatibility/OS.md) \
Listing the supported os versions for our products.
