default: image test notebook

.PHONY: image shell

image:
	docker build --tag rasterio_jupyter:latest .

test:
	docker run -it --rm rasterio_jupyter:latest python -c "import rasterio, fiona, shapely, numpy, sys; print('Python:', sys.version); print('Rasterio:', rasterio.__version__); print('Fiona:', fiona.__version__); print('Shapely:', shapely.__version__); print('Numpy', numpy.__version__);"

shell: image
	docker run -it --rm rasterio_jupyter:latest /bin/bash

notebook:
	docker run -it --rm \
		-p 0.0.0.0:8888:8888 \
		--rm \
		--interactive \
		--tty \
		--volume $(shell pwd)/:/code \
		--volume /Users/sumitasok/data/production/cartis/clients/8/projects/15/surveys/21/datasets/99:/data \
		rasterio_jupyter:latest  /bin/bash -c "cd /code && jupyter notebook --ip=0.0.0.0 --allow-root"

pyshell:
	docker run -it --rm \
		--rm \
		--interactive \
		--tty \
		--volume $(shell pwd)/notebooks/:/notebooks \
		--volume /Users/sumitasok/data/production/cartis/clients/8/projects/15/surveys/21/datasets/99:/data \
		rasterio_jupyter:latest  /bin/bash -c "python"
