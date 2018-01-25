# -*- coding: utf-8 -*-
"""
Created on Thu Jan 25 18:45:32 2018

@author: April
"""

#从网页下载批量下载图片 
import re  
import time  
from urllib.request import urlopen, urlretrieve  
  
#下载HTML  
def getHtml(url):  
    page=urlopen(url)  
    html= page.read()  
    return html  
  
#从html中解析出图片URL  
def getImg(html):  
    reg=r'src="(.*?\.jpg)"'  
    imgre=re.compile(reg);  
    htmld=html.decode('utf-8')  
    imglist=imgre.findall(htmld)  
    return imglist  
  
#下载处理  
def imgDownload(imgUrl):  
    urlretrieve(imgUrl, '%s.jpg'%time.time())  
  
#主函数  
def main():  
    url='http://wanimal1983.tumblr.com'  
    html=getHtml(url)  
    imglist=getImg(html)  
    for imgurl in imglist:  
        print(imgurl)  
        imgDownload(imgurl)  
          
#执行主函数  
if __name__=='__main__':  
    main()  