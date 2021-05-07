FROM python:3.9

# Allow statements and log messages to immediately appear in the Cloud Run logs
ENV PYTHONUNBUFFERED True

COPY requirements.txt ./
COPY requirements-composer.txt ./
COPY requirements-test.txt ./

RUN pip install --no-cache-dir -r requirements.txt
RUN pip install --no-cache-dir -r requirements-test.txt
RUN pip install --no-cache-dir -r requirements-composer.txt

#copy dag code to container image
ENV DAGS /dags
WORKDIR $DAGS
COPY . ./
CMD ["pytest", "-s", "dags/example_dag_test.py"]
