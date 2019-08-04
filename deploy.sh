docker build -t jimmykiang/multi-client:latest -t jimmykiang/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jimmykiang/multi-server:latest -t jimmykiang/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jimmykiang/multi-worker:latest -t jimmykiang/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push jimmykiang/multi-client:latest
docker push jimmykiang/multi-server:latest
docker push jimmykiang/multi-worker:latest

docker push jimmykiang/multi-client:$SHA
docker push jimmykiang/multi-server:$SHA
docker push jimmykiang/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=jimmykiang/multi-server:$SHA
kubectl set image deployments/client-deployment client=jimmykiang/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=jimmykiang/multi-worker:$SHA