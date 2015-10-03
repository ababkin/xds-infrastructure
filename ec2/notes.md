###CloudFormation

###NOTE: always generate a new etcd discovery url (go here: https://discovery.etcd.io/new)
aws cloudformation create-stack --stack-name xdataset --capabilities CAPABILITY_IAM --template-body "file://~/work/xdataset/aws/ec2/infrastructure.json" \
--parameters  \
ParameterKey=DiscoveryURL,\
ParameterValue=https://discovery.etcd.io/c2aa577ba53c33c6884a65120082019f,\


aws cloudformation update-stack --stack-name xdataset --capabilities CAPABILITY_IAM --template-body "file://~/work/xdataset/aws/ec2/infrastructure.json" --parameters  ParameterKey=DiscoveryURL,ParameterValue=https://discovery.etcd.io/ed360a37a30869becd88d96504e87f8a


###Docker

> docker run -it --rm -v $(pwd):/deploy


####Building haskell-scratch image (only need to do this once really)
cd haskell-scratch
make clean
make
docker images # note the integer-gmp hash
docker tag -f <hash from the above command looking like: bffbca670919> ababkin/haskell-scratch:integer-gmp
docker push ababkin/haskell-scratch:integer-gmp


####Build project and extract the executable
cd <project dir>
docker build --rm=false -t ababkin/xds-downloader:latest .
docker run --rm -v $(pwd)/deploy:/deploy ababkin/xds-downloader:latest cp /usr/local/bin/xds-downloader /deploy


####Build deploy image
cd <project dir>
docker pull ababkin/haskell-scratch:integer-gmp
docker build -f deploy/Dockerfile -t ababkin/xds-downloader:deploy .
docker push ababkin/xds-downloader:deploy




####Run container on the target instance
sudo yum install -y docker ; sudo service docker start

sudo docker pull ababkin/xds-downloader:deploy

sudo docker run -it \
 -e AWS_ACCESS_KEY_ID=<key> \
 -e AWS_ACCESS_KEY=<key> \
 -e AWS_ACCESS_KEY_SECRET=<secret> \
 -e AWS_SECRET_ACCESS_KEY=<secret> \
 -e AWS_SECRET_KEY=<secret> \
  ababkin/xds-downloader:deploy \
  xds-downloader 
