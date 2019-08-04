docker build -t jugon666/multi-client:latest -t jugon666/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jugon666/multi-server:latest -t jugon666/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jugon666/multi-worker:latest -t jugon666/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push jugon666/multi-client:latest
docker push jugon666/multi-server:latest
docker push jugon666/multi-worker:latest

docker push jugon666/multi-client:$SHA
docker push jugon666/multi-server:$SHA
docker push jugon666/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=jugon666/multi-server:$SHA
kubectl set image deployments/client-deployment client=jugon666/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=jugon666/multi-worker:$SHA