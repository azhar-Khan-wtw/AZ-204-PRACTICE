
# 🚀 Azure App Service Deployment Guide for Django App

This document provides step-by-step instructions to deploy your Django application to **Azure App Service (Linux)** using the Azure CLI and a custom `startup.sh` script.

---

## 📁 Project Structure

Ensure your Django project has the following structure:

```
MyDjangoapp/
├── manage.py
├── requirements.txt
├── startup.sh
├── MyDjangoapp/
│   ├── __init__.py
│   ├── settings.py
│   ├── urls.py
│   ├── wsgi.py
│   └── ...
└── ...
```

---

## 📝 1. Create `startup.sh`

Create a `startup.sh` in the **root of your Django project** (where `manage.py` exists):

```bash
#!/bin/bash
pip install -r requirements.txt
gunicorn MyDjangoapp.wsgi:application --bind=0.0.0.0:8000
```

> 🔁 Replace `MyDjangoapp.wsgi` with your actual Django project name if different.

Make it executable:

```bash
chmod +x startup.sh
```

---

## 📦 2. Zip the Application Files

Navigate to your Django project folder and zip the contents **(not the folder itself)**:

```bash
cd ~/Azure/AZ-204/AZ-204-PRACTICE/MyDjangoapp
zip -r ../deploy.zip .
```

---

## ☁️ 3. Deploy to Azure Web App

Use Azure CLI to deploy your zipped project:

```bash
az webapp deploy   --name MyDjangoApp   --resource-group az-204-practice-rgp   --src-path ../deploy.zip
```

---

## ⚙️ 4. Set Startup Command

Tell Azure to run your custom startup script:

```bash
az webapp config set   --name MyDjangoApp   --resource-group az-204-practice-rgp   --startup-file ./startup.sh
```

---

## 🔄 5. Restart the Web App

```bash
az webapp restart   --name MyDjangoApp   --resource-group az-204-practice-rgp
```

---

## 📋 6. Monitor Logs (Optional)

```bash
az webapp log tail   --name MyDjangoApp   --resource-group az-204-practice-rgp
```

---

## ✅ Tips

- Use `gunicorn` for production deployment on Azure.
- Keep `requirements.txt` and `startup.sh` at the project root.
- Ensure your app listens on port `8000` (`--bind=0.0.0.0:8000`).

---
