docker build -t vivekcdp/multi-client:latest -t vivekcdp/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t vivekcdp/multi-server:latest -t vivekcdp/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t vivekcdp/multi-worker:latest -t vivekcdp/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push vivekcdp/multi-client:latest
docker push vivekcdp/multi-server:latest
docker push vivekcdp/multi-worker:latest

docker push vivekcdp/multi-client:$SHA
docker push vivekcdp/multi-server:$SHA
docker push vivekcdp/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=vivekcdp/multi-server:$SHA
kubectl set image deployments/client-deployment client=vivekcdp/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=vivekcdp/multi-worker:$SHA