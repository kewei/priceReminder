#coding=utf-8
import scrapy
from priceremider.items import PriceremiderItem
from scrapy import log


class CdonSpider(scrapy.Spider):
    name = "cdon"
    allowed_domains = ['cdon.se']
    def __init__(self, start_url, *args, **kwargs):
        super(CdonSpider, self).__init__(*args, **kwargs)
        self.start_urls = [start_url]
    
    def parse(self, response):
        product = PriceremiderItem()
        for product_detail in response.xpath('//div[@id="site-wrapper"]/div[@id="inner-wrapper"]/div[@class="page-content-wrapper"]/main[@class="page-content"]'):
            title = product_detail.xpath('div/div[@class="product-head-title"]/h1/text()').extract()[0].strip()
#             description = product_detail.xpath('div/div[@id="product-data"]/div/div/div[@class="product-description"]').extract()[0].strip()
            description = product_detail.xpath('//ul[@class="usp-list"]/li/text()').extract()
            if description:
                pass
            else:
                description = title
            price = product_detail.xpath('div/div/div/form/div[@id="price-wrapper"]/div/span[@class="price big blink"]/text()').extract()[0].strip()
            if price:
                currency = product_detail.xpath('div/div/div/form/div[@id="price-wrapper"]/div/meta[@itemprop="priceCurrency"]/@content').extract()[0].strip()
                status = product_detail.xpath('div/div/div/form/div[@id="price-wrapper"]/div/meta[@itemprop="availability"]/@content').extract()[0].strip()
            else:
                price = product_detail.xpath('div/div/div[@id="product-price-wrapper"]/div/div/span[@class="price big blink"]/text()').extract()[0].strip()
                currency = product_detail.xpath('div/div/div[@id="product-price-wrapper"]/div/div/meta[@itemprop="priceCurrency"]/@content').extract()[0].strip()
                status = product_detail.xpath('div/div/div[@id="product-price-wrapper"]/div/div/span[@class="out-of-stock"]/text()').extract()[0].strip()
            image = product_detail.xpath('//a[@id="front-image-link"]/@href').extract()[0].strip()
#             url = product_detail.xpath('link[@itemprop="url"]/@href').extract()[0].strip()
            url = response.url
        category = response.xpath('//div[@class="breadcrumbs"]/ul/li[2]/a/span/text()').extract()[0].strip()
        if isinstance(description, (str,unicode)):
            description = description
        else:
            description = " ".join(description)
        product['description'] = description.encode('utf-8')
        for i, u, p, c, s, t, cat in zip([image], [url], [price], [currency], [status], [title], [category]):
            product['image'] = i.encode('utf-8')
            product['url'] = u.encode('utf-8')
            p = p.encode('utf-8')
            c = c.encode('utf-8')
            product['status'] = s.encode('utf-8')
            product['title'] = t.encode('utf-8')
            product['category'] = cat.encode('utf-8')
        ch = ''.join(it for it in p if '0' <= it <= '9')
        product['price'] = ch + c
        product['company'] = 'CDON'
        
        yield product