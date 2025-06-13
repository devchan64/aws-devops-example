FROM python:3.10-slim as builder

WORKDIR /install
COPY app/requirements.txt .
RUN pip install --user --no-cache-dir -r requirements.txt


# 실제 실행 이미지(현재는 불필요하지만 미리 자리 잡기)
FROM python:3.10-slim

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app

# builder에서 설치된 패키지를 복사
COPY --from=builder /root/.local /root/.local
ENV PATH=/root/.local/bin:$PATH

COPY ./app .

CMD ["python", "./manage.py", "runserver", "0.0.0.0:80"]
