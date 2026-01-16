# 外卖系统 (WaiMaiDemo)

这是一个基于 Java Web 技术栈开发的外卖订餐系统，采用 Spring MVC 架构模式构建。

## 技术栈

- **后端框架**: Spring、Spring MVC
- **数据库**: MySQL
- **Web 容器**: Jakarta EE (支持 Servlet 6.0)
- **前端技术**: JSP 页面
- **数据库连接**: JDBC

## 项目结构

```
src/
├── main/
│   ├── java/top/buwang/demo/
│   │   ├── controller/     # 控制器层
│   │   │   ├── MerchantController.java
│   │   │   ├── OrderController.java
│   │   │   ├── ProductController.java
│   │   │   ├── SearchController.java
│   │   │   └── cartController.java
│   │   ├── dao/           # 数据访问层
│   │   │   ├── ProductDao.java
│   │   │   ├── cartDao.java
│   │   │   ├── merchantDao.java
│   │   │   ├── ordersDao.java
│   │   │   ├── skuDao.java
│   │   │   └── typeDao.java
│   │   ├── util/          # 工具类
│   │   │   └── DB.java
│   │   └── vo/            # 值对象
│   │       ├── Product.java
│   │       ├── Type.java
│   │       ├── cart.java
│   │       ├── merchant.java
│   │       ├── orders.java
│   │       └── sku.java
│   ├── resources/spring/  # Spring 配置文件
│   │   ├── spring-base.xml
│   │   └── spring-mvc.xml
│   └── webapp/            # Web 资源
│       ├── WEB-INF/
│       ├── admin/         # 管理员页面
│       │   ├── merchant.jsp
│       │   └── product.jsp
│       ├── index.jsp      # 首页
│       ├── merchant.jsp
│       └── order.jsp
```

## 功能模块

### 1. 商家管理 (Merchant)
- 商家信息展示（名称、电话、地址、评分等）
- 商家状态管理

### 2. 商品管理 (Product)
- 商品信息（名称、描述、价格）
- 商品分类管理
- 商品规格管理（SKU）

### 3. 购物车功能 (Cart)
- 添加商品到购物车
- 修改购物车中商品数量

### 4. 订单管理 (Order)
- 订单生成与管理

### 5. 搜索功能 (Search)
- 提供商品搜索功能

## 数据库设计

系统包含以下数据表：

- **merchant**: 商家表，存储商家信息
- **type**: 商品分类表，按商家分类商品
- **product**: 商品表，存储商品基本信息
- **sku**: 商品规格表，存储不同规格的价格和库存信息
- **cart**: 购物车表，记录用户购物车内容
- **orders**: 订单表，记录订单信息

## 特色功能

1. **自动建表**: 系统在首次启动时会自动检测并创建所需的数据库表
2. **初始数据**: 自动插入示例数据（如"沙县小吃"商家及"鸡腿饭"商品等）
3. **编码处理**: 支持 UTF-8 编码，正确处理中文字符
4. **数据库连接池**: 统一的数据库连接管理

## 配置说明

- **数据库连接**: 在 [DB.java](src/main/java/top/buwang/demo/util/DB.java) 中配置数据库连接信息
- **默认数据库**: waimai
- **默认用户名**: root
- **默认密码**: 123456

## 使用说明

1. 确保已安装 MySQL 数据库并启动服务
2. 修改 [DB.java](src/main/java/top/buwang/demo/util/DB.java) 中的数据库连接参数
3. 部署到 Web 容器（如 Tomcat）并启动
4. 系统将自动初始化数据库表结构和初始数据

## 扩展性

- 采用 Spring MVC 架构，便于功能扩展
- 分离的 Controller、DAO 和 VO 层，提高代码可维护性
- 统一的数据库操作工具类，简化数据访问逻辑
