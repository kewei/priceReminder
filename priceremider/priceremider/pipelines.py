# -*- coding: utf-8 -*-

# Define your item pipelines here
#
# Don't forget to add your pipeline to the ITEM_PIPELINES setting
# See: http://doc.scrapy.org/en/latest/topics/item-pipeline.html
# import sys
# sys.path.append('/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/site-packages/')
# import pymongo
# from scrapy.conf import settings
# from scrapy.exceptions import DropItem
# from scrapy import log

# class MongoDBPipeline(object):
#     
#     def __init__(self):
#         connection = pymongo.MongoClient(
#             settings['MONGODB_SERVER'],
#             settings['MONGODB_PORT']
#                                          )
#         db = connection[settings['MONGODB_DB']]
#         self.collection = db[settings['MONGODB_COLLECTION']]
#     def process_item(self, item, spider):
#         valid = True
#         for data in item:
#             if not data:
#                 valid = False
#                 raise DropItem("Missing {0}".format(data))
#         if valid:
#             self.collection.insert(dict(item))
#             log.msg("Price added to MongoDB database!",
#                     level=log.DEBUG, spider=spider)
#         return item
            
import sys
#import MySQLdb
from twisted.enterprise import adbapi
import hashlib
from scrapy.exceptions import DropItem
from scrapy import log

class MySQLStorePipeline(object):
  def __init__(self, dbpool):
      self.dbpool = dbpool
  @classmethod
  def from_settings(cls, settings):
      dbargs = dict(
            host = settings['MYSQL_HOST'],
            db = settings['MYSQL_DB'],
            user = settings['MYSQL_USER'],
            passwd = settings['MYSQL_PASSWD'],
            charset = 'utf8',
            use_unicode = True,
                    )
      dbpool = adbapi.ConnectionPool('MySQLdb', **dbargs)
      return cls(dbpool)
  def process_item(self, item, spider):    
    query = self.dbpool.runInteraction(self._do_upsert, item, spider)
    query.addErrback(self._handle_error, item, spider)
    return query
  def _do_upsert(self, conn, item, spider):
      """Perform an insert or update."""
      query_check = "select * from %s where url = %%s" % spider.name
      conn.execute(query_check, (item['url'], ))
      result = conn.fetchone()
      if result:
          query_udpate = "UPDATE %s SET price=%ss" % spider.name
          conn.execute(query_udpate, (item['price']))
          log.msg("Item updated in db: %s" % item, level=log.DEBUG)
      else:
          query_insert = "INSERT INTO %s (title, company, description, price, status, image, url, category) VALUES (%%s, %%s, %%s, %%s, %%s, %%s, %%s, %%s)" % spider.name
          conn.execute(query_insert,
                   (item['title'], item['company'], item['description'], item['price'], item['status'], item['image'], item['url'], item['category']))
          log.msg("Item stored in db: %s" % item, level=log.DEBUG)
#       if result:
#           log.msg("Item already stored in db: %s" % item, level=log.DEBUG)
#       else:
#           query_insert = "INSERT INTO %s (title, company, description, price, status, image, url, category) VALUES (%%s, %%s, %%s, %%s, %%s, %%s, %%s, %%s)" % spider.name
#           conn.execute(query_insert,
#                    (item['title'], item['company'], item['description'], item['price'], item['status'], item['image'], item['url'], item['category']))
#           log.msg("Item stored in db: %s" % item, level=log.DEBUG)
#       log.msg("Error: %s" % item, level=log.DEBUG)
  def _handle_error(self, e):
      log.err(e)