#coding=utf-8
import scrapy
from priceremider.items import PriceremiderItem
from scrapy import log


class SibaSpider(scrapy.Spider):
    name = "siba"
    allowed_domains = ['siba.se']
    def __init__(self, start_url, *args, **kwargs):
        super(SibaSpider, self).__init__(*args, **kwargs)
        self.start_urls = [start_url]
    
    def parse(self, response):
        product = PriceremiderItem()
        for product_detail in response.xpath('//div[@id="product-wrapper"]/div[@class="product-info"]'):
            title1 = product_detail.xpath('div[@class="product-title"]/h1/text()').extract()[0].strip()
            title2 = product_detail.xpath('div[@class="product-title"]/h2/text()').extract()[0].strip()
#             description = product_detail.xpath('div/div[@id="product-data"]/div/div/div[@class="product-description"]').extract()[0].strip()
            description = product_detail.xpath('div[@class="product-info-extra"]//ul/li/text()').extract()
            if description:
                pass
            else:
                description = title1+title2
            price = product_detail.xpath('div[@class="buy-area-outer"]/div[@class="buy-area"]/div[@class="price"]/text()').extract()[0].strip()
            if price:
                currency = product_detail.xpath('div[@class="buy-area-outer"]/div[@class="buy-area"]/div[@class="price"]/span[@class="currency"]/text()').extract()[0].strip()
            else:
                price = product_detail.xpath('//div[@class="price"]/text()').extract()[0].strip()
                currency = product_detail.xpath('//div[@class="price"]/span[@class="currency"]/text()').extract()[0].strip()
        image = response.xpath('//div[@class="product-images"]/div[@class="product-main-image"]/a/img/@data-src').extract()[0].strip()
        status = response.xpath('//div[@class="buy-button"]/input/@value').extract()[0].strip()
        if status:
            pass
        else:
            status = response.xpath('//div[@class="buy-area"]/div[@class="buy-msg gray-buy-msg"]/h3/text()').extract()[0].strip()    
            
#             url = product_detail.xpath('link[@itemprop="url"]/@href').extract()[0].strip()
        url = response.url
        category = response.xpath('//div[@class="breadcrumb-holder"]/div/ul[@class="breadcrumb"]/li[3]/a/text()').extract()[0].strip()
        if isinstance(description, (str,unicode)):
            description = description
        else:
            description = " ".join(description)
        product['description'] = description.encode('utf-8')
        for i, u, p, c, s, t1, t2, cat in zip([image], [url], [price], [currency], [status], [title1], [title2], [category]):
            product['image'] = i.encode('utf-8') + "&width=450"
            product['url'] = u.encode('utf-8')
            p = p.encode('utf-8')
            c = c.encode('utf-8')
            product['status'] = s.encode('utf-8')
            product['title'] = t1.encode('utf-8') + t2.encode('utf-8')
            product['category'] = cat.encode('utf-8')
        ch = ''.join(it for it in p if '0' <= it <= '9')
        product['price'] = ch + c
        product['company'] = 'Siba'
        
        yield product