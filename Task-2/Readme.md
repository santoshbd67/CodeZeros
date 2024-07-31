## Create Namespace using following command

```
kubectl create ns nginx-deployment
```
## Deploy the nginx pod using following command

```
kubectl apply -f Nginx-deployment.yaml
```

## Expose the application using NodePort

```
kubectl apply -f service.yaml
```
# Note: If we want to expose this application to external world we can write ingress.yaml file through which we can access the application
