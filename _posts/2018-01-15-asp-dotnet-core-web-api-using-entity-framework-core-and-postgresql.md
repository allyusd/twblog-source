---
title: "ASP.Net Core Web API 使用 Entity Framework Core 和 PostgreSQL"
tags: Visual-Studio-Code .Net-Core ASP.NET Web-API Entity-Framework-Core PostgreSQL CSharp
---

ASP.Net Core Web API 使用 Entity Framework Core 和 PostgreSQL

## 前提

如果你還沒有準備好 Visual Studio Code with .Net Core 開發環境，請先參考[使用 Visual Studio Code 開發 .Net Core](https://twblog.hongjianching.com/2018/01/14/visual-studio-code-with-dotnet-core/)

接著依照[在 macOS、Linux 和 Windows 上，使用 ASP.NET Core MVC 和 Visual Studio Code 建立 Web API](https://docs.microsoft.com/zh-tw/aspnet/core/tutorials/web-api-vsc)完成 Todo WebApi 的範例專案。

## 使用 Entity Framework Core 和 PostgreSQL

在 **TodoApi.csproj** 新增套件參考

```
<PackageReference Include="Npgsql.EntityFrameworkCore.PostgreSQL" Version="2.0.0" />
<PackageReference Include="Microsoft.EntityFrameworkCore.Design" Version="2.0.1" />
```

在 **appsettings.json** 新增連接字串

```
"ConnectionStrings": { "TodoContext": "Server=localhost;User ID=postgres;Password=mysecretpassword;Database=postgres" }
```

接著修改 **Startup.cs** 程式碼，註解原本的 InMemoryDatabase，改用 PostgreSQL。

```csharp
// services.AddDbContext<TodoContext>(opt => opt.UseInMemoryDatabase("TodoList"));
var connectionString = Configuration.GetConnectionString("TodoContext");
services.AddEntityFrameworkNpgsql().AddDbContext<TodoContext>(options => options.UseNpgsql(connectionString));
```

最後別忘了在資料庫建立表單。

注意，因為 C# 預設命名慣例是 PascalCase，而 PostgreSQL 預設命名慣例是 lower_case_with_underscores，所以如果 sql 的表格或欄位名稱不加上雙引號，會造成兩者不一致，這個範例是依 C# 命名慣例為主，個人習慣以 PostgreSQL 為主。

```sql
CREATE TABLE "TodoItems" (
    "Id" serial NOT NULL,
    "Name" varchar NOT NULL,
    "IsComplete" bool NOT NULL,
    PRIMARY KEY ("Id")
);
```

以上就完成使用 Entity Framework Core 和 PostgreSQL 取代原本 InMemoryDatabase，資料可以保留下來嘍！

![](/assets/images/2018-01-15-asp-dotnet-core-web-api-using-entity-framework-core-and-postgresql/001.png)

## Reference

[Npgsql - Getting Started](http://www.npgsql.org/efcore/index.html)