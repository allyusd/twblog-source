---
title: "最好的內部頂級網域"
tags: Domain
---

你是否會在內部網路使用一些自己發明的網域名稱呢？像是

* server1.dev
* server1.test
* server1.apple (apple 也許是你的產品名稱)

要注意了，這可能導致一些麻煩[^3]，如果你是個謹慎的人，在使用網域前先在 [IANA TLD List](https://data.iana.org/TLD/tlds-alpha-by-domain.txt) 或是 [Wiki - List of Internet top-level domains](https://en.wikipedia.org/wiki/List_of_Internet_top-level_domains) 確認現實中不存在，但是這不代表之後不會被買走。

[^3]:[Chrome 63 forces .dev domains to HTTPS via preloaded HSTS](https://ma.ttias.be/chrome-force-dev-domains-https-via-preloaded-hsts/)

事實上 .dev 已經是 Google 所有，而且計劃繼續擁有更多[^1]。同樣的 .apple 也已經被買下，正是你熟悉的 Apple 公司。[^2]

[^1]:[Google Registry](https://www.registry.google/)

[^2]:[IANA - Root Zone Database](https://www.iana.org/domains/root/db)

不論是不是誤打誤中，幸運的 .test 是個可接受的選項，他在 [RFC2606](https://tools.ietf.org/html/rfc2606) 被明確的保留下來做為**測試**使用。該文件只保留了四個頂級網域和三個次級網域。

* .test
* .example
* .invalid
* .localhost
* example.com
* example.net
* example.org

雖然有人提出[建議](https://tools.ietf.org/html/draft-chapin-rfc2606bis-00)希望保留更多的頂級網域，像是 .local、.localdomain、.domain、.lan、.home、.host，可惜沒有被接受。

最好的方式是直接買一個網域，建立次級網域當內部使用。

像是購買 allyusd.com，然後使用 dev.allyusd.com 當作內部網域。

另一個可接受的方式是使用 .test 或是 .example，因為 .invalid 語義上不太好，而 .localhost 又[有人提出](https://tools.ietf.org/html/draft-west-let-localhost-be-localhost-06)希望他真的是 localhost。

## Reference

[Why MyCompany.Local is a Bad Idea](https://www.pluralsight.com/blog/software-development/choose-internal-top-level-domain-name)

[Don't Use .dev For Development](https://iyware.com/dont-use-dev-for-development/)

[Q. Can I use the .local or .pvt top-level domain (TLD) names as part of an Active Directory (AD) tree name?](http://www.itprotoday.com/management-mobility/q-can-i-use-local-or-pvt-top-level-domain-tld-names-part-active-directory-ad)

[Stop Using "internal" Top Level Domain Names](https://isc.sans.edu/forums/diary/Stop+Using+internal+Top+Level+Domain+Names/21095/)

[Top level domain/domain suffix for private network?](https://serverfault.com/questions/17255/top-level-domain-domain-suffix-for-private-network)