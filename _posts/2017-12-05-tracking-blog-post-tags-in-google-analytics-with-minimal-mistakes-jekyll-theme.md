---
title: "使用 Google Analytics 追蹤文章標籤 (Tags) 在 Minimal Mistakes Jekyll Theme"
tags: Google-Analytics Jekyll Minimal-Mistakes
---

想要分析部落格哪些文章類型最受歡迎，在網路上找到方法[^1]，實際操作在 Minimal Mistakes 蠻簡單的。

一般來說 analytics 會是使用 google-universal 設定，修改 \_includes/analytics-providers/google-universal.html

修改前

```html
<script>
  ...

  ga('create', '{{ site.analytics.google.tracking_id }}', 'auto');
  ga('send', 'pageview');
</script>
```

修改後

```html
{% raw %}
<script>
  ...

  ga('create', '{{ site.analytics.google.tracking_id }}', 'auto');
  ga('send', 'pageview');
  {% if page.tags.size > 0 %}
  {% for tag in page.tags %}
    ga('send', 'event', 'taggedPost', 'view', '{{ tag }}');
  {% endfor %}
  {% endif %}
</script>
{% endraw %}
```

[^1]: [Tracking Your Most Popular Blog Post Tags in Google Analytics with Jekyll](https://maxchadwick.xyz/blog/tracking-your-most-popular-blog-post-tags-in-google-analytics-with-jekyll)
