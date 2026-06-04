import os
import logging
from celery import Celery
from django.conf import settings 

logger = logging.getLogger(__name__)

# Set the default Django settings module
os.environ.setdefault("DJANGO_SETTINGS_MODULE", "bookstore.settings")

# Create the Celery app
app = Celery("bookstore")

# Load configuration from Django settings
app.config_from_object("django.conf:settings", namespace="CELERY")

# Auto-discover tasks from all installed apps
app.autodiscover_tasks()  # Removed the lambda, let Celery discover automatically

@app.task(bind=True, ignore_result=True)
def debug_task(self):
    """Debug task to verify Celery is working"""
    logger.info(f"Debug task executed: {self.request!r}")
    return f"Request: {self.request!r}"