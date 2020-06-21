#coding=utf-8
import scrapy
from priceremider.items import PriceremiderItem
from scrapy import log


class NetonnetSpider(scrapy.Spider):
    name = "netonnet"
    allowed_domains = ['netonnet.se']
    def __init__(self, start_url, *args, **kwargs):
        super(NetonnetSpider, self).__init__(*args, **kwargs)
        self.start_urls = [start_url]
    
    def parse(self, response):
        product = PriceremiderItem()
#         for product_detail in response.xpath('//div[@id="site_content"]/div[@id="site_content_middle"]/div[id="site_content_middle_page"]'):
        category = response.xpath('//div[@class="product-leftInfo"]//ol[@class="breadcrumb"]/li[1]/a/text()').extract()[0].strip()
        title = response.xpath('//div[@id="product-leftInfo"]//h2/text()').extract()[0].strip()
        description = response.xpath('//div[@id="prod_leftInfo"]//div[@class="product-usps"]//li/text()').extract()
        if description:
            pass
        else:
            description = title
        price = response.xpath('//div[@id="productPurchaseBoxContainer"]//div[@class="price-big"]/text()').extract()[0].strip()
        if price:
                currency = 'SEK'
                status = response.xpath('//div[@class="product-rightInfo"]//div[@id="onlineStockstatus"]//h3/text()').extract()[0].strip()
        else:
                price = response.xpath('//span[@id="product_price"]/text()').extract()[0].strip()
                currency = 'SEK'
                status = response.xpath('//div[@class="product-rightInfo"]//div[@id="onlineStockstatus"]//h3/text()').extract()[0].strip()
        image = response.xpath('//div[@class="verticalInline"]//img[@class="productImage"]/@src').extract()[0].strip()
#             url = product_detail.xpath('link[@itemprop="url"]/@href').extract()[0].strip()
        url = response.url
        if isinstance(description, (str,unicode)):
            description = description
        else:
            description = " ".join(description)
        product['description'] = description.encode('utf-8')
        if isinstance(status, (str,unicode)):
            status = status
            product['status'] = status.encode('utf-8')
        for i, u, p, c, t, cat in zip([image], [url], [price], [currency], [title], [category]):
            product['image'] = i.encode('utf-8')
            product['url'] = u.encode('utf-8')
            p = p.encode('utf-8')
            c = c.encode('utf-8')
            product['title'] = t.encode('utf-8')
            product['category'] = cat.encode('utf-8')
        product['company'] = 'Netonnet'
        ch = ''.join(it for it in p if '0' <= it <= '9')
        product['price'] = ch + c
        yield product