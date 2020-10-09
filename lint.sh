docker run -v $(pwd):/src --workdir /src quay.io/helmpack/chart-testing:v3.1.1 ct lint --chart-dirs /src/charts --all
