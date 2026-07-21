FROM python:3.10-alpine
WORKDIR /app
RUN adduser -D navineo_user
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY src/ .
RUN chown -R navineo_user:navineo_user /app
USER navineo_user
EXPOSE 8083
CMD ["python", "app.py"]
