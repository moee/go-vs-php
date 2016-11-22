DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
CONTAINER_NAME=go-vs-php
PORT=80
BENCHMARK_ENDPOINT=http://127.0.0.1:$PORT/

function run_benchmark {
	name=$1
	DOCKER_IMAGE=govsphp:$name

	echo $name
	echo "=========="

	mkdir -p $DIR/results/$name

	if [ -f $DIR/$name/setup.sh ]; then
		echo "running setup script"
		$DIR/$name/setup.sh
	fi

	echo "building benchmark image $DOCKER_IMAGE"
	docker build -t $DOCKER_IMAGE $DIR/benchmarks/$name

	docker kill $CONTAINER_NAME 2>/dev/null
	docker rm $CONTAINER_NAME 2>/dev/null
	echo running image
	docker run -d --name $CONTAINER_NAME -p $PORT:80 $DOCKER_IMAGE
	
	echo running benchmark
	ab -c 15 -n 10000 -g $DIR/results/${name}/ab.dat $BENCHMARK_ENDPOINT 
	docker ps -s --filter name=$CONTAINER_NAME | tee $DIR/results/${name}/docker.txt

	#docker kill $CONTAINER_NAME 2>/dev/null	
	#docker rm $CONTAINER_NAME 2>/dev/null	
}

if [ -z $1 ]; then
	for dir in $(ls -d $DIR/benchmarks/*/); do
		run_benchmark `basename $dir`
	done
else
	run_benchmark $1
fi
