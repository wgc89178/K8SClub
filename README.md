#  [K8SClub/container-basics](https://github.com/K8SClub/container-basics)

注：
* 本项目为`K8SClub`社区首个项目。
* 本项目为马哥《[容器技术训练营](https://ke.qq.com/course/2145808?saleToken=2095963&from=pclink)》课程同步素材。
* 本项目仅包含: _**实践代码**_ ，课程在[腾讯课堂](https://ke.qq.com/course/2145808?saleToken=2095963&from=pclink)(有录播)，索取课件/在线学习/咨询/加入社区 请扫码添加顾问。

|添加顾问<br/> _索取课件_ |申请加入<br/>K8SClub|微信扫码<br/>在线学习|QQ扫码<br/>在线学习|马哥教育<br/>官网|
|---|---|---|---|---|
|![alt "添加顾问索取课件"](.images/handou.jpg "添加顾问索取课件")|![alt "申请加入K8SClub社区 https://wj.qq.com/s2/5923990/837c/"](images/github.collection.jpg "申请加入K8SClub社区")|!["微信扫码在线学习 https://ke.qq.com/course/2145808?saleToken=2095963&from=pclink"](.images/docker+k8s+3days.ke.qq.com.jpg "微信扫码在线学习")|![alt "QQ扫码在线学习 https://ke.qq.com/course/2145808?saleToken=2095963&from=pclink"](.images/docker+k8s+3days.wechat.jpg "QQ扫码在线学习")|<a href="http://www.magedu.com/" title="马哥教育"><img src="http://www.magedu.com/wp-content/uploads/2018/12/2018122312035677.png?s=container-basics" width = "120" alt="马哥教育" /></a>|

## 课前提示

* **有 _经验_ 的同学**，可以先课前尝试一下示例，欢迎在 [Issues](https://github.com/K8SClub/container-basics/issues) 区反馈问题并展开讨论。
* **有 _问题_ 的同学**，可在 [Issues](https://github.com/K8SClub/container-basics/issues) 区提问，社区老师以及志愿者会在业余时间解答。
* **有 _时间和兴趣_ 的同学**，可以尝试Rewivew下其他同学的问题和作业，欢迎同学们相互review共同学习，看下其他同学的思路，你可能会有想不到的收获。
* **课后作业**，请积极提交作业，结课后会选一名答题较好的同学，送一本签名版[《Kubernetes进阶实战》](https://union-click.jd.com/jdc?e=&p=AyIGZRhaHQsbBVUcXhMyEgRQHV0VAxY3EUQDS10iXhBeGlcJDBkNXg9JHU4YDk5ER1xOGRNLGEEcVV8BXURFUFdfC0RVU1JRUy1OVxUBFwFTG1oRMkFfC1MGZn5uZBUYMH5Jc3cIclMQHFQLWStaJQITBlYfUhYBFgRlK1sSMkRpVRpaFAMTAlQfWCUDIgdREl0RBBAOUB1YEwMiAFUSa11cVkwNdQxWWkZYACtrJQEiN2UbaxYyUGlVGlsQVxYDVEtSFQQXAFNJCxYHEAdcTAsdBhFTBRMLEDIQBlQfUg%3D%3D)。
    * [第一天作业](https://github.com/K8SClub/container-basics/issues/2)
    * [第二天作业](https://github.com/K8SClub/container-basics/issues/5)
    * 第三天作业 @TODO：
* **Github Issue** 请参考：
    * [Kubernetes Issues](https://github.com/kubernetes/kubernetes/issues)
    * [Markdown在线学习](http://www.mdeditor.com/)
    
## 环境需求

### 系统及配置

|课程|系统及版本|内存|CPU|数量|
|----:|-------|---|----|----|
|第1,2天|Ubuntu Server 18.04|4G|2U+|1|
|第3天|Ubuntu Server 18.04|4G|2U+|5+|

#### 镜像下载
* 国内推荐
    * [官方国内源下载](https://cn.ubuntu.com/download)
    * [网易源下载](http://mirrors.163.com/ubuntu-releases/18.04/ubuntu-18.04.4-live-server-amd64.iso)
* 海外推荐：
    * [官方源下载](https://mirrors.melbourne.co.uk/ubuntu-releases/18.04.4/ubuntu-18.04.4-live-server-amd64.iso)

### 问题咨询

* 技术问题，提[Issue](https://github.com/K8SClub/container-basics/issues)
* 课程问题，扫码加微信咨询

## About K8SClub

**K8SClub** 是 [马哥教育](http://www.magedu.com/) 发起的`Docker` 及 `Kubernetes` 技术社区。

### 相关链接

* [马哥教育官网](http://www.magedu.com/)
* [K8SClub 社区](https://github.com/K8SClub)
* [《Kubernetes进阶实战》](https://union-click.jd.com/jdc?e=&p=AyIGZRhaHQsbBVUcXhMyEgRQHV0VAxY3EUQDS10iXhBeGlcJDBkNXg9JHU4YDk5ER1xOGRNLGEEcVV8BXURFUFdfC0RVU1JRUy1OVxUBFwFTG1oRMkFfC1MGZn5uZBUYMH5Jc3cIclMQHFQLWStaJQITBlYfUhYBFgRlK1sSMkRpVRpaFAMTAlQfWCUDIgdREl0RBBAOUB1YEwMiAFUSa11cVkwNdQxWWkZYACtrJQEiN2UbaxYyUGlVGlsQVxYDVEtSFQQXAFNJCxYHEAdcTAsdBhFTBRMLEDIQBlQfUg%3D%3D) 

若有帮助，欢迎分享[马哥教育](http://www.magedu.com/)，[K8SClub 社区](https://github.com/K8SClub)及[《Kubernetes进阶实战》](https://union-click.jd.com/jdc?e=&p=AyIGZRhaHQsbBVUcXhMyEgRQHV0VAxY3EUQDS10iXhBeGlcJDBkNXg9JHU4YDk5ER1xOGRNLGEEcVV8BXURFUFdfC0RVU1JRUy1OVxUBFwFTG1oRMkFfC1MGZn5uZBUYMH5Jc3cIclMQHFQLWStaJQITBlYfUhYBFgRlK1sSMkRpVRpaFAMTAlQfWCUDIgdREl0RBBAOUB1YEwMiAFUSa11cVkwNdQxWWkZYACtrJQEiN2UbaxYyUGlVGlsQVxYDVEtSFQQXAFNJCxYHEAdcTAsdBhFTBRMLEDIQBlQfUg%3D%3D) 给你的朋友共同学习。

## 请关注社区，不要勿走远，未完待续。。。