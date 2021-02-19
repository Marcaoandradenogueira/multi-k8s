docker build -t marcaoan/multi-client:latest -t marcaoan/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t marcaoan/multi-server:latest -t marcaoan/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t marcaoan/multi-worker:latest -t marcaoan/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push marcaoan/multi-client:latest
docker push marcaoan/multi-server:latest
docker push marcaoan/multi-worker:latest

docker push marcaoan/multi-client:$SHA
docker push marcaoan/multi-server:$SHA
docker push marcaoan/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=marcaoan/multi-client:$SHA
kubectl set image deployments/server-deployment server=marcaoan/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=marcaoan/multi-worker:$SHA