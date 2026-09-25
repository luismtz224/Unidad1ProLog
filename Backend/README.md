# Backend

Backend del la app del proyecto unidad 1 de prrolog hecha en Python

## Start

Tener Python 3.14.x

Terminal

```bash
cd Backend
pip install -r requirements.txt   
```

Configurar el .env con las rutas 

```
DATABASE_URL=mysql+pymysql://usuario:password@localhost:3306/base de datos
RUTA_IMAGENES=C:/.imagenes/
CORS_ORIGINS=http://127.0.0.1:5500,http://localhost:5500
```

para correrlo

```bash
uvicorn app.main:app --reload --port 8000
```

y ya tendran el backend funcionando