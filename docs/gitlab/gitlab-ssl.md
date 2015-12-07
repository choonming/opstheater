# Self signed key generation for gitlab

## Description

In order to secure gitlab, we'll want to run it over SSL certificates. In order to do that in a test environment we'll need some kind of self-signed certs and store them somewhere (currently in the control repo under ./site/profiles/files/gitlab_ssl/)

## OpenSSL self-signed certs

1. Generate the key:

```sh
sudo openssl genrsa -out ./gitlab.key 2048
```

2. Generate the CSR

```sh
sudo openssl req -new -key ./gitlab.key -out ./gitlab.csr
```

3. Sign the key 

```sh
sudo openssl x509 -req -days 1500 -in ./gitlab.csr -signkey ./gitlab.key -out ./gitlab.crt
```