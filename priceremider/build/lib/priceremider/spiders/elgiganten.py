#coding=utf-8
import scrapy
from priceremider.items import PriceremiderItem
from scrapy import log


class ElgigantenSpider(scrapy.Spider):
    name = "elgiganten"
    allowed_domains = ["elgiganten.se"]
#    start_urls = ["http://www.elgiganten.se/product/ljud-bild/kablar-och-adapters/S2HDM114X/hdmi-kabel-svart-2-m"]
    def __init__(self, start_url, *args, **kwargs):
        super(ElgigantenSpider, self).__init__(*args, **kwargs)
        self.start_urls = [start_url]
      
    def parse(self, response):
        self.log('A response from %s just arrived!' % response.url)
        product = PriceremiderItem()
        for product_detail in response.xpath('//div[@class="product-detail-page"]/section[@class="section product-main-info main-content padded"]'):
            description = product_detail.xpath('meta[@itemprop="description"]/@content').extract()[0].strip()
            title = product_detail.xpath('meta[@itemprop="name"]/@content').extract()[0].strip()
            image = product_detail.xpath('meta[@itemprop="image"]/@content').extract()[0].strip()
            url = product_detail.xpath('link[@itemprop="url"]/@href').extract()[0].strip()
            price = product_detail.xpath('div[@id="product-detail-wrapper"]/div/div[@class="product-price align-left any-1-1"]/span/span/text()').extract()[0].strip()
            currency = product_detail.xpath('div[@id="product-detail-wrapper"]/div/div[@class="product-price align-left any-1-1"]/meta[@itemprop="priceCurrency"]/@content').extract()[0].strip()
            status = product_detail.xpath('div[@id="product-detail-wrapper"]/div/div[@class="buy-button-container align-left any-1-1"]/div/div[@class="stock-info"]/span/text()').extract()
            if status:
                pass
            else:
                status = product_detail.xpath('div[@id="product-detail-wrapper"]/div/div[@class="buy-button-container align-left any-1-1"]/div/div[@class="stock-info"]/span[2]/text()').extract()[0].strip()
            if status:
                pass
            else:
                status = product_detail.xpath('div[@id="product-detail-wrapper"]/div/div[@class="buy-button-container align-left any-1-1"]/div/div[@class="collect-at-store-button"]/span/@title')
        category = response.xpath('//nav[@class="row bottom"]/ol[@class="breadcrumbs S-1-1"]/li[2]/a/text()').extract()[0].strip()
        
        if isinstance(status, (str,unicode)):
            status = status
        else:
            status = " ".join(status)
            status = status.strip()
        product['status'] = status.encode('utf-8')
        for d, i, u, p, c, t, cat in zip([description], [image], [url], [price], [currency], [title], [category]):
            product['description'] = d.encode('utf-8')
            product['image'] = i.encode('utf-8')
            product['url'] = u.encode('utf-8')
            p = p.encode('utf-8')
            c = c.encode('utf-8')
            product['title'] = t.encode('utf-8')
            product['category'] = cat.encode('utf-8')
        ch = ''.join(it for it in p if '0' <= it <= '9')
        product['price'] = ch + c
        product['company'] = 'Elgiganten'
        yield product