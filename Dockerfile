# syntax=docker/dockerfile:1

FROM python:3.9.6-slim-buster
WORKDIR /app
COPY requirements.txt requirements.txt
RUN pip install -i https://pypi.tuna.tsinghua.edu.cn/simple -r requirements.txt
COPY . .
CMD ["python", "-m", "flask", "run", "--host=0.0.0.0"]
# test
