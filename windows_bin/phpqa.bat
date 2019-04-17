@echo off

mkdir %cd%\tmp-phpqa

docker run --init -it --rm -v %cd%:/project -v %cd%/tmp-phpqa:/tmp -w /project jakzal/phpqa:alpine %*

