---
title: "Chrome 58 https error missing_subjectAltName"
tags: Chrome
---

Chrome 58 版之後 https 網站出現錯誤 missing_subjectAltName

最近突然遇到 Chrome 瀏覽內部網站 https 時出現錯誤，「您的連線不是私人連線」，本來以前是個人電腦憑證出了狀況，後來才知道這個情況原因是 Chrome 58 版之後不再支援沒有 Subject Alternative Names 的憑證。[^1]

[^1]:[Support for commonName matching in Certificates (removed)](https://www.chromestatus.com/feature/4981025180483584)

Since version 58, Chrome requires SSL certificates to use SAN (Subject Alternative Name) instead of the popular Common Name (CN)[^2]

[^2]:[Fixing Chrome 58+ [missing_subjectAltName] with openssl when using self signed certificates](https://alexanderzeitler.com/articles/Fixing-Chrome-missing_subjectAltName-selfsigned-cert-openssl/)

測試 Firefox 53 同樣有此現象，可能從 48 開始就不支援 commonName maching
同步測試發現 IE 11 不受影響

### Other Ref
[Creating self signed certificate for domain and subdomains - NET::ERR_CERT_COMMON_NAME_INVALID](http://stackoverflow.com/questions/27294589/creating-self-signed-certificate-for-domain-and-subdomains-neterr-cert-commo)
