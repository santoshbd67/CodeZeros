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
