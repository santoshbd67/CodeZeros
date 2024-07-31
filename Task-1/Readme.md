## provisioning the Infrastructure for the task-1 using Terrafrom
```
    terraform init
    terraform plan
    terraform apply --auto-approve
```
## Build and run the docker image using following commonds

```
docker build -t santoshbd67/nodejs:latest .
docker run -d -p 3000:3000 santoshbd67/nodejs:latest
```

## Access the Nodejs application using
```
http://public_ip_instance:3000
