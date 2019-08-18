#build all images with $GIT_SHA param to have the commit id as unique tag on image 
docker build -t aashishghogre/multi-client:latest -t aashishghogre/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t aashishghogre/multi-server:latest -t aashishghogre/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t aashishghogre/multi-worker:latest -t aashishghgore/multi-worker:$SHA -f ./worker/Dockerfile ./worker

#Push all images to docker hub with commit id tag
docker push aashishghogre/multi-client:$SHA
docker push aashishghogre/multi-server:$SHA
docker push aashishghogre/multi-worker:$SHA

#Push all images to docker hub with latesttag
docker push aashishghogre/multi-client:latest
docker push aashishghogre/multi-server:latest
docker push aashishghogre/multi-worker:latest

#Apply files to kubernetes 
kubectl apply -f k8s

#Imperatively set the image to latest
kubectl set image deployments/client-deployment client=aashishghogre/multi-client:$SHA
kubectl set image deployments/server-deployment server=aashishghogre/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=aashishghogre/multi-worker:$SHA
