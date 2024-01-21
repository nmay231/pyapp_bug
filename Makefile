# WHEEL=$()

.PHONE: build-working
build-working: build-wheel
	cd pyapp-latest && \
		PYAPP_PROJECT_PATH=../$(wildcard dist/*.whl) \
		PYAPP_EXEC_SPEC=pyapp_bug.entry:main \
		cargo build --release
	mkdir -p dist && mv pyapp-latest/target/release/pyapp dist/pyapp_bug

.PHONE: build-bugged
build-bugged: build-wheel
	cd pyapp-latest && \
		PYAPP_PROJECT_PATH=../$(wildcard dist/*.whl) \
		PYAPP_DISTRIBUTION_PATH=./python-3.10.13.tar.gz \
		PYAPP_EXEC_SPEC=pyapp_bug.entry:main \
		cargo build --release
	mkdir -p dist && mv pyapp-latest/target/release/pyapp dist/pyapp_bug

.PHONY: build-wheel
build-wheel:
	poetry build -f wheel

.PHONY: init
init:
	curl https://github.com/ofek/pyapp/releases/latest/download/source.tar.gz -Lo pyapp-source.tar.gz
	tar -xgz -f pyapp-source.tar.gz
	rm pyapp-source.tar.gz
	mv pyapp-v* pyapp-latest
	curl https://www.python.org/ftp/python/3.10.13/Python-3.10.13.tar.xz -o pyapp-latest/python-3.10.13.tar.gz
