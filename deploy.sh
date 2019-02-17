docker build -t nreoch9/multi-client:latest -t nreoch9/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t nreoch9/multi-server:latest -t nreoch9/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t nreoch9/multi-worker:latest -t nreoch9/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push nreoch9/multi-client:latest
docker push nreoch9/multi-server:latest
docker push nreoch9/multi-worker:latest
docker push nreoch9/multi-client:$SHA
docker push nreoch9/multi-server:$SHA
docker push nreoch9/multi-worker:$SHA
kubectl apply -f k8s/
kubectl set image deployments/client-deployment client=nreoch9/multi-client:$SHA
kubectl set image deployments/server-deployment server=nreoch9/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=nreoch9/multi-worker:$SHA
