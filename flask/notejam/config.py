import os
from flask.ext.sqlalchemy import SQLAlchemy

basedir = os.path.abspath(os.path.dirname(__file__))

db_uri = 'sqlite:///' + os.path.join(basedir, 'notejam.db')
if os.environ.get('MYSQL_HOST'):
    db_uri = 'mysql://root:password@{host}/notejam'.format(host=os.getenv('MYSQL_HOST', 'localhost'))

class Config(object):
    DEBUG = False
    TESTING = False
    SECRET_KEY = 'notejam-flask-secret-key'
    CSRF_ENABLED = True
    CSRF_SESSION_KEY = 'notejam-flask-secret-key'
    SQLALCHEMY_DATABASE_URI = db_uri


class ProductionConfig(Config):
    DEBUG = False


class DevelopmentConfig(Config):
    DEVELOPMENT = True
    DEBUG = True


class TestingConfig(Config):
    TESTING = True
