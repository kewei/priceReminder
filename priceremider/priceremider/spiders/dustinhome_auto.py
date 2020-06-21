#coding=utf-8
import scrapy
from urlparse import urlparse 
from scrapy.spiders import CrawlSpider, Rule
from scrapy.linkextractors import LinkExtractor
from priceremider.items import PriceremiderItem
from scrapy.shell import inspect_response
from scrapy import log


class Dustinhome_autoSpider(CrawlSpider):
    name = "dustinhome_auto"
    allowed = ['dustinhome.se']
    start_urls = ["http://www.dustinhome.se"]
    rules = (
        Rule(LinkExtractor(allow=("/product/*")), callback='parse_item', follow=True),)
    
    def parse_item(self, response):
        product = PriceremiderItem()
        for product_detail in response.xpath('//div[@class="product-wrapper"]/div[@class="container"]/div[@class="row"]'):
            title1 = product_detail.xpath('//*[@class="product-name margin-top-md"]//text()').extract()
            title2 = product_detail.xpath('//div[contains(@class, "product-info")]/h4/text()').extract()[0].strip()
#             description = product_detail.xpath('div/div[@id="product-data"]/div/div/div[@class="product-description"]').extract()[0].strip()
            price = product_detail.xpath('//div[contains(@class, "product-info")]//span[@class="price"]/text()').extract()[0].strip()
        image = response.xpath('//div[@class="iosSlider"]/div/div[@class="slide"][1]/img/@data-src').extract()[0].strip().lstrip('/')
        status = response.xpath('//div[contains(@class, "product-info")]//li[@class="h4"][contains(., "Lagerstatus:")]//text()').extract()
        if status:
            pass
        else:
            status = response.xpath('//div[contains(@class, "product-info")]//div[@class="alert alert-warning"]/text()').extract()[0].strip()    
            
#             url = product_detail.xpath('link[@itemprop="url"]/@href').extract()[0].strip()
        url = response.url
        category = response.xpath('//ol[@class="breadcrumb categorycrumb padding-x-off pull-left hidden-print hidden-xs"]/li[2]/div/a/span/text()').extract()[0].strip()
        if isinstance(status, (str,unicode)):
            status = status
        else:
            status = " ".join(status)
        product['status'] = status.encode('utf-8')
        for ite in title1:
            if ite.strip():
                title1_str = ''.join(ite)
                title1_str = title1_str.strip()
            else:
                pass
        for i, u, p, t1, t2, cat in zip([image], [url], [price], [title1_str], [title2], [category]):
            product['image'] = i.encode('utf-8') + "&width=450"
            product['url'] = u.encode('utf-8')
            p = p.encode('utf-8')
            product['title'] = t1.encode('utf-8') + t2.encode('utf-8')
            product['category'] = cat.encode('utf-8')
        product['price'] = ''.join(it for it in p if '0' <= it <= '9') + 'SEK'
        product['description'] = product['title']
        product['company'] = 'Dustinhome'
        
        yield product