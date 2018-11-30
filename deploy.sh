docker build -t ryandussiaume/multi-client:latest -t ryandussiaume/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ryandussiaume/multi-server:latest -t ryandussiaume/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ryandussiaume/multi-worker:latest -t ryandussiaume/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push ryandussiaume/multi-client:latest
docker push ryandussiaume/multi-server:latest
docker push ryandussiaume/multi-worker:latest

docker push ryandussiaume/multi-client:$SHA
docker push ryandussiaume/multi-server:$SHA
docker push ryandussiaume/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ryandussiaume/multi-server:$SHA
kubectl set image deployments/client-deployment client=ryandussiaume/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ryandussiaume/multi-worker:$SHA
