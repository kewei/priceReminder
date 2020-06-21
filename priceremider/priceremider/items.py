# -*- coding: utf-8 -*-

# Define here the models for your scraped items
#
# See documentation in:
# http://doc.scrapy.org/en/latest/topics/items.html

import scrapy


class PriceremiderItem(scrapy.Item):
    # define the fields for your item here like:
    # name = scrapy.Field()
    title = scrapy.Field() #href link in the result
    company = scrapy.Field()
    price = scrapy.Field()
    status = scrapy.Field()
    image = scrapy.Field()
    url = scrapy.Field()
    description = scrapy.Field()
    category = scrapy.Field()
