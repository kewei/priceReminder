#coding=utf-8
import scrapy
from urlparse import urlparse 
from scrapy.spiders import CrawlSpider, Rule
from scrapy.linkextractors import LinkExtractor
from priceremider.items import PriceremiderItem
from scrapy.shell import inspect_response
from scrapy import log


class Webhallen_autoSpider(CrawlSpider):
    name = "webhallen_auto"
    allowed_domains = ['webhallen.com']
    start_urls = ["http://www.webhallen.com"]
    rules = (
        Rule(LinkExtractor(allow=("/se-sv/.*")), callback='parse_item', follow=False),)
    
    def parse_item(self, response):
        product = PriceremiderItem()
#         for product_detail in response.xpath('//div[@id="site_content"]/div[@id="site_content_middle"]/div[id="site_content_middle_page"]'):
        category = response.xpath('//p[@class="page_hierarchy"]/a[1]/text()').extract()[0].strip()
        title = response.xpath('//div[@id="prod_top"]/h1[@itemprop="name"]/text()').extract()[0].strip()
#             description = product_detail.xpath('//div[@id="prod_info"]/div[@id="prod_tab"]').extract()
#             if description:
#                 pass
#             else:
#                 description = title
        description = title
        price = response.xpath('//span[@id="prod_price_sum"]/span[@id="product_price"]/text()').extract()[0].strip()
        if price:
                currency = response.xpath('//meta[@itemprop="priceCurrency"]/@content').extract()[0].strip()
                status = response.xpath('//table[@class="stock"]').extract()[0].strip()
        else:
                price = response.xpath('//span[@id="product_price"]/text()').extract()[0].strip()
                currency = response.xpath('//meta[@itemprop="priceCurrency"]/@content').extract()[0].strip()
                status = response.xpath('//table[@class="stock"]').extract()[0].strip()
        image = response.xpath('//img[@id="prod_image"]/@src').extract()[0].strip()
#             url = product_detail.xpath('link[@itemprop="url"]/@href').extract()[0].strip()
        url = response.url
#         if isinstance(description, (str,unicode)):
#             description = description
#         else:
#             description = " ".join(description)
        product['description'] = description.encode('utf-8')
        for i, u, p, c, s, t, cat in zip([image], [url], [price], [currency], [status], [title], [category]):
            product['image'] = i.encode('utf-8')
            product['url'] = u.encode('utf-8')
            p = p.encode('utf-8')
            c = c.encode('utf-8')
            product['status'] = s.encode('utf-8')
            product['title'] = t.encode('utf-8')
            product['category'] = cat.encode('utf-8')
        product['company'] = 'Webhallen'
        ch = ''.join(it for it in p if '0' <= it <= '9')
        product['price'] = ch + c
        yield product